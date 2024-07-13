import 'dart:developer';
import 'dart:ffi';

import 'package:doss/constants/cont.dart';
import 'package:doss/controllers/base_address.dart';
import 'package:doss/controllers/patrol_vehicle.dart';
import 'package:doss/controllers/plans_payment.dart';
import 'package:doss/controllers/sign_up.dart';
import 'package:doss/controllers/user_data.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/utils/spacing.dart';
import 'package:doss/view/pages/auth/signin/signin.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:doss/view/widgets/txt_button.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';

import '../../../../constants/colors.dart';
import '../../../widgets/custom_appbar.dart';
import '../../../widgets/custom_button.dart';
import '../../../widgets/custom_snackbar.dart';
import 'components/base_address.dart';
import 'components/base_area.dart';
import 'components/enter_email.dart';
import 'components/patrol_vehicle.dart';
import 'components/plan_and_payment.dart';
import 'components/user_data.dart';

class SignUpOnBoardingPage extends StatefulWidget {
  const SignUpOnBoardingPage({Key? key}) : super(key: key);

  @override
  State<SignUpOnBoardingPage> createState() => _OnBoardingState();
}

class _OnBoardingState extends State<SignUpOnBoardingPage> {
  final cont=Get.put(SignUpCont());
  final userDataCont=Get.put(UserDataCont());
  final baseAddressCont=Get.put(BaseAddressCont());
  final patrolVehicleCont=Get.put(PatrolVehicleCont());
  final planPaymentCont=Get.put(PlanPaymentCont());
  unFocusUserData(){
    userDataCont.nameNode.unfocus();
    userDataCont.phoneNode.unfocus();
    userDataCont.documentNode.unfocus();
  }
  unFocusBaseAddress(){
    baseAddressCont.numberNode.unfocus();
    baseAddressCont.streetNode.unfocus();
    baseAddressCont.countryNode.unfocus();
    baseAddressCont.cityNode.unfocus();
    baseAddressCont.zipCodeNode.unfocus();
    baseAddressCont.complementNode.unfocus();
  }
  unFocusPlanPayment(){
    planPaymentCont.agencyNode.unfocus();
    planPaymentCont.accountNode.unfocus();
    planPaymentCont.homeNode.unfocus();
    planPaymentCont.commercialNode.unfocus();
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
        ()=> Scaffold(
        body: Background(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier * 2.5),
            child: Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned(
                        top: SizeConfig.heightMultiplier*18,
                        bottom: 0,
                        left: 0,
                        right: 0,
                        child: PageView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          controller: cont.pageController,
                          itemCount:6,
                          onPageChanged: (int index) {
                              cont.currentPage.value = index;
                          },
                          itemBuilder: (context, index) {
                              if(index==0 ) {
                                return EnterEmailPage();
                            } else if(index == 1 ) {
                              return   UserData();
                            }
                            else if(index==2){
                              return const BaseAddressPage();
                            }
                            else if(index==3){
                              return  const BaseArea();
                            }
                            else if(index==4){
                              return  const PatrolVehicle();
                            }
                            else if(index==5){
                              return  PlansAndPayment();
                            }
                          },
                        ),
                      ),
                      Positioned(
                        top: SizeConfig.heightMultiplier * 7,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                             CustomAppbar(title: "Create a New Account",
                            onTap: (){
                              if(cont.currentPage.value==0){
                                unFocusUserData();
                                Get.back();
                              }
                              if(cont.currentPage.value==1){
                                unFocusUserData();
                                cont.pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                              if(cont.currentPage.value==2){
                                unFocusBaseAddress();
                                cont.pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                              if(cont.currentPage.value==3){
                                cont.pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                              if(cont.currentPage.value==4){
                                patrolVehicleCont.numberNode.unfocus();
                                cont.pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                              if(cont.currentPage.value==5){
                                unFocusPlanPayment();
                                cont.pageController.previousPage(
                                  duration: const Duration(milliseconds: 300),
                                  curve: Curves.easeInOut,
                                );
                              }
                            },
                            ),
                            Spacing.y(4),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: List.generate(
                                6,
                                    (index) => Expanded(child: buildDotIndicator(index)),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildDotIndicator(int index) {
    
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      height: SizeConfig.heightMultiplier*0.8,
      margin:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*0.8),
      decoration: BoxDecoration(
        color: cont.currentPage.value >= index ? AppColors.primaryClr : AppColors.greyClr,
        borderRadius: BorderRadius.circular(5),
      ),
    );
  }
}



