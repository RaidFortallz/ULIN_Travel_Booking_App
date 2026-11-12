import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/app_snackbar.dart';
import 'package:ulin/core/constants/custom_widgets/button_custom.dart';
import 'package:ulin/core/constants/custom_widgets/error_text.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';
import 'package:ulin/core/constants/custom_widgets/textfield_custom.dart';
import 'package:ulin/core/di/injection.dart';
import 'package:ulin/core/state/request_cubit.dart';
import 'package:ulin/features/auth/presentation/cubit/password_reset_cubit.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final PasswordResetCubit _cubit = getIt<PasswordResetCubit>();
  final TextEditingController _emailController = TextEditingController();
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _emailController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _emailController.dispose();
    _cubit.close();
    super.dispose();
  }

  bool get _isEmailValid => RegExp(
    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
  ).hasMatch(_emailController.text.trim());

  void _submit() {
    FocusScope.of(context).unfocus();
    setState(() => _submitted = true);

    if (_isEmailValid) {
      _cubit.forgotPassword(_emailController.text.trim());
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<PasswordResetCubit, RequestState<Object>>(
      bloc: _cubit,
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == RequestStatus.success) {
          final email = Uri.encodeQueryComponent(_emailController.text.trim());
          context.push('/reset-password?email=$email');
        } else if (state.status == RequestStatus.failure) {
          showAppSnackBar(context, state.message ?? 'Something went wrong');
        }
      },
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: Column(
            children: [
              Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                  onPressed: () => context.pop(),
                  icon: Icon(Icons.arrow_back_ios_new_rounded),
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 45),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Image.asset(
                            'assets/images/ulin1.png',
                            width: 60,
                            height: 60,
                          ),
                        ),

                        SizedBox(height: 36),

                        TextCustom(
                          "Forgot Password?",
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),

                        SizedBox(height: 8),

                        TextCustom(
                          "Enter your email and we will send you a 6-digit code to reset your password.",
                          fontSize: 13,
                          color: WarnaApp.wrBlack.withValues(alpha: 0.6),
                        ),

                        SizedBox(height: 36),

                        TextCustom(
                          "Email",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          controller: _emailController,
                          hintText: "johndoe@gmail.com",
                          fillColor: WarnaApp.wrWhite,
                          width: double.infinity,
                          height: 38,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          prefix: Icon(
                            Icons.email_outlined,
                            color: WarnaApp.wrMain,
                          ),
                        ),

                        if (_submitted && !_isEmailValid) ...[
                          SizedBox(height: 4),
                          ErrorText(
                            "Enter a valid email, e.g. johndoe@gmail.com",
                          ),
                        ],

                        SizedBox(height: 40),

                        BlocBuilder<PasswordResetCubit, RequestState<Object>>(
                          bloc: _cubit,
                          builder: (context, state) {
                            return Center(
                              child: ButtonCustom(
                                label: "Send Code",
                                isLoading: state.isLoading,
                                onTap: _submit,
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
