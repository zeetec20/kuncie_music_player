# Music Player

<div align="center">

<img src="https://i.ibb.co/yg4JkCV/5400454-Recovered-1.png" style="border-radius: 10px;">

UI Design ([Figma](https://www.figma.com/file/RJ9Lyi4oX99fxgKmUOR5z8/Kuncie?node-id=0%3A1)) &nbsp;&nbsp;
Prototype ([Figma Prototype](https://www.figma.com/proto/RJ9Lyi4oX99fxgKmUOR5z8/Kuncie?node-id=1%3A2&scaling=scale-down&page-id=0%3A1&starting-point-node-id=1%3A2)) &nbsp;&nbsp;
APK File ([APK](https://drive.google.com/file/d/1YW3wOh3Ya57282_givLvOQ9RbTq8pUXq/view?usp=sharing)) &nbsp;&nbsp;
Video Demo ([Youtube](https://youtu.be/KAblsTQskek))

</div>

## Description
This repository is source code of music player, build with languade dart on framework flutter with api from itunes.

## Requirement Device
- Operation System : Windows
- Flutter : 2.10.2
- Dart : 2.16.1
- Mobile Device : Vivo V11 Pro
- Mobile Operation System : Android
- Android Version : 10

## Support Features
- Best artist of the month
- Popular artist
- Search music
- Register
- Login
- Like music from artist of the month
- Like music from popular artist
- Like music from search
- Like music from recently played
- Remove liked music
- Play music from artist of the month
- Play music from popular artist
- Play music from search
- Play music from recently played
- Played music automation enter recently music
- Pause played music
- Resume stoped music
- Play previous music
- Play next music

## Run project
- Clone respository
```bash
git clone https://github.com/zeetec20/kuncie_music_player.git
```
- Open repository
```bash
cd kuncie_music_player
```
- Run command
```bash
flutter pub get
flutter run
```

## Build app
- Clone respository
```bash
git clone https://github.com/zeetec20/kuncie_music_player.git
```
- Open repository
```bash
cd kuncie_music_player
```
- Run command
```bash
flutter pub get
flutter build apk --release
```

## Test app
- Clone respository
```bash
git clone https://github.com/zeetec20/kuncie_music_player.git
```
- Open repository
```bash
cd kuncie_music_player
```
- Run command
```bash
flutter test
```

## Deploy App
- Generate keystore
```bash
# Linux
keytool -genkey -v -keystore ~/upload-keystore.jks -keyalg RSA -keysize 2048 -validity 10000 -alias upload

# Windows
keytool -genkey -v -keystore c:\Users\USER_NAME\upload-keystore.jks -storetype JKS -keyalg RSA -keysize 2048 -validity 10000 -alias upload
```
- Reference the keystore
```properties
storePassword=<password from previous step>
keyPassword=<password from previous step>
keyAlias=upload
storeFile=<location of the key store file, such as /Users/<user name>/upload-keystore.jks>
```
- Configure signing in [grandle](https://docs.flutter.dev/deployment/android#configure-signing-in-gradle)
- Build appbundle
```bash
flutter run appbundle --release
```
- Upload appbundle to [Google Play Console](https://developer.android.com/studio/publish/upload-bundle)

