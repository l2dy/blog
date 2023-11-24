---
up: 
related: 
created: 2023-10-29
tags:
---
## Built-in Keyboard Shortcuts

Use Fn key or "Select ... source" shortcuts to switch input source, which can be enabled in System Settings.

> In addition to the options detailed above for switching input sources, you can also change input sources by using the Fn key. To use this option, in [Keyboard settings](https://support.apple.com/en-sg/guide/mac-help/keyboard-settings-kbdm162/14.0/mac/14.0), click the “Press fn key to” pop-up menu, then choose Change Input Source.

## Input Source Switching API

> Sometimes the input source switching API (`TISSelectInputSource`) does not work properly for some input sources.
> It changes an indicator (statusbar), but behavior of input source is not changed.
>
> This issue is occurred on the input sources which has complex behavior such as Japanese.

It's a macOS bug that CJK input sources can not be switched to reliably by calling the API.

### Workaround

No simple yet reliable workaround.

## References

- https://support.apple.com/en-us/guide/mac-help/kbdm162/mac
- https://github.com/Hammerspoon/hammerspoon/issues/1429
- https://github.com/tekezo/Karabiner/issues/308#issuecomment-190693550
- https://github.com/tekezo/Karabiner/blob/version_10.15.0/src/core/server/Resources/vkchangeinputsourcedef.xml#L210-L236
- https://github.com/nuridol/SwitchIM/blob/db93e4d0f299916670b4a36222abfc84dda9f4b7/SwitchIM/SwitchIM.swift#L132-L140
