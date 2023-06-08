import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/localization/string_hardcoded_extension.dart';
import 'package:foodie/router/app_router.dart';

import '../../../../common/log_in_register_button.dart';
import '../../../../router/app_route.dart';
import '../../../../theme/theme.dart';
import '../auth_controller.dart';
import '../auth_validators.dart';
import '../widgets/secondary_auth_text_button.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> with AuthValidators {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _submitted = false;

  String get email => _emailController.text;
  String get password => _passwordController.text;

  Future<void> _submit() async {
    setState(() => _submitted = true);
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(authControllerProvider.notifier);

      controller.signIn(email, password);
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
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
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SvgPicture.asset(
                Assets.images.logo,
              ),
            ),
            Expanded(
              flex: 2,
              child: Form(
                key: _formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(25),
                      child: TextFormField(
                        controller: _emailController,
                        keyboardType: TextInputType.emailAddress,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        validator: (email) =>
                            !_submitted ? null : emailErrorText(email ?? ''),
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
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(25, 0, 25, 25),
                      child: TextFormField(
                        controller: _passwordController,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
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
                    ),
                    LogInRegisterButton(
                      color: ThemeColors.primary,
                      label: 'Ulogiraj me'.hardcoded,
                      onPressed: () {
                        _submit();
                      },
                    ),
                    Flexible(
                      child: SecondaryAuthTextButton(
                        label: 'Nemaš profil? Pridruži nam se!'.hardcoded,
                        onPressed: () {
                          goRouter.pushNamed(AppRoute.signup.name);
                        },
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
