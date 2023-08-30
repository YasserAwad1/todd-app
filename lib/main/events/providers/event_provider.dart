import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/events/service/event_service.dart';
import 'package:toddily_preschool/models/events/event_model.dart';

class EventProvider with ChangeNotifier {
  EventService _service = EventService();
  List<EventModel> events = [];

  getEvents() async {
    events = await _service.getEvents();
  }
}
