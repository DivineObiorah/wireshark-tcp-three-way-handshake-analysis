# Lab Walkthrough

## Before starting

Use the Cisco CyberOps Workstation VM. The lab's required login is `analyst` / `cyberops`. The following paths are expected to exist inside that VM:

- `/home/analyst/lab.support.files/scripts/cyberops_topo.py`
- `/home/analyst/lab.support.files/scripts/reg_server_start.sh`

These are supplied by the lab environment. Do not replace them with locally invented versions.

## Part 1 — Prepare the hosts to capture traffic

### Step 1: Start the VM and log in

Start CyberOps Workstation and sign in as `analyst`.

### Step 2: Start Mininet

In the main VM terminal:

```bash
sudo lab.support.files/scripts/cyberops_topo.py
```

This starts the lab's Mininet network topology. Wait for the `mininet>` prompt.

### Step 3: Open H1 and H4 terminals

At the Mininet prompt, enter each command:

```text
xterm H1
xterm H4
```

H1 is used as the client/browser host. H4 hosts the web server.

### Step 4: Start the web server on H4

In the H4 terminal:

```bash
/home/analyst/lab.support.files/scripts/reg_server_start.sh
```

Keep the H4 terminal available while doing the capture.

### Step 5: Switch to analyst on H1

In the H1 terminal:

```bash
su analyst
```

The lab notes that Firefox cannot be run from the root account, so switch to `analyst`.

### Step 6: Start Firefox on H1

```bash
firefox &
```

Wait for the browser window to open.

### Step 7: Start tcpdump on H1

In the H1 terminal:

```bash
sudo tcpdump -i H1-eth0 -v -c 50 -w /home/analyst/capture.pcap
```

The command captures on `H1-eth0`, writes the packets to `/home/analyst/capture.pcap`, and stops after 50 packets. The `-v` option enables verbose progress output.

### Step 8: Generate HTTP traffic

While tcpdump is running, quickly navigate Firefox to:

```text
http://172.16.0.40
```

The request creates the client/server traffic that the lab asks you to inspect. Wait for the capture to finish.

## Part 2 — Analyze packets using Wireshark

### Step 1: Open the saved capture

In the H1 terminal:

```bash
wireshark &
```

If the lab VM displays the superuser warning described in the handout, follow its prompt. In Wireshark, choose **File → Open** and select:

```text
/home/analyst/capture.pcap
```

### Step 2: Apply a TCP display filter

Enter this in the display-filter bar:

```text
tcp
```

The handout's example identifies the first three frames as the traffic of interest. Confirm the handshake sequence in your own capture rather than assuming frame numbers or values will always match.

### Step 3: Inspect packet 1

Select the first handshake packet in the packet list. In the packet details pane:

1. Expand **Transmission Control Protocol**.
2. Record the source and destination ports.
3. Expand **Flags**.
4. Identify the set flag(s).
5. Record the relative sequence number.

The expected role of packet 1 is the client-to-server SYN request.

### Step 4: Inspect packet 2

Select the server's reply. Record:

- Source and destination ports.
- Set TCP flags.
- Relative sequence number.
- Relative acknowledgment number.

The expected role of packet 2 is SYN plus ACK from server to client.

### Step 5: Inspect packet 3

Select the third handshake packet. Identify the set flag(s) and record relative sequence and acknowledgment numbers. The handout explains that the relative sequence and acknowledgment numbers are shown as 1 at this point in its example and that the TCP connection is established.

Your display may differ depending on capture and Wireshark settings; record what your own packet details show.

## Part 3 — View packets using tcpdump

### Step 1: Read the manual

Open a terminal and run:

```bash
man tcpdump
```

Search forward for the `-r` option by typing:

```text
/-r
```

Press `n` to move to the next match and `q` to exit the manual. Answer the worksheet question about what `-r` does.

### Step 2: Read the first three TCP packets

Run:

```bash
tcpdump -r /home/analyst/capture.pcap tcp -c 3
```

This reads the saved capture, filters for TCP, and displays up to three packets. Compare the flags and direction with the Wireshark handshake.

The Cisco handout shows example output with `[S]`, `[S.]`, and `[.]` flag notation. Treat those as examples, not guaranteed values from your capture.

## Cleanup

### Step 1: Stop Mininet

Return to the main terminal showing the `mininet>` prompt and enter:

```text
quit
```

Wait for Mininet to stop its controllers, terminals, links, switches, and hosts.

### Step 2: Clean up Mininet state

At the CyberOps VM shell:

```bash
sudo mn -c
```

Enter the `analyst` sudo password (`cyberops`) if prompted.

## After the lab

1. Complete `ANALYSIS_WORKSHEET.md`.
2. Save screenshots listed in the root `EVIDENCE_CHECKLIST.md`.
3. Write a brief, factual summary in `../evidence/RESULTS.md`.
4. Review PCAPs before sharing; they are ignored by Git by default.
