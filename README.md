# TanukiDay


*A Flutter project focused on **authenticate**, **database**, **manage and display data**.*

> Cloud solution : **Firebase**  
> - **Authentication** using `OAuth`  
> - **Firestore** using `NoSQL` 

---

| 1 | 2 | 3 |
| --- | --- | --- |
| ![Image 1](.screenshots/1.png) | ![Image 2](.screenshots/2.png) | ![Image 3](.screenshots/3.png) |

## writing in progress...

**OAuth and login**

## Firebase


> Firebase is a Backend-as-a-Service (BaaS) app development platform that provides hosted backend services such as a realtime database, **cloud storage**, **authentication**, crash reporting, machine learning, remote configuration, and hosting for your static files.  
\- [*Flutter doc*](https://docs.flutter.dev/data-and-backend/firebase) -

![Firebase logged home screen](.screenshots/firebaseHome.png)

**DOCUMENTATION**    
\- [Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup?platform=ios)  
&emsp; Get started tutorial  
\- [Get to know Firebase for Flutter](https://firebase.google.com/codelabs/firebase-get-to-know-flutter#0)  
&emsp;  Complete tutorial, going beyond current needs but nice to keep it for the router 

**MAIN STEPS**

**1.** [Install](https://firebase.google.com/docs/cli#setup_update_cli) `Firebase CLI` then use a google/gmail account to log in.

```zsh
firebase login
```

**2.** install the [FlutterFire CLI](https://firebase.google.com/docs/cli#setup_update_cli)  **globally**, then add it to your PATH environnement variable.

```bash
dart pub global activate flutterfire_cli
```
**3.** In **Flutter project folder** :

Use this command each time after updating app structure or pluggin settings in firebase. This will generate *lib/firebase_options.dart*, *android/app/google-services.json* and *ios/Flutter/Runner/GoogleService-Info.plist* setting files.

```zsh
flutterfire configure 
```

**4.** Add [firebase_core package](https://pub.dev/packages/firebase_core)  
```zsh
flutter pub add firebase_core
```
 
In *lib/main.dart*, import the Firebase core plugin and the configuration file you generated earlier. Also, initialize Firebase using the DefaultFirebaseOptions object exported by the configuration file.

```dart
    import 'package:firebase_core/firebase_core.dart';
    import 'firebase_options.dart';

    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
```

## Android Emulator Fixes

**Multidex Fix**  
A problem about `multidex` can occure if the number of methods in project is bigger than 65,536. It can be be resolved following this [stackoverflow post](https://stackoverflow.com/questions/55591958/flutter-firestore-causing-d8-cannot-fit-requested-classes-in-a-single-dex-file)  
```dart
// android/app/build.gradle
defaultConfig {
    ...

    multiDexEnabled true
}

dependencies {
    ...

    implementation 'androidx.multidex:multidex:2.0.1'
}
```


## Authentication

### Google sign in
Official tutorial to start up [Get Started with Firebase Authentication on Flutter](https://firebase.google.com/docs/auth/flutter/start)

Then read and follow this package [google_sign_in dart package](https://pub.dev/packages/google_sign_in/example)  

To get the **SHA1 key** needed by firebase in authenticate settings, use in a terminal window in android project folder : 

```bash
./gradlew signingReport
```

![firebase screenshot sha1 key](.screenshots/sha1.png)

Here the code i used :  
```dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'dart:developer' as dev;

static Future<bool> signInWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

      final GoogleSignInAuthentication? googleAuth =
          await googleUser?.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth?.accessToken,
        idToken: googleAuth?.idToken,
      );
      await FirebaseAuth.instance.signInWithCredential(credential);
      return true;
    } on Exception catch (e) {
      dev.log('exception->$e');
      return false;
    }
  }
```

### Github sign in

[article medium daté 2020](https://medium.com/flutter-community/flutter-firebase-github-authentication-990fe8731d9e)  
[Cet article geek for geeks plus recent](https://www.geeksforgeeks.org/flutter-firebase-github-authentication/)  
Created my **OAuth app** on my github account (gave project URL a new public repo)
Firebase give **redirect URL**.  
**FIREBASE AUTH HANDLER** https://diaryapp-93501.firebaseapp.com/__/auth/handler
Github give **Client ID** and generate **secret key**  

6. Pb Kotlin gradle version...  
**FIXED**

```gradle
    [build.gradle (android project level)]
    buildscript {
        ext.kotlin_version = '1.9.23'
        repositories {
            google()
            jcenter()
        }

        dependencies {
            classpath 'com.android.tools.build:gradle:7.3.0'
            classpath "org.jetbrains.kotlin:kotlin-gradle-plugin:$kotlin_version"
        }

    }
```

```gradle
    [settings.gradle]
    plugins {
        id "dev.flutter.flutter-plugin-loader" version "1.0.0"
        id "com.android.application" version "7.3.0" apply false
        // Cette ligne semble necessaire :
        id "org.jetbrains.kotlin.android" version "1.9.23" apply false 
    }
```

5. **envied** package (same than weather project)  
Put **GITHUB Key, ID, Auth in .env**  
then access into flutter [article tuto](https://dev.to/namankk/securely-storing-api-keys-in-flutter-3ko4) (envied 3 packages)  
*Envied requires types to be explicitly declared :* use **String** instead of **const** in sample code  
**To generate files :**  
`flutter pub run build_runner build --delete-conflicting-outputs`

6. Sign up with Github - cette fois on s'aide de cet [article](https://medium.com/firebase-developers/dive-into-firebase-auth-on-flutter-third-party-authentication-a242472ae347)  
**packages** :  `url_launcher` + `uni_links`  
**Emulateur clean app caches :**  
Emulateur > settings > app > diaryApp > clear cache + stockage  
**Probleme emulateur android :**  
google chrome affiche un contenu tout noir/blanc : 
[stackoverflow fix](https://stackoverflow.com/questions/70656197/google-chrome-open-with-white-screen-on-android-emulator)  
Create or open the advancedFeatures.ini file.  
macOS/Linux: ~/.android/advancedFeatures.ini  
Add the following lines:  

```bash
    Vulkan = off
    GLDirectMem = on
```

7. Router :  
[Flutter Navigation doc](https://docs.flutter.dev/ui/navigation#using-the-router)  
package `go_router 13.2.0`  
[package features usecases](https://github.com/flutter/packages/blob/main/packages/go_router/example/lib/redirection.dart) *i used this to start*  
[Flutter go_router: The Essential Guide - medium](https://medium.com/@antonio.tioypedro1234/flutter-go-router-the-essential-guide-349ef39ec5b3)


8. **Database in Firebase**  
<br/>
**RealTime dataBase** (ABANDON)  
_ [Firebase-doc Get Started with Realtime Database](https://firebase.google.com/docs/database/flutter/start)  
_ [Firebase-doc Read and Write Data](https://firebase.google.com/docs/database/flutter/read-and-write)  
_ [article medium](https://medium.com/@samra.sajjad0001/real-time-data-management-in-flutter-with-firebase-database-458f81667a6c)  
<br/>
**Firestore Database** (celle donnée en exemple dans le sujet(logo))  
_ [Premiers pas avec Cloud Firestore](https://firebase.google.com/docs/firestore/quickstart?hl=fr&authuser=0) `cloud_firestore: ^4.15.9`  
_ Doc officielle bien faite et complète, principes de bases facilement accessibles. 

9. **Calendar**  
[article medium comparant differents packages de calendar](https://medium.com/flutter-community/flutter-calendar-library-comparison-c08d5ba3cc9e)  
Choix du package [**table_calendar**](https://pub.dev/packages/table_calendar) pour tester  
son [github](https://github.com/aleksanderwozniak/table_calendar?tab=readme-ov-file)  
la page du [package pub dev](https://pub.dev/packages/table_calendar)  
<br/>
~ collection dart [**LinkedHashMap**](https://api.flutter.dev/flutter/dart-collection/LinkedHashMap-class.html)  
The `keys`, `values` and `entries` are iterated in key insertion order.  
For this project i used a **`StreamBuilder`** based on a  
`Stream<LinkedHashMap<DateTime, List<Entry>>>` object received from firestore  
Each date is maped with a list of entry object.  


<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>
<br/>

----

**False first try**
  - [Flutter — Google Sign In using firebase auth](https://medium.com/@dev.lens/flutter-google-sign-in-using-firebase-authentication-step-by-step-ef2ddfb84a2c) [tuto medium]  
[Add Firebase to your Flutter app](https://firebase.google.com/docs/flutter/setup?hl=en&authuser=0&_gl=1*1li3hbj*_ga*MzEzNzgwODI3LjE3MDk5NjYwODk.*_ga_CW55HF8NVT*MTcwOTk2NjA4OC4xLjEuMTcwOTk2ODI4MC4wLjAuMA..&platform=ios#available-plugins) [Firebase doc]
  - log to firebase webpage with a fresh created google account
  - create project > name it > add flutter project
  - Download firebase CLI and add it to path
  - run firebase login to log with the new account
  -  From any directory, run this command:  
`dart pub global activate flutterfire_cli`
  - Then, at the root of your Flutter project directory, run this command:  
    `flutterfire configure --project=fir-oauth-train`  
This automatically registers your per-platform apps with Firebase and adds a lib/firebase_options.dart configuration file to your Flutter project.  
  - To initialize Firebase, call Firebase.initializeApp from the firebase_core package with the configuration from your new firebase_options.dart file:  

    ```dart
    import 'package:firebase_core/firebase_core.dart';  
    import 'firebase_options.dart';


    void main() async {

        await Firebase.initializeApp(
            options: DefaultFirebaseOptions
              .currentPlatform,
        );

        runApp(const MyApp());
    }
    ```

  - also need the dart package **firebase_core** 2.27.0
  - then for tutorial : **firebase_auth**: ^4.17.8 + **google_sign_in**: ^6.2.1  
  - [Firebase Authentication on Android](https://firebase.google.com/docs/auth/android/start) FirebaseDoc
  - . generation d'une clé SHA1 Fingerprint pour l'emulateur android avec : `keytool -list -v -alias androiddebugkey -keystore ~/.android/debug keystore`  
  . mdp default android  
  . added into firebase > project settings > current app
  . adding this into `./android/app/build.gradle`  
    [`!`]several files with this name  

    ```dart
    // https://firebase.google.com/docs/auth/android/start
        dependencies {
            // Import the BoM for the Firebase platform
            implementation(platform("com.google.firebase:firebase-bom:32.7.4"))

            // Add the dependency for the Firebase Authentication library
            // When using the BoM, you don't specify versions in Firebase library dependencies
            implementation("com.google.firebase:firebase-auth")
        }
    ```
  - **PROBLEME DE VERSION GRADLE ... RESET FROM SCRATCH**
**Probleme encore tentative de comprendre ,et de résoudre **  
[Module was compiled with an incompatible version of Kotlin. The binary version of its metadata is 1.5.1, expected version is 1.1.15](https://stackoverflow.com/questions/67699823/module-was-compiled-with-an-incompatible-version-of-kotlin-the-binary-version-o/74425347#74425347)
