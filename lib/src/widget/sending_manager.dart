import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_projects/src/utils/colors.dart';
import 'package:multi_image_picker/multi_image_picker.dart';

import '../model/message.dart';

class SendingManager extends StatelessWidget {
  final _controller = TextEditingController();
  final store = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  final storage = FirebaseStorage.instance;
  final String chatWith;

  SendingManager(this.chatWith);

  void sendMessage(BuildContext context,
      String text,
      MessageType messageType,) {
    if (text == null || text.isEmpty) {
      closeKeyboard(context);
      return;
    }
    var myId = auth.currentUser.uid;
    var message =
    MessageModel(text: text, from: myId, type: messageType.toString());
    var batch = store.batch();

    var messageToMe = getRef(myId, chatWith).collection('messages').doc();

    var messageToOther = getRef(chatWith, myId).collection('messages').doc();

    var lastMessageToMe = getRef(myId, chatWith);

    var lastMessageToOther = getRef(chatWith, myId);

    batch.set(messageToMe, message.toMap());
    batch.set(messageToOther, message.toMap());

    batch.set(lastMessageToMe, message.toMap());
    batch.set(lastMessageToOther, message.toMap());

    try {
      batch.commit();
      _controller.clear();
      //closeKeyboard(context);
    } catch (e) {
      print(e.toString());
    }
  }

  void sendImageMessage(BuildContext context) async {
    var myId = auth.currentUser.uid;
    var assets = await MultiImagePicker.pickImages(maxImages: 10);
    if (assets.isEmpty) return;
    var downloadLinks = <String>[];
    try {
      for (var asset in assets) {
        var image = await asset.getByteData();
        var imageFile = image.buffer.asUint8List();
        var result = await storage
            .ref('chat_images')
            .child(myId)
            .child(Timestamp.now().toString() + '.png')
            .putData(imageFile);
        downloadLinks.add(await result.ref.getDownloadURL());
      }
      var text = downloadLinks.join(',');
      sendMessage(context, text, MessageType.image);
    } catch (e) {
      print(e.toString());
    }
  }

  void closeKeyboard(BuildContext context) =>
      FocusScope.of(context).requestFocus(FocusNode());

  @override
  Widget build(BuildContext context) {
     return Container(
       color: Colors.white,
       padding: EdgeInsets.symmetric(vertical: 8, horizontal: 3),
       child: Row(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [
           Expanded(
             child: Container(
               margin: EdgeInsets.symmetric(horizontal: 8),
               decoration: BoxDecoration(
                 border: Border.all(color: Palette.darkColor, width: .1),
                 borderRadius: BorderRadius.circular(50),
               ),
               child: ClipRRect(
                 borderRadius: BorderRadius.circular(50),
                 child: Row(
                   children: [
                     Expanded(
                       child: TextField(
                         decoration: InputDecoration(
                           contentPadding: EdgeInsets.symmetric(horizontal: 8),
                           border: InputBorder.none,
                           hintText: 'Type Message ... ',
                           isCollapsed: true,
                         ),
                         maxLines: 3,
                         minLines: 1,
                         controller: _controller,
                       ),
                     ),
                     IconButton(
                       icon: Icon(Icons.camera_alt_rounded),
                       onPressed: () => sendImageMessage(context),
                     ),
                   ],
                 ),
               ),
             ),
           ),
           FloatingActionButton(
             backgroundColor: Palette.darkColor,
             child: Icon(Icons.send),
             mini: true,
             onPressed: () =>
                 sendMessage(context, _controller.text.trim(), MessageType.text),
           )
         ],
       ),
     );
  }

  getRef(String from, String to) {
    return store.collection('chat_rooms').doc(from).collection('room').doc(to);
  }
}
