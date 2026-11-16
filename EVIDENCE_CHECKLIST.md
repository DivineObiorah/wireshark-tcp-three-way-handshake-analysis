# Evidence Checklist

Capture evidence as you perform the lab. These are recommended screenshots/notes, not evidence that the activity has already been completed.

## Part 1 — Prepare the hosts and capture traffic

- [ ] `01-cyberops-desktop.png` — CyberOps Workstation running and logged in as `analyst`. Avoid exposing unrelated personal information.
- [ ] `02-mininet-topology.png` — main terminal showing the topology script started and Mininet prompt.
- [ ] `03-h1-h4-terminals.png` — H1 and H4 terminal windows open; include host labels if visible.
- [ ] `04-h4-web-server.png` — H4 terminal showing the supplied web-server startup command and its resulting status/output.
- [ ] `05-h1-firefox.png` — Firefox running on H1; show the requested `172.16.0.40` page if it loads.
- [ ] `06-tcpdump-capture.png` — H1 terminal showing the `tcpdump` command and capture completion/output.

## Part 2 — Analyze packets using Wireshark

- [ ] `07-wireshark-tcp-filter.png` — opened `capture.pcap` with the `tcp` display filter applied.
- [ ] `08-handshake-syn.png` — first handshake packet selected; show TCP source/destination ports, SYN flag, and relative sequence number.
- [ ] `09-handshake-syn-ack.png` — second packet selected; show ports, SYN and ACK flags, relative sequence and acknowledgment numbers.
- [ ] `10-handshake-ack.png` — third packet selected; show ACK flag and relative sequence/acknowledgment numbers.

## Part 3 — View packets using tcpdump

- [ ] `11-tcpdump-man-r-option.png` — manual page search for `-r` and the option description.
- [ ] `12-tcpdump-read-three.png` — output of `tcpdump -r /home/analyst/capture.pcap tcp -c 3`.

## Cleanup and documentation

- [ ] `13-mininet-quit.png` — Mininet terminal after `quit` completes.
- [ ] `14-mininet-cleanup.png` — `sudo mn -c` command and cleanup output.
- [ ] Complete `docs/ANALYSIS_WORKSHEET.md` with values observed in your own capture.
- [ ] Add a short outcome summary to `evidence/RESULTS.md`.

## Screenshot quality and naming

1. Capture the relevant application/terminal only; crop unnecessary desktop space where practical.
2. Keep command text and important output readable.
3. Do not edit packet values or terminal output.
4. Avoid duplicate screenshots. One clear screenshot per checklist item is usually enough.
5. Use the numbered lowercase names above to keep evidence in task order.
6. If a step fails, document the error honestly; do not replace it with a fabricated successful screenshot.
7. Do not include passwords, private keys, unrelated personal data, or sensitive traffic payloads.

You do not need to commit the PCAP if it contains sensitive traffic. The repository ignores PCAP files by default; use a sanitized screenshot and written observations where appropriate.
