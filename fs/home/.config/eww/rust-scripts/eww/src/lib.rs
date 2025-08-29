use std::{
    io,
    path::{Path, PathBuf},
    process::Command,
};

pub struct EwwClient {
    config_path: Option<PathBuf>,
}

#[derive(thiserror::Error, Debug)]
pub enum EwwError {
    #[error("IO Error `{0}`")]
    IoError(#[from] io::Error),
}

pub type EwwResult<T> = Result<T, EwwError>;

impl EwwClient {
    pub fn new() -> Self {
        Self { config_path: None }
    }

    pub fn with_config_path(path: impl AsRef<Path>) -> Self {
        Self {
            config_path: Some(path.as_ref().into()),
        }
    }

    fn eww_single(&self, arg: String) -> EwwResult<()> {
        return self.eww(vec![arg]);
    }

    fn eww(&self, args: Vec<String>) -> EwwResult<()> {
        let mut command = Command::new("eww");
        if let Some(path) = self.config_path.as_ref() {
            command.arg("-c");
            command.arg(path);
        }
        command.args(args);
        command.output()?;

        Ok(())
    }

    pub fn update(&self, key: &str, value: &str) -> EwwResult<()> {
        self.eww(vec![String::from("update"), format!("{key}={value}")])
    }

    pub fn inspector(&self) -> EwwResult<()> {
        self.eww_single("inspector".into())
    }
}
