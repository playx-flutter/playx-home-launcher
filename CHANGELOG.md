# Changelog

## 0.1.0
> Note: This release includes breaking changes.

## 📦 playx_home_launcher v0.1.0

### ✨ **Major Changes**

- **Refined API** for better clarity and null-safety:
    - **Renamed methods** for consistency:
        - `checkIfAppIsLauncher` ➜ `isLauncherApp`: Checks if a specified app is a launcher.
        - `checkIfLauncherIsDefault` ➜ `isDefaultLauncher`: Checks if a specified app is the default launcher.
    - **New helper methods**:
        - `isThisAppTheDefaultLauncher()`: Checks if the current app is the default launcher.
        - `isThisAppALauncher()`: Checks if the current app is a launcher.
        - `getCurrentPackageName()`: Gets the package name of the current app.

- **Enhancements**:
    - Return types are now non-nullable (`Future<bool>`).
    -Included Android 11+ manifest setup directly in method docs.
    - `showLauncherSelectionDialog` now has a parameter to open settings if the dialog fails.
  
### 🐛 **Bug Fixes**
- Fixed a bug causing `checkIfDefaultLauncher` to crash the app on certain android devices.

    
## 0.0.1

- Initial release.