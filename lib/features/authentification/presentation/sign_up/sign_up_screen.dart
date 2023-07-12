import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/features/authentification/data/avatar_data.dart';
import 'package:foodie/features/authentification/presentation/auth_controller.dart';
import 'package:foodie/localization/string_hardcoded_extension.dart';
import 'package:foodie/router/app_router.dart';
import 'package:foodie/router/router_context_extension.dart';

import '../../../../common/log_in_sign_up_button.dart';
import '../../../../router/app_route.dart';
import '../../../../theme/theme.dart';
import '../widgets/secondary_auth_text_button.dart';
import '../auth_validators.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends ConsumerState<SignUpScreen>
    with AuthValidators {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _nameController = TextEditingController();

  bool _submitted = false;

  String get email => _emailController.text;
  String get password => _passwordController.text;
  String get name => _nameController.text;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  Future<bool> _submit(String avatarUrl, BuildContext context) async {
    setState(() => _submitted = true);
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(authControllerProvider.notifier);
      final isSigned = controller.createUser(name, email, password, avatarUrl);
      return isSigned;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      authControllerProvider,
      ((previous, state) {
        if (state is AsyncError) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.error.toString(),
              ),
              backgroundColor: ThemeColors.primary,
            ),
          );
        }
      }),
    );
    final goRouter = ref.read(goRouterProvider);
    return WillPopScope(
      onWillPop: () async => false,
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: SafeArea(
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                children: [
                  SvgPicture.asset(
                    Assets.images.logo,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 25),
                    child: Form(
                      key: _formKey,
                      child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            TextFormField(
                              controller: _nameController,
                              keyboardType: TextInputType.name,
                              validator: (name) => !_submitted
                                  ? null
                                  : nameErrorText(name ?? ''),
                              decoration: InputDecoration(
                                hintText: 'Ime'.hardcoded,
                                hintStyle: TextStyles.text,
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
                              ),
                            ),
                            TextFormField(
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => !_submitted
                                  ? null
                                  : emailErrorText(email ?? ''),
                              decoration: InputDecoration(
                                hintText: 'Email'.hardcoded,
                                hintStyle: TextStyles.text,
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
                              ),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (password) => !_submitted
                                  ? null
                                  : passwordErrorText(password ?? ''),
                              decoration: InputDecoration(
                                hintText: 'Lozinka'.hardcoded,
                                hintStyle: TextStyles.text,
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
                              ),
                            ),
                            Text(
                              'Odaberi avatara:'.hardcoded,
                              style: TextStyles.secondaryAuthText,
                            ),
                            SizedBox(
                              height: 180,
                              child: GridView.builder(
                                physics: const NeverScrollableScrollPhysics(),
                                itemCount: AvatarData.avatars.length,
                                gridDelegate:
                                    const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 4,
                                  mainAxisSpacing: 10,
                                  crossAxisSpacing: 10,
                                ),
                                itemBuilder: (context, index) {
                                  final avatar = AvatarData.avatars[index];

                                  final isSelected = index ==
                                      ref
                                          .watch(
                                              authControllerProvider.notifier)
                                          .selectedAvatarIndex;

                                  return GestureDetector(
                                    onTap: () {
                                      ref
                                          .read(authControllerProvider.notifier)
                                          .setSelectedAvatarIndex(index);
                                      setState(() {});
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(50),
                                      child: SvgPicture.asset(
                                        avatar,
                                        alignment: Alignment.centerLeft,
                                        colorFilter: ColorFilter.mode(
                                            ThemeColors.primary,
                                            isSelected
                                                ? BlendMode.color
                                                : BlendMode.dstIn),
                                      ),
                                    ),
                                  );
                                },
                              ),
                            ),
                            LogInSignUpButton(
                              color: ThemeColors.primary,
                              label: 'Pridruži me'.hardcoded,
                              onPressed: () async {
                                final selectedIndex = ref
                                    .read(authControllerProvider.notifier)
                                    .selectedAvatarIndex;
                                final avatarUrl =
                                    AvatarData.avatars[selectedIndex];

                                final canEnter =
                                    await _submit(avatarUrl, context);
                                if (canEnter) {
                                  goRouter.pushNamed(AppRoute.home.name);
                                }
                              },
                            ),
                            SecondaryAuthTextButton(
                              label: 'Imaš profil? Ulogiraj se!'.hardcoded,
                              onPressed: () {
                                context.pushLogIn();
                              },
                            ),
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: e,
                                  ))
                              .toList()),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
