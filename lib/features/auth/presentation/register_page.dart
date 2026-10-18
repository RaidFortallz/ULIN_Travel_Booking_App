import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';
import 'package:ulin/core/constants/custom_widgets/textfield_custom.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  bool _isObscurePassword = true;
  bool _isObscureConfirm = true;
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
                          hintText: "Full Name",
                          keyboardType: TextInputType.name,
                          textInputAction: TextInputAction.next,
                          width: double.infinity,
                          height: 38,
                        ),

                        SizedBox(height: 16),

                        TextCustom(
                          "Email",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          hintText: "Email",
                          keyboardType: TextInputType.emailAddress,
                          textInputAction: TextInputAction.next,
                          width: double.infinity,
                          height: 38,
                        ),

                        SizedBox(height: 16),

                        TextCustom(
                          "Password",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          hintText: "Password",
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.next,
                          width: double.infinity,
                          height: 38,
                          isPassword: true,
                          isObscure: _isObscurePassword,
                          onToggle: () {
                            setState(() {
                              _isObscurePassword = !_isObscurePassword;
                            });
                          },
                        ),

                        SizedBox(height: 16),

                        TextCustom(
                          "Confirm Password",
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          hintText: "Confirm Password",
                          keyboardType: TextInputType.visiblePassword,
                          textInputAction: TextInputAction.done,
                          width: double.infinity,
                          height: 38,
                          isPassword: true,
                          isObscure: _isObscureConfirm,
                          onToggle: () {
                            setState(() {
                              _isObscureConfirm = !_isObscureConfirm;
                            });
                          },
                        ),

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
                                            borderRadius: BorderRadius.circular(
                                              30,
                                            ),
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
                                color: WarnaApp.wrBlack.withValues(alpha: 0.7),
                              ),
                            ),
                          ],
                        ),

                        SizedBox(height: 40),

                        GestureDetector(
                          onTap: () => context.go('/login'),
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
                                  "Sign Up",
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: WarnaApp.wrWhite,
                                ),
                              ),
                            ),
                          ),
                        ),

                        SizedBox(height: 20),

                        Center(
                          child: Column(
                            children: [
                              TextCustom("or register with", fontSize: 14),

                              SizedBox(height: 20),

                              GestureDetector(
                                child: Image.asset(
                                  'assets/images/Google.png',
                                  width: 25,
                                  height: 25,
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
    );
  }
}
