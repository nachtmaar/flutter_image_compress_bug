# flutter_image_compress_bug

Run app:
```bash
flutter pub get
flutter run lib/main.dart
```

Fetch images from device:
```bash
adb backup -noapk com.example.flutterimagecompressbug
```

Extract backup:
```bash
( printf "\x1f\x8b\x08\x00\x00\x00\x00\x00" ; tail -c +25 backup.ab ) |  tar xfvz -
```

Find images in:
- assets/passierte_tomaten_samsung.jpg # original image
- apps/com.example.flutterimagecompressbug/r/app_flutter/image_compress.jpg
- apps/com.example.flutterimagecompressbug/r/app_flutter/flutter_image_compress.jpg

Here is the result after the test run:
```bash
➜ identify -verbose assets/passierte_tomaten_samsung.jpg|grep -i orientation
  Orientation: RightTop
    exif:Orientation: 6

➜ identify -verbose apps/com.example.flutterimagecompressbug/r/app_flutter/image_compress.jpg|grep -i orientation
  Orientation: RightTop
    exif:Orientation: 6

➜ identify -verbose apps/com.example.flutterimagecompressbug/r/app_flutter/flutter_image_compress.jpg |grep -i orientation
  Orientation: Undefined
```