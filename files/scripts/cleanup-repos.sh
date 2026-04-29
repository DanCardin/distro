#!/usr/bin/env bash
# Remove any build-time repos that shouldn't ship in the final image.
# Terra and RPMFusion are intentionally kept — they're needed for post-boot
# updates via `bootc upgrade`.
# If you enabled the CachyOS kernel, uncomment the line below: kernel updates
# come through image rebuilds, so the COPR isn't needed at runtime.

set -oue pipefail

# rm -f /etc/yum.repos.d/_copr_bieszczaders-kernel-cachyos.repo
