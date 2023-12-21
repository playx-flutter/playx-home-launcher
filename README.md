# Playx Home Launcher

**Flutter Plugin for Android**

Playx Home Launcher simplifies launcher management in Flutter applications. It provides essential utilities to check the current default launcher and integrate a selection dialog for users to choose their preferred home launcher.

## Features
- Obtain the package name of the current default launcher on the user's device.
-   Seamlessly integrate a selection dialog for users to choose their desired home launcher.
-  Open the launcher settings on the device.
- Check if an app is the default launcher.
- Check if an app is alauncher.

## Getting Started

1.  **Installation:**

    Add the Playx Home Launcher package to your `pubspec.yaml` file:

```yaml
    dependencies:
      playx_home_launcher: ^version_number
```

Run:

```bash
    flutter pub get` 
```    
2.  **Import:**

    Import the package in your Dart code:

```dart
    import 'package:playx_home_launcher/playx_home_launcher.dart';` 
```

3.  **Usage:**

    Utilize the provided functions to manage launcher-related tasks in your app.
 ```dart   
// Returns current launcher package name
String currentLauncher = await PlayxHomeLauncher.getCurrentLauncher();

// Check if the launcher is the default
// packageName variable is optional as if not provided it will use the app package name.
bool? isLauncherDefault = await PlayxHomeLauncher.checkIfLauncherIsDefault(packageName: 'com.example.myapp');

// Show launcher selection dialog if avialble or Open launcher settings
PlayxHomeLauncher.showLauncherSelectionDialog(context);

// Check if the app is a launcher
bool? isAppLauncher = await PlayxHomeLauncher.checkIfAppIsLauncher(packageName: 'com.example.myapp');

// Open launcher settings
await PlayxHomeLauncher.openLauncherSettings();

```

4.  **Enjoy:**

    Enhance your Flutter app with streamlined launcher management using Playx Home Launcher!


## Note

Playx Home Launcher is exclusively designed for Android applications developed with Flutter.

## License

This project is licensed under the MIT License - see the [LICENSE](https://github.com/playx-flutter/playx-home-launcher/blob/main/LICENSE) file for details.

For more details and examples, refer to the documentation.
