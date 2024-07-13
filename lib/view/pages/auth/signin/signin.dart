import 'package:doss/controllers/sign_in.dart';
import 'package:doss/utils/size_config.dart';
import 'package:doss/view/widgets/auth_textfield.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:doss/view/widgets/custom_appbar.dart';
import 'package:doss/view/widgets/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:top_snackbar_flutter/custom_snack_bar.dart';
import 'package:top_snackbar_flutter/top_snack_bar.dart';
import '../../../../constants/colors.dart';
import '../../../../constants/icons.dart';
import '../../../../utils/spacing.dart';
import '../../../widgets/custom_snackbar.dart';
import '../../../widgets/txt_button.dart';
import '../../bottomnav/bottom_nav_bar.dart';
import '../signup/signup_onboarding.dart';


class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  final signInCont=Get.put(SignInCont());
  List<String> icon=[
    AppIcons.faceBook,
    AppIcons.google,
    AppIcons.apple,
  ];
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return  Obx(
      ()=> Scaffold(
        resizeToAvoidBottomInset: false,
        body: Background(
            child:
            Padding(
              padding:  EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*2.5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Spacing.y(7),
                  const CustomAppbar(title: "To enter"),
                  Spacing.y(4),
                  Text("Access your account",
                  style: textTheme.headlineMedium,
                  ).tr(),
                  Spacing.y(3),
                  AuthTextField(
                    onValidate: (val){
                      if(val!.isEmpty){
                        return tr("Please enter email");
                      }
                      else if (!RegExp(r'^[\w-]+(\.[\w-]+)*@gmail\.com$').hasMatch(val)) {
                        return tr("Please Enter Correct Email");
                      }
                    },
                    hintText: "Ex: seunome@email.com",
                    controller: signInCont.emailController,
                    title: "Email",
                  ),
                  AuthTextField(
                    hintText: "*********",
                    controller: signInCont.passwordController,
                    title: "Password",
                    isPassword: true,
                  ),
                  Spacing.y(4),
                  CustomButton(
                      title: "To enter",
                      onTap: (){
                        if(!signInCont.isEnabled.value) {
                          showTopSnackBar(
                            Overlay.of(context),
                            CustomSnackBar.error(message:"Enter Email and Password"),
                            displayDuration: const Duration(seconds: 1),
                          );
                        }
                        else{
                          Get.to(()=>const BottomNavPage());
                        }
                      },
                  isEnabled: signInCont.isEnabled.value,
                  ),
                  Spacing.y(4),
                  Align(
                    alignment: Alignment.center,
                    child: Text("or enter with",
                      style: textTheme.bodyLarge,
                    ).tr(),
                  ),
                  Spacing.y(3),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ...List.generate(3, (index) =>Padding(
                        padding:EdgeInsets.symmetric(horizontal: SizeConfig.widthMultiplier*2.5),
                        child: CircleAvatar(
                          radius: 22,
                          backgroundColor: AppColors.whiteClr,
                          child: Image.asset(icon[index],
                            height: SizeConfig.imageSizeMultiplier*9,
                            width: SizeConfig.imageSizeMultiplier*9,
                          ),
                        ),
                      ) )
                    ],
                  ),
                  Spacing.y(3),
                  const Spacer(),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account yet?",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium,
                      ).tr(),
                       CustomTextBtn(
                        title: "Register",
                        onTap: (){
                          Get.to(()=>const SignUpOnBoardingPage());
                        },
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Forgot password?",
                        textAlign: TextAlign.center,
                        style: textTheme.bodyMedium,
                      ).tr(),
                      const CustomTextBtn(title: "Retrieve here"),
                    ],
                  ),
                  Spacing.y(4),
                ],
              ),
            ),
          ),
       ),
    );
   }
}
