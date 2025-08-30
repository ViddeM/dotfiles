use eyre::Context;
use niri_ipc::{Request, Response, socket::Socket};

use crate::internal_state::InternalState;

mod external_state;
mod internal_state;

fn main() -> eyre::Result<()> {
    color_eyre::install()?;

    let mut socket = Socket::connect().wrap_err("Failed to connect to niri socket")?;

    let mut state = InternalState::new();

    let response = socket.send(Request::EventStream).unwrap();
    match response {
        Ok(Response::Handled) => {
            let mut read_event = socket.read_events();
            while let Ok(event) = read_event() {
                if let Err(_err) = state.handle_event(event) {
                    /* TODO: Maybe do something but eh */
                }

                let external_state = external_state::ExternalState::from(&state);
                let json = serde_json::to_string(&external_state)
                    .wrap_err("Failed to serialize external state")?;
                println!("{}", json);
            }
        }
        Ok(_) => return Err(eyre::eyre!("Unexpected response from niri: {response:?}")),
        Err(err) => return Err(eyre::eyre!("Got error response from niri, err: {err}")),
    }

    Ok(())
}
