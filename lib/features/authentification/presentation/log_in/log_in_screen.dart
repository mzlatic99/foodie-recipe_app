import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:foodie/router/app_router.dart';
import 'package:foodie/router/router_context_extension.dart';
import 'package:foodie/utils/async_value_ui_extension.dart';
import 'package:foodie/utils/widgets/loader_widget.dart';

import '../../../../common/log_in_sign_up_button.dart';
import '../../../../constants/string_constants.dart';
import '../../../../router/app_route.dart';
import '../../../../theme/theme.dart';
import '../auth_controller.dart';
import '../auth_validators.dart';
import '../widgets/secondary_auth_text_button.dart';

class LogInScreen extends ConsumerStatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _LogInScreenState();
}

class _LogInScreenState extends ConsumerState<LogInScreen> with AuthValidators {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _submitted = false;

  String get email => _emailController.text.trim();
  String get password => _passwordController.text.trim();

  Future<bool> _submit() async {
    setState(() => _submitted = true);
    FocusScope.of(context).unfocus();
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(authControllerProvider.notifier);
      final success = await controller.signIn(email, password);
      return success;
    }
    return false;
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
      (_, state) => state.showSnackbarOnError(context),
    );
    final goRouter = ref.watch(goRouterProvider);
    final authController = ref.watch(authControllerProvider);
    return Scaffold(
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
                              style: TextStyles.textFieldStyle,
                              controller: _emailController,
                              keyboardType: TextInputType.emailAddress,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              validator: (email) => !_submitted
                                  ? null
                                  : emailErrorText(email ?? ''),
                              decoration: const InputDecoration(
                                hintText: StringConstants.email,
                              ),
                            ),
                            TextFormField(
                              controller: _passwordController,
                              autovalidateMode:
                                  AutovalidateMode.onUserInteraction,
                              obscureText: true,
                              validator: (password) => !_submitted
                                  ? null
                                  : passwordErrorText(password ?? ''),
                              decoration: const InputDecoration(
                                hintText: StringConstants.password,
                              ),
                            ),
                            authController.isLoading
                                ? const Center(
                                    child: Loader(),
                                  )
                                : LogInSignUpButton(
                                    color: ThemeColors.primary,
                                    label: StringConstants.login,
                                    onPressed: authController.isLoading
                                        ? null
                                        : () async {
                                            final isSubmitted = await _submit();
                                            if (isSubmitted) {
                                              goRouter
                                                  .goNamed(AppRoute.home.name);
                                              ref.invalidate(
                                                  authControllerProvider);
                                            }
                                          },
                                  ),
                            SecondaryAuthTextButton(
                              label: StringConstants.loginSecondaryButtonLabel,
                              onPressed: () {
                                context.goSignUp();
                              },
                            ),
                          ]
                              .map((e) => Padding(
                                    padding: const EdgeInsets.symmetric(
                                        vertical: 10),
                                    child: e,
                                  ))
                              .toList())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
