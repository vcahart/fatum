import 'package:get/get.dart';
import '/features/core/models/bmi/bmi_model.dart';


class BmiController extends GetxController {
  var bmiData = BmiData(height: 0, weight: 0).obs;

  void updateBmiData(BmiData newData) {
    bmiData.value = newData;
  }
}
