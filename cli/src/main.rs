mod app;

use crate::app::App;
use clap::{Parser, Subcommand};

#[derive(Parser)]
#[command(version, about, long_about = None)]
struct Cli {
    #[command(subcommand)]
    command: Option<Commands>,
}

#[derive(Subcommand)]
enum Commands {
    /// Install wallpapers on the system
    InstallWallpapers,
    /// Uninstall wallpapers from the system
    UninstallWallpapers,
}

fn main() {
    let cli = Cli::parse();
    let app = App::new();

    match &cli.command {
        Some(Commands::InstallWallpapers) => {
            app.install_wallpapers();
        }
        Some(Commands::UninstallWallpapers) => {
            app.uninstall_wallpapers();
        }
        None => {}
    }
}
