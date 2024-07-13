import 'dart:convert';

import 'package:doss/constants/api.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/models/bank.dart';
import 'package:doss/services/api.dart';
import 'package:doss/view/widgets/custom_snackbar.dart';

class BanksService{
 static Future<BankModel?> getBanks() async {
    try {
      final response = await ApiService.get(
        endPoint: '${ApiUrls.endpoint}bank/all', accessToken: authCont.accessToken.value,
        isAuth: false,
      );
      if (response != null) {
        if (response.statusCode == 200) {
          final jsonData = jsonDecode(response.body);
          print(response.body);
          return BankModel.fromJson(jsonData);
        } else {
          showCustomSnackbar(true, "Something went wrong");
        }
      } else {
        showCustomSnackbar(true, "Something went wrong");
      }
    } catch (e) {
      print(e.toString());
      showCustomSnackbar(true, "Something went wrong");
    }
  }
}