import 'dart:convert';

import 'package:doss/constants/api.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/models/history.dart';
import 'package:doss/services/api.dart';
import 'package:doss/view/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class HistoryCont extends GetxController {
  RxInt selectedTab = 0.obs;
  int allPageNo = 1;
  int roofPageNo = 1;
  int verificationPageNo = 1;

  RxBool allReachesEnd = false.obs;
  RxBool roofEndReachesEnd = false.obs;
  RxBool verificationReachesEnd = false.obs;

  Rxn<List<HistoryItem>> _allHistory = Rxn<List<HistoryItem>>();
  List<HistoryItem>? get getAllHistory => _allHistory.value;
  Rxn<List<HistoryItem>> _roofHistory = Rxn<List<HistoryItem>>();
  List<HistoryItem>? get getRoofHistory => _roofHistory.value;
  Rxn<List<HistoryItem>> _verificationHistory = Rxn<List<HistoryItem>>();
  List<HistoryItem>? get getVerificationHistory => _verificationHistory.value;

  Future<void> getAllHistoryFromBackend() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint +
              "history/service-provider/all?page=${allPageNo}&total=6",
          accessToken: authCont.accessToken.value);
      print(response?.body);
      if (response != null) {
        if (response.statusCode == 200) {
          final model = HistoryModel.fromJson(jsonDecode(response!.body));
          if (allPageNo == 1) {
            _allHistory.value = [];
          }
          if (model.data!.history!.isEmpty) {
            allReachesEnd.value = true;
          }
          _allHistory.value!.addAll(model.data!.history!);
          _allHistory.refresh();
        }
      }
    } catch (e) {
      showCustomSnackbar(true, 'Something went wrong');
    }
  }

  Future<void> getVerificationHistoryFromBackend() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint +
              "history/service-provider/all?page=${verificationPageNo}&total=6&historyType=verification",
          accessToken: authCont.accessToken.value);
      print(response?.body);
      if (response != null) {
        if (response.statusCode == 200) {
          final model = HistoryModel.fromJson(jsonDecode(response!.body));
          if (verificationPageNo == 1) {
            _verificationHistory.value = [];
          }
          if (model.data!.history!.isEmpty) {
            verificationReachesEnd.value = true;
          }
          _verificationHistory.value!.addAll(model.data!.history!);
          _verificationHistory.refresh();
        }
      }
    } catch (e) {
      showCustomSnackbar(true, 'Something went wrong');
    }
  }

  Future<void> getRoofHistoryFromBackend() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint +
              "history/service-provider/all?page=${roofPageNo}&total=6&historyType=Coverage",
          accessToken: authCont.accessToken.value);
      print(response?.body);
      if (response != null) {
        if (response.statusCode == 200) {
          final model = HistoryModel.fromJson(jsonDecode(response!.body));
          if (roofPageNo == 1) {
            _roofHistory.value = [];
          }
          if (model.data!.history!.isEmpty) {
            roofEndReachesEnd.value = true;
          }
          _roofHistory.value!.addAll(model.data!.history!);
          _roofHistory.refresh();
        }
      }
    } catch (e) {
      showCustomSnackbar(true, 'Something went wrong');
    }
  }
}
