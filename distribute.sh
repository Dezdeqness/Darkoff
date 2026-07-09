#!/usr/bin/env bash
#
# Distribute the app to testers.
#   iOS     -> TestFlight
#   Android -> Firebase App Distribution
#
# Usage:
#   ./distribute.sh                      # both platforms, build + upload
#   ./distribute.sh --ios                # iOS only
#   ./distribute.sh --android            # Android only
#   ./distribute.sh --no-upload          # both platforms, build only (no upload, no tags)
#   ./distribute.sh --ios --no-upload    # iOS build check only
#   RELEASE_NOTES="..." ./distribute.sh  # custom release notes for both platforms
#   SKIP_WAIT=1 ./distribute.sh          # iOS: upload without waiting for processing (no TestFlight changelog)
#
set -euo pipefail

ROOT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
cd "${ROOT_DIR}"

export LANG="${LANG:-en_US.UTF-8}"
export LC_ALL="${LC_ALL:-en_US.UTF-8}"

usage() {
  sed -n '2,20p' "${BASH_SOURCE[0]}" | sed 's/^# \{0,1\}//'
}

run_ios=false
run_android=false
explicit_platform=false
no_upload=false

while [[ $# -gt 0 ]]; do
  case "$1" in
    --ios) run_ios=true; explicit_platform=true ;;
    --android) run_android=true; explicit_platform=true ;;
    --no-upload) no_upload=true ;;
    -h|--help) usage; exit 0 ;;
    *) echo "error: unknown argument '$1'" >&2; echo; usage; exit 1 ;;
  esac
  shift
done

# No platform flag -> both platforms.
if [[ "${explicit_platform}" == false ]]; then
  run_ios=true
  run_android=true
fi

label_suffix=""
if [[ "${no_upload}" == true ]]; then
  export NO_UPLOAD=1
  label_suffix=" (build only)"
fi

if [[ "${run_ios}" == true && "$(uname -s)" != "Darwin" ]]; then
  echo "error: run this on macOS — the iOS build requires Xcode." >&2
  exit 1
fi

bundle install --quiet

if [[ "${run_ios}" == true ]]; then
  echo ""
  echo "==> iOS -> TestFlight${label_suffix}"
  bundle exec fastlane ios distribute
fi

if [[ "${run_android}" == true ]]; then
  echo ""
  echo "==> Android -> Firebase App Distribution${label_suffix}"
  bundle exec fastlane android distribute
fi

echo ""
echo "==> Done."
