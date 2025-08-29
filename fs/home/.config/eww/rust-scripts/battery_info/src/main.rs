use battery::{Battery, units::Time};
use clap::Parser;
use eww::EwwClient;
use eyre::Context;

#[derive(Parser, Debug)]
struct Args {
    #[arg(long)]
    percentage: bool,
    #[arg(long)]
    time: bool,
}

fn main() -> eyre::Result<()> {
    color_eyre::install().ok();

    let args = Args::parse();

    eyre::ensure!(
        args.percentage || args.time,
        "Neither --percentage nor --time was specified"
    );

    let battery = get_first_battery()?;

    let eww_client = EwwClient::new();

    let Some(battery) = battery else {
        eww_client
            .update("battery_exists", "false")
            .wrap_err("Failed to write battery_exists")?;
        return Ok(());
    };

    eww_client
        .update("battery_exists", "true")
        .wrap_err("Failed to write battery_exists")?;

    if args.percentage {
        let c = battery.state_of_charge();

        let num = f32::from(c);
        let percentage = (num * 100.0) as i32;

        if percentage <= 20 {
            eww_client
                .update("battery_state", "low")
                .wrap_err("Failed to set battery_state")?;
        } else if percentage <= 80 {
            eww_client
                .update("battery_state", "medium")
                .wrap_err("Failed to set battery_state")?;
        } else {
            eww_client
                .update("battery_state", "high")
                .wrap_err("Failed to set battery_state")?;
        }

        match battery.state() {
            battery::State::Charging => update_battery_image(&eww_client, "charging")?,
            _ => {
                if percentage <= 10 {
                    update_battery_image(&eww_client, "10")?;
                } else if percentage <= 20 {
                    update_battery_image(&eww_client, "20")?;
                } else if percentage <= 30 {
                    update_battery_image(&eww_client, "30")?;
                } else if percentage <= 40 {
                    update_battery_image(&eww_client, "40")?;
                } else if percentage <= 50 {
                    update_battery_image(&eww_client, "50")?;
                } else if percentage <= 60 {
                    update_battery_image(&eww_client, "60")?;
                } else if percentage <= 70 {
                    update_battery_image(&eww_client, "70")?;
                } else if percentage <= 80 {
                    update_battery_image(&eww_client, "80")?;
                } else if percentage <= 90 {
                    update_battery_image(&eww_client, "90")?;
                } else {
                    update_battery_image(&eww_client, "100")?;
                }
            }
        }

        print!("{percentage}");
    }

    if args.time {
        if let Some(s) = battery.time_to_empty() {
            print!("{}", time_to_string(s));
        } else if let Some(s) = battery.time_to_full() {
            print!("{}", time_to_string(s));
        } else {
            print!("{}", format_time(0, 0, 0));
        }
    }

    Ok(())
}

fn update_battery_image(eww_client: &EwwClient, name: &str) -> eyre::Result<()> {
    eww_client
        .update(
            "battery_image",
            format!("images/battery_{name}.png").as_str(),
        )
        .wrap_err("Failed to update eww battery_image")?;

    Ok(())
}

fn time_to_string(time: Time) -> String {
    let seconds = time.value.floor();
    let minutes = if seconds > 60.0 { seconds / 60.0 } else { 0.0 };
    let hours = if minutes > 60.0 { minutes / 60.0 } else { 0.0 };

    let seconds = (seconds as i32) % 60;
    let minutes = (minutes as i32) % 60;
    let hours = hours as i32;

    format_time(hours, minutes, seconds)
}

fn format_time(hours: i32, minutes: i32, seconds: i32) -> String {
    format!("{:02}h:{:02}m:{:02}s", hours, minutes, seconds)
}

fn get_first_battery() -> eyre::Result<Option<Battery>> {
    let manager = battery::Manager::new().wrap_err("Failed to create battery manager")?;

    let battery = manager
        .batteries()
        .wrap_err("Failed to get batteries")?
        .enumerate()
        .find_map(|(_, battery)| Some(battery));

    let battery = match battery {
        Some(b) => b.wrap_err("Failed to get battery")?,
        None => return Ok(None),
    };

    Ok(Some(battery))
}
