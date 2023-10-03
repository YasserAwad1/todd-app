import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/models/latestPhotos/photo_model.dart';
import 'package:http/http.dart' as http;

class AboutService {
  bool hasError = false;

  Future<List<PhotoModel>> getPhotos() async {
    try {
      final url = Uri.parse(Endpoints.getAboutImagaes);
      final response = await http.get(url, headers: {
        "Accept": "application/json",
      });

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        // print(
        //     '*************************ABOUT IMAGES**************************');
        // print(jsonResponse);
        // print(
            // '*************************ABOUT IMAGES**************************');
        final photos = (jsonResponse['aboutImages'] as List)
            .map(
              (e) => PhotoModel.fromJson(e),
            )
            .toList();
        hasError = false;
        return photos;
      } else {
        hasError = true;
        throw Exception('Error in getting about images');
      }
    } catch (e) {
      // print(e);
      hasError = true;
      rethrow;
    }
  }
}
