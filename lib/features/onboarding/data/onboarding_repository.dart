import '../../../constants/string_constants.dart';
import '../../../theme/theme.dart';
import '../domain/onboard.dart';

class OnboardingRepository {
  final List<Onboard> data = [
    Onboard('', image: Assets.images.logo),
    Onboard(StringConstants.onboardingFirstMessage,
        image: Assets.images.onboarding0),
    Onboard(StringConstants.onboardingSecondMessage,
        image: Assets.images.onboarding1),
    Onboard(StringConstants.onboardingThirdMessage,
        image: Assets.images.onboarding2),
    Onboard(StringConstants.onboardingFourthMessage,
        image: Assets.images.onboarding3),
  ];
}
