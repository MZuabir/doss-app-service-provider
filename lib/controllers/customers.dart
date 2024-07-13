import 'dart:convert';
import 'dart:developer';

import 'package:doss/constants/api.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/models/customer_plan.dart';
import 'package:doss/models/customers.dart';
import 'package:doss/models/residential_detail.dart';
import 'package:doss/services/api.dart';
import 'package:doss/view/widgets/custom_snackbar.dart';
import 'package:get/get.dart';

class CustomersCont extends GetxController {
  RxBool isLoading = true.obs;
  RxInt activeCustomers = 0.obs;
  RxNum totalProfitEarns = RxNum(0);
  RxNum totalProfitEarnsByMonth = RxNum(0);

  //
  int allCustomersPageNo = 1;
  int activePageNo = 1;
  int pendingPageNo = 1;
  int cancelledPageNo = 1;

  RxBool allReachesEnd = false.obs;
  RxBool activeEndReachesEnd = false.obs;
  RxBool pendingReachesEnd = false.obs;
  RxBool cancelledReachesEnd = false.obs;

  Rxn<CustomerPlanModel> _plans = Rxn<CustomerPlanModel>();
  CustomerPlanModel? get getPlans => _plans.value;

  Rxn<List<Residentials>> _allcustomers = Rxn<List<Residentials>>();
  List<Residentials>? get getAllCustomers => _allcustomers.value;
  Rxn<List<Residentials>> _activeCustomers = Rxn<List<Residentials>>();
  List<Residentials>? get getActiveCustomers => _activeCustomers.value;
  Rxn<List<Residentials>> _pendingCustomers = Rxn<List<Residentials>>();
  List<Residentials>? get getPendingCustomers => _pendingCustomers.value;
  Rxn<List<Residentials>> _cancelledCustomers = Rxn<List<Residentials>>();
  List<Residentials>? get getCancelledCustomers => _cancelledCustomers.value;

  Future<void> _getActiveCustomers() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint + ApiUrls.activeCustomers,
          accessToken: authCont.accessToken.value);
      if (response != null) {
        if (response!.statusCode == 200) {
          final body = jsonDecode(response.body);
          activeCustomers.value = int.parse(body['data']['total'].toString());
        }
      }
    } catch (e) {
      showCustomSnackbar(true, 'Something went wrong');
    }
  }

  Future<void> _getProfits() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint + ApiUrls.profitCustomers,
          accessToken: authCont.accessToken.value);
     
      if (response != null) {
        if (response!.statusCode == 200) {
          log("RUN SUCCESS");
          final body = jsonDecode(response.body);
          totalProfitEarns.value = num.parse(body['data']['totalProfitEarn'].toString());
          totalProfitEarnsByMonth.value = num.parse(body['data']['totalByMonth'].toString());
        }
      }
    } catch (e) {
      showCustomSnackbar(true, 'Something went wrong');
    }
  }

  Future<void> _getPlans() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint +
              'service-provider/plans',
          accessToken: authCont.accessToken.value);
                 
      if (response != null) {

        if (response!.statusCode == 200) {

          _plans.value = CustomerPlanModel.fromJson(jsonDecode(response.body));
        }
      }
    } catch (e) {
      print(e);
      showCustomSnackbar(true, 'Something went wrong');
    }
  }

  Future<ResidentialDetailModel?> getResidentialDetai(
      String residentialID) async {
    try {
     log("RUNNING $residentialID");
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint +
              'service-provider/customer/$residentialID/details',
          accessToken: authCont.accessToken.value);
         
       if(response!=null){
         if(response.statusCode==200){
          return ResidentialDetailModel.fromJson(jsonDecode(response.body));
         }
       }
    } catch (e) {
      
      log("EEE"+ e.toString());
      showCustomSnackbar(true, 'Something went wrong');
    }
  }

  Future<void> getAllCustomersFromBackend() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint +
              ApiUrls.customers +
              '?page=$allCustomersPageNo&total=6',
          accessToken: authCont.accessToken.value);
      print(response?.body);
      if (response != null) {
        if (response!.statusCode == 200) {
          final model = CustomersModel.fromJson(jsonDecode(response!.body));
          if (allCustomersPageNo == 1) {
            _allcustomers.value = [];
          }
          if (model.data!.residentials!.isEmpty) {
            allReachesEnd.value = true;
          }
          _allcustomers.value!.addAll(model.data!.residentials!);
          _allcustomers.refresh();
        }
      }
    } catch (e) {
      showCustomSnackbar(true, 'Something went wrong');
    }
  }

  Future<void> getActiveCustomersFromBackend() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint +
              ApiUrls.customers +
              '?page=$activePageNo&total=6&status=Active',
          accessToken: authCont.accessToken.value);
      print(response?.body);

      if (response != null) {
        if (response.statusCode == 200) {
          final residentials =
              jsonDecode(response.body)['data']['residentials'];
          if (activePageNo == 1) {
            _activeCustomers.value = [];
          }
          if (residentials.isEmpty) {
            activeEndReachesEnd.value = true;
          }
          residentials.forEach((element) {
            _activeCustomers.value!.add(Residentials.fromJson(element));
          });
          _activeCustomers.refresh();
        }
      }
    } catch (e) {
      print(e);
      showCustomSnackbar(true, 'Something went wrong');
    }
  }

  Future<void> getPendingCustomersFromBackend() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint +
              ApiUrls.customers +
              '?page=$pendingPageNo&total=6&status=Pending',
          accessToken: authCont.accessToken.value);
      print(response?.body);
      if (response != null) {
        if (response!.statusCode == 200) {
          final residentials =
              jsonDecode(response.body)['data']['residentials'];
          if (pendingPageNo == 1) {
            _pendingCustomers.value = [];
          }
          if (residentials.isEmpty) {
            pendingReachesEnd.value = true;
          }
          residentials.forEach((element) {
            _pendingCustomers.value!.add(Residentials.fromJson(element));
          });
          _pendingCustomers.refresh();
        }
      }
    } catch (e) {
      showCustomSnackbar(true, 'Something went wrong');
    }
  }

  Future<void> getCancelledCustomersFromBackend() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint +
              ApiUrls.customers +
              '?page=$cancelledPageNo&total=6&status=canceled',
          accessToken: authCont.accessToken.value);
      print(response?.body);
      if (response != null) {
        if (response!.statusCode == 200) {
          final residentials =
              jsonDecode(response.body)['data']['residentials'];
          if (cancelledPageNo == 1) {
            _cancelledCustomers.value = [];
          }
          if (residentials.isEmpty) {
            cancelledReachesEnd.value = true;
          }
          residentials.forEach((element) {
            _cancelledCustomers.value!.add(Residentials.fromJson(element));
          });
          _cancelledCustomers.refresh();
        }
      }
    } catch (e) {
      showCustomSnackbar(true, 'Something went wrong');
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () async {
      await _getActiveCustomers();
      await _getProfits();
      await _getPlans();
      isLoading.value = false;
    });
  }
}
