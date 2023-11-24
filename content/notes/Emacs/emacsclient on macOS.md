---
up: 
related: 
created: 2023-09-14
tags:
  - emacs
  - macos
---
## Starting Emacs Server Automatically

Configure a macOS launch agent with the plist file and load it with `launchctl`.

```
launchctl load -w ~/Library/LaunchAgents/gnu.emacs.daemon.plist
```

```xml
<!-- Put following in ~/Library/LaunchAgents/gnu.emacs.daemon.plist -->
<?xml version="1.0" encoding="UTF-8"?>
<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">
<plist version="1.0">
<dict>
    <key>Label</key>
    <string>gnu.emacs.daemon</string>

    <key>ProgramArguments</key>
    <array>
        <string>/Applications/MacPorts/Emacs.app/Contents/MacOS/Emacs</string>
        <string>--fg-daemon</string>
    </array>

    <key>RunAtLoad</key>
    <true/>

    <key>ProcessType</key>
    <string>Interactive</string>
</dict>
</plist>
```

## Emacs Client with AppleScript

Save the following in `Script Editor.app` as an Application.

```AppleScript
do shell script "/Applications/MacPorts/Emacs.app/Contents/MacOS/bin/emacsclient -c -n"
```

> ⚠ **Warning:** Without `-n` the applet won't quit and prevents system sleep.