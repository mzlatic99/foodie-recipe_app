import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/features/authentification/data/auth_repository.dart';
import 'package:foodie/features/challenges/presentation/challenges_controller.dart';
import 'package:foodie/features/rewards/controller/rewards_controller.dart';
import 'package:foodie/router/app_router.dart';

import '../../../../router/app_route.dart';
import '../../../../theme/theme.dart';
import 'profile_controller.dart';
import 'widgets/profile_title_row.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authRepositoryProvider);
    final challengeController = ref.watch(challengeControllerProvider.notifier);
    final profileController = ref.watch(profileControllerProvider);
    final rewardsController = ref.watch(rewardsControllerProvider.notifier);
    rewardsController.checkRewardConditions();
    final goRouter = ref.watch(goRouterProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
            appBar: AppBar(
              forceMaterialTransparency: true,
              automaticallyImplyLeading: false,
              actions: [
                IconButton(
                  padding: const EdgeInsets.only(right: 10),
                  onPressed: () async {
                    await profileController.signOut();
                    if (auth.currentUser == null) {
                      goRouter.pushNamed(AppRoute.login.name);
                    }
                  },
                  icon: SvgPicture.asset(
                    Assets.icons.signOut,
                    width: 20,
                  ),
                ),
              ],
            ),
            body: SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Column(
                      children: [
                        SvgPicture.asset(
                          auth.currentUser?.photoURL ?? Assets.avatars.avatar0,
                        ),
                        Text(
                          '${auth.currentUser?.displayName}',
                          style: TextStyles.mainText,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Broj bodova: ',
                              style: TextStyles.text,
                            ),
                            Text(
                              profileController.displayPoints(),
                              style: TextStyles.mainText,
                            ),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              'Level: ',
                              style: TextStyles.text,
                            ),
                            Text(
                              profileController.displayLevel(),
                              style: TextStyles.mainText,
                            ),
                          ],
                        ),
                      ]
                          .map((e) => Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 3),
                                child: e,
                              ))
                          .toList(),
                    ),
                    ProfileTitleRow(
                      icon: Assets.icons.medal,
                      label: 'Medalje',
                      function: () {},
                      secondLabel: '',
                    ),
                    challengeController.numberOfCompletedChallenges > 0
                        ? SizedBox(
                            height: 80,
                            width: double.infinity,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: true,
                                itemCount: challengeController
                                    .numberOfCompletedChallenges,
                                itemBuilder: (context, index) {
                                  final challenge = profileController
                                      .challengeToDisplay(index);
                                  return challenge.completed
                                      ? Padding(
                                          padding:
                                              const EdgeInsets.only(right: 15),
                                          child: SvgPicture.asset(
                                            challenge.icon,
                                            width: 50,
                                          ),
                                        )
                                      : const SizedBox.shrink();
                                }),
                          )
                        : const SizedBox.shrink(),
                    ProfileTitleRow(
                      icon: Assets.icons.trophy,
                      label: 'Nagrade',
                      function: () {},
                      secondLabel: 'Vidi sve',
                    ),
                    ListView.builder(
                        shrinkWrap: true,
                        itemCount: rewardsController.rewards.length,
                        physics: const NeverScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          final reward =
                              profileController.rewardToDisplay(index);
                          return ListTile(
                            dense: true,
                            leading: SvgPicture.asset(
                              reward.completed
                                  ? Assets.icons.receivedBadge
                                  : Assets.icons.unreceivedBadge,
                              alignment: Alignment.centerLeft,
                            ),
                            title:
                                Text(reward.name, style: TextStyles.mainText),
                            subtitle: Text(reward.description,
                                style: TextStyles.text),
                          );
                        }),
                    ProfileTitleRow(
                      icon: Assets.icons.time,
                      label: 'Povijest gurmanskih napada',
                      function: () {},
                      secondLabel: 'Vidi sve',
                    ),
                  ],
                ),
              ),
            )),
      ),
    );
  }
}
