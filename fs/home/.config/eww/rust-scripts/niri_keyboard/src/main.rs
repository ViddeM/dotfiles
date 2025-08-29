use clap::Parser;
use eww::EwwClient;
use eyre::{Context, ContextCompat};

#[derive(Parser, Debug)]
struct Args {
    #[arg(long)]
    current: bool,
    #[arg(long)]
    all: bool,
}

fn main() -> eyre::Result<()> {
    color_eyre::install().ok();

    let args = Args::parse();

    eyre::ensure!(
        args.current || args.all,
        "Neither --current nor --all was specified"
    );

    let response = niri_ipc::socket::Socket::connect()
        .wrap_err("Failed to connect to niri socket")?
        .send(niri_ipc::Request::KeyboardLayouts)
        .wrap_err("Failed to send keyboard_layouts request to niri")?
        .map_err(|err| eyre::eyre!("Got error response from niri ipc, err: {err}"))?;

    let niri_ipc::Response::KeyboardLayouts(keyboard_layouts) = response else {
        eyre::bail!("Got unexpected response from niri_ipc {response:?}");
    };

    if args.current {
        let current = keyboard_layouts
            .names
            .get(keyboard_layouts.current_idx as usize)
            .wrap_err("Failed to get current keyboard layout")?;

        let eww_client = EwwClient::new();
        update_flag(&eww_client, current).wrap_err("Failed to update flag image")?;

        print!("{current}");
    }

    if args.all {
        keyboard_layouts.names.iter().for_each(|layout| {
            println!("{layout}");
        });
    }

    Ok(())
}

fn update_flag(eww_client: &EwwClient, layout: &String) -> eyre::Result<()> {
    let shortname = match layout.as_str() {
        "English (US)" => "us",
        "Swedish" => "se",
        _ => {
            eyre::bail!("Unknown keyboard layout {layout}");
        }
    };

    eww_client
        .update("keyboard_flag", &format!("images/flag_{shortname}.png"))
        .wrap_err("Failed to update flag image path")?;

    Ok(())
}
