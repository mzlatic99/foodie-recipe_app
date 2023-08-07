import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/features/authentification/data/auth_repository.dart';
import 'package:foodie/router/router_context_extension.dart';

import '../../../../constants/firebase_constants.dart';
import '../../../../constants/string_constants.dart';
import '../../../../theme/theme.dart';

final searchProvider = StateProvider<String>((ref) => '');

class AddFriendPage extends ConsumerStatefulWidget {
  const AddFriendPage({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _AddFriendPageState();
}

class _AddFriendPageState extends ConsumerState<AddFriendPage> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final firestore = FirebaseFirestore.instance;
    final currentUser = ref.watch(authRepositoryProvider).currentUser;
    return Scaffold(
        appBar: AppBar(
          title: Text(
            StringConstants.addFriend,
            style: TextStyles.title,
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                child: TextField(
                  controller: _controller,
                  onChanged: (value) {
                    ref.read(searchProvider.notifier).state = value;
                  },
                  onTapOutside: (event) =>
                      FocusManager.instance.primaryFocus?.unfocus(),
                  decoration: _addInputFieldDecoration(
                      StringConstants.searchComunity, TextStyles.text),
                ),
              ),
              StreamBuilder(
                  stream: firestore
                      .collection(FirebaseConstants.usersCollection)
                      .snapshots(),
                  builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                    List data = !snapshot.hasData
                        ? []
                        : snapshot.data!.docs
                            .where((element) =>
                                element[FirebaseConstants.nameField]
                                    .toString()
                                    .contains(ref.watch(
                                      searchProvider,
                                    )))
                            .toList();
                    return ListView.builder(
                        shrinkWrap: true,
                        itemCount: data.length,
                        itemBuilder: (context, i) {
                          final bool skip =
                              data[i][FirebaseConstants.nameField] as String ==
                                  currentUser!.displayName;
                          return skip
                              ? const SizedBox.shrink()
                              : Card(
                                  elevation: 0,
                                  child: ListTile(
                                    dense: true,
                                    onTap: () {
                                      final id = data[i].id.toString();
                                      final name = data[i]
                                              [FirebaseConstants.nameField]
                                          as String;
                                      context.pushChatPage(
                                        id: id,
                                        name: name,
                                        roomId: FirebaseConstants.emptyRoomId,
                                      );
                                    },
                                    contentPadding: const EdgeInsets.symmetric(
                                        horizontal: 15, vertical: 5),
                                    horizontalTitleGap: 0,
                                    leading: SvgPicture.asset(
                                      data[i][FirebaseConstants.avatarField],
                                      alignment: Alignment.centerLeft,
                                    ),
                                    title: Text(
                                        data[i][FirebaseConstants.nameField]),
                                  ),
                                );
                        });
                  })
            ],
          ),
        ));
  }

  InputDecoration _addInputFieldDecoration(String hint, TextStyle style) {
    return InputDecoration(
      hintText: hint,
      hintStyle: style,
      focusColor: ThemeColors.greyText,
      contentPadding: const EdgeInsets.all(15),
      focusedBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ThemeColors.primary,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
      enabledBorder: OutlineInputBorder(
        borderSide: const BorderSide(
          color: ThemeColors.main,
          width: 2,
        ),
        borderRadius: BorderRadius.circular(16),
      ),
    );
  }
}
