import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/app_snackbar.dart';
import 'package:ulin/core/constants/custom_widgets/button_custom.dart';
import 'package:ulin/core/constants/custom_widgets/error_text.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';
import 'package:ulin/core/constants/custom_widgets/textfield_custom.dart';
import 'package:ulin/core/di/injection.dart';
import 'package:ulin/core/state/request_cubit.dart';
import 'package:ulin/features/auth/presentation/cubit/password_reset_cubit.dart';

class ResetPasswordPage extends StatefulWidget {
  final String email;

  const ResetPasswordPage({super.key, required this.email});

  @override
  State<ResetPasswordPage> createState() => _ResetPasswordPageState();
}

class _ResetPasswordPageState extends State<ResetPasswordPage> {
  final PasswordResetCubit _cubit = getIt<PasswordResetCubit>();
  final TextEditingController _pinController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscure = true;
  bool _submitted = false;
  bool _resending = false;

  @override
  void initState() {
    super.initState();
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _pinController.dispose();
    _passwordController.dispose();
    _cubit.close();
    super.dispose();
  }

  bool get _isPasswordValid {
    final value = _passwordController.text;
    return value.length >= 8 &&
        RegExp(r'[^A-Za-z0-9\s]').hasMatch(value) &&
        RegExp(r'[0-9]').hasMatch(value) &&
        RegExp(r'^[A-Z]').hasMatch(value);
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    setState(() => _submitted = true);

    if (_pinController.text.length != 6) {
      showAppSnackBar(context, 'Please enter the 6-digit code.');
      return;
    }

    if (!_isPasswordValid) return;

    _cubit.resetPassword(
      email: widget.email,
      code: _pinController.text,
      password: _passwordController.text,
    );
  }

  void _resend() {
    _resending = true;
    _cubit.forgotPassword(widget.email);
  }

  @override
  Widget build(BuildContext context) {
    final pinTheme = PinTheme(
      width: 44.w,
      height: 52.h,
      textStyle: TextStyle(
        fontSize: 20.sp,
        fontWeight: FontWeight.w500,
        color: WarnaApp.wrGreen,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: WarnaApp.wrGrey),
        color: WarnaApp.wrWhite,
      ),
    );

    return BlocListener<PasswordResetCubit, RequestState<Object>>(
      bloc: _cubit,
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == RequestStatus.success) {
          if (_resending) {
            _resending = false;
            showAppSnackBar(
              context,
              'A new code has been sent if the email is registered.',
            );
          } else {
            showAppSnackBar(context, 'Password updated. Please log in.');
            context.go('/login');
          }
        } else if (state.status == RequestStatus.failure) {
          _resending = false;
          showAppSnackBar(context, state.message ?? 'Something went wrong.');
        }
      },
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
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
                      padding: const EdgeInsets.symmetric(horizontal: 36),
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

                          SizedBox(height: 30),

                          TextCustom(
                            "Reset Password",
                            fontSize: 24,
                            fontWeight: FontWeight.w500,
                          ),

                          SizedBox(height: 8),

                          TextCustom(
                            "Enter the 6-digit code sent to ${widget.email} and choose a new password.",
                            fontSize: 13,
                            color: WarnaApp.wrBlack.withValues(alpha: 0.6),
                          ),

                          SizedBox(height: 28),

                          Center(
                            child: Material(
                              color: Colors.transparent,
                              child: Pinput(
                                length: 6,
                                controller: _pinController,
                                defaultPinTheme: pinTheme,
                                separatorBuilder: (index) =>
                                    SizedBox(width: 6.w),
                                focusedPinTheme: pinTheme.copyWith(
                                  decoration: pinTheme.decoration!.copyWith(
                                    border: Border.all(
                                      color: WarnaApp.wrGreen,
                                      width: 2,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),

                          SizedBox(height: 24),

                          TextCustom(
                            "New Password",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: WarnaApp.wrGreen,
                          ),
                          TextfieldCustom(
                            controller: _passwordController,
                            hintText: "New password",
                            fillColor: WarnaApp.wrWhite,
                            width: double.infinity,
                            height: 38,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            prefix: Icon(
                              Icons.lock_open_outlined,
                              color: WarnaApp.wrMain,
                            ),
                            isPassword: true,
                            isObscure: _isObscure,
                            onToggle: () {
                              setState(() => _isObscure = !_isObscure);
                            },
                          ),
                          SizedBox(height: 6),
                          if (_submitted && !_isPasswordValid)
                            ErrorText(
                              "At least 8 characters, with a symbol, a number, and starting with a capital letter.",
                            )
                          else
                            TextCustom(
                              "At least 8 characters, with a symbol, a number, and starting with a capital letter.",
                              fontSize: 11,
                              color: WarnaApp.wrBlack.withValues(alpha: 0.5),
                            ),

                          SizedBox(height: 32),

                          BlocBuilder<PasswordResetCubit, RequestState<Object>>(
                            bloc: _cubit,
                            builder: (context, state) {
                              return Center(
                                child: ButtonCustom(
                                  label: "Reset Password",
                                  width: 200,
                                  isLoading: state.isLoading && !_resending,
                                  onTap: _submit,
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 20),

                          Center(
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                TextCustom(
                                  "Didn't receive a code?",
                                  fontSize: 13,
                                ),
                                SizedBox(width: 6),
                                GestureDetector(
                                  onTap: _resend,
                                  child: TextCustom(
                                    "Re-send",
                                    fontSize: 13,
                                    color: WarnaApp.wrBlue,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              ],
                            ),
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
      ),
    );
  }
}
