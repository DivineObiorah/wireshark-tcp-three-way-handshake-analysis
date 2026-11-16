# Commands Reference

Commands below are taken from, or directly support, the Cisco TCP three-way-handshake lab. Run them in the CyberOps Workstation VM, in the terminal/host specified.

## Part 1 — Prepare hosts and capture traffic

| Command | Where | Purpose |
|---|---|---|
| `sudo lab.support.files/scripts/cyberops_topo.py` | Main CyberOps VM terminal | Starts the supplied Mininet topology. |
| `xterm H1` | Mininet prompt | Opens a terminal for host H1 (client). |
| `xterm H4` | Mininet prompt | Opens a terminal for host H4 (web server). |
| `/home/analyst/lab.support.files/scripts/reg_server_start.sh` | H4 terminal | Starts the supplied web server on H4. |
| `su analyst` | H1 terminal | Switches from root to the `analyst` account so Firefox can be launched as the lab requires. |
| `firefox &` | H1 terminal | Starts Firefox in the background. |
| `sudo tcpdump -i H1-eth0 -v -c 50 -w /home/analyst/capture.pcap` | H1 terminal | Captures up to 50 packets from H1's `H1-eth0` interface and writes them to the PCAP file. |

### Open the web page during capture

In Firefox on H1, navigate to:

```text
http://172.16.0.40
```

The lab says to navigate quickly after starting `tcpdump`, because the capture is limited to 50 packets.

## Part 2 — Wireshark analysis

| Command/action | Purpose |
|---|---|
| `wireshark &` | Starts Wireshark in the background on H1. |
| File → Open → `/home/analyst/capture.pcap` | Loads the saved packet capture. |
| Display filter `tcp` | Shows TCP packets in the capture. |

In the packet details pane, expand **Transmission Control Protocol**, then **Flags**. Record source/destination ports, flags, and relative sequence/acknowledgment numbers for the three handshake packets.

## Part 3 — Read the capture with tcpdump

| Command/action | Purpose |
|---|---|
| `man tcpdump` | Opens the tcpdump manual. |
| `/-r` then `n` | Searches forward in the manual for the `-r` option and advances to the next match. |
| `q` | Exits the manual. |
| `tcpdump -r /home/analyst/capture.pcap tcp -c 3` | Reads the saved PCAP, selects TCP traffic, and displays up to three packets. |

**Option meanings**

- `-i H1-eth0`: capture from the named network interface.
- `-v`: verbose output.
- `-c 50`: stop after 50 packets.
- `-w FILE`: write captured packets to a file.
- `-r FILE`: read packets from a previously saved capture file.
- `tcp`: packet-selection expression limiting output to TCP packets.
- `-c 3`: display up to three packets when reading the capture.

## Cleanup

| Command | Where | Purpose |
|---|---|---|
| `quit` | Main Mininet prompt | Stops the Mininet session and its topology. |
| `sudo mn -c` | Main CyberOps VM shell | Cleans up Mininet processes and residual state. |

The lab specifies the sudo password `cyberops` when prompted for the `analyst` account.

## Optional repository helper scripts

The scripts in [`scripts/`](scripts/README.md) wrap the capture and read commands for convenience. They are repository-authored helpers, not Cisco-provided scripts. The exact commands above remain the authoritative lab commands.
