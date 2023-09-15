import 'dart:io';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/kidImages/kid_image_model.dart';
import 'package:http/http.dart' as http;

class KidImagesService {
  var token = locator.get<LocalRepo>().token;
  // bool hasError = false;

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
      // final response = await http.post(
      //   url,
      // headers: {
      //   "Accept": "application/json",
      //   'Authorization': 'Bearer $token'
      // },
      //   body: kidImageModel.toJson(),
      // );
      // print(response.statusCode);
      // if (response.statusCode < 300) {
      //   return true;
      // } else {
      //   return false;
      // }
    } catch (e) {
      print('*************SENDING KID IMAGE*************');
      print(e);
      print('*************SENDING KID IMAGE*************');
      return false;
    }
  }
}
