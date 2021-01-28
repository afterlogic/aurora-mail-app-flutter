# Подготовка workspace 
1. Устанавливаем [Xcode](https://apps.apple.com/ru/app/xcode/id497799835?l=en&mt=12)
2. Устанавливаем [Android Studio](https://developer.android.com/studio)
3. Устанавливаем Flutter согласно [инструкции](https://flutter.dev/docs/get-started/install)
4. Устанавливаем [Cocoa Pod](https://cocoapods.org/),
6. Скачиваем [j2objc](https://github.com/google/j2objc/releases/download/2.7/j2objc-2.7.zip), Распаковать в папку ios и переименовать распакованную папку в dist
# Настройка Android
После установки Android Studio, добавляем в неё [Flutter plugin](https://plugins.jetbrains.com/plugin/9212-flutter)
(`Configure` -> `Plugins` -> Search `Flutter`)
и открываем Flutter проект.

Для debug сборки приложения под конкретную версию android, нужно установить Android sdk такой же версии.
[подробнее](https://developer.android.com/studio/releases/platforms)

Для этого в Android Studio нажимаем 2 раза Shift, вводим SDK Manage, выбираем нужные sdk и нажимаем ok

# Версии приложения
Версии приложения - приложения с разными ресурсами и кредами. Одна из версий - это aurora 

в папке `build_res/afterlogic` находятся ресурсы для сборки aurora версии приложения. в папке `aurora-mail-app-customs` находятся ресурсы для других для версий
поля в  `build_res/afterlogic/build_variant.yaml` переопределяют поля с тем же ключом в корневом `build_variant.yaml`.
Если версия для разных сборок разная и находятся в папке конкретной сборки, то номер сборки для всех один и находится в корневом `build_variant.yaml`.

в папках отсутвуют ключи подписи и файлы google-services

Google-services можно скачать из firebase проектов 
([firebase](https://console.firebase.google.com) -> `Настройки проекта` -> `Общие настройки` -> `Ваши приложения`-> Кнопка `google-services.json`)

Ключи находятся у менеджера, но так же понадобится 4 значения записанные в файл `key.properties`
```
storePassword=...
keyPassword=...
keyAlias=...
storeFile=key.jks
```

эти файлы нужно расположить так: 
```
crashlytics:
    google-services.json
    GoogleService-Info.plist
image:
    ...
sign:
    key.jks
    key.properties
theme:
    ...
build_variant.yaml 
```

для переключения на сборку нужно ввести команду `sh sh/build_variant.sh {путь к build_variant.yaml сборки}` 
например  `sh sh/build_variant.sh build_res/afterlogic/build_variant.yaml`

подробнее в файле [how_to_switch_customers.md](./how_to_switch_customers.md)

# Сборка Android
для релизной сборки используется скрипт
`sh/build_android.sh`
после его выполнения в папке `build` появится файл .apk и .aab

# настройка IOS

Нужно импортировать сертификаты, которые находятся у менеджера.
Открыть папку ios в xcode, в проводнике проекта выбрать `Runner`, 
перейти на вкладку `Signing & Capabilities`,
нажать `Add Account` и добавить аккаунт

# Сборка IOS

### Способ через xcode
выполнить команду `flutter build ios`
открыть папку ios в xcode
выбрать в устройствах `Any IOS Device`
в toolbar нажать `Product` и `Archive`.
После сборки откроется `Organizer`, 
в нем нужно выбрать собранный архив и нажать `distribute app`.   
После, несколько раз в диалогах кликаем `next`.

### Способ через скрипт
выполнить `sh/build_ios.sh`
Собранный пакет появятся в каталоге `build` с расширением .ipa
его можно залить в TestFlight с помощью приложения [Transporter](https://apps.apple.com/ru/app/transporter/id1450874784?l=en&mt=12)

# Необязательные шаги

### Локализация 
Строковые ресурсы находятся в `assets/flutter_i18n`,
после их изменения нужно запустить скрипт `sh/localizator.sh`, что бы сгенерировать dart классы

### отпечаток ключа Android для FIDO
для получения отпечатка ключа вида `KvjLw8eJtT7fFmfdsx5kq76ApiK`, который используется для ассоцииции домена на бэке для функционала FIDO
нужно использовать эту команду 
Потребуется инструмент `keytool` и `openssl`

```keytool -exportcert -alias {alias} -keystore {jks path} | openssl sha256 -binary | openssl base64 | sed 's/=//g' | tr '+' '-' | tr '/' '_'```
