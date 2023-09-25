import 'package:flutter/cupertino.dart';
import 'package:toddily_preschool/main/kids/service/kids_service.dart';
import 'package:toddily_preschool/models/kids/kid_model.dart';

class KidsProvider with ChangeNotifier {
  final KidsService _service = KidsService();
  List<KidModel> kids = [];
  List<KidModel> extraChildren = [];
  bool hasError = false;

  Future<void> getChildrenByTeachOrParentId(int userId) async {
    try {
      kids = await _service.getKidsByTeachOrParentId(userId);
      hasError = _service.hasError;
    } catch (e) {
      print(e);
      hasError = _service.hasError;
    }
  }

  Future<void> getExtrasChildren() async {
    try {
      extraChildren = await _service.getExtrasChildren();
      hasError = _service.hasError;
    } catch (e) {
      print(e);
      hasError = _service.hasError;
    }
  }
}
