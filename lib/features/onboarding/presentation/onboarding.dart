import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/router/router_context_extension.dart';
import '../../../common/log_in_sign_up_button.dart';
import '../../../constants/string_constants.dart';
import '../../../theme/theme.dart';
import '../data/onboarding_repository.dart';
import 'widgets/dot_indicator.dart';
import 'widgets/onboarding_content.dart';

final onBoardingPageProvider = StateProvider<int>((ref) => 0);

class Onboarding extends ConsumerStatefulWidget {
  const Onboarding({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _OnboardingState();
}

class _OnboardingState extends ConsumerState<Onboarding> {
  late PageController _pageController;

  @override
  void initState() {
    _pageController = PageController(initialPage: 0);
    super.initState();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final pageIndex = ref.watch(onBoardingPageProvider);
    OnboardingRepository onBoardingRepository = OnboardingRepository();
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        body: SafeArea(
            child: Column(
          children: [
            Expanded(
              child: PageView.builder(
                physics: const ScrollPhysics(parent: PageScrollPhysics()),
                itemCount: onBoardingRepository.data.length,
                controller: _pageController,
                onPageChanged: (value) =>
                    ref.read(onBoardingPageProvider.notifier).state = value,
                itemBuilder: (context, index) => SizedBox(
                  height: MediaQuery.of(context).size.height / 2,
                  child: Column(
                    children: [
                      Expanded(
                        child: OnboardContent(
                          asset: onBoardingRepository.data[index].image,
                          title: onBoardingRepository.data[index].title,
                        ),
                      ),
                      index == 4
                          ? Column(children: [
                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: LogInSignUpButton(
                                  color: ThemeColors.main,
                                  label: StringConstants.existingMember,
                                  onPressed: () {
                                    context.goLogIn();
                                  },
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(20, 0, 20, 40),
                                child: LogInSignUpButton(
                                  color: ThemeColors.primary,
                                  label: StringConstants.newMember,
                                  onPressed: () {
                                    context.goSignUp();
                                  },
                                ),
                              ),
                            ])
                          : const SizedBox.shrink(),
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  onBoardingRepository.data.length,
                  (index) => Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: DotIndicator(
                      isActive: index == pageIndex,
                    ),
                  ),
                ),
              ],
            ),
          ],
        )),
      ),
    );
  }
}
