#!/usr/bin/env bash
# Bootstrap Terra repo.  The terra-release and terra-gpg-keys packages are
# only reachable via the metalink mirror, not the direct baseurl, so we must
# deploy the metalink-based .repo first before installing them.

set -oue pipefail

curl -fsSL \
    "https://raw.githubusercontent.com/terrapkg/packages/f${OS_VERSION}/anda/terra/release/terra.repo" \
    -o /etc/yum.repos.d/terra.repo

dnf install -y --nogpgcheck terra-gpg-keys terra-release
