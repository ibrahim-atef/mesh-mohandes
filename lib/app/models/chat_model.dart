import 'package:flutter/material.dart';

import "parents/model.dart";
import 'user_model.dart';

class Chat extends Model {
  // message text
  String? _text;

  // time of the message
  int? _time;

  // user id who send the message
  String? _userId;

  User? _user;

  Chat(this._text, this._time, this._userId, this._user) {
    // generate unique id
    this.id = UniqueKey().toString();
  }

  Chat.fromDocumentSnapshot(dynamic jsonMap) {
    try {
      // Firebase removed - now accepts Map<String, dynamic> or compatible object
      if (jsonMap is Map<String, dynamic>) {
        id = jsonMap['id']?.toString();
        text = jsonMap['text']?.toString() ?? '';
        time = jsonMap['time'] ?? 0;
        userId = jsonMap['user']?.toString();
      } else {
        // Fallback for compatibility
        id = null;
        text = '';
        time = 0;
        userId = null;
        user = null;
      }
    } catch (e) {
      id = null;
      text = '';
      time = 0;
      user = null;
      userId = null;
      print(e);
    }
  }

  @override
  int get hashCode => super.hashCode ^ id.hashCode ^ text.hashCode ^ time.hashCode ^ userId.hashCode;

  String get text => _text ?? '';

  set text(String? value) {
    _text = value;
  }

  int get time => _time ?? 0;

  set time(int? value) {
    _time = value;
  }

  User get user => _user ?? User();

  set user(User? value) {
    _user = value;
  }

  String get userId => _userId ?? '';

  set userId(String? value) {
    _userId = value;
  }

  @override
  bool operator ==(dynamic other) =>
      identical(this, other) ||
      super == other && other is Chat && runtimeType == other.runtimeType && id == other.id && text == other.text && time == other.time && userId == other.userId;

  @override
  Map<String, dynamic> toJson() {
    var map = new Map<String, dynamic>();
    map["id"] = id;
    map["text"] = text;
    map["time"] = time;
    map["user"] = userId;
    return map;
  }
}
