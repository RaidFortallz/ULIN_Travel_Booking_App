import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:material_ui/material_ui.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:ulin/core/constants/colors_theme.dart';
import 'package:ulin/core/constants/custom_widgets/app_snackbar.dart';
import 'package:ulin/core/constants/custom_widgets/button_custom.dart';
import 'package:ulin/core/constants/custom_widgets/text_custom.dart';
import 'package:ulin/core/di/injection.dart';
import 'package:ulin/core/state/request_cubit.dart';
import 'package:ulin/features/auth/domain/entities/app_user.dart';
import 'package:ulin/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:ulin/features/profile/presentation/cubit/profile_cubit.dart';

class ProfileSetupStep2Page extends StatefulWidget {
  const ProfileSetupStep2Page({super.key});

  @override
  State<ProfileSetupStep2Page> createState() => _ProfileSetupStep2PageState();
}

class _ProfileSetupStep2PageState extends State<ProfileSetupStep2Page> {
  final ProfileCubit _cubit = getIt<ProfileCubit>();
  final ImagePicker _picker = ImagePicker();
  XFile? _image;

  @override
  void dispose() {
    _cubit.close();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final picked = await _picker.pickImage(
      source: ImageSource.gallery,
      maxWidth: 1024,
      maxHeight: 1024,
      imageQuality: 85,
    );

    if (picked != null) {
      setState(() => _image = picked);
    }
  }

  void _save() {
    if (_image == null) {
      context.go('/emailverification');
      return;
    }
    _cubit.uploadAvatar(_image!.path);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<ProfileCubit, RequestState<AppUser>>(
      bloc: _cubit,
      listenWhen: (p, c) => p.status != c.status,
      listener: (context, state) {
        if (state.status == RequestStatus.success) {
          context.read<AuthBloc>().add(AuthUserUpdated(state.data!));
          context.go('/emailverification');
        } else if (state.status == RequestStatus.failure) {
          showAppSnackBar(context, state.message ?? 'Something went wrong.');
        }
      },
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: TextCustom(
            "Add Profile Picture",
            fontSize: 18.sp,
            fontWeight: FontWeight.w500,
          ),
          actions: [
            Padding(
              padding: const EdgeInsets.only(right: 18),
              child: GestureDetector(
                onTap: () => context.go('/emailverification'),
                child: TextCustom(
                  "Skip",
                  fontSize: 18.sp,
                  fontWeight: FontWeight.bold,
                  color: WarnaApp.wrBlue,
                ),
              ),
            ),
          ],
          leading: IconButton(
            onPressed: () => context.pop(),
            icon: Icon(Icons.arrow_back_ios_new_rounded),
          ),
        ),
        body: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 175.w,
                    height: 175.h,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: WarnaApp.wrGrey,
                    ),
                    child: _image == null
                        ? Center(child: Icon(Icons.person, size: 110))
                        : ClipOval(
                            child: Image.file(
                              File(_image!.path),
                              fit: BoxFit.cover,
                            ),
                          ),
                  ),
                ),

                SizedBox(height: 50),

                GestureDetector(
                  onTap: _pickImage,
                  child: Container(
                    width: double.infinity,
                    height: 51.h,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(30),
                      border: Border.all(color: WarnaApp.wrGreen),
                      color: WarnaApp.wrWhite,
                    ),
                    child: Center(
                      child: TextCustom(
                        "Select Profile Picture",
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w500,
                        color: WarnaApp.wrBlue,
                      ),
                    ),
                  ),
                ),

                SizedBox(height: 50),

                TextCustom(
                  "Your Photo Should :",
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w500,
                ),

                SizedBox(height: 20),

                Row(
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: WarnaApp.wrBlack,
                      ),
                    ),
                    SizedBox(width: 10),

                    TextCustom(
                      "Show your face clearly",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: WarnaApp.wrBlack,
                      ),
                    ),
                    SizedBox(width: 10),

                    TextCustom(
                      "Be a close-up face",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),

                Row(
                  children: [
                    Container(
                      width: 6.w,
                      height: 6.h,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: WarnaApp.wrBlack,
                      ),
                    ),
                    SizedBox(width: 10),

                    TextCustom(
                      "Be clear and sharp",
                      fontSize: 17.sp,
                      fontWeight: FontWeight.w500,
                    ),
                  ],
                ),

                SizedBox(height: 60),

                Center(
                  child: BlocBuilder<ProfileCubit, RequestState<AppUser>>(
                    bloc: _cubit,
                    builder: (context, state) {
                      return Center(
                        child: ButtonCustom(
                          label: "Save",
                          width: 156.w,
                          height: 48.h,
                          fontSize: 18.sp,
                          isLoading: state.isLoading,
                          onTap: _save,
                        ),
                      );
                    },
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
