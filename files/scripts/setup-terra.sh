#!/usr/bin/env bash
# Installs terra-release, which sets up the Terra repo file and GPG key.
# This follows the official Fyra Labs installation method for Fedora.
# The repo persists in the image for post-install updates via `bootc upgrade`.

set -oue pipefail

dnf install -y \
    --nogpgcheck \
    --repofrompath "terra,https://repos.fyralabs.com/terra${OS_VERSION}" \
    terra-release
