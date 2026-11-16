# Wireshark TCP 3-Way Handshake Lab

A practical network-analysis lab using the **Cisco CyberOps Workstation** virtual machine, Mininet, Wireshark, and `tcpdump`.

The activity follows the Cisco lab *9.2.6 – Lab: Using Wireshark to Observe the TCP 3-Way Handshake*. It captures traffic between Mininet host **H1** (client) and **H4** (web server), then examines the TCP connection-establishment packets.

> **Status:** Project template prepared. No lab activity has been run as part of creating this repository. Add your own screenshots, packet observations, and answers after completing the lab.

## Objectives

1. Prepare the Mininet hosts to capture traffic.
2. Capture the browser-to-web-server traffic in a PCAP file.
3. Inspect the TCP three-way handshake in Wireshark.
4. Read the saved capture with `tcpdump`.
5. Answer the packet-analysis and reflection questions using your own results.

## Lab environment and requirements

- Cisco CyberOps Workstation virtual machine.
- Login supplied by the lab: username `analyst`, password `cyberops`.
- Mininet topology script already present in the VM:
  `/home/analyst/lab.support.files/scripts/cyberops_topo.py`
- Web-server startup script already present in the VM:
  `/home/analyst/lab.support.files/scripts/reg_server_start.sh`
- Wireshark, `tcpdump`, Firefox, and `xterm` available in the CyberOps VM.
- A working CyberOps VM console.

The topology and server scripts above are **provided by the VM**. They are not recreated or redistributed in this repository.

## Quick start

Run the commands in the CyberOps VM, in the indicated terminals. Follow the detailed walkthrough in [`docs/LAB_WALKTHROUGH.md`](docs/LAB_WALKTHROUGH.md).

### 1. Start the topology

Log in as `analyst`, then run:

```bash
sudo lab.support.files/scripts/cyberops_topo.py
```

At the Mininet prompt:

```text
mininet> xterm H1
mininet> xterm H4
```

### 2. Start the web server on H4

In the H4 terminal:

```bash
/home/analyst/lab.support.files/scripts/reg_server_start.sh
```

### 3. Start the browser and capture on H1

In the H1 terminal:

```bash
su analyst
firefox &
```

After Firefox opens, start the capture:

```bash
sudo tcpdump -i H1-eth0 -v -c 50 -w /home/analyst/capture.pcap
```

While `tcpdump` is capturing, visit:

```text
http://172.16.0.40
```

The lab specifies a 50-packet capture. The browser request must be made while the capture is running.

### 4. Inspect the capture with Wireshark

In the H1 terminal:

```bash
wireshark &
```

Open `/home/analyst/capture.pcap` using **File → Open**, then apply this display filter:

```text
tcp
```

Inspect the first three handshake packets and record the values you actually observe.

### 5. Read the first three TCP packets with tcpdump

```bash
tcpdump -r /home/analyst/capture.pcap tcp -c 3
```

### 6. Clean up Mininet

In the main Mininet terminal:

```text
mininet> quit
```

Back at the CyberOps VM shell:

```bash
sudo mn -c
```

Enter `cyberops` if prompted for the `analyst` user's sudo password.

## Expected TCP handshake pattern

| Packet | Direction | Expected TCP flags | Meaning |
|---|---|---|---|
| 1 | H1 → H4 | SYN | Client requests a TCP connection |
| 2 | H4 → H1 | SYN, ACK | Server acknowledges and responds |
| 3 | H1 → H4 | ACK | Client acknowledges; handshake completes |

Use your own capture to confirm the flags, ports, and relative sequence/acknowledgment numbers. Do not copy sample packet values from the Cisco handout as if they came from your capture.

## Repository contents

- [`COMMANDS.md`](COMMANDS.md) — commands from the activity with concise explanations.
- [`EVIDENCE_CHECKLIST.md`](EVIDENCE_CHECKLIST.md) — evidence to collect for each part.
- [`docs/`](docs/README.md) — walkthrough, analysis notes, and answer worksheet.
- [`scripts/`](scripts/README.md) — optional helper scripts for the exact capture/read commands.
- [`screenshots/`](screenshots/README.md) — screenshot locations and naming guidance.
- [`evidence/`](evidence/README.md) — space for concise text notes and observed results.
- [`captures/`](captures/README.md) — local PCAP capture location; captures are ignored by Git by default.
- [`backup/`](backup/README.md) — optional local backup location; contents are ignored by Git.

## Results worksheet

Complete [`docs/ANALYSIS_WORKSHEET.md`](docs/ANALYSIS_WORKSHEET.md) after inspecting your own packets. Keep the observed values and screenshots consistent.

## Safety and scope

This is a controlled lab using the supplied CyberOps Workstation and Mininet topology. Keep the activity inside that environment. A PCAP can contain network metadata or application data; review it before sharing. This repository does not include Cisco's PDF, VM image, or proprietary lab scripts.

## Completion criteria

- [ ] CyberOps VM started and logged in.
- [ ] Mininet topology started; H1 and H4 terminals opened.
- [ ] Web server started on H4.
- [ ] Browser request from H1 made while `tcpdump` is running.
- [ ] PCAP opened in Wireshark and filtered with `tcp`.
- [ ] Three handshake packets inspected and worksheet completed.
- [ ] First three TCP packets read using `tcpdump -r`.
- [ ] Mininet stopped and cleaned up.
- [ ] Screenshots and notes added without inventing results.
