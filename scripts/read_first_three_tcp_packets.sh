#!/usr/bin/env bash
# Repository helper for reading the first three TCP packets from the lab PCAP.
set -euo pipefail

CAPTURE="${1:-/home/analyst/capture.pcap}"
COUNT="${2:-3}"

if [[ ! -f "$CAPTURE" ]]; then
  echo "Error: capture file not found: $CAPTURE" >&2
  echo "Run the capture step on H1 first." >&2
  exit 1
fi

tcpdump -r "$CAPTURE" tcp -c "$COUNT"
