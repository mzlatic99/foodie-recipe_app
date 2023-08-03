import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:foodie/common/main_button_widget.dart';
import 'package:foodie/constants/string_constants.dart';
import 'package:foodie/features/friends/presentation/duel/duel_controller.dart';
import 'package:foodie/router/router_context_extension.dart';
import 'package:foodie/utils/widgets/add_space.dart';
import 'package:foodie/utils/widgets/loader_widget.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../theme/theme.dart';
import 'widgets/duel_option_widget.dart';

class DuelPage extends ConsumerStatefulWidget {
  const DuelPage({
    super.key,
    required this.id,
    required this.name,
    required this.roomId,
  });
  final String id;
  final String name;
  final String roomId;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _DuelPageState();
}

class _DuelPageState extends ConsumerState<DuelPage> {
  @override
  Widget build(BuildContext context) {
    final duelController = ref.watch(duelControllerProvider.notifier);
    final state = ref.watch(duelControllerProvider);
    print('STATE ERROR: ${state.error}');
    print('STATE VALUE: ${state.value}');
    print('STATE IS LOADING ${state.isLoading}');
    return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: state.hasValue
            ? MainButtonWidget(
                label: StringConstants.cook,
                style: TextStyles.mainButton,
                onPressed: () {
                  context.pushDetailPage(recipe: state.value!);
                },
                backgorundColor: ThemeColors.primary,
              )
            : const SizedBox.shrink(),
        appBar: AppBar(
          title: Text(
            widget.name,
          ),
          actions: [
            state.hasValue
                ? Padding(
                    padding: const EdgeInsets.only(right: 20),
                    child: MainButtonWidget(
                      label: StringConstants.sendCulinaryDuel,
                      style: TextStyles.mainButton,
                      onPressed: () {
                        duelController.sendDuel(widget.roomId, widget.id);
                      },
                      backgorundColor: ThemeColors.primary,
                      elevation: 0,
                    ),
                  )
                : const SizedBox.shrink(),
          ],
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Text(
                StringConstants.culinaryDuelDetails,
                style: TextStyles.title,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    child: DuelOptionWidget(
                      title: StringConstants.randomRecipe,
                      icon: Assets.icons.randomDices,
                      onTap: () async {
                        await duelController.chooseRandomRecipe();
                      },
                    ),
                  ),
                ],
              ),
              addVerticalSpace(20),
              state.isLoading
                  ? const Loader()
                  : Column(children: [
                      state.value != null
                          ? Padding(
                              padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                              child: Text(
                                state.value!.name,
                                style: TextStyles.titleProfile,
                              ),
                            )
                          : const SizedBox.shrink(),
                      state.value != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(16),
                              child: CachedNetworkImage(
                                width: MediaQuery.sizeOf(context).width * 0.6,
                                fit: BoxFit.cover,
                                imageUrl: state.value!.imageUrl,
                                placeholder: (context, url) =>
                                    Shimmer.fromColors(
                                  baseColor: Colors.black26,
                                  highlightColor: Colors.black12,
                                  child: Container(
                                    color: ThemeColors.white,
                                  ),
                                ),
                              ),
                            )
                          : const SizedBox.shrink(),
                    ]),
            ]
                .map((e) => Padding(
                      padding: const EdgeInsets.only(top: 20),
                      child: e,
                    ))
                .toList(),
          ),
        ));
  }
}
