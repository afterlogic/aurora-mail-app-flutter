Копируйте папку template из каталога build_res, она содержит необходимые ресурсы для приложения 

В неё требуется добавить файл ```google-services.json``` и ```GoogleService-Info.plist```
из вашего firebase проекта.
Так же требуется файл ```key.jks```, который содержит ключ для подписи приложения, и файл ```key.properties``` 
с полями из файла ```key_template.properties```.

В ```build_variant.yaml``` н

IOS
Нужно создать id приложения и id для модуля AppShareExtension? который состоит из id ващего приложения + ".AppShareExtension".
например id = ```my.app.id``` id AppShareExtension = ```my.app.id.AppShareExtension```
Нужно создать ```App Groups``` 
После указать данные id в соответсвующих полях файла ```build_variant.yaml```

для переключения на сборку нужно выполнить sh файл 
```sh/build_variant.sh <путь>``` 
где в переменной ```путь``` находится путь до ```build_variant.yaml``` файла 