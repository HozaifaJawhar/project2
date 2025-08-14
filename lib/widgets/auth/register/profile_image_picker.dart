import 'dart:io';
import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';

class ProfileImagePicker extends StatefulWidget {
  @override
  _ProfileImagePickerState createState() => _ProfileImagePickerState();
}

class _ProfileImagePickerState extends State<ProfileImagePicker> {
  File? _selectedImage;

  Future<void> _pickImage() async {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SafeArea(
          child: Wrap(
            children: [
              ListTile(
                leading: Icon(Icons.photo_library),
                title: Text('اختيار من المعرض', style: GoogleFonts.almarai()),
                onTap: () => _getImage(ImageSource.gallery),
              ),
              ListTile(
                leading: Icon(Icons.photo_camera),
                title: Text('التقاط صورة', style: GoogleFonts.almarai()),
                onTap: () => _getImage(ImageSource.camera),
              ),
            ],
          ),
        );
      },
    );
  }

  Future<void> _getImage(ImageSource source) async {
    Navigator.pop(context);
    // In a real app, you would use image_picker package here
    // For demo purposes, we'll just simulate selection
    setState(() {
      // _selectedImage = picked image file
    });
  }

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Column(
      children: [
        GestureDetector(
          onTap: _pickImage,
          child: Container(
            width: isPortrait ? screenHeight * 0.12 : screenWidth * 0.12,
            height: isPortrait ? screenHeight * 0.12 : screenWidth * 0.12,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.grey2,
              image: _selectedImage != null
                  ? DecorationImage(
                      image: FileImage(_selectedImage!),
                      fit: BoxFit.cover,
                    )
                  : null,
            ),
            child: Stack(
              children: [
                if (_selectedImage == null)
                  Center(
                    child: Icon(
                      Icons.person,
                      size: isPortrait
                          ? screenHeight * 0.08
                          : screenWidth * 0.08,
                      color: Colors.white,
                    ),
                  ),
                Positioned(
                  bottom: 0,
                  right: isPortrait
                      ? screenHeight * 0.015
                      : screenWidth * 0.015,
                  child: Container(
                    width: isPortrait
                        ? screenHeight * 0.04
                        : screenWidth * 0.04,
                    height: isPortrait
                        ? screenHeight * 0.04
                        : screenWidth * 0.04,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: AppColors.greyText,
                      border: Border.all(
                        color: Colors.white,
                        width: isPortrait
                            ? screenHeight * 0.0025
                            : screenWidth * 0.0025,
                      ),
                    ),
                    child: Icon(
                      Icons.camera_alt,
                      size: isPortrait
                          ? screenHeight * 0.02
                          : screenWidth * 0.02,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        SizedBox(height: screenHeight * 0.01),
        Text(
          'اختر صورة شخصية (اختياري)',
          style: GoogleFonts.almarai(
            color: AppColors.greyText,
            fontSize: isPortrait ? screenHeight * 0.018 : screenWidth * 0.018,
            fontWeight: FontWeight.w400,
          ),
        ),
      ],
    );
  }
}
