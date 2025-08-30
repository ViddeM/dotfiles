use std::collections::HashMap;

use serde::Serialize;

use crate::internal_state::InternalState;

#[derive(Serialize)]
pub struct ExternalState {
    outputs: HashMap<String, Output>,
}

#[derive(Serialize)]
pub struct Output {
    workspaces: Vec<Workspace>,
    active_workspace: Option<ActiveWorkspace>,
}

#[derive(Serialize)]
struct ActiveWorkspace {
    has_more_to_left: bool,
    has_more_to_right: bool,
    columns: Vec<ActiveWorkspaceColumn>,
}

#[derive(Serialize, Clone)]
struct ActiveWorkspaceColumn {
    is_active: bool,
    is_urgent: bool,
    num_windows: usize,
}

impl From<&Column> for ActiveWorkspaceColumn {
    fn from(value: &Column) -> Self {
        ActiveWorkspaceColumn {
            is_active: value.contains_focused_window,
            is_urgent: value.windows.iter().any(|w| w.is_urgent),
            num_windows: value.windows.iter().count(),
        }
    }
}

const COLS_ON_EACH_SIDE: usize = 2;

impl From<&Workspace> for ActiveWorkspace {
    fn from(value: &Workspace) -> Self {
        let columns = value
            .columns
            .iter()
            .map(|col| ActiveWorkspaceColumn::from(col))
            .collect::<Vec<_>>();

        let Some((index, active)) = value
            .columns
            .iter()
            .enumerate()
            .find(|(_, column)| column.contains_focused_window)
        else {
            // We don't have any (?) windows on the active workspace.
            return ActiveWorkspace {
                has_more_to_left: false,
                has_more_to_right: false,
                columns: vec![],
            };
        };

        let mut columns_before = columns
            .iter()
            .enumerate()
            .filter(|(i, _)| i < &index)
            .map(|(_, c)| c.clone())
            .rev()
            .take(COLS_ON_EACH_SIDE)
            .collect::<Vec<_>>();
        columns_before.reverse();

        let columns_after = columns
            .iter()
            .enumerate()
            .filter(|(i, _)| i > &index)
            .map(|(_, c)| c.clone())
            .take(COLS_ON_EACH_SIDE)
            .collect::<Vec<_>>();

        columns_before.push(active.into());

        let columns = columns_before
            .into_iter()
            .chain(columns_after.into_iter())
            .collect::<Vec<_>>();

        Self {
            has_more_to_left: index > COLS_ON_EACH_SIDE,
            has_more_to_right: columns.iter().count().checked_sub(index + 1).unwrap_or(0)
                > COLS_ON_EACH_SIDE,
            columns,
        }
    }
}

#[derive(Serialize)]
struct Workspace {
    id: u64,
    index: u8,
    is_active: bool,
    is_urgent: bool,
    columns: Vec<Column>,
}

#[derive(Serialize)]
struct Column {
    index: usize,
    contains_focused_window: bool,
    windows: Vec<Window>,
}

#[derive(Serialize)]
struct Window {
    id: u64,
    is_urgent: bool,
    is_focused: bool,
}

impl From<&InternalState> for ExternalState {
    fn from(state: &InternalState) -> Self {
        let mut output_to_workspaces: HashMap<String, Vec<Workspace>> = HashMap::new();
        for ws in state.workspaces.iter() {
            let Some(output) = ws.output.clone() else {
                continue;
            };

            let mut columns_to_window_ids: HashMap<usize, Vec<u64>> = HashMap::new();
            for window in state.windows.iter() {
                if window.is_floating {
                    continue;
                }

                if window.workspace_id != Some(ws.id) {
                    continue;
                }

                let column_index = window
                    .layout
                    .pos_in_scrolling_layout
                    .expect("No position for non-floating window?")
                    .0;
                columns_to_window_ids
                    .entry(column_index)
                    .and_modify(|c| c.push(window.id))
                    .or_insert(vec![window.id]);
            }

            let mut columns: Vec<Column> = columns_to_window_ids
                .into_iter()
                .map(|(c_index, window_ids)| {
                    let windows = state
                        .windows
                        .iter()
                        .filter(|w| w.workspace_id == Some(ws.id))
                        .filter(|w| window_ids.contains(&w.id))
                        .map(|w| Window {
                            id: w.id,
                            is_urgent: w.is_urgent,
                            is_focused: w.is_focused,
                        })
                        .collect::<Vec<_>>();

                    Column {
                        index: c_index,
                        contains_focused_window: windows.iter().any(|w| w.is_focused),
                        windows,
                    }
                })
                .collect();

            columns.sort_by(|c1, c2| c1.index.cmp(&c2.index));

            let workspace = Workspace {
                id: ws.id,
                index: ws.idx,
                is_active: ws.is_active,
                is_urgent: ws.is_urgent,
                columns,
            };

            if let Some(workspaces) = output_to_workspaces.get_mut(&output) {
                workspaces.push(workspace);
            } else {
                output_to_workspaces.insert(output, vec![workspace]);
            }
        }

        output_to_workspaces.values_mut().for_each(|wss| {
            wss.sort_by(|ws1, ws2| ws1.index.cmp(&ws2.index));
        });

        Self {
            outputs: output_to_workspaces
                .into_iter()
                .map(|(output, workspaces)| {
                    let active = workspaces
                        .iter()
                        .find(|ws| ws.is_active)
                        .map(|ws| ws.into());
                    (
                        output,
                        Output {
                            workspaces,
                            active_workspace: active,
                        },
                    )
                })
                .collect(),
        }
    }
}
