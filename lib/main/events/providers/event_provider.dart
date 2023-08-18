import 'package:flutter/material.dart';

class EventProvider with ChangeNotifier {
  String eventName = '';
  int role = 0;

  String getEventNameById() {
    eventName = 'Event Name';
    return eventName;
  }

  int get getRole {
    return role;
  }

  setRole(int roleNum) {
    role = roleNum;
    print(role);
  }
}
