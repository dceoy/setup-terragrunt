#!/usr/bin/env bash
#
# Usage:
#  ./entrypoint.sh <terragrunt_version> <directory_path>

set -euo pipefail

if [[ "${1}" == '--debug' ]]; then
  set -x && shift
fi

TERRAGRUNT_VERSION="${1:-latest}"
DIRECTORY_PATH="${2:-/usr/local/bin}"
TERRAGRUNT_PATH="${DIRECTORY_PATH%/}/terragrunt"
ARCH_TYPE="$(uname -s | tr '[:upper:]' '[:lower:]')_$([[ "$(uname -m)" == 'x86_64' ]] && echo 'amd64' || echo 'arm64')"

if [[ "${TERRAGRUNT_VERSION}" == 'latest' ]]; then
  curl -sSL https://api.github.com/repos/gruntwork-io/terragrunt/releases/latest \
    | jq -r ".assets[] | select(.name | endswith(\"${ARCH_TYPE}\")) | .browser_download_url" \
    | xargs curl -sSL -o "${TERRAGRUNT_PATH}"
else
  curl -sSL -o "${TERRAGRUNT_PATH}" \
    "https://github.com/gruntwork-io/terragrunt/releases/download/v${TERRAGRUNT_VERSION}/terragrunt_${ARCH_TYPE}"
fi
chmod +x "${TERRAGRUNT_PATH}"

if [[ -n "${GITHUB_ACTIONS:-}" ]]; then
  installed_terragrunt_version="$(${TERRAGRUNT_PATH} --version)"
  echo "terragrunt-version=${installed_terragrunt_version#terragrunt version }" >> "${GITHUB_OUTPUT}"
  echo "terragrunt-path=${TERRAGRUNT_PATH}" >> "${GITHUB_OUTPUT}"
fi
