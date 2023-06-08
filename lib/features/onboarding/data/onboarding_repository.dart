import '../../../theme/theme.dart';
import '../domain/onboard.dart';

class OnboardingRepository {
  final List<Onboard> data = [
    Onboard('', image: Assets.images.logo),
    Onboard('Pronađi svoju inspiraciju', image: Assets.images.onboarding0),
    Onboard('Kuhaj, šeraj i natječi se', image: Assets.images.onboarding1),
    Onboard('Skupljaj bodove i osvoji nagrade',
        image: Assets.images.onboarding2),
    Onboard('Upusti se u kulinarsku avanturu',
        image: Assets.images.onboarding3),
  ];
}
