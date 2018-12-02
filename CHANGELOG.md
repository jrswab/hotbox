# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## [2.0.0] - 2018-12-01
### Added
- Script to run smoked
- Script to edit config.ini which allows the user specify an editor such as
  `config.sh vim` (defaults to Nano)
- Contents of smoke directory to GitIgnore
- Auto execution of install.sh for new users
- Auto execution of tmux for new users
- "enterHotbox.sh" script data to run.sh
- Auto creation of local smoke directory if non-existant (for new containers)

### Changed
- Location of smoke files
- startup script name and usage (runDocker.sh to run.sh)
- `jrswab/hotbox` repo now only holds the files the user needs to run.
- The original repo files to `jrswab/hotbox-dev` repo on gitlab

## Removed
- enterHotbox.sh

## [1.0.1] - 2018-11-30
### Changed
- share-file-size in config.ini.example to 8G
- readme to reflect intrustional changes and updates.

## [1.0.0] - 2018-09-30
### Added
- SMOKE 0.0.5
- Config template with node IPs included
- Escape the docker container with `ctrl+h`
