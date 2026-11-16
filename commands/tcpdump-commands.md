# tcpdump Commands

Run these inside the CyberOps Workstation VM in the host/terminal specified.

## Capture on H1

```bash
sudo tcpdump -i H1-eth0 -v -c 50 -w /home/analyst/capture.pcap
```

- `-i H1-eth0`: select H1's interface.
- `-v`: verbose progress/output.
- `-c 50`: stop after 50 packets.
- `-w`: write packets to the specified capture file.

While the capture is running, navigate Firefox on H1 to `http://172.16.0.40`.

## Read the first three TCP packets

```bash
tcpdump -r /home/analyst/capture.pcap tcp -c 3
```

- `-r`: read from a saved capture file.
- `tcp`: select TCP packets.
- `-c 3`: stop after displaying three packets.

## Read the manual

```bash
man tcpdump
```

In the manual, type `/-r` to search forward, `n` for the next match, and `q` to exit.

## Mininet cleanup

At the Mininet prompt:

```text
quit
```

Then at the CyberOps VM shell:

```bash
sudo mn -c
```
