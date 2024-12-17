import 'package:get/get.dart';
import '/constants/text_strings.dart';
import '/features/authentication/models/user_model.dart';
import '/repository/authentication_repository/authentication_repository.dart';
import '/repository/user_repository/user_repository.dart';
import '/features/core/models/bmi/bmi_model.dart';

import '../../../utils/helper/helper_controller.dart';

class BmiController extends GetxController {
  var bmiData = BmiData(height: 0, weight: 0).obs;

  void updateBmiData(BmiData newData) {
    bmiData.value = newData;
  }
}
