import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillChipGrid extends StatefulWidget {
  final List<String> skills;

  const SkillChipGrid({Key? key, required this.skills}) : super(key: key);

  @override
  _SkillChipGridState createState() => _SkillChipGridState();
}

class _SkillChipGridState extends State<SkillChipGrid> {
  Set<String> selectedSkills = {};

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.skills.map((skill) {
        final isSelected = selectedSkills.contains(skill);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                selectedSkills.remove(skill);
              } else {
                selectedSkills.add(skill);
              }
            });
          },
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: isSelected ? AppColors.primary : AppColors.white,
              border: Border.all(
                color: isSelected ? AppColors.primary : AppColors.grey2,
              ),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (isSelected)
                  Icon(Icons.check, size: 16, color: Colors.white),
                if (isSelected) SizedBox(width: 4),
                Text(
                  skill,
                  style: GoogleFonts.almarai(
                    color: isSelected ? Colors.white : AppColors.primary,
                    fontSize: 14,
                    fontWeight: FontWeight.w400,
                  ),
                ),
              ],
            ),
          ),
        );
      }).toList(),
    );
  }
}
