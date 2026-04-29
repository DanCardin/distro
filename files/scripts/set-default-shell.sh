#!/usr/bin/env bash
set -euo pipefail

# Set fish as the default shell for new users
sed -i 's|^SHELL=.*|SHELL=/usr/bin/fish|' /etc/default/useradd
