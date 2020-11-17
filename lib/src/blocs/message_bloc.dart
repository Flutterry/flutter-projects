import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../model/models.dart';

class MessageBloc {
  var loading = false;
  final String _userId;
  final _store = FirebaseFirestore.instance;
  final _auth = FirebaseAuth.instance;
  StreamTransformer _streamTransformer;
  DocumentSnapshot lastDoc;

  MessageBloc(this._userId) {
    this._streamTransformer =
        StreamTransformer<MessageEvent, List<MessageModel>>.fromHandlers(
            handleData: (event, sink) {
      var messagesRef = _store
          .collection('chat_rooms')
          .doc(_auth.currentUser.uid)
          .collection('room')
          .doc(_userId);

      switch (event) {
        case MessageEvent.startToListen:
          messagesRef
              .collection('messages')
              .limit(1)
              .orderBy('date', descending: true)
              .snapshots()
              .listen((event) {
            for (var eventTypes in event.docChanges) {
              if (eventTypes.type == DocumentChangeType.added) {
                var message = MessageModel.fromFirebaseDocument(eventTypes.doc);
                _messages.insert(0, message);
                if (lastDoc == null) lastDoc = eventTypes.doc;
              }
            }
            sink.add(_messages);
            messageSink(MessageEvent.loadMore);
          });
          break;
        case MessageEvent.loadMore:
          if (loading) break;
          loading = true;
          messagesRef
              .collection('messages')
              .limit(10)
              .orderBy('date', descending: true)
              .startAfterDocument(lastDoc)
              .get()
              .then((querySnapshot) {
            for (var doc in querySnapshot.docs) {
              var message = MessageModel.fromFirebaseDocument(doc);
              _messages.add(message);
              lastDoc = doc;
            }
            sink.add(_messages);
            loading = false;
          });
          break;
      }
    });
  }

  var _messages = <MessageModel>[];
  var _messageStreamController = StreamController<MessageEvent>();

  Function(MessageEvent) get messageSink => _messageStreamController.sink.add;

  Stream<List<MessageModel>> get messageStream =>
      _messageStreamController.stream.transform(_streamTransformer);

  void dispose() {
    _messageStreamController.close();
  }
}

enum MessageEvent { startToListen, loadMore }
