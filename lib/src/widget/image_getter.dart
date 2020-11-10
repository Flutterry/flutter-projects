import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

import './switch_widget_with_animation.dart';
import '../utils/colors.dart';

class ImageGetter extends StatefulWidget {
  final ImageUrl image;
  final ImageSource source;

  ImageGetter(this.image, {this.source = ImageSource.camera});

  @override
  _ImageGetterState createState() => _ImageGetterState();
}

class _ImageGetterState extends State<ImageGetter> {
  @override
  Widget build(BuildContext context) {
    return SwitchedWidget(
        IconButton(
          icon: Icon(Icons.photo_camera, size: 40),
          onPressed: () => getImage(widget.source),
        ),
        GestureDetector(
          onTap: () => getImage(widget.source),
          child: CircleAvatar(
            radius: 40,
            backgroundColor: Palette.darkColor,
            backgroundImage: widget.image.url == null
                ? null
                : FileImage(File(widget.image.url)),
          ),
        ),
        widget.image.url == null);
  }

  getImage(ImageSource source) async {
    var normalImage = await ImagePicker().getImage(source: source);
    if (normalImage.path != null) {
      var cropperImage = await ImageCropper.cropImage(
        sourcePath: normalImage.path,
        aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
        compressFormat: ImageCompressFormat.png,
        compressQuality: 100,
      );
      setState(() {
        widget.image.url = cropperImage.path;
      });
    }
  }
}

class ImageUrl {
  String url;

  ImageUrl(this.url);
}
