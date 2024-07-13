import 'dart:convert';
import 'dart:developer';
import 'dart:io';

import 'package:doss/constants/api.dart';
import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/formatters.dart';
import 'package:doss/models/acc_detail.dart';
import 'package:doss/models/bank.dart';
import 'package:doss/models/zip_code.dart';
import 'package:doss/services/api.dart';
import 'package:doss/services/banks.dart';
import 'package:doss/services/zipcode.dart';
import 'package:doss/view/widgets/custom_snackbar.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class AccountDetailCont extends GetxController {
  Rxn<AccountDetailModel> _accDetail = Rxn<AccountDetailModel>();
  AccountDetailModel? get getAccDetail => _accDetail.value;

  //FOR USER DATA
  final userDataformKey = GlobalKey<FormState>();
  TextEditingController name = TextEditingController();
  TextEditingController phone = TextEditingController();
  TextEditingController document = TextEditingController();
  RxBool isCpfSelected = true.obs;
  RxBool isCpnjSelected = false.obs;
  RxString photoUrl = ''.obs;
  final FocusNode nameNode = FocusNode();
  final FocusNode phoneNode = FocusNode();
  final FocusNode documentNode = FocusNode();
  Rxn<XFile> photo = Rxn<XFile>();
  RxString userPhotoUrl = ''.obs;
  String base64Image = '';

  //FOR BASE ADDRESS
  RxBool isCheckingZipCode = false.obs;

  final baseAddressformKey = GlobalKey<FormState>();
  TextEditingController number = TextEditingController();
  TextEditingController country = TextEditingController();
  TextEditingController city = TextEditingController();
  TextEditingController street = TextEditingController();
  TextEditingController state = TextEditingController();
  TextEditingController zipCode = TextEditingController();
  TextEditingController complement = TextEditingController();
  final FocusNode numberNode = FocusNode();
  final FocusNode countryNode = FocusNode();
  final FocusNode cityNode = FocusNode();
  final FocusNode streetNode = FocusNode();
  final FocusNode zipCodeNode = FocusNode();
  final FocusNode complementNode = FocusNode();

  //FOR BASE AREA
  RxInt area = 30.obs;

  //FOR PLANS AND PAYMENTS

  final plansAndPaymentsFormKey = GlobalKey<FormState>();

  TextEditingController homePrice = TextEditingController();
  TextEditingController commercialPrice = TextEditingController();
  TextEditingController agency = TextEditingController();
  TextEditingController account = TextEditingController();
  final FocusNode homeNode = FocusNode();
  final FocusNode commercialNode = FocusNode();
  final FocusNode agencyNode = FocusNode();
  final FocusNode accountNode = FocusNode();
  RxString? selectedBank = "".obs;
  RxString? selectedBankId = "".obs;
  Rxn<BankModel> banks = Rxn<BankModel>();
  BankModel? get getBankDetails => banks.value;

  _asdasd() {}

  Future<void> checkZipCode(String val) async {
    try {
      isCheckingZipCode.value = true;
      final model = await ZipCodeService.getZipCodeDetails(val);
      if (model != null) {
        state.text = model.data!.state!.sigla!;
        city.text = model.data!.city!.name!;
        street.text = model.data!.street!;
        complement.text = model.data!.complement!;
        country.text = 'Brazil';
      }
    } catch (e) {
    } finally {
      isCheckingZipCode.value = false;
    }
  }

  Future<void> _getUserDetails() async {
    try {
      final response = await ApiService.get(
          endPoint: ApiUrls.endpoint + ApiUrls.serviceProvider,
          accessToken: authCont.accessToken.value);
      log(response!.body);
      if (response?.statusCode == 200) {
        _accDetail.value =
            AccountDetailModel.fromJson(jsonDecode(response!.body));
        //STORE DATA IN ALL VARIABLES
        final data = getAccDetail!.data!;

        //USER INFO
        name.text = data.serviceProvider!.name!;
        phone.text = data.serviceProvider!.phone!;
        document.text = data.serviceProvider!.document!;
        photoUrl.value = data.serviceProvider!.photo ?? "";
        if (data.serviceProvider!.typeDocument == 'Cpf') {
          isCpfSelected.value = true;
        }
        userPhotoUrl.value = data.serviceProvider!.photo!;
        //ADDRESS
        zipCode.text = data.address!.zipCode!;
        country.text = data.address!.country!;
        state.text = data.address!.state!;
        number.text = data.address!.number!;
        city.text = data.address!.city!;
        street.text = data.address!.street!;
        complement.text = data.address!.complement!;

        //FOR AREA
        log("AREAAA ${data.coverage!.coverageArea!}");
        area.value = data.coverage!.coverageArea!.toInt();
        //FOR PLANS AND PAYMENTS
        homePrice.text =
            priceFormat.format(data.formPayment!.plans!.first.price!);
        commercialPrice.text =
            priceFormat.format(data.formPayment!.plans!.last.price!);
        selectedBankId!.value = data.formPayment!.bankId!;
        agency.text = data.formPayment!.agency!;
        account.text = data.formPayment!.account!;
        banks.value!.data.banks.forEach((element) {
          if (element.id == selectedBankId!.value) {
            selectedBank!.value = element.name;
          }
        });
      }
    } catch (e) {
      print(e);
      showCustomSnackbar(true, "Something went wrong");
    }
  }

  Future<void> updateUserDetails() async {
    try {
      if (photo.value != null) {
        await convertImageToBase64();
      }
      log(area.toString());
      final body = {
        "serviceProvider": photo.value == null
            ? {
                "id": getAccDetail!.data!.serviceProvider!.id,
                "name": name.text,
                "typeDocument": isCpfSelected.value ? "Cpf" : 'Cpnj',
                "document": document.text,
                "phone": phone.text,
              }
            : {
                "id": getAccDetail!.data!.serviceProvider!.id,
                "name": name.text,
                "typeDocument": isCpfSelected.value ? "Cpf" : 'Cpnj',
                "document": document.text,
                "phone": phone.text,
                "photo": base64Image
              },
        "address": {
          "zipCode": zipCode.text,
          "country": country.text,
          "state": state.text,
          "city": city.text,
          "neighborhood": "",
          "street": street.text,
          "complement": complement.text,
          "number": number.text
        },
        "coverage": {"coverageArea": area.value},
        "formPayment": {
          "bankId": selectedBankId!.value,
          "agency": agency.text,
          "account": account.text,
          "plans": [
            {
              "id": getAccDetail!.data!.formPayment!.plans!.first.id,
              "description":
                  getAccDetail!.data!.formPayment!.plans!.first.description,
              "price": homePrice.text.contains(",")
                  ? homePrice.text.replaceAll(",", ".")
                  : homePrice.text
            },
            {
              "id": getAccDetail!.data!.formPayment!.plans![1].id,
              "description":
                  getAccDetail!.data!.formPayment!.plans![1].description,
              "price": commercialPrice.text.contains(",")
                  ? commercialPrice.text.replaceAll(",", ".")
                  : commercialPrice.text
            }
          ]
        }
      };

      authCont.isLoading.value = true;
      await ApiService.put(
          endPoint: ApiUrls.endpoint + ApiUrls.serviceProvider,
          accessToken: authCont.accessToken.value,
          body: body);
      showCustomSnackbar(false, "Updated!");
    } catch (e) {
      print(e);
      showCustomSnackbar(true, "Something went wrong");
    } finally {
      authCont.isLoading.value = false;
    }
  }

  Future<void> convertImageToBase64() async {
    XFile? image = photo.value;
    if (image != null) {
      File file = File(image.path);
      List<int> imageBytes = await file.readAsBytes();
      base64Image = base64Encode(imageBytes);
    } else {
      base64Image = '';
    }
  }

  @override
  void onInit() {
    super.onInit();
    Future.delayed(Duration.zero, () async {
      banks.value = await BanksService.getBanks();
      _getUserDetails();
    });
  }
}
