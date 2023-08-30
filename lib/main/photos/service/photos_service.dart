import 'dart:convert';
import 'dart:math';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';
import 'package:http/http.dart' as http;

class PhotosService {
  Future<List<PhotoModel>> getPhotos() async {
    try {
      final url = Uri.parse(Endpoints.photos);
      final response = await http.get(url, headers: {
        "Accept": "application/json",
      });

      if (response.statusCode == 200) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse);
        final photos = (jsonResponse['posts'] as List)
            .map(
              (e) => PhotoModel.fromJson(e),
            )
            .toList();
        return photos;
      } else {
        return [];
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
