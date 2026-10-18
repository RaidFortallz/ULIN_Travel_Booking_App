import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';
import 'package:ulin/core/constants/custom_widgets/textfield_custom.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool _isObscure = true;
  bool _isSelected = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    padding: const EdgeInsets.symmetric(horizontal: 45),
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
                          "Welcome Back!",
                          fontSize: 24,
                          fontWeight: FontWeight.w500,
                        ),
                        SizedBox(height: 4),
                        TextCustom(
                          "Sign in to your account",
                          fontSize: 13,
                          fontWeight: FontWeight.normal,
                        ),

                        SizedBox(height: 36),

                        TextCustom(
                          "Email",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          hintText: "Email",
                          width: double.infinity,
                          height: 38,
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.done,
                          prefix: Icon(
                            Icons.email_outlined,
                            color: WarnaApp.wrMain,
                          ),
                        ),

                        SizedBox(height: 26),

                        TextCustom(
                          "Password",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          hintText: "Password",
                          width: double.infinity,
                          isPassword: true,
                          height: 38,
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          prefix: Icon(
                            Icons.lock_open_outlined,
                            color: WarnaApp.wrMain,
                          ),
                          isObscure: _isObscure,
                          onToggle: () {
                            setState(() {
                              _isObscure = !_isObscure;
                            });
                          },
                        ),

                        SizedBox(height: 9),

                        Align(
                          alignment: Alignment.centerRight,
                          child: TextCustom(
                            "Forgot Password?",
                            fontSize: 12,
                            color: WarnaApp.wrBlue,
                          ),
                        ),

                        GestureDetector(
                          onTap: () {
                            setState(() {
                              _isSelected = !_isSelected;
                            });
                          },
                          child: Row(
                            children: [
                              Container(
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
                                            shape: BoxShape.circle,
                                            color: WarnaApp.wrGreen,
                                          ),
                                        ),
                                      )
                                    : null,
                              ),

                              SizedBox(width: 6),

                              TextCustom(
                                "Remember Me",
                                fontSize: 12,
                                color: WarnaApp.wrBlack.withValues(alpha: 0.7),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(height: 50),

                        GestureDetector(
                          onTap: () => context.push('/profile1'),
                          child: Center(
                            child: Container(
                              width: 156,
                              height: 48,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                color: WarnaApp.wrGreen,
                              ),
                              child: Center(
                                child: TextCustom(
                                  "Log in",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: WarnaApp.wrWhite,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 30),

                        Center(
                          child: Column(
                            children: [
                              TextCustom("or continue with", fontSize: 14),

                              SizedBox(height: 22),

                              GestureDetector(
                                child: Image.asset(
                                  'assets/images/Google.png',
                                  width: 25,
                                  height: 25,
                                ),
                              ),

                              SizedBox(height: 26),

                              Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  TextCustom(
                                    "Don't have an account?",
                                    fontSize: 13,
                                  ),

                                  SizedBox(width: 8),

                                  GestureDetector(
                                    onTap: () => context.push('/register'),
                                    child: TextCustom(
                                      "Sign Up",
                                      fontSize: 13,
                                      color: WarnaApp.wrBlue,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                ],
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
    );
  }
}
