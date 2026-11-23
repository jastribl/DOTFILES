# DOTFILES

A collection of shell, Git, tmux, Vim, editor, and machine setup configuration for personal Macs and work development machines.

## What lives here

- `dotfiles/` contains files and profile variants deployed into the home directory or used as machine-specific settings.
- `update-scripts/` contains the setup and update scripts. Runtime state and selected package lists live under its ignored `cache/` and `brew/` directories.
- `Sublime/`, `iterm2/`, `file_templates/`, and `random-settings/` contain application settings, templates, and saved preferences.
- `setup-od.sh` is the OnDemand-specific entry point. It selects work profiles and starts a work shell session.
- `update.sh` runs the regular update scripts. Run it from the repository root.

## First-time setup

1. Clone this repository to `~/Github/DOTFILES`.
2. Make sure Bash 4 or newer is available. On macOS, `update-osx.sh` can install Homebrew and configure the Homebrew Bash.
3. Run `./update.sh` from the repository root. The script checks for an SSH public key unless passed `-s`, then deploys dotfiles and runs platform setup scripts.
4. On a work OnDemand machine, run `./setup-od.sh` to select work-specific profiles and start the appropriate work directory session.

The first run may ask which profile to use for machine-specific settings. Selections are saved under the ignored `update-scripts/cache/prefs/` directory. To change a selection, edit or remove the corresponding `.pref` file there and run `./update.sh` again.

## Machine profiles

Profile variants are stored in directories under `dotfiles/`, including `bashrc.local/`, `gitconfig.local/`, `ssh/config.local/`, `brew-list/`, and `cask-list/`. The profile name represents the machine or context, such as `personal`, `facebook`, or `facebook.devserver`. OS-specific settings use `osx` and `linux` variants.

On macOS, the selected Homebrew and cask inventory is copied to ignored runtime files under `update-scripts/brew/`. Edit the tracked profile in `dotfiles/brew-list/` or `dotfiles/cask-list/`; do not edit the generated runtime copy.

## Updating

Run `./update.sh` from the repository root. Individual update scripts are rate-limited using timestamps in `update-scripts/cache/`. Use `./update.sh -f` to force all update scripts to run, or `./update.sh -s` to skip the SSH-key check. Some scripts install or update packages and plugins, so their behavior depends on the platform and installed tools.

## Notes

- The setup scripts are primarily Bash and expect the repository to be at `~/Github/DOTFILES`.
- `update-osx.sh` configures macOS preferences, Homebrew packages, Sublime Text settings, Rectangle settings, and editor extension inventories.
- Work-specific configuration depends on tools and services available only in the work environment.
- Review machine-specific scripts and profile files before using them on a new machine; some contain work paths and commands.
