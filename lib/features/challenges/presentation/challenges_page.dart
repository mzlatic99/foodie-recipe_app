import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/features/challenges/presentation/challenges_controller.dart';
import 'package:foodie/localization/string_hardcoded_extension.dart';
import 'package:intl/intl.dart';

import '../../../constants/app_constants.dart';
import '../../../providers/providers.dart';
import '../../../theme/theme.dart';

class ChallengesPage extends ConsumerStatefulWidget {
  const ChallengesPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _ChallengesPageState();
}

class _ChallengesPageState extends ConsumerState<ChallengesPage> {
  @override
  Widget build(BuildContext context) {
    final challengeController = ref.watch(challengeControllerProvider.notifier);
    final storageService = ref.watch(storageServiceProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          title: Text(
            'Kulinarske misije'.hardcoded,
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
                            storageService.getLength(StorageBox.challengesBox) >
                                    0
                                ? storageService
                                    .getAll(StorageBox.challengesBox)[index]
                                : challengeController.challenges[index];
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 30),
                          child: SizedBox(
                            height: 60,
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
                                      Text(challenge.name,
                                          style: TextStyles.subtitle),
                                      Text(
                                        challenge.description,
                                        style: TextStyles.text.copyWith(
                                            color: ThemeColors.inactiveStep),
                                      ),
                                      Row(
                                        children: [
                                          Expanded(
                                            child: Text(
                                              '0',
                                              style: TextStyles.text,
                                            ),
                                          ),
                                          Expanded(
                                            flex: 5,
                                            child: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(16),
                                              child: LinearProgressIndicator(
                                                  value: 0,
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
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      storageService.getLength(
                                                  StorageBox.challengesBox) ==
                                              3
                                          ? const SizedBox.shrink()
                                          : GestureDetector(
                                              onTap: () async {
                                                await challengeController
                                                    .replaceChallenge(
                                                        challenge, index);
                                                setState(() {});
                                              },
                                              child: SvgPicture.asset(
                                                Assets.icons.replace,
                                              ),
                                            ),
                                      Text(
                                        '${challenge.points} bodova',
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
