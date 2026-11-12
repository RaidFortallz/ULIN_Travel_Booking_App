import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/app_snackbar.dart';
import 'package:ulin/core/constants/custom_widgets/button_custom.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';
import 'package:ulin/core/constants/custom_widgets/textfield_custom.dart';
import 'package:ulin/core/di/injection.dart';
import 'package:ulin/core/state/request_cubit.dart';
import 'package:ulin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulin/features/auth/presentation/cubit/register_cubit.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final RegisterCubit _cubit = getIt<RegisterCubit>();

  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  bool _isObscurePassword = true;
  bool _isSelected = false;
  bool _showPasswordRules = false;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _nameController.addListener(() => setState(() {}));
    _emailController.addListener(() => setState(() {}));
    _passwordController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _cubit.close();
    super.dispose();
  }

  // Validasi
  bool get _isNameValid => _nameController.text.trim().isNotEmpty;

  bool get _isEmailValid => RegExp(
    r'^[^@\s]+@[^@\s]+\.[^@\s]+$',
  ).hasMatch(_emailController.text.trim());

  bool get _hasMinLength => _passwordController.text.length >= 8;

  bool get _hasSymbol =>
      RegExp(r'[^A-Za-z0-9\s]').hasMatch(_passwordController.text);

  bool get _hasNumber => RegExp(r'[0-9]').hasMatch(_passwordController.text);

  bool get _startsWithCapital =>
      RegExp(r'^[A-Z]').hasMatch(_passwordController.text);

  bool get _isPasswordValid =>
      _hasMinLength && _hasSymbol && _hasNumber && _startsWithCapital;

  bool get _showNameError => _submitted && !_isNameValid;

  bool get _showEmailError =>
      (_submitted || _emailController.text.isNotEmpty) && !_isEmailValid;

  bool get _showTermsError => _submitted && !_isSelected;

  void _onSignUp() {
    FocusScope.of(context).unfocus();
    setState(() {
      _submitted = true;
      _showPasswordRules = true;
    });

    if (_isNameValid && _isEmailValid && _isPasswordValid && _isSelected) {
      _cubit.register(
        name: _nameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text,
        terms: _isSelected,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocListener(
      listeners: [
        BlocListener<RegisterCubit, RequestState<Object>>(
          bloc: _cubit,
          listenWhen: (p, c) => p.status != c.status,
          listener: (context, state) {
            if (state.status == RequestStatus.success) {
              showAppSnackBar(context, 'Account created. Please log in.');
              context.go('/login');
            } else if (state.status == RequestStatus.failure) {
              showAppSnackBar(
                context,
                state.message ?? 'Something went wrong.',
              );
            }
          },
        ),
        BlocListener<AuthBloc, AuthState>(
          listenWhen: (p, c) =>
              p.isSubmitting && !c.isSubmitting && c.errorMessage != null,
          listener: (context, state) =>
              showAppSnackBar(context, state.errorMessage!),
        ),
      ],
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
                      padding: EdgeInsets.symmetric(horizontal: 40),
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
                            "Create an account",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                          ),

                          SizedBox(height: 10),

                          TextCustom(
                            "Sign up for a great and amazing travel experience",
                            fontSize: 12,
                            color: WarnaApp.wrBlack.withValues(alpha: 0.5),
                          ),

                          SizedBox(height: 18),

                          TextCustom(
                            "Full Name",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: WarnaApp.wrGreen,
                          ),
                          TextfieldCustom(
                            controller: _nameController,
                            hintText: "John Doe",
                            fillColor: WarnaApp.wrWhite,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            width: double.infinity,
                            height: 38,
                          ),
                          if (_showNameError) ...[
                            SizedBox(height: 4),
                            _ErrorText("Please enter your full name"),
                          ],

                          SizedBox(height: 16),

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
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            width: double.infinity,
                            height: 38,
                          ),
                          if (_showEmailError) ...[
                            SizedBox(height: 4),
                            _ErrorText(
                              "Enter a valid email, e.g. johndoe@gmail.com",
                            ),
                          ],

                          SizedBox(height: 16),

                          TextCustom(
                            "Password",
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: WarnaApp.wrGreen,
                          ),
                          TextfieldCustom(
                            controller: _passwordController,
                            hintText: "Password",
                            fillColor: WarnaApp.wrWhite,
                            keyboardType: TextInputType.visiblePassword,
                            textInputAction: TextInputAction.done,
                            width: double.infinity,
                            height: 38,
                            isPassword: true,
                            isObscure: _isObscurePassword,
                            onTap: () {
                              if (!_showPasswordRules) {
                                setState(() {
                                  _showPasswordRules = true;
                                });
                              }
                            },
                            onToggle: () {
                              setState(() {
                                _isObscurePassword = !_isObscurePassword;
                              });
                            },
                          ),

                          if (_showPasswordRules) ...[
                            SizedBox(height: 10),
                            _PasswordRule(
                              text: "At least 8 characters",
                              isValid: _hasMinLength,
                              showError: _submitted,
                            ),
                            _PasswordRule(
                              text: "Contains a symbol (e.g. ! @ #)",
                              isValid: _hasSymbol,
                              showError: _submitted,
                            ),
                            _PasswordRule(
                              text: "Contains a number",
                              isValid: _hasNumber,
                              showError: _submitted,
                            ),
                            _PasswordRule(
                              text: "Starts with a capital letter",
                              isValid: _startsWithCapital,
                              showError: _submitted,
                            ),
                          ],

                          SizedBox(height: 16),

                          Row(
                            children: [
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    _isSelected = !_isSelected;
                                  });
                                },
                                child: Container(
                                  width: 20,
                                  height: 20,
                                  decoration: BoxDecoration(
                                    shape: BoxShape.circle,
                                    border: Border.all(color: WarnaApp.wrGreen),
                                  ),
                                  child: _isSelected
                                      ? Center(
                                          child: Container(
                                            width: 14,
                                            height: 14,
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                              color: WarnaApp.wrGreen,
                                            ),
                                          ),
                                        )
                                      : null,
                                ),
                              ),

                              SizedBox(width: 6),

                              Expanded(
                                child: TextCustom(
                                  "I confirm i am 18 or older and accept the Terms of Services and Privacy Policies.",
                                  fontSize: 11,
                                  color: _showTermsError
                                      ? Colors.red
                                      : WarnaApp.wrBlack.withValues(alpha: 0.7),
                                ),
                              ),
                            ],
                          ),

                          SizedBox(height: 40),

                          BlocBuilder<RegisterCubit, RequestState<Object>>(
                            bloc: _cubit,
                            builder: (context, state) {
                              return Center(
                                child: ButtonCustom(
                                  label: "Sign Up",
                                  isLoading: state.isLoading,
                                  onTap: _onSignUp,
                                ),
                              );
                            },
                          ),

                          SizedBox(height: 20),

                          Center(
                            child: Column(
                              children: [
                                TextCustom("or register with", fontSize: 14),

                                SizedBox(height: 20),

                                GestureDetector(
                                  onTap: () => context.read<AuthBloc>().add(
                                    const AuthGoogleSubmitted(),
                                  ),
                                  child: Image.asset(
                                    'assets/images/Google.png',
                                    width: 25,
                                    height: 25,
                                  ),
                                ),

                                SizedBox(height: 50),
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

// Teks peringatan merah dan ikon tanda seru di kiri
class _ErrorText extends StatelessWidget {
  final String text;

  const _ErrorText(this.text);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(Icons.error_outline_rounded, size: 14, color: Colors.red),
        SizedBox(width: 4),
        Expanded(child: TextCustom(text, fontSize: 11, color: Colors.red)),
      ],
    );
  }
}

// Aturan password:
class _PasswordRule extends StatelessWidget {
  final String text;
  final bool isValid;
  final bool showError;

  const _PasswordRule({
    required this.text,
    required this.isValid,
    required this.showError,
  });

  @override
  Widget build(BuildContext context) {
    final Color borderColor = isValid
        ? WarnaApp.wrGreen
        : (showError ? Colors.red : WarnaApp.wrBlack.withValues(alpha: 0.3));

    final Color textColor = isValid
        ? WarnaApp.wrGreen
        : (showError ? Colors.red : WarnaApp.wrBlack.withValues(alpha: 0.6));

    return Padding(
      padding: const EdgeInsets.only(bottom: 6),
      child: Row(
        children: [
          AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            width: 18,
            height: 18,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: isValid ? WarnaApp.wrGreen : Colors.transparent,
              border: Border.all(color: borderColor, width: 1.5),
            ),
            child: isValid
                ? Icon(Icons.check, size: 12, color: WarnaApp.wrWhite)
                : null,
          ),
          SizedBox(width: 8),
          TextCustom(text, fontSize: 11, color: textColor),
        ],
      ),
    );
  }
}
