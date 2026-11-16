# TCP Three-Way Handshake Notes

The lab focuses on the TCP connection-establishment exchange between the browser host H1 and the web server on H4.

1. **SYN** — the client initiates a TCP connection.
2. **SYN-ACK** — the server acknowledges the client's request and sends its own synchronization request.
3. **ACK** — the client acknowledges the server's response. The connection is established.

## What to inspect

In Wireshark, expand **Transmission Control Protocol** and inspect:

- Source and destination ports.
- TCP flags.
- Relative sequence number.
- Relative acknowledgment number.

In the lab's tcpdump example, the flags appear as `[S]`, `[S.]`, and `[.]`, corresponding to SYN, SYN+ACK, and ACK.

## Important distinction

A typical client source port is an ephemeral/dynamic port, while the HTTP server destination port is normally port 80. Confirm the actual ports in your own capture. The handout's sample client port and sequence values are not universal and should not be copied into your results.
