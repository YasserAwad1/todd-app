import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/models/events/event_model.dart';
import 'package:http/http.dart' as http;

class EventService {
  bool hasError = false;

  Future<List<EventModel>> getEvents() async {
    try {
      final url = Uri.parse(Endpoints.events);

      final response = await http.get(url, headers: {
        "Accept": "application/json",
      });

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        final events = (jsonResponse['events'] as List)
            .map(
              (e) => EventModel.fromJson(e),
            )
            .toList();
        // print(events);
        hasError = false;

        return events;
      } else {
        hasError = true;
        throw Exception('Error in getting events');
      }
    } catch (e) {
      // print(e);
      hasError = true;
      rethrow;
    }
  }
}
