import 'package:doss/constants/icons.dart';

class OnBoardingModel {
  final String image;
  final String title;
  final String description;

  OnBoardingModel({
    required this.image,
    required this.title,
    required this.description,
  });
}
final List<OnBoardingModel> onBoardingData = [
  OnBoardingModel(
    image: 'assets/images/onBoarding1.png',
    title: 'Welcome to DossApp!',
    description: 'Discover customers for your own coverage area.',
  ),
  OnBoardingModel(
    image: 'assets/images/onBoarding2.png',
    title: 'Real-time coverage',
    description:
    'With Coverages you support your customers in a technological and assertive way.',
  ),
  OnBoardingModel(
    image: 'assets/images/onBoarding3.png',
    title: 'In-app checks',
    description:
    'With Verifications you interact with your customer in a punctual and direct way.',
  ),
];


class HomeGridModel {
  final String icon;
  final String title;

  HomeGridModel({
    required this.icon,
    required this.title,
  });
}
final List<HomeGridModel> homeGridData = [
  HomeGridModel(
    icon: AppIcons.profile,
    title: 'Account',
  ),
  HomeGridModel(
    icon: AppIcons.car,
    title: 'Vehicles',
  ),
  HomeGridModel(
    icon: AppIcons.profile,
    title: 'Notifications',
  ),
  HomeGridModel(
    icon: AppIcons.people,
    title: 'Customers',
  ),
  HomeGridModel(
    icon: AppIcons.refresh,
    title: 'History',
  ),
  HomeGridModel(
    icon: AppIcons.message,
    title: 'Help',
  ),
];

