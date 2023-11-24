---
up: 
related: 
created: 2023-10-17
tags:
---
## Debug Commands

```bash
iw phy0 info # supported frequencies and TX power
iw phy0 reg get # regulatory domain
iw phy0 channels # DFS state
iw phy0 get txq
iw wlan0 info # current ssid, type, channel & width and txpower
iw dev wlan0 station dump # list of associated stations

# All interfaces' info
iw phy
iw dev
```

## AP Optimization

### Regulatory Domain

The default country 00 is more restrictive than others. For example, under country SG,

1. Channel 32 (5150 - 5170) becomes available.
2. Maximum transmit power (`txpower`) increases from 20 to 23 dBm (subject to device capabilities).

```bash
root@OpenWrt:~# iw phy0 reg get
global
country 00: DFS-UNSET
	(755 - 928 @ 2), (N/A, 20), (N/A), PASSIVE-SCAN
	(2402 - 2472 @ 40), (N/A, 20), (N/A)
	(2457 - 2482 @ 20), (N/A, 20), (N/A), AUTO-BW, PASSIVE-SCAN
	(2474 - 2494 @ 20), (N/A, 20), (N/A), NO-OFDM, PASSIVE-SCAN
	(5170 - 5250 @ 80), (N/A, 20), (N/A), AUTO-BW
	(5250 - 5330 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW, PASSIVE-SCAN
	(5490 - 5730 @ 160), (N/A, 20), (0 ms), DFS, PASSIVE-SCAN
	(5735 - 5835 @ 80), (N/A, 20), (N/A), PASSIVE-SCAN
	(57240 - 63720 @ 2160), (N/A, 0), (N/A)

root@OpenWrt:~# iw phy0 reg get
global
country SG: DFS-FCC
	(2400 - 2483 @ 40), (N/A, 23), (N/A)
	(5150 - 5250 @ 80), (N/A, 23), (N/A), AUTO-BW
	(5250 - 5350 @ 80), (N/A, 20), (0 ms), DFS, AUTO-BW
	(5470 - 5725 @ 160), (N/A, 27), (0 ms), DFS
	(5725 - 5850 @ 80), (N/A, 30), (N/A)
	(57000 - 66000 @ 2160), (N/A, 40), (N/A)
```

See also [https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/tree/db.txt](https://git.kernel.org/pub/scm/linux/kernel/git/sforshee/wireless-regdb.git/tree/db.txt)

```bash
# This is the world regulatory domain
country 00:
	# There is no global intersection for 802.11ah, so just mark the entire
	# possible band as NO-IR
	(755 - 928 @ 2), (20), NO-IR
	(2402 - 2472 @ 40), (20)
	# Channel 12 - 13.
	(2457 - 2482 @ 20), (20), NO-IR, AUTO-BW
	# Channel 14. Only JP enables this and for 802.11b only
	(2474 - 2494 @ 20), (20), NO-IR, NO-OFDM
	# Channel 36 - 48
	(5170 - 5250 @ 80), (20), NO-IR, AUTO-BW
	# Channel 52 - 64
	(5250 - 5330 @ 80), (20), NO-IR, DFS, AUTO-BW
	# Channel 100 - 144
	(5490 - 5730 @ 160), (20), NO-IR, DFS
	# Channel 149 - 165
	(5735 - 5835 @ 80), (20), NO-IR
	# IEEE 802.11ad (60GHz), channels 1..3
	(57240 - 63720 @ 2160), (0)
```

## WiFi Channel Confusion

With an 80 MHz wide channel, the center frequency falls in between 20 MHz channels. OpenWRT and `iw` consider this central frequency in the lower frequency channel.

For example, the 80 MHz wide channel formed from channels 36 and 48 is considered “channel 40”, while the new naming convention for 802.11ac recommends 42 instead.

[https://support.metageek.com/hc/en-us/articles/203532644-802-11ac-Channels](https://support.metageek.com/hc/en-us/articles/203532644-802-11ac-Channels)

## Client mode

```
config wifi-iface 'wifinet1'
	option device 'radio0'
	option mode 'sta'
	option ssid 'AP_SSID'
	option encryption 'psk2'
	option bssid 'xx:xx:xx:xx:xx:xx'
	option key 'xxxxxxxx'
	option network 'wan'
```

Don't use AP+STA on one physical radio without travelmate.

> A logical combination of AP+STA mode on one physical radio allows most of OpenWrt supported router devices to connect to a wireless hotspot/station (STA) and provide a wireless access point (AP) from that hotspot at the same time. Downside of this solution: whenever the STA interface looses the connection it will go into an active scan cycle which renders the radio unusable for AP mode operation, therefore the AP is taken down if the STA looses its association.
> To avoid these kind of deadlocks, travelmate will set all station interfaces to an "always off" mode and connects automatically to available/configured hotspots.

https://github.com/openwrt/packages/blob/openwrt-21.02/net/travelmate/files/README.md

## DFS

### Debug Script

- Save list of unusable channels when radar is detected.

The DFS-RADAR-DETECTED message doesn't show which channels are occupied by radar. `freq` and `chan_width` data is from the channel configured on device.

```sh
#!/bin/ash
set -e

while :; do
  logread -l 100 | grep DFS-RADAR-DETECTED && break || sleep 10
done

date >> /tmp/radar_channels.log
iw phy0 channels >> /tmp/radar_channels.log
```
