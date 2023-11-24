---
up: 
related: 
created: 2023-11-15
tags:
---
## Build from Source

> Provisioning profile "iOS Team Provisioning Profile: ..." doesn't support the Associated Domains, Fonts, iCloud, and Push Notifications capability.

Follow the README to build Blink Shell in Xcode. With a free developer account, these entitlements are not supported, and therefore breaks functionality link WebAuthn.

## Crash on Start

Crash log contains `Termination Reason: SIGNAL 5 Trace/BPT trap: 5`, which indicates that it's a memory safety issue from programming errors.

On the line where the program crashed, Blink constructs a URL from `BlinkPaths.groupContainerPath()` without null-safety checks.

```swift
let migratorFileURL = URL(fileURLWithPath: BlinkPaths.groupContainerPath()).appendingPathComponent(".migrator")
```

`BlinkPaths.groupContainerPath()` in turn calls the [`containerURLForSecurityApplicationGroupIdentifier`](https://developer.apple.com/documentation/foundation/nsfilemanager/1412643-containerurlforsecurityapplicati) method on the default `NSFileManager`, which in iOS,  returns `nil` when the group identifier invalid for the app, i.e. missing from it's App Groups Entitlement.

## AltStore Modifications

### App Groups in Entitlements

AltStore replaces the original app group with a new one to workaround Apple's restrictions. In `func updateAppGroups`, each app group identifier is appended with a `.` and the team identifier used to sign the app.

```swift
for groupIdentifier in applicationGroups
{
    let adjustedGroupIdentifier = groupIdentifier + "." + team.identifier
    
    if let group = fetchedGroups.first(where: { $0.groupIdentifier == adjustedGroupIdentifier })
    {
        groups.append(group)
    }
    else
    {
        dispatchGroup.enter()
        ...
```

### File Providers

Any `NSExtensionFileProviderDocumentGroup` is rewritten into the new app group as well.

The `filter` and `min` chain ensures that the shortest matching candidate is found.

```swift
// To keep file providers working, remap the NSExtensionFileProviderDocumentGroup, if there is
one.
if var extensionInfo = infoDictionary["NSExtension"] as? [String: Any],
    let appGroup = extensionInfo["NSExtensionFileProviderDocumentGroup"] as? String,
    let localAppGroup = appGroups.filter({ $0.contains(appGroup) }).min(by: { $0.count < $1.count })
{
    extensionInfo["NSExtensionFileProviderDocumentGroup"] = localAppGroup
    infoDictionary["NSExtension"] = extensionInfo
}
```

### App bundle IDs

The `parentBundleID` is also modified to include the team ID.

```swift
if application.isAltStoreApp
{
    // Use legacy bundle ID format for AltStore (and its extensions).
    updatedParentBundleID = "com.\(team.identifier).\(parentBundleID)"
}
else
{
    updatedParentBundleID = parentBundleID + "." + team.identifier // Append just team identifier to make it harder to track.
}

let bundleID = application.bundleIdentifier.replacingOccurrences(of: parentBundleID, with: updatedParentBundleID)
```

## Verification

Crash explicitly and log app group ID on successful invocation.

```diff
diff --git a/BlinkConfig/BlinkPaths.m b/BlinkConfig/BlinkPaths.m
--- a/BlinkConfig/BlinkPaths.m
+++ b/BlinkConfig/BlinkPaths.m
@@ -29,6 +29,7 @@
 //
 ////////////////////////////////////////////////////////////////////////////////

+#import <os/log.h>
 #import "BlinkPaths.h"
 #import "XCConfig.h"

@@ -66,6 +67,13 @@ NSString *__iCloudsDriveDocumentsPath = nil;

     NSFileManager *fm = [NSFileManager defaultManager];
     NSString *path = [fm containerURLForSecurityApplicationGroupIdentifier:groupID].path;
+
+    if (path == nil) {
+      [NSException raise:@"Invalid app group ID" format:@"app group %@ not found", groupID];
+    } else {
+      os_log(OS_LOG_DEFAULT, "app group %{public}@ found", groupID);
+    }
+
     __groupContainerPath = path;
   }
   return __groupContainerPath;
```

Before iOS 10, `NSLog(@"app group %@ found", groupID);` can be used instead.

## Fix

```
NSString *groupID = [XCConfig infoPlistFullGroupID];
```

The key used to search for the group's container directory is `BLINK_GROUP_ID` from `XCConfig`, which is stored in `BlinkConfig/Info.plist`.

You can use the variable `TEAM_ID` from the `developer_setup.xcconfig` file if you have followed Blink's guidance on building and installing Blink yourself.

```diff
diff --git a/BlinkConfig/Info.plist b/BlinkConfig/Info.plist
--- a/BlinkConfig/Info.plist
+++ b/BlinkConfig/Info.plist
@@ -5,7 +5,7 @@
 	<key>BLINK_CLOUD_ID</key>
 	<string>$(CLOUD_ID)</string>
 	<key>BLINK_GROUP_ID</key>
-	<string>$(GROUP_ID)</string>
+	<string>$(GROUP_ID).$(TEAM_ID)</string>
 	<key>BLINK_KEYCHAIN_ID1</key>
 	<string>$(KEYCHAIN_ID1)</string>
 	<key>BLINK_REVCAT_PUBKEY</key>
```

Hardcoding the team ID or modifying Blink's code to auto-detect the new app group would work as well.

## References

- https://developer.apple.com/documentation/xcode/identifying-the-cause-of-common-crashes#Determine-whether-the-crash-is-a-Swift-runtime-error
- https://github.com/blinksh/blink/blob/77d3cec7ff7dc7f2389d372d1d10dba9b9d6aaec/Blink/Migrator/Migrator.swift#L42
- https://github.com/altstoreio/AltStore/blob/7d7e098ef5e48fe346430e068271d1b1ae49817b/AltServer/Devices/ALTDeviceManager%2BInstallation.swift#L849
- https://stackoverflow.com/a/45957891
