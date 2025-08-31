use std::{collections::HashMap, ops::Div};

use serde::Serialize;

use crate::internal_state::InternalState;

#[derive(Serialize)]
pub struct ExternalState {
    outputs: HashMap<String, Output>,
}

#[derive(Serialize)]
pub struct Output {
    workspaces: Vec<Workspace>,
    current_workspace: Option<usize>,
    workspace_count: usize,
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

impl From<&Workspace> for ActiveWorkspace {
    fn from(value: &Workspace) -> Self {
        let all_columns = value
            .columns
            .iter()
            .map(|col| ActiveWorkspaceColumn::from(col))
            .collect::<Vec<_>>();
        let total_columns = all_columns.len();

        let Some((index, _)) = value
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

        let start_column = get_start_column(total_columns, index);

        let columns = all_columns
            .into_iter()
            .skip(start_column)
            .take(MAX_COLS)
            .collect::<Vec<_>>();

        Self {
            has_more_to_left: start_column > 0,
            has_more_to_right: (start_column + columns.len()) < total_columns, // TODO: Might be some off-by-one error here. Think later
            columns,
        }
    }
}

const MAX_COLS: usize = 7;

fn get_start_column(total_columns: usize, active_column_index: usize) -> usize {
    if total_columns == 0 {
        return 0;
    }

    let optimal_cols_on_each_size = (MAX_COLS as f32).div(2.0).floor() as usize;

    let left_initial_index = active_column_index
        .checked_sub(optimal_cols_on_each_size)
        .unwrap_or(0);
    let taken_left = active_column_index - left_initial_index;
    let missing_left = optimal_cols_on_each_size - taken_left;

    let right_optimal_index = active_column_index + optimal_cols_on_each_size + missing_left;
    let capped_right = (total_columns - 1).min(right_optimal_index);
    let taken_right = capped_right - active_column_index;
    let missing_right = optimal_cols_on_each_size
        .checked_sub(taken_right)
        .unwrap_or(0);

    let corrected_left = left_initial_index.checked_sub(missing_right).unwrap_or(0);

    corrected_left
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
                        .enumerate()
                        .find(|(_, ws)| ws.is_active)
                        .map(|(index, ws)| (index, ws.into()));

                    let active_index = active.as_ref().map(|(i, _)| i + 1);
                    let active_ws = active.map(|(_, ws)| ws);
                    let total_ws_count = workspaces.len();

                    (
                        output,
                        Output {
                            workspaces,
                            active_workspace: active_ws,
                            current_workspace: active_index,
                            workspace_count: total_ws_count,
                        },
                    )
                })
                .collect(),
        }
    }
}

#[cfg(test)]
mod tests {
    use super::*;

    #[test]
    fn get_start_column_with_room_to_spare() {
        assert_eq!(get_start_column(23, 15), 12);
    }

    #[test]
    fn get_start_column_too_few_left() {
        assert_eq!(get_start_column(10, 1), 0);
    }

    #[test]
    fn get_start_column_too_few_right() {
        assert_eq!(get_start_column(19, 17), 12)
    }

    #[test]
    fn get_start_column_no_cols() {
        assert_eq!(get_start_column(0, 0), 0);
    }

    #[test]
    fn get_start_column_active_is_at_start() {
        assert_eq!(get_start_column(8, 0), 0);
    }

    #[test]
    fn get_start_column_active_is_at_end() {
        assert_eq!(get_start_column(8, 7), 1);
    }

    #[test]
    fn get_start_column_too_few_both_ends() {
        assert_eq!(get_start_column(3, 1), 0);
    }
}
