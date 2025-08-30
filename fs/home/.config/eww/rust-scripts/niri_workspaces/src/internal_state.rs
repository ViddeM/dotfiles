use niri_ipc::{Event, Window, Workspace};

#[derive(Debug)]
pub struct InternalState {
    pub workspaces: Vec<Workspace>,
    pub windows: Vec<Window>,
}

impl InternalState {
    pub fn new() -> Self {
        Self {
            workspaces: vec![],
            windows: vec![],
        }
    }

    pub fn handle_event(&mut self, e: Event) -> eyre::Result<()> {
        match e {
            Event::WorkspacesChanged { workspaces } => self.workspaces = workspaces,
            Event::WorkspaceActivated { id, focused } => {
                if focused {
                    self.workspaces
                        .iter_mut()
                        .for_each(|w| w.is_focused = false);
                }

                let output = if let Some(new_active_workspace) =
                    self.workspaces.iter_mut().find(|w| w.id == id)
                {
                    new_active_workspace.is_focused = focused;
                    new_active_workspace.is_active = true;
                    new_active_workspace.output.clone()
                } else {
                    eyre::bail!("Could not find workspace that was activated");
                };

                if let Some(output) = output {
                    self.workspaces
                        .iter_mut()
                        .filter(|w| w.id != id)
                        .filter(|w| w.output == Some(output.clone()))
                        .for_each(|w| w.is_active = false);
                }
            }
            Event::WorkspaceActiveWindowChanged {
                workspace_id,
                active_window_id,
            } => {
                if let Some(workspace) = self.workspaces.iter_mut().find(|w| w.id == workspace_id) {
                    workspace.active_window_id = active_window_id;
                }
            }
            Event::WindowsChanged { windows } => self.windows = windows,
            Event::WindowOpenedOrChanged { window } => {
                if window.is_focused {
                    self.windows.iter_mut().for_each(|w| w.is_focused = false);
                }

                if let Some(w) = self.windows.iter_mut().find(|w| w.id == window.id) {
                    // Update window
                    *w = window;
                } else {
                    // Add new window
                    self.windows.push(window);
                }
            }
            Event::WindowClosed { id } => {
                if let Some((index, _)) = self.windows.iter().enumerate().find(|(_, w)| w.id == id)
                {
                    self.windows.remove(index);
                }
            }
            Event::WindowFocusChanged { id } => {
                self.windows.iter_mut().for_each(|w| w.is_focused = false);

                if let Some(id) = id {
                    let Some(window) = self.windows.iter_mut().find(|w| w.id == id) else {
                        eyre::bail!("Failed to find winodw that got focused?");
                    };

                    window.is_focused = true;
                }
            }
            Event::WindowLayoutsChanged { changes } => {
                changes.into_iter().for_each(|(id, layout)| {
                    self.windows
                        .iter_mut()
                        .find(|w| w.id == id)
                        .map(|w| w.layout = layout);
                })
            }
            Event::ConfigLoaded { .. } => { /* Not relevant */ }
            Event::KeyboardLayoutsChanged { .. } => { /* Not relevant */ }
            Event::KeyboardLayoutSwitched { .. } => { /* Not relevant */ }
            Event::WorkspaceUrgencyChanged { .. } => { /* Not relevant */ }
            Event::WindowUrgencyChanged { .. } => { /* Not relevant */ }
            Event::OverviewOpenedOrClosed { .. } => { /* Not relevant */ }
        }

        Ok(())
    }
}
