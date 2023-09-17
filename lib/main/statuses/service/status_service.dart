import 'dart:convert';

import 'package:toddily_preschool/common/constants/end_points.dart';
import 'package:toddily_preschool/common/local/local_repo.dart';
import 'package:toddily_preschool/locator.dart';
import 'package:toddily_preschool/models/status/toSendModels/send_status_model.dart';
import 'package:toddily_preschool/models/status/status_model.dart';
import 'package:http/http.dart' as http;
import 'package:toddily_preschool/models/status/toSendModels/status_to_send_model.dart';
import 'package:toddily_preschool/models/subStatus/sub_status_model.dart';

class StatusService {
  
  bool hasError = false;

  // Future<List<StatusModel>> getStatuses() async {
  //   try {
  //     final url = Uri.parse(Endpoints.statuses);

  //     final response = await http.get(
  //       url,
  //       headers: {
  //         "Accept": "application/json",
  //         'Authorization': 'Beare $token'
  //       },
  //     );

  //     if (response.statusCode < 300) {
  //       final jsonResponse = jsonDecode(response.body);
  //       print('****************status RESPONSE************');
  //       print(jsonResponse[0]);
  //       print('****************status RESPONSE************');
  //       final statuses = (jsonResponse as List)
  //           .map(
  //             (e) => StatusModel.fromJson(e),
  //           )
  //           .toList();

  //       return statuses;
  //     } else {
  //       print('error');
  //       return [];
  //     }
  //   } catch (e) {
  //     print(e);
  //     rethrow;
  //   }
  // }

  Future<List<StatusModel>> getChildStatusByDate(
      int childId, String date) async {
        var token = await locator.get<LocalRepo>().getToken();
    try {
      final url =
          Uri.parse('${Endpoints.childStatusByDate}/${childId.toString()}');

      final response = await http.post(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      }, body: {
        "date": date,
      });

      print(response.body);

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print('****************CHILD status RESPONSE************');
        print(jsonResponse['status']);
        print('****************CHILD status RESPONSE************');
        final statuses = (jsonResponse['status'] as List)
            .map(
              (e) => StatusModel.fromJson(e),
            )
            .toList();
        print(statuses);
        hasError = false;
        return statuses;
      } else {
        print('error');
        hasError = true;
        throw Exception('error in getting status by date');
      }
    } catch (e) {
      print(e);
      hasError = true;
      throw Exception('error in getting status by date');
    }
  }

  Future<List<StatusModel>> getStatusesToSend(int childId) async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url =
          Uri.parse('${Endpoints.getStatusesToSend}/${childId.toString()}');

      final response = await http.get(url, headers: {
        "Accept": "application/json",
        'Authorization': 'Bearer $token'
      });

      if (response.statusCode < 300) {
        final jsonResponse = jsonDecode(response.body);
        print(jsonResponse['status']);
        final statuses = (jsonResponse['status'] as List)
            .map(
              (e) => StatusModel.fromJson(e),
            )
            .toList();
        print(statuses);
        hasError = false;
        return statuses;
      } else {
        hasError = true;
        throw Exception('error in getting statuses to send');
      }
    } catch (e) {
      print(e);
      hasError = true;
      rethrow;
    }
  }

  Future<bool> sendStatus(int childId, List<SubStatusModel> statuses) async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse(Endpoints.sendStatus);
      var sendStatus = SendStatusModel(childId: childId, subStatuses: statuses);
      final response = await http.post(
        url,
        headers: {
          "Accept": "application/json",
          "Content-Type": "application/json",
          'Authorization': 'Bearer $token'
        },
        body: jsonEncode(
          sendStatus.toJson(),
        ),
      );
      print(response.statusCode);
      print(response.body);
      if (response.statusCode < 300) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }

  Future<bool> statusTest() async {
    try {
      var token = await locator.get<LocalRepo>().getToken();
      final url = Uri.parse(Endpoints.sendStatus);
      final response = await http.post(url,
          headers: {
            "Accept": "application/json",
            "Content-Type": "application/json",
            'Authorization': 'Bearer $token'
          },
          body: jsonEncode(
            {
              "child_id": 3,
              "status": [
                {
                  "status_id": 3,
                  "substatus": [
                    {
                      "substatus_id": 4,
                      "description": "status test function",
                    }
                  ]
                }
              ]
            },
          ));
      print(response.statusCode);
      print(response.body);
      if (response.statusCode < 300) {
        var jsonResponse = jsonDecode(response.body);
        print(jsonResponse['message']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print(e);
      rethrow;
    }
  }
}
