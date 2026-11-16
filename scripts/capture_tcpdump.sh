#!/usr/bin/env bash
# Repository helper for the Cisco CyberOps TCP handshake lab.
# Run inside the H1 terminal after switching to the analyst account.
set -euo pipefail

INTERFACE="${1:-H1-eth0}"
OUTPUT="${2:-/home/analyst/capture.pcap}"
COUNT="${3:-50}"

if ! command -v tcpdump >/dev/null 2>&1; then
  echo "Error: tcpdump is not installed or not in PATH." >&2
  exit 1
fi

echo "Capturing up to ${COUNT} packets on ${INTERFACE}."
echo "Output file: ${OUTPUT}"
echo "While capture is running, browse to http://172.16.0.40 on H1."
sudo tcpdump -i "$INTERFACE" -v -c "$COUNT" -w "$OUTPUT"
