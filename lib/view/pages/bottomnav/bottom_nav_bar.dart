import 'package:doss/constants/cont.dart';
import 'package:doss/view/pages/bottomnav/profile/profile.dart';
import 'package:doss/view/pages/bottomnav/roof/roof.dart';
import 'package:doss/view/pages/bottomnav/verification/verification.dart';
import 'package:doss/view/widgets/background.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../constants/colors.dart';
import '../../../constants/icons.dart';
import '../../../utils/size_config.dart';
import 'home/home.dart';

class BottomNavPage extends StatefulWidget {
  const BottomNavPage({Key? key}) : super(key: key);

  @override
  State<BottomNavPage> createState() => _BottomNavPageState();
}

class _BottomNavPageState extends State<BottomNavPage>
    with WidgetsBindingObserver {
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    if (state == AppLifecycleState.resumed) {
      authCont.refreshToken();
    }
  }

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    Future.delayed(Duration.zero, () async {
      await authCont.getNewVerificationExistance();
    });
  }

  final screens = [
    const HomePage(),
    const RoofPage(),
    VerificationPage(),
    const ProfilePage()
  ];
  @override
  Widget build(BuildContext context) {
    return Obx(
      ()=>Scaffold(
        body: Background(
          child: IndexedStack(
            index: authCont.bnbIndex.value,
            children: screens,
          ),
        ),
        bottomNavigationBar: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          backgroundColor: AppColors.darkGryClr,
          showSelectedLabels: false,
          showUnselectedLabels: false,
          elevation: 10,
          selectedItemColor: AppColors.primaryClr,
          unselectedItemColor: Colors.white,
         currentIndex: authCont.bnbIndex.value,
          onTap: (index) => authCont.bnbIndex.value = index,
          unselectedLabelStyle:
              TextStyle(fontSize: SizeConfig.textMultiplier * 1.5),
          selectedLabelStyle:
              TextStyle(fontSize: SizeConfig.textMultiplier * 1.6),
          items: [
            BottomNavigationBarItem(
              icon: Image.asset(AppIcons.home,
                  height: SizeConfig.imageSizeMultiplier * 6,
                  color: authCont.bnbIndex.value == 0 ? AppColors.primaryClr : Colors.white),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppIcons.security,
                  height: SizeConfig.imageSizeMultiplier * 6,
                  color: authCont.bnbIndex.value == 1 ? AppColors.primaryClr : Colors.white),
              label: 'Security',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppIcons.search,
                  height: SizeConfig.imageSizeMultiplier * 6,
                  color: authCont.bnbIndex.value == 2 ? AppColors.primaryClr : Colors.white),
              label: 'search',
            ),
            BottomNavigationBarItem(
              icon: Image.asset(AppIcons.profile,
                  height: SizeConfig.imageSizeMultiplier * 6,
                  color: authCont.bnbIndex.value == 3 ? AppColors.primaryClr : Colors.white),
              label: 'Profile',
            ),
          ],
        ),
      ),
    );
  }
}
