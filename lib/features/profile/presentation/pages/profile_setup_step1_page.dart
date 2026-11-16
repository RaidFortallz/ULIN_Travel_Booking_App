import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:material_ui/material_ui.dart';
import 'package:go_router/go_router.dart';
import 'package:intl/intl.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/app_snackbar.dart';
import 'package:ulin/core/constants/custom_widgets/button_custom.dart';
import 'package:ulin/core/constants/custom_widgets/dropdown_custom.dart';
import 'package:ulin/core/constants/custom_widgets/error_text.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';
import 'package:ulin/core/constants/custom_widgets/textfield_custom.dart';
import 'package:ulin/core/di/injection.dart';
import 'package:ulin/core/state/request_cubit.dart';
import 'package:ulin/features/auth/domain/entities/app_user.dart';
import 'package:ulin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulin/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileSetupStep1Page extends StatefulWidget {
  const ProfileSetupStep1Page({super.key});

  @override
  State<ProfileSetupStep1Page> createState() => _ProfileSetupStep1PageState();
}

class _ProfileSetupStep1PageState extends State<ProfileSetupStep1Page> {
  final ProfileCubit _cubit = getIt<ProfileCubit>();
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _bioController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _birthdayController = TextEditingController();
  final TextEditingController _locationController = TextEditingController();
  DateTime? _birthday;
  String? _gender;
  bool _submitted = false;

  @override
  void initState() {
    super.initState();
    _usernameController.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _bioController.dispose();
    _phoneController.dispose();
    _birthdayController.dispose();
    _locationController.dispose();
    _cubit.close();
    super.dispose();
  }

  String? _nullIfEmpty(String value) {
    final trimmed = value.trim();
    return trimmed.isEmpty ? null : trimmed;
  }

  Future<void> _pickBirthday() async {
    FocusScope.of(context).unfocus();

    final DateTime? picked = await showDatePicker(
      context: context,
      firstDate: DateTime(1945),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      _birthday = picked;
      _birthdayController.text = DateFormat('MM/dd/yyyy').format(picked);
    }
  }

  void _submit() {
    FocusScope.of(context).unfocus();
    setState(() => _submitted = true);

    if (_usernameController.text.trim().isEmpty) return;

    _cubit.saveProfile(
      username: _usernameController.text.trim(),
      bio: _nullIfEmpty(_bioController.text),
      phone: _nullIfEmpty(_phoneController.text),
      birthday: _birthday == null
          ? null
          : DateFormat('yyyy-MM-dd').format(_birthday!),
      gender: _gender?.toLowerCase(),
      location: _nullIfEmpty(_locationController.text),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, RequestState<AppUser>>(
      bloc: _cubit,
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == RequestStatus.success) {
          context.read<AuthBloc>().add(AuthUserUpdated(state.data!));
          context.push('/profile2');
        } else if (state.status == RequestStatus.failure) {
          showAppSnackBar(context, state.message ?? 'Something went wrong.');
        }
      },
      child: Scaffold(
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
                            controller: _usernameController,
                            hintText: "Jhon Doe",
                            fillColor: WarnaApp.wrWhite,
                            width: double.infinity,
                            height: 36,
                            textInputAction: TextInputAction.next,
                          ),

                          if (_submitted &&
                              _usernameController.text.trim().isEmpty) ...[
                            SizedBox(height: 4),
                            ErrorText("Please enter your username"),
                          ],

                          SizedBox(height: 18),

                          TextCustom(
                            "Bio",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: WarnaApp.wrGreen,
                          ),
                          TextfieldCustom(
                            controller: _bioController,
                            hintText:
                                "I love traveling and exploring new places",
                            fillColor: WarnaApp.wrWhite,
                            width: double.infinity,
                            maxLines: 3,
                            keyboardType: TextInputType.multiline,
                            textInputAction: TextInputAction.next,
                          ),

                          SizedBox(height: 18),

                          TextCustom(
                            "Phone Number",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: WarnaApp.wrGreen,
                          ),
                          TextfieldCustom(
                            controller: _phoneController,
                            hintText: "6200000",
                            fillColor: WarnaApp.wrWhite,
                            width: double.infinity,
                            height: 36,
                            keyboardType: TextInputType.number,
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
                            fillColor: WarnaApp.wrWhite,
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
                            "Location",
                            fontSize: 18,
                            fontWeight: FontWeight.w500,
                            color: WarnaApp.wrGreen,
                          ),
                          TextfieldCustom(
                            controller: _locationController,
                            hintText: "Indonesia",
                            fillColor: WarnaApp.wrWhite,
                            width: double.infinity,
                            height: 36,
                          ),

                          SizedBox(height: 32),

                          BlocBuilder<ProfileCubit, RequestState<AppUser>>(
                            bloc: _cubit,
                            builder: (context, state) {
                              return Center(
                                child: ButtonCustom(
                                  label: "Continue",
                                  fontSize: 18,
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
      ),
    );
  }
}
