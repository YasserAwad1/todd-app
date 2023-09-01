import 'package:flutter/material.dart';
import 'package:toddily_preschool/main/events/service/event_service.dart';
import 'package:toddily_preschool/models/events/event_images_model.dart';
import 'package:toddily_preschool/models/events/event_model.dart';

class EventProvider with ChangeNotifier {
  EventService _service = EventService();
  List<EventModel> events = [];
  List<EventImagesModel> eventImages = [];

  getEvents() async {
    events = await _service.getEvents();
  }

  // getEventById(int id){
  //   eventImages =

  // }

}
