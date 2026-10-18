import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/dropdown_custom.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';
import 'package:ulin/core/constants/custom_widgets/textfield_custom.dart';

class ProfileSetupStep1Page extends StatefulWidget {
  const ProfileSetupStep1Page({super.key});

  @override
  State<ProfileSetupStep1Page> createState() => _ProfileSetupStep1PageState();
}

class _ProfileSetupStep1PageState extends State<ProfileSetupStep1Page> {
  final TextEditingController _birthdayController = TextEditingController();
  String? _gender;

  @override
  void dispose() {
    _birthdayController.dispose();
    super.dispose();
  }

  Future<void> _pickBirthday() async {
    FocusScope.of(context).unfocus();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1945),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _birthdayController.text = DateFormat('MM/dd/yyyy').format(picked);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: FocusScope.of(context).unfocus,
        child: SafeArea(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Align(
                alignment: Alignment.center,
                child: TextCustom(
                  "Profile",
                  fontSize: 22,
                  fontWeight: FontWeight.w500,
                ),
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: EdgeInsets.symmetric(horizontal: 50),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 26),

                        TextCustom(
                          "Setup your profile in the best way you\nwould like to be addressed",
                          fontSize: 12,
                          fontWeight: FontWeight.normal,
                          color: WarnaApp.wrBlack.withValues(alpha: 0.6),
                        ),

                        SizedBox(height: 22),

                        TextCustom(
                          "Username",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          hintText: "Jhon Doe",
                          width: double.infinity,
                          height: 36,
                          textInputAction: TextInputAction.next,
                        ),

                        SizedBox(height: 18),

                        TextCustom(
                          "Bio",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          hintText: "I love traveling and exploring new places",
                          width: double.infinity,
                          maxLines: 3,
                          keyboardType: TextInputType.multiline,
                          textInputAction: TextInputAction.next,
                        ),

                        SizedBox(height: 18),

                        TextCustom(
                          "Location",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          hintText: "Indonesia",
                          width: double.infinity,
                          height: 36,
                          textInputAction: TextInputAction.next,
                        ),

                        SizedBox(height: 18),

                        TextCustom(
                          "Birthday",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          hintText: "mm/dd/yyyy",
                          width: double.infinity,
                          height: 36,
                          controller: _birthdayController,
                          readOnly: true,
                          onTap: _pickBirthday,
                        ),

                        SizedBox(height: 18),

                        TextCustom(
                          "Gender",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        DropdownCustom(
                          hintText: "Male",
                          width: double.infinity,
                          height: 36,
                          items: const ["Male", "Female"],
                          onChanged: (value) {
                            setState(() {
                              _gender = value;
                            });
                          },
                        ),

                        SizedBox(height: 18),

                        TextCustom(
                          "Job Title",
                          fontSize: 18,
                          fontWeight: FontWeight.w500,
                          color: WarnaApp.wrGreen,
                        ),
                        TextfieldCustom(
                          hintText: "Business Travel",
                          width: double.infinity,
                          height: 36,
                        ),

                        SizedBox(height: 32),

                        GestureDetector(
                          onTap: () {
                            context.push('/profile2');
                          },
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
                                  "Continue",
                                  fontSize: 18,
                                  fontWeight: FontWeight.w500,
                                  color: WarnaApp.wrWhite,
                                ),
                              ),
                            ),
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
