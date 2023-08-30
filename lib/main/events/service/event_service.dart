import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/models/events/event_model.dart';
import 'package:http/http.dart' as http;

class EventService {
  Future<List<EventModel>> getEvents() async {
    try {
      final url = Uri.parse(Endpoints.events);

      final response = await http.get(url, headers: {
        "Accept": "application/json",
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        final events = (jsonResponse['events'] as List)
            .map(
              (e) => EventModel.fromJson(e),
            )
            .toList();
        print(events);

        return events;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
