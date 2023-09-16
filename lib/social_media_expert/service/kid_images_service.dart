import 'dart:convert';
import 'dart:io';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:http/http.dart' as http;

class KidImagesService {
  var token = locator.get<LocalRepo>().token;
  bool hasError = false;

  Future<bool> sendKidImage(int childId, List<File?> images) async {
    Map<String, String> headers = {
      "Accept": "application/json",
      'Authorization': 'Bearer $token'
    };
    try {
      final url = Uri.parse(Endpoints.sendKidImage);
      final request = http.MultipartRequest('POST', url);
      for (int i = 0; i < images.length; i++) {
        request.files.add(
          await http.MultipartFile.fromPath('images[]', images[i]!.path,
              filename: images[i]!.path.split('/').last),
        );
      }
      request.headers.addAll(headers);
      request.fields.addAll({"child_id": childId.toString()});
      http.Response response =
          await http.Response.fromStream(await request.send());
      print('********responseee*******');
      print(response.body);
      print('********responseee*******');
      print(response.statusCode);
      if (response.statusCode < 300) {
        print('Images Sent Successfuly');
        images.clear();
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print('*************SENDING KID IMAGE*************');
      print(e);
      print('*************SENDING KID IMAGE*************');
      return false;
    }
  }

  Future<List<KidImageModel>> getKidPhotosToCheck(int childId) async {
    try {
      final url =
          Uri.parse('${Endpoints.getChildImagesToCheck}/${childId.toString()}');

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse['images']);
        final images = (jsonResponse['images'] as List)
            .map(
              (e) => KidImageModel.fromJson(e),
            )
            .toList();
        print(images);
        hasError = false;
        return images;
      } else {
        hasError = true;
        throw Exception('Error in getting kid images');
      }
    } catch (e) {
      hasError = true;
      print(e);
      throw Exception('Error in getting kid images');
    }
  }

  Future<bool> checkImage(int imageId) async {
    try {
      final url = Uri.parse('${Endpoints.checkImage}/${imageId.toString()}');
      final response = await http.put(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      print(response.statusCode);
      if (response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw Exception('error in checking image');
    }
  }

  Future<bool> deleteImageCopy(int imageId) async {
    try {
      final url =
          Uri.parse('${Endpoints.deleteImageCopy}/${imageId.toString()}');
      final response = await http.delete(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });
      print(response.statusCode);
      if (response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      throw Exception('error in delete image copy');
    }
  }
}
