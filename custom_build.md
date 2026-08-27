1. Clone the [repository](https://github.com/afterlogic/aurora-mail-app-flutter)
2. Install [Xcode](https://apps.apple.com/app/xcode/id497799835?l=en&mt=12)
3. Install [Android Studio](https://developer.android.com/studio)
4. Install Flutter according to [instructions](https://flutter.dev/docs/get-started/install)

5. If PGP functionality is required, the following tools need to be installed

Java > ObjectiveC

Download [j2objc](https://github.com/google/j2objc/releases/download/2.7/j2objc-2.7.zip), unpack into `ios` directory and rename the unpacked directory to `dist`

6. The starting point for building any version, including custom one, is a set of configuration files and images.
Set of resources for building regular version is found in `build_res` directory, it also contains a template for creating a custom build.
To create a custom build, copy `template` directory from `build_res` and rename it with an arbitrary name - it holds all the resources required by an application

7. To build iOS app:

In your Apple account, create id for AppGroup, with `App Groups` type selected when creating ID. 
It can be done [here](https://developer.apple.com/account/resources/identifiers/list)

Also, you need to create app id and id for AppShareExtension module which is constructed as your app id + ".AppShareExtension".
For example, id = `my.app.id` id AppShareExtension = `my.app.id.AppShareExtension`

And activate `App Groups` for both ids, using the group created earlier

Then specify app id and group id in corresponding fields of `build_variant.yaml` file. There's no need to specify id AppShareExtension.
Make sure to specify Team ID. You can find it [here](https://developer.apple.com/account/#/membership)

8. To build Android app:

Specify app id, for example `my.app.id` in `build_variant.yaml` file.

9. The project uses Firebase service for collecting analytics data. To build the app, you neeed to create Firebase project. It can be done [here](https://firebase.google.com/).
In the project, create 2 apps, for iOS and Android versions. 
In the directory with app template, create `crashlytics` directory and place two files in it: `GoogleService-Info.plist` and `google-services.json` from respective apps in Firebase project.

10. To sign the application, creating [signing key](https://developer.android.com/studio/publish/app-signing#generate-key) is required. 
The file `key.jks`, which contains app signing key, needs to be placed to `sign` directory.
Edit the `key_template.properties` file and rename it into `key.properties`. 

11. Changing theme and updating image files.
Images are found in `image` subdirectory.
All the images must be of 512õ512 or 1024õ1024 size.

* `icon.png` icon is used on desktop. Should not have alpha channel. 
* `icon_foreground.png` icon with transparent background is used as physical icnon in some versions of Android. 
* `main_logo.png` icon is displayed on login and About screens.

The color scheme is described in `theme/lib/app_color.dart` file.

12. To switch to custom build, run `sh/build_variant.sh <path>` where `path` variable holds a path to `build_variant.yaml` file in a directory holding custom version resources.

13. To create certificates for signing iOS version, open XCode project. Click root project Runner in project structure, and in the new window openeed, select Runner from Targets list, then select Signing & Capabilities. Certificates should be created automatically.

14. To build Android version run `build_android.sh`

Packages built will be placed to `build` directory.

15. To build iOS version run `sh/build_ios.sh` 

Package built will be placed to `build` directory, with `.ipa` extension, it can be uploaded to TestFlight using [Transporter](https://apps.apple.com/app/transporter/id1450874784?l=en&mt=12) application.

In the application, you can turn specific features on/off by specifying `true` or `false` in for a flag in ```build_variant.yaml``` file.

Build flags:
* multiUserEnable - allows for adding and switching between mail users
* multiAccountEnable - allows for swtching email account for a user
* cryptoEnable - PGP email encryption
* useMainLogo - using `main_logo.png` on login screen
* selfDestructingEmail - allows for sending mails which are made unavailable after certain amount of time
* expandMessageThread - allows for opening message thread by clicking number of messages in thread on message list screen
* logger - debug logging of the application
* enablePushNotification - reporting new incoming messages using push-notifications

16. Auto-filling login credentials in debug mode.

To speed up local testing, the login screen can pre-fill the email and password fields when the app runs in debug mode. This only works with `flutter run` (debug builds), it has no effect on release builds.

To use it, pass the values with `--dart-define` when running the app:

```
flutter run --dart-define=DEBUG_EMAIL=your@email.com --dart-define=DEBUG_PASSWORD=yourpassword
```

If you use VS Code, you can add these to the `args` of your launch configuration in `.vscode/launch.json` instead:

```json
{
    "name": "aurora_mail (debug)",
    "request": "launch",
    "type": "dart",
    "args": [
        "--dart-define=DEBUG_EMAIL=your@email.com",
        "--dart-define=DEBUG_PASSWORD=yourpassword"
    ]
}
```

Do not commit real credentials to the repository. Keep them only in your local run configuration.

17. Firebase App Check debug token.

App Check is enabled per brand via the `enableAppCheck` flag in `build_variant.yaml`. When it's `true`, a debug build needs a debug token, otherwise it falls back to the production attestation providers (Play Integrity / App Attest), which don't work on unregistered dev devices/emulators.

Generate any UUID yourself (e.g. `uuidgen`, or PowerShell's `New-Guid`), then pass it with `--dart-define`:

```
fvm flutter run --dart-define=FIREBASE_APP_CHECK_DEBUG_TOKEN=your-generated-uuid
```

Or add it to the `args` of your `.vscode/launch.json` configuration, same as `DEBUG_EMAIL`/`DEBUG_PASSWORD` above.

On first run with this define set, the app registers that exact UUID as its own debug secret (see `MainActivity.onCreate` on Android). You then need to add the same UUID in the Firebase console: **App Check → your app → Manage debug tokens**. Without that registration step, requests using the token will still be rejected.

This define is required on every `flutter run`/build where you want App Check to work in debug — it isn't persisted anywhere, and it's independent of which brand/`build_variant.sh` you last ran.

18. Running in debug mode without Android Studio (terminal only).

Android Studio isn't required to run the app in debug — the emulator and device tooling both work from Flutter's own CLI.

* List connected devices and running emulators:
  ```
  fvm flutter devices
  ```
* Run on a specific device (use an id from the list above):
  ```
  fvm flutter run -d <device_id>
  ```
* To use a physical phone: enable Developer Options and USB debugging on the device, connect it via USB (or `adb connect <ip>:<port>` for wireless debugging), then it will show up in `fvm flutter devices`.
* To use an emulator without opening Android Studio, list AVDs previously created through it and launch one:
  ```
  fvm flutter emulators
  fvm flutter emulators --launch <emulator_id>
  ```
  (creating a new AVD from scratch still needs `avdmanager`/`sdkmanager` from the Android command-line tools, which can be installed separately from Android Studio.)

Combine with the `--dart-define` flags from the sections above as needed, e.g.:
```
fvm flutter run -d <device_id> --dart-define=DEBUG_EMAIL=your@email.com --dart-define=DEBUG_PASSWORD=yourpassword --dart-define=FIREBASE_APP_CHECK_DEBUG_TOKEN=your-generated-uuid
```
