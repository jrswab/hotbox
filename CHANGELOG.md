# Changelog
All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## [Unreleased]

## 2.2.0 - 2020-02-29
### Added
- `rpc-config.ini`
- `seed-config.ini`
- user input to check if RPC node or not

### Changed
- `config.ini.example` to `witness-config.ini`
- tmux name to include hotkeys for changing widows and leaving the hotbox correctly.
- smoked to light version for seed nodes and witnesses
- install.sh if statements to case statements.
- wallet.sh RPC to jrswab.com
- witness and seed config `shared-file-size` to 12G

### Fixed
- setup.sh not adding new lines during walk through.
- witness shared-file-size
- continuation issue when user enters an invalid user name

## 2.1.0 - 2020-02-27
### Added
- Witness disabled check to update script
- Script to setup a new server running a debian based system.
  - Does basic security updates
  - Installs Docker
  - Creates new user
  - Creates hotbox directory and downloads `run.sh`

### Updated
- changelog.md with missing releases
- contributing.md
- .gitinore
- .dockerignore

### Changed
- update.sh to be the core file.
- install.sh to create a tmux session with two windows
- install.sh from hard coded version numbers to variables.
- readme.md to have quick information now that walkthroughs are in github wiki
- relase to be `secureMe.sh` instead of `run.sh`

## 2.0.5 - 2020-02-22
### Changed
- Config.ini plugins for less RAM usage

## 2.0.4 - 2020-02-21
### Changed
- Update file to pull smoked v0.1.0
- Install file to pull smoke v0.1.0

## 2.0.3 - 2019-11-19
### Changed
- Update file to pull smoked v0.0.7
- Install file to pull smoke v0.0.7

### Fixed
- Incorrect wget url
- Update script url

# 2.0.2 - 2018-12-31
### Added
- Update script

### Fixed
- Missing wget

## 2.0.1 - 2018-12-27
### Changed
- Install file to pull smoke v0.0.6

## 2.0.0 - 2018-12-01
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

## 1.0.1 - 2018-11-30
### Changed
- share-file-size in config.ini.example to 8G
- readme to reflect intrustional changes and updates.

## 1.0.0 - 2018-09-30
### Added
- SMOKE 0.0.5
- Config template with node IPs included
- Escape the docker container with `ctrl+h`
