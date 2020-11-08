class Message {
  String message, type, from;
  DateTime time;

  Message.fromFirebase(Map<String, dynamic> snapshot) {
    message = snapshot['message'];
    type = snapshot['type'];
    from = snapshot['from'];
    time = snapshot['time'];
  }

  toMap() => {
        'message': message,
        'type': type,
        'from': from,
        'time': time,
      };
}
