import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/features/challenges/presentation/challenges_controller.dart';
import 'package:intl/intl.dart';

import '../../../constants/storage_box_constants.dart';
import '../../../constants/string_constants.dart';
import '../../../providers/providers.dart';
import '../../../theme/theme.dart';
import '../../authentification/data/auth_repository.dart';
import '../domain/challenge.dart';

class ChallengesPage extends ConsumerStatefulWidget {
  const ChallengesPage({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends ConsumerState<ChallengesPage> {
  @override
  Widget build(BuildContext context) {
    final auth = ref.watch(authRepositoryProvider);
    ref.read(storageServiceProvider).user = auth.currentUser!.email!;
    final challengeController = ref.watch(challengeControllerProvider.notifier);
    final storageService = ref.watch(storageServiceProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            StringConstants.culinaryMissions,
            style: TextStyles.title,
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${DateFormat.MMMMd().format(challengeController.currentWeekMonday(DateTime.now()))} - ${DateFormat.MMMMd().format(challengeController.currentWeekSunday(DateTime.now()))}',
              ),
              const SizedBox(
                height: 20,
              ),
              Expanded(
                  child: ListView.builder(
                      shrinkWrap: true,
                      itemCount:
                          challengeController.numberOfChallengesDisplayed,
                      itemBuilder: (context, index) {
                        final challenge =
                            challengeController.challengeToDisplay(index);

                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: SizedBox(
                            height: challengeController.rowHeight,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                  child: SvgPicture.asset(
                                    challenge.icon,
                                    alignment: Alignment.centerLeft,
                                  ),
                                ),
                                Expanded(
                                  flex: 2,
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        challenge.name,
                                        style: TextStyles.subtitle.copyWith(
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      Text(
                                        challenge.description,
                                        style: TextStyles.text
                                            .copyWith(color: ThemeColors.main),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              challenge.progress.toString(),
                                              style: TextStyles.text,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: LinearProgressIndicator(
                                                  value: (challenge.progress /
                                                          challenge.quantity)
                                                      .toDouble(),
                                                  minHeight: 15,
                                                  color: ThemeColors.main,
                                                  backgroundColor:
                                                      ThemeColors.inactiveStep),
                                            ),
                                          ),
                                          Expanded(
                                            child: Text('${challenge.quantity}',
                                                textAlign: TextAlign.right,
                                                style: TextStyles.text),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: challenge.completed
                                      ? SvgPicture.asset(
                                          Assets.icons.check,
                                          alignment: Alignment.centerRight,
                                        )
                                      : Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            storageService.getLength<Challenge>(
                                                            StorageBox
                                                                .challengesBox) ==
                                                        3 ||
                                                    challenge.progress > 0
                                                ? const SizedBox.shrink()
                                                : GestureDetector(
                                                    onTap: () {
                                                      challengeController
                                                          .replaceChallenge(
                                                              challenge);
                                                      setState(() {});
                                                    },
                                                    child: SvgPicture.asset(
                                                      Assets.icons.replace,
                                                    ),
                                                  ),
                                            Text(
                                              '${challenge.points} points',
                                              style: TextStyles.points,
                                            ),
                                          ],
                                        ),
                                )
                              ],
                            ),
                          ),
                        );
                      }))
            ],
          ),
        ),
      ),
    );
  }
}
