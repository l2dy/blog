## ZNC Multi-Connect and CertFP

Connect to multiple networks by specifying network name in username in `username/networkname` format.

```irc
/server add networkname IP/port -ssl -username=username/networkname -password=x -autoconnect
/set irc.server.snoonet.ssl_fingerprint xxxx
/set irc.server.libera.ssl_cert "${weechat_config_dir}/ssl/client.pem"
```

Set `irc.server.libera.ssl_fingerprint` to verify with fingerprint only if your server has a self-signed certificate.

## Look and Feel

### Separate Server Buffers

```irc
/set irc.look.server_buffer independent
```

## IRC Smart Filter

```irc
/filter add irc_smart * irc_smart_filter *
```

## XDG Directories

Table of default directories and paths.

Variable              | Default value              | Fallback value
--------------------- | -------------------------- | ------------------------------------------------------------------------
`weechat_config_dir`  | `$XDG_CONFIG_HOME/weechat` | `$HOME/.config/weechat` if `$XDG_CONFIG_HOME` is not defined or empty
`weechat_data_dir`    | `$XDG_DATA_HOME/weechat`   | `$HOME/.local/share/weechat` if `$XDG_DATA_HOME` is not defined or empty
`weechat_cache_dir`   | `$XDG_CACHE_HOME/weechat`  | `$HOME/.cache/weechat` if `$XDG_CACHE_HOME` is not defined or empty
`weechat_runtime_dir` | `$XDG_RUNTIME_DIR/weechat` | same as cache directory if `$XDG_RUNTIME_DIR` is not defined or empty

| Option                       | Default value                                     |
|------------------------------|---------------------------------------------------|
| `fifo.file.path`             | `${weechat_runtime_dir}/weechat_fifo_${info:pid}` |
| `logger.file.path`           | `${weechat_data_dir}/logs`                        |
| `relay.network.ssl_cert_key` | `${weechat_config_dir}/ssl/relay.pem`             |
| `script.scripts.path`        | `${weechat_cache_dir}/script`                     |
| `weechat.plugin.path`        | `${weechat_data_dir}/plugins`                     |
| `xfer.file.download_path`    | `${weechat_data_dir}/xfer`                        

https://github.com/weechat/weechat/blob/b614a5c5db243ad64f0ab32e4e68d221e57878b7/ReleaseNotes.adoc#v3.2_xdg_directories