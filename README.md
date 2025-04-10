# Playx Home Launcher

**A Flutter Plugin for Android**

`Playx Home Launcher` provides seamless access to Android's launcher-related APIs. Whether you're building a custom launcher or want to let users manage their launcher preferences, this plugin equips you with powerful tools to interact with the default launcher, check app capabilities, and access system launcher settings.

---

## ✨ Features

- 🔍 Get the **current default launcher** package name.
- ✅ Check if **your app or any other app** is a launcher or the default launcher.
- ⚙️ Open the system **launcher settings**.
- 📤 Show the **launcher selection dialog** to help users choose their preferred home screen app.
- 📦 Get the **package name** of the current app.

---

## 🛠 Getting Started

### 1. Installation

Add the package to your `pubspec.yaml`:

```yaml
dependencies:
  playx_home_launcher: ^<latest_version>
```

Then run:

```bash
flutter pub get
```

---

### 2. Android Setup

To use `getDefaultLauncherPackageName` on Android 11 and above, add this to your `AndroidManifest.xml`:

```xml
<queries>
  <intent>
    <action android:name="android.intent.action.MAIN" />
    <category android:name="android.intent.category.HOME" />
  </intent>
</queries>
```

Without this, Android may return fallback home apps like `com.android.settings.FallbackHome`.

---

### 3. Import the Package

```dart
import 'package:playx_home_launcher/playx_home_launcher.dart';
```

---

### 4. Usage Examples

#### 🔍 Get Default Launcher

```dart
final String? defaultLauncher = await PlayxHomeLauncher.getDefaultLauncherPackageName();
```

#### ✅ Check If Current App Is a Launcher

```dart
final bool isLauncher = await PlayxHomeLauncher.isThisAppALauncher();
```

#### ✅ Check If Current App Is the Default Launcher

```dart
final bool isDefault = await PlayxHomeLauncher.isThisAppTheDefaultLauncher();
```

#### 📦 Check If *Any App* Is a Launcher

```dart
final bool isLauncher = await PlayxHomeLauncher.isLauncherApp(packageName: 'com.example.otherapp');
```

#### 📦 Check If *Any App* Is the Default Launcher

```dart
final bool isDefault = await PlayxHomeLauncher.isDefaultLauncher(packageName: 'com.example.otherapp');
```

#### ⚙️ Open Launcher Settings

```dart
await PlayxHomeLauncher.openLauncherSettings();
```

#### 🔄 Show Launcher Selection Dialog

```dart
await PlayxHomeLauncher.showLauncherSelectionDialog(
  openSettingsOnError: true, // Fallback to settings if dialog fails
);
```

#### 📦 Get This App’s Package Name

```dart
final String packageName = await PlayxHomeLauncher.getCurrentPackageName();
```

---

## 📱 Making Your App a Launcher

To make your Flutter app act as a launcher (i.e., appear in the launcher selection dialog), you need to declare a launcher intent filter in your Android `AndroidManifest.xml` under the `<activity>` tag:

```xml
<intent-filter>
  <action android:name="android.intent.action.MAIN" />
  <category android:name="android.intent.category.HOME" />
  <category android:name="android.intent.category.DEFAULT" />
</intent-filter>
```

> ⚠️ Your app must be built to handle launcher responsibilities like displaying home screen UI, managing widgets, etc.

---

## 📌 Notes

- 📱 This plugin is **Android-only**. It will not function on iOS or other platforms.
- 🛡️ Make sure to test on physical devices, as launcher behavior might differ in emulators or certain OEM environments.

---

## 📄 License

Licensed under the MIT License.  
See the [LICENSE](https://github.com/playx-flutter/playx-home-launcher/blob/main/LICENSE) file for more details.

---

## 📚 Example

Check out the [example directory](example/) in the repository for a working sample app using all the available methods.

