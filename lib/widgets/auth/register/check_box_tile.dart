import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CheckboxTile extends StatefulWidget {
  final String text;

  const CheckboxTile({Key? key, required this.text}) : super(key: key);

  @override
  _CheckboxTileState createState() => _CheckboxTileState();
}

class _CheckboxTileState extends State<CheckboxTile> {
  bool isChecked = false;

  @override
  Widget build(BuildContext context) {
    final screenHeight = MediaQuery.of(context).size.height;
    final screenWidth = MediaQuery.of(context).size.width;
    final isPortrait =
        MediaQuery.of(context).orientation == Orientation.portrait;

    return Row(
      children: [
        Expanded(
          child: Text(
            widget.text,
            textAlign: TextAlign.right,
            style: GoogleFonts.almarai(
              fontSize: isPortrait ? screenHeight * 0.018 : screenWidth * 0.018,
              fontWeight: FontWeight.w600,
              color: AppColors.secondary,
            ),
          ),
        ),
        SizedBox(width: screenWidth * 0.03),
        Checkbox(
          value: isChecked,
          side: BorderSide(
            color: AppColors.greyText,
            width: isPortrait ? screenHeight * 0.002 : screenWidth * 0.002,
          ),
          onChanged: (value) {
            setState(() {
              isChecked = value ?? false;
            });
          },
          activeColor: AppColors.primary,
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
        ),
      ],
    );
  }
}
