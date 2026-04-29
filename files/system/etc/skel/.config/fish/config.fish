# Disable welcome message
set -g fish_greeting

# ============================================================================
# Environment Variables (XDG Base Directory)
# ============================================================================
set -gx XDG_CACHE_HOME $HOME/.cache
set -gx XDG_CONFIG_HOME $HOME/.config
set -gx XDG_DATA_HOME $HOME/.local/share

# ============================================================================
# Application-specific XDG paths
# ============================================================================
# AWS
set -gx AWS_CONFIG_FILE $XDG_CONFIG_HOME/aws/config
set -gx AWS_SHARED_CREDENTIALS_FILE $XDG_CONFIG_HOME/aws/credentials
set -gx AWS_CLI_HISTORY_FILE $XDG_CACHE_HOME/aws/history

# Docker
set -gx DOCKER_CONFIG $XDG_CONFIG_HOME/docker
set -gx DOCKER_BUILDKIT 1

# GPG
set -gx GNUPGHOME $XDG_DATA_HOME/gnupg

# Minikube
set -gx MINIKUBE_HOME $XDG_DATA_HOME/minikube

# NPM
set -gx NPM_CONFIG_USERCONFIG $XDG_CONFIG_HOME/npm/config
set -gx NPM_CONFIG_CACHE $XDG_CACHE_HOME/npm

# PostgreSQL
set -gx PSQL_HISTORY $XDG_CACHE_HOME/pg/psql_history
set -gx PGCLIENTENCODING utf-8

# Python
set -gx PYTHONSTARTUP $XDG_CONFIG_HOME/python/startup

# Rust/Cargo
set -gx CARGO_HOME $XDG_DATA_HOME/cargo
set -gx RUSTUP_HOME $XDG_DATA_HOME/rustup

# WD
set -gx WD_CONFIG $XDG_DATA_HOME/wd/config

# History
set -gx LESSHISTFILE $XDG_CACHE_HOME/less/history

# Bun
set -gx BUN_INSTALL $HOME/.local/share/bun

# ============================================================================
# General Environment Variables
# ============================================================================
set -gx MANPAGER "sh -c 'col -bx | bat -l man -p'"
set -gx EDITOR nvim

# ============================================================================
# PATH Configuration
# ============================================================================
fish_add_path /home/linuxbrew/.linuxbrew/bin
fish_add_path $HOME/.local/bin
fish_add_path $XDG_DATA_HOME/cargo/bin
fish_add_path $HOME/.atuin/bin
fish_add_path $BUN_INSTALL/bin

# ============================================================================
# Cargo environment
# ============================================================================
if test -f $HOME/.local/share/cargo/env.fish
    source $HOME/.local/share/cargo/env.fish
end

# All aliases have been converted to functions in the functions/ directory

# ============================================================================
# Interactive Session Configuration
# ============================================================================
if status is-interactive
    zoxide init fish --cmd m | source
    if type -q sauce
        sauce --shell fish shell init | source
    end
    if type -q wd
        wd --shell fish shell init | source
    end
    starship init fish | source
    atuin init fish --disable-up-arrow | source
end
