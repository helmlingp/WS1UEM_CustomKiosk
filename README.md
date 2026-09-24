# Example Windows Custom Kiosk Profiles

This repository contains example Omnissa Workspace ONE custom kiosk profile XML files and supporting PowerShell scripts for deploying icons and shortcut links used by kiosk layouts.

The examples are intended as a starting point for customizing Assigned Access profiles for Windows 10 and Windows 11 kiosk scenarios.

## Included files

### Profile examples

- `Win10_Example_KioskProfile.xml`  
  Base Windows 10 kiosk profile with a standard `AllowedApps` list and default profile configuration.

- `Win10_Example_KioskProfile_Chrome_AutoLaunch.xml`  
  Similar to the base example, but includes a Chrome application configured for auto-launch using `rs5:AutoLaunch="true"`.

- `Win10_Example_KioskProfile_with_CitrixWorkspaceApp.xml`  
  Example that includes Citrix Workspace in the allowed apps list.

- `Win10_Example_SingleAppUWPKioskProfile.xml`  
  Example focused on a single UWP application kiosk experience.

- `Win11_Example_KioskProfile.xml`  
  Windows 11 profile example with `StartLayout` and `v5:StartPins` entries for Start menu pinning.

- `Win11_Example_MultiUser_KioskProfile copy.xml`  
  Windows 11 multi-user kiosk profile example showing a profile pattern that can be adapted for group-based assignments.

### PowerShell helper scripts

- `ExampleDeployIcons.ps1`  
  Copies icon files from a local `Icons` folder into a target path under `Program Files\CUSTOMER`.

- `ExampleDeployShortcuts.ps1`  
  Creates Start menu shortcut `.lnk` files for kiosk destinations such as web apps and internal portals.

## How these profiles are structured

Each XML example follows the same general pattern:

- `AssignedAccessConfiguration`
- `Profiles`
- `Profile`
- `AllAppsList`
- `AllowedApps`
- `StartLayout` and/or `v5:StartPins`
- `Configs`
- `DefaultProfile`

Key items to review when adapting a profile:

- Update the `AllowedApps` section to include all required desktop apps, UWP apps, and management agents.
- Review the Workspace ONE agent entries to make sure the required executables are permitted in kiosk mode.
- Use `rs5:AutoLaunch="true"` on an app entry when an app should launch automatically at startup.
- Keep `StartLayout` and `v5:StartPins` content inside `<![CDATA[ ... ]]>` blocks when used in the profile XML.
- Adjust the `Configs` section to match your kiosk scenario, such as default profile assignment or autologon account usage.

## Recommended customization workflow

1. Pick the profile closest to your Windows version and kiosk pattern.
2. Edit the `AllowedApps` list for your required apps and management agents.
3. Update app IDs and file paths to match your environment.
4. Adjust `StartLayout` and `v5:StartPins` to match the shortcuts and pinned apps you want users to see.
5. Validate that all referenced executables and icons actually exist on the managed device.
6. Encode the XML correctly when placing it into a Workspace ONE custom kiosk profile payload.

## XML encoding note

When embedding the profile XML inside a Workspace ONE `<Data></Data>` block, the XML content must be encoded as text. The repository examples show this pattern:

```xml
<?xml version="1.0" encoding="utf-8"?>
```

This needs to be represented as escaped text in the final profile payload, for example:

```text
&amp;lt;?xml version=&quot;1.0&quot; encoding=&quot;utf-8&quot;?&amp;gt;
```

So when working with these example files, convert the text inside the `<Data></Data>` block to XML to make it easier to read and modify.

## Use cases

### Standard kiosk

The standard customer kiosk use case is a device that autologs in to a fixed assigned access profile and provides a limited set of approved apps.

### Multi-user kiosk

A multi-user kiosk allows different user groups to receive different assigned access profiles while sharing the same hardware. This is useful in environments where a single device is used by multiple teams, departments, or user populations but each group needs a tailored experience, app set, and access model.

For example, an office device may be used by a user from the Finance business unit one day and by IT support the next. Finance can receive a preconfigured kiosk profile that displays a specific application list and Start layout, while IT can be assigned a default Windows desktop experience with no kiosk restrictions. The same physical device can support both scenarios by assigning different profiles based on user group membership, authentication context, or a policy-driven device assignment.

The benefit of this model is that it reduces hardware sprawl, standardizes device management, and provides a controlled, consistent experience without exposing unrelated apps or workflows. It also simplifies support because each group maintains a predictable configuration while the base OS and management policy remain centrally controlled by Workspace ONE.

## Script usage notes

### Icons script

The `ExampleDeployIcons.ps1` script copies the local `Icons` folder into a target kiosk customer path. This is useful when custom icon files are referenced by Start menu shortcut entries.

### Shortcuts script

The `ExampleDeployShortcuts.ps1` script creates shortcut objects in the Start menu using the array of `TargetFile`, `ShortcutFile`, `Arguments`, and `IconLocation` entries. Update the array with your own app URLs and paths before deployment.

## Important caveat

These files are reference examples. Before use in production, validate all app paths, app IDs, Start layout entries, and security-related entries against your Windows devices. Custom kiosk profiles must match the exact software installed on each device.
