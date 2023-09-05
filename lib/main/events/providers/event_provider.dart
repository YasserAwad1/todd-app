import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/events/service/event_service.dart';
import 'package:toddily_preschool/models/events/event_images_model.dart';
import 'package:toddily_preschool/models/events/event_model.dart';

class EventProvider with ChangeNotifier {
  EventService _service = EventService();
  List<EventModel> events = [];
  List<EventImagesModel> eventImages = [];
  bool hasError = false;

  getEvents() async {
    try {
      events = await _service.getEvents();
      hasError = _service.hasError;
    } catch (e) {
      print(e);
      hasError = _service.hasError;
      rethrow;
    }
  }

  // getEventById(int id){
  //   eventImages =

  // }
}
