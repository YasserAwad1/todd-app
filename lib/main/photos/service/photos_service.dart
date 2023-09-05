import 'dart:convert';
import 'dart:math';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';
import 'package:http/http.dart' as http;

class PhotosService {
  bool hasError = false;

  Future<List<PhotoModel>> getPhotos() async {
    try {
      final url = Uri.parse(Endpoints.photos);
      final response = await http.get(url, headers: {
        "Accept": "application/json",
      });

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        final photos = (jsonResponse['posts'] as List)
            .map(
              (e) => PhotoModel.fromJson(e),
            )
            .toList();
            hasError = false;
        return photos;
      } else {
        hasError = true;
        throw Exception('Error in getting photos');
      }
    } catch (e) {
      print(e);
      hasError = true;
      rethrow;
    }
  }
}
