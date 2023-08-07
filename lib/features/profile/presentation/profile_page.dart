import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/features/authentification/data/auth_repository.dart';
import 'package:foodie/features/challenges/presentation/challenges_controller.dart';
import 'package:foodie/features/rewards/controller/rewards_controller.dart';
import 'package:foodie/utils/widgets/helper_widget.dart';

import '../../../../theme/theme.dart';
import '../../../constants/string_constants.dart';
import '../../../providers/providers.dart';
import '../../../router/app_route.dart';
import '../../../router/app_router.dart';
import '../../../services/points/points.dart';
import 'profile_controller.dart';
import 'widgets/profile_title_row.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final auth = ref.watch(authRepositoryProvider);
    ref.read(storageServiceProvider).user = auth.currentUser!.email!;
    final challengeController = ref.read(challengeControllerProvider.notifier);
    final profileController = ref.read(profileControllerProvider.notifier);
    final rewardsController = ref.read(rewardsControllerProvider.notifier);
    final totalPoints = ref.watch(pointsProvider);
    final goRouter = ref.watch(goRouterProvider);
    rewardsController.checkRewardConditions();
    return WillPopScope(
      onWillPop: () async => false,
      child: SafeArea(
        child: Scaffold(
          extendBodyBehindAppBar: true,
          appBar: AppBar(
            automaticallyImplyLeading: false,
            forceMaterialTransparency: true,
            actions: [
              GestureDetector(
                onTap: () async {
                  await profileController.signOut();
                  goRouter.goNamed(AppRoute.login.name);
                },
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: SvgPicture.asset(
                    Assets.icons.signOut,
                    width: 25,
                  ),
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
                            StringConstants.points,
                            style: TextStyles.text,
                          ),
                          Text(
                            ': ${totalPoints.getTotalPoints()}',
                            style: TextStyles.mainText,
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            StringConstants.level,
                            style: TextStyles.text,
                          ),
                          Text(
                            ' ${totalPoints.calculateLevel()}',
                            style: TextStyles.mainText,
                          ),
                        ],
                      ),
                    ]
                        .map((e) => Padding(
                              padding: const EdgeInsets.symmetric(vertical: 3),
                              child: e,
                            ))
                        .toList(),
                  ),
                  ProfileTitleRow(
                    icon: Assets.icons.medal,
                    label: StringConstants.medals,
                    function: () {},
                  ),
                  challengeController.getNumberOfCompletedChallenges() > 0
                      ? SizedBox(
                          height: 70,
                          width: double.infinity,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            itemCount: challengeController
                                .getNumberOfCompletedChallenges(),
                            itemBuilder: (context, index) {
                              final challenge = profileController
                                  .completedChallengeBadgeToDisplay(index);
                              return challenge.completed
                                  ? Padding(
                                      padding: const EdgeInsets.only(right: 15),
                                      child: GestureDetector(
                                        onTap: () => showSnackBar(context,
                                            content: challenge.description),
                                        child: SvgPicture.asset(
                                          challenge.icon,
                                          width: 50,
                                        ),
                                      ),
                                    )
                                  : const SizedBox.shrink();
                            },
                          ),
                        )
                      : const SizedBox.shrink(),
                  ProfileTitleRow(
                    icon: Assets.icons.trophy,
                    label: StringConstants.rewards,
                    function: () {},
                  ),
                  ListView.builder(
                      padding: EdgeInsets.zero,
                      shrinkWrap: true,
                      itemCount: rewardsController.rewards.length,
                      physics: const NeverScrollableScrollPhysics(),
                      itemBuilder: (context, index) {
                        final reward = profileController.rewardToDisplay(index);
                        if (reward != null) {
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
                        } else {
                          return const SizedBox.shrink();
                        }
                      }),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
