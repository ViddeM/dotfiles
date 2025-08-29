use chrono::{Datelike, Local, Timelike};
use clap::Parser;

#[derive(Parser, Debug)]
struct Args {
    #[arg(long)]
    hour: bool,
    #[arg(long)]
    minutes: bool,
    #[arg(long("day-of-week"))]
    day_of_week: bool,
    #[arg(long)]
    day: bool,
    #[arg(long)]
    month: bool,
    #[arg(long)]
    year: bool,
}

fn main() -> eyre::Result<()> {
    let args = Args::parse();

    let args_count = vec![
        args.hour,
        args.minutes,
        args.day_of_week,
        args.day,
        args.month,
        args.year,
    ]
    .into_iter()
    .filter(|&b| b == true)
    .count();

    eyre::ensure!(args_count > 0, "No output mode specified");

    eyre::ensure!(
        args_count == 1,
        "More than one output mode was specified, please specify exactly 1."
    );

    let now = Local::now();
    if args.hour {
        print!("{:02}", now.hour());
    }

    if args.minutes {
        print!("{:02}", now.minute());
    }

    let date = now.date_naive();
    if args.day_of_week {
        print!("{}", date.weekday());
    }

    if args.day {
        print!("{}", date.day());
    }

    if args.month {
        print!("{}", date.month());
    }

    if args.year {
        print!("{}", date.year());
    }

    Ok(())
}
