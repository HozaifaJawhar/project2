import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:ammerha_volunteer/core/models/register_helper.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SkillChipGrid extends StatefulWidget {
  final List<Skill> skills;
  final Set<int> selectedIds;
  final Function(Set<int>) onSelectionChanged;

  const SkillChipGrid({
    Key? key,
    required this.skills,
    required this.selectedIds,
    required this.onSelectionChanged,
  }) : super(key: key);

  @override
  _SkillChipGridState createState() => _SkillChipGridState();
}

class _SkillChipGridState extends State<SkillChipGrid> {
  late Set<int> _selectedIds;

  @override
  void initState() {
    super.initState();
    _selectedIds = widget.selectedIds;
  }

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: widget.skills.map((skill) {
        final isSelected = _selectedIds.contains(skill.id);
        return GestureDetector(
          onTap: () {
            setState(() {
              if (isSelected) {
                _selectedIds.remove(skill.id);
              } else {
                _selectedIds.add(skill.id);
              }
            });
            // إعلام الويدجت الأب بالتغيير
            widget.onSelectionChanged(_selectedIds);
          },
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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
                  const Icon(Icons.check, size: 16, color: Colors.white),
                if (isSelected) const SizedBox(width: 4),
                Text(
                  skill.name, // عرض اسم المهارة
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
