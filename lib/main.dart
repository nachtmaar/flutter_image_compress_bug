import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'dart:typed_data';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'package:image/image.dart' as Im;
import 'package:flutter/services.dart' show rootBundle;

main() {
  runApp(App());
}

class App extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _AppState();
  }
}

class _AppState extends State<App> {
  bool loaded = false;
  Uint8List compressedImage;
  String assetImage = 'assets/passierte_tomaten_samsung.jpg';

  @override
  Widget build(BuildContext context) {
    var originalImage = Image.asset(assetImage);

    if (!loaded) {
      test();
    }

    return MaterialApp(
        home: Scaffold(
      appBar: AppBar(
        title: Text('Rotation'),
      ),
      // load compressed image if ready
      body: loaded ? Image.memory(compressedImage) : originalImage,
    ));
  }

  // compress asset image with FlutterImageCompress and Image for comparison
  // stores both images on the device
  void test() async {
    final applicationDirectory = await getApplicationDocumentsDirectory();

    ByteData originalImageBytes = await rootBundle.load(assetImage);
    Uint8List originalImageBytesUint8 = originalImageBytes.buffer.asUint8List();

    // use FlutterImageCompress for image compression
    var imageFlutterImageCompress =
        await FlutterImageCompress.compressAssetImage(assetImage,
            rotate: 0, quality: 50);
    print('saving FlutterImageCompress compressed image');
    File('${applicationDirectory.path}/flutter_image_compress.jpg')
        .writeAsBytesSync(imageFlutterImageCompress);

    // use Image compression for comparison
    Im.Image image = Im.decodeImage(originalImageBytesUint8);
    image = Im.copyRotate(image, 0);
    List<int> imageImage = Im.writeJpg(image, quality: 50);
    print('saving Image compressed image');
    File('${applicationDirectory.path}/image_compress.jpg')
        .writeAsBytesSync(imageImage);

    setState(() {
      this.compressedImage = Uint8List.fromList(imageFlutterImageCompress);
      loaded = true;
      print('loaded');
    });
  }
}
