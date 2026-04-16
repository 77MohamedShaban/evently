import '../core/resources/AssetsManager.dart';
import '../core/resources/StringsManager.dart';

class OnboardingModel {
  final image;
  final title;
  final desc;

  const OnboardingModel({
    required this.image,
    required this.title,
    required this.desc,
  });

  static  List<OnboardingModel> introData = [
    OnboardingModel(
      image: AssetsManager.onboarding_image_1,
      title: StringsManager.onboarding_title_1,
      desc: StringsManager.onboarding_desc_1,
    ),
    OnboardingModel(
      image: AssetsManager.onboarding_image_2,
      title: StringsManager.onboarding_title_2,
      desc: StringsManager.onboarding_desc_2,
    ),
    OnboardingModel(
      image: AssetsManager.onboarding_image_3,
      title: StringsManager.onboarding_title_3,
      desc: StringsManager.onboarding_desc_3,
    ),
  ];
}
