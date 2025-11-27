#!/usr/bin/env bash
# Return a working directory for new terminals; fallback to $PWD.
set -euo pipefail

printf '%s\n' "${PWD:-$HOME}"
