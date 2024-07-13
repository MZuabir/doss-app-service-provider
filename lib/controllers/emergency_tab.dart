import 'dart:convert';
import 'dart:developer';

import 'package:doss/constants/api.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/models/residential_contacts.dart';
import 'package:doss/models/useful_contacts.dart';
import 'package:doss/services/api.dart';
import 'package:get/get.dart';

class EmergencyTabCont extends GetxController {
  //FOR USEFULL CONTACTS
  int usefullContactsPageNumber = 1;
  RxBool usefullContactsReachEnd = false.obs;
  final Rxn<List<UsefullContacts>> _usefulContacts =
      Rxn<List<UsefullContacts>>();
  List<UsefullContacts>? get getUsefulContacts => _usefulContacts.value;

  Future<void> getUsefullContactsData() async {
    final response = await ApiService.get(
        endPoint:
            // '${ApiUrls.endpoint}${ApiUrls.usefullContacts}&page=$usefullContactsPageNumber&count=20',
            '${ApiUrls.endpoint}${ApiUrls.usefullContacts}',
        accessToken: authCont.accessToken.value);
    final model = UsefullContactsModel.fromJson(jsonDecode(response!.body));
    if (usefullContactsPageNumber == 1) {
      _usefulContacts.value = [];
    }
    _usefulContacts.value!.addAll(model.data!.contacts!);
  }

  //FOR CUSTOMERS
  int customersPageNumber = 1;
  RxBool customersReachEnd = false.obs;
  final Rxn<List<ResidentialContacts>> _residentialContacts =
      Rxn<List<ResidentialContacts>>();
  List<ResidentialContacts>? get getResidentialContacts =>
      _residentialContacts.value;

  Future<void> getResidentialContactsData() async {
    final response = await ApiService.get(
        endPoint:
            '${ApiUrls.endpoint}${ApiUrls.residentialContacts}?page=$customersPageNumber&total=6',
        accessToken: authCont.accessToken.value);
    final model = ResidentialContactsModel.fromJson(jsonDecode(response!.body));
    if (customersPageNumber == 1) {
      _residentialContacts.value = [];
    }
    log(response.body.toString());
    if(model.data!.contacts!.isEmpty){
      customersReachEnd.value=true;
    }
    _residentialContacts.value!.addAll(model.data!.contacts!);
    _residentialContacts.refresh();
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () async {
      await getUsefullContactsData();
      getResidentialContactsData();
    });
  }
}
