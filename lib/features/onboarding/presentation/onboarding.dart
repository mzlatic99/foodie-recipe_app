import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/router/router_context_extension.dart';
import '../../../common/log_in_register_button.dart';
import '../../../theme/theme.dart';
import '../data/onboarding_repository.dart';
import 'widgets/dot_indicator.dart';
import 'widgets/onboarding_content.dart';
import '../../../providers/providers.dart';

class Onboarding extends ConsumerStatefulWidget {
  const Onboarding({super.key});

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
    return Scaffold(
      body: SafeArea(
          child: Column(
        children: [
          Expanded(
            child: PageView.builder(
              physics: const ScrollPhysics(parent: PageScrollPhysics()),
              itemCount: OnboardingRepository().data.length,
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
                        ? Column(
                            children: [
                              LogInRegisterButton(
                                color: ThemeColors.main,
                                label: 'Postojeći član',
                                onPressed: () {
                                  context.goLogIn();
                                },
                              ),
                              LogInRegisterButton(
                                color: ThemeColors.primary,
                                label: 'Novi Član',
                                onPressed: () {
                                  context.goSignUp();
                                },
                              ),
                            ],
                          )
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
                OnboardingRepository().data.length,
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
    );
  }
}
