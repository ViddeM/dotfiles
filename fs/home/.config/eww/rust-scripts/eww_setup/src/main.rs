use std::{
    collections::{HashMap, HashSet},
    thread,
    time::Duration,
};

use eww::EwwClient;
use eyre::Context;
use niri_ipc::{Event, Request, Response, socket::Socket};

// Program to properly setup eww for all connected monitors.
fn main() -> eyre::Result<()> {
    color_eyre::install()?;

    let mut socket = Socket::connect().wrap_err("Failed to connect to niri socket")?;

    let response = socket
        .send(Request::EventStream)
        .wrap_err("Failed to request eventstream from niri")?;

    let mut state = NiriMonitorsState {
        eww_client: EwwClient::new(),
        monitors: HashSet::new(),
    };

    match response {
        Ok(Response::Handled) => {
            let mut read_event = socket.read_events();
            while let Ok(event) = read_event() {
                //println!("Event: {event:?}");

                state.handle_event(event);
            }
        }
        Ok(_) => return Err(eyre::eyre!("Unexpected response from niri: {response:?}")),
        Err(err) => return Err(eyre::eyre!("Got error response from niri, err: {err}")),
    }

    Ok(())
}

struct NiriMonitorsState {
    eww_client: EwwClient,
    monitors: HashSet<String>,
}

impl NiriMonitorsState {
    fn handle_event(&mut self, event: Event) -> eyre::Result<()> {
        match event {
            Event::WorkspacesChanged { workspaces } => {
                println!("Relevant event");
                let new_outputs = workspaces
                    .into_iter()
                    .filter_map(|ws| ws.output)
                    .collect::<HashSet<_>>();

                if new_outputs.len() != self.monitors.len() {
                    self.monitors = new_outputs;
                    self.reset_bars().wrap_err("Failed to reset bars")?;
                    return Ok(());
                }

                if !new_outputs.iter().all(|o| self.monitors.contains(o)) {
                    self.monitors = new_outputs;
                    self.reset_bars().wrap_err("Failed to reset bars")?;
                    return Ok(());
                }
            }
            _ => { /* Ignored */ }
        }

        Ok(())
    }

    fn reset_bars(&self) -> eyre::Result<()> {
        println!("Resetting bars with monitors {:?}", self.monitors);
        self.eww_client
            .close_all()
            .wrap_err("Failed to close eww windows")?;

        for monitor in self.monitors.iter() {
            println!("Monitor: {monitor}");

            let mut args: HashMap<String, String> = HashMap::new();
            args.insert("monitor".into(), monitor.clone());
            self.eww_client
                .open_with_args(
                    "bar_center".into(),
                    Some(format!("center-{monitor}")),
                    &args,
                )
                .wrap_err("Failed to open with center bar")?;

            // Sleep a couple of millis just to avoid center bar opening after right/left and causing positioning issues.
            thread::sleep(Duration::from_millis(60));

            self.eww_client
                .open_with_args("bar_left".into(), Some(format!("left-{monitor}")), &args)
                .wrap_err("Failed to open with left_bar")?;

            self.eww_client
                .open_with_args("bar_right".into(), Some(format!("right-{monitor}")), &args)
                .wrap_err("Failed to open with right_bar")?;
        }

        Ok(())
    }
}
