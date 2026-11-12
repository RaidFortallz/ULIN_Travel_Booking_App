import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:material_ui/material_ui.dart';
import 'package:pinput/pinput.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/app_snackbar.dart';
import 'package:ulin/core/constants/custom_widgets/button_custom.dart';
import 'package:ulin/core/constants/custom_widgets/error_text.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';
import 'package:ulin/core/di/injection.dart';
import 'package:ulin/core/state/request_cubit.dart';
import 'package:ulin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulin/features/auth/presentation/cubit/email_verification_cubit.dart';

class EmailVerificationPage extends StatefulWidget {
  const EmailVerificationPage({super.key});

  @override
  State<EmailVerificationPage> createState() => _EmailVerificationPageState();
}

class _EmailVerificationPageState extends State<EmailVerificationPage> {
  final EmailVerificationCubit _cubit = getIt<EmailVerificationCubit>();
  final TextEditingController _pinController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _cubit.sendCode();
  }

  @override
  void dispose() {
    _pinController.dispose();
    _cubit.close();
    super.dispose();
  }

  void _verify() {
    if (_pinController.text.length != 6) {
      showAppSnackBar(context, 'Please enter the 6-digit code.');
      return;
    }

    FocusScope.of(context).unfocus();
    _cubit.verify(_pinController.text);
  }

  @override
  Widget build(BuildContext context) {
    final email = context.select((AuthBloc bloc) => bloc.state.user?.email);

    final defaultPinTheme = PinTheme(
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

    return BlocListener<EmailVerificationCubit, EmailVerificationState>(
      bloc: _cubit,
      listenWhen: (p, c) =>
          p.verifyStatus != c.verifyStatus || p.sendStatus != c.sendStatus,
      listener: (context, state) {
        if (state.verifiedUser != null) {
          context.read<AuthBloc>().add(AuthUserUpdated(state.verifiedUser!));
          return;
        }

        if (state.verifyStatus == RequestStatus.failure) {
          _pinController.clear();
        }

        if (state.sendStatus == RequestStatus.failure &&
            state.message != null) {
          showAppSnackBar(context, state.message!);
        }
      },
      child: Scaffold(
        body: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () => FocusScope.of(context).unfocus(),
          child: SafeArea(
            child: Center(
              child: SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 36,
                    vertical: 26,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/ulin1.png',
                        width: 130.w,
                        height: 130.h,
                      ),

                      SizedBox(height: 60.h),

                      TextCustom(
                        "Verify your Email Address",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                      ),

                      SizedBox(height: 20.h),

                      TextCustom(
                        "We sent a 6-digit code to\n${email ?? 'your email'}",
                        fontSize: 14.sp,
                        fontWeight: FontWeight.w500,
                        textAlign: TextAlign.center,
                        color: WarnaApp.wrBlack.withValues(alpha: 0.4),
                      ),

                      SizedBox(height: 30.h),

                      Material(
                        color: Colors.transparent,
                        child: Pinput(
                          length: 6,
                          controller: _pinController,
                          animationCurve: Curves.ease,
                          defaultPinTheme: defaultPinTheme,
                          separatorBuilder: (index) => SizedBox(width: 6.w),
                          focusedPinTheme: defaultPinTheme.copyWith(
                            decoration: defaultPinTheme.decoration!.copyWith(
                              border: Border.all(
                                color: WarnaApp.wrGreen,
                                width: 2,
                              ),
                            ),
                          ),
                          onCompleted: (code) => _verify(),
                        ),
                      ),

                      BlocBuilder<
                        EmailVerificationCubit,
                        EmailVerificationState
                      >(
                        bloc: _cubit,
                        buildWhen: (p, c) =>
                            p.verifyStatus != c.verifyStatus ||
                            p.message != c.message,
                        builder: (context, state) {
                          if (state.verifyStatus == RequestStatus.failure &&
                              state.message != null) {
                            return Padding(
                              padding: const EdgeInsets.only(top: 12),
                              child: ErrorText(state.message!),
                            );
                          }
                          return const SizedBox.shrink();
                        },
                      ),

                      SizedBox(height: 26),

                      BlocBuilder<
                        EmailVerificationCubit,
                        EmailVerificationState
                      >(
                        bloc: _cubit,
                        buildWhen: (p, c) =>
                            p.resendIn != c.resendIn ||
                            p.sendStatus != c.sendStatus,
                        builder: (context, state) {
                          final waiting = state.resendIn > 0;

                          return Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              TextCustom(
                                "Didn't receive a code?",
                                fontSize: 15.sp,
                              ),

                              SizedBox(width: 7),

                              GestureDetector(
                                onTap: waiting ? null : _cubit.sendCode,
                                child: TextCustom(
                                  waiting
                                      ? "Re-send in ${state.resendIn}s"
                                      : "Re-send",
                                  fontSize: 15.sp,
                                  color: waiting
                                      ? WarnaApp.wrBlack.withValues(alpha: 0.4)
                                      : WarnaApp.wrBlue,
                                ),
                              ),
                            ],
                          );
                        },
                      ),

                      SizedBox(height: 50),

                      BlocBuilder<
                        EmailVerificationCubit,
                        EmailVerificationState
                      >(
                        bloc: _cubit,
                        buildWhen: (p, c) => p.verifyStatus != c.verifyStatus,
                        builder: (context, state) {
                          return ButtonCustom(
                            label: "Continue",
                            width: 156.w,
                            height: 48.h,
                            fontSize: 18.sp,
                            isLoading:
                                state.verifyStatus == RequestStatus.loading,
                            onTap: _verify,
                          );
                        },
                      ),

                      SizedBox(height: 24),

                      GestureDetector(
                        onTap: () => context.read<AuthBloc>().add(
                          const AuthLogoutRequested(),
                        ),
                        child: TextCustom(
                          "Use a different account",
                          fontSize: 13.sp,
                          color: WarnaApp.wrBlue,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
