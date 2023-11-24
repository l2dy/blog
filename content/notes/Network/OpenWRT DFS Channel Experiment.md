---
up: 
related: 
created: 2023-10-31
tags:
---
> This option allows hostapd to select one of the provided channels when a channel should be automatically selected.

```bash
uci set wireless.radio0.channel=auto
uci add_list wireless.radio0.channels=52-144
uci commit

wifi
```