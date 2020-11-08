import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';

class GetProfileImage extends StatefulWidget {
  final Function(String) whenDone;

  GetProfileImage(this.whenDone);

  @override
  _GetProfileImageState createState() => _GetProfileImageState();
}

class _GetProfileImageState extends State<GetProfileImage> {
  String image;

  @override
  Widget build(BuildContext context) {
    return image == null
        ? IconButton(
            onPressed: () async {
              image = await getImage();
              widget.whenDone(image);
              setState(() {});
            },
            icon: Icon(
              Icons.camera_alt_rounded,
              size: 50,
            ),
          )
        : GestureDetector(
            onTap: () async {
              image = await getImage();
              widget.whenDone(image);
              setState(() {});
            },
            child: CircleAvatar(
              backgroundImage: FileImage(File(image)),
              radius: 50,
            ),
          );
  }

  Future<String> getImage() async {
    PickedFile image = await ImagePicker().getImage(source: ImageSource.camera);
    File finalImage = await ImageCropper.cropImage(
      sourcePath: image.path,
      aspectRatio: CropAspectRatio(ratioX: 1, ratioY: 1),
      compressQuality: 100,
      compressFormat: ImageCompressFormat.png,
    );
    return finalImage.path;
  }
}
