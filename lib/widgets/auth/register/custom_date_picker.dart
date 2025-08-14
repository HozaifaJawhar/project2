import 'package:ammerha_volunteer/config/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CustomDatePicker extends StatefulWidget {
  final String label;
  final String placeholder;
  final String? Function(String?)? validator;

  const CustomDatePicker({
    Key? key,
    required this.label,
    required this.placeholder,
    this.validator,
  }) : super(key: key);

  @override
  _CustomDatePickerState createState() => _CustomDatePickerState();
}

class _CustomDatePickerState extends State<CustomDatePicker> {
  DateTime? _selectedDate;
  final TextEditingController _dateController = TextEditingController();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate ?? DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = _formatDate(picked);
      });
    }
  }

  String _formatDate(DateTime date) {
    return '${date.year}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.label,
          style: GoogleFonts.almarai(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: AppColors.primary,
          ),
        ),
        const SizedBox(height: 6),
        SizedBox(
          height: 68, // Fixed height to accommodate error message
          child: TextFormField(
            controller: _dateController,
            readOnly: true,
            textAlign: TextAlign.right,
            validator: widget.validator,
            decoration: InputDecoration(
              hintText: widget.placeholder,
              hintStyle: GoogleFonts.almarai(
                fontSize: 12,
                fontWeight: FontWeight.w500,
                color: AppColors.greyText,
              ),
              filled: true,
              fillColor: AppColors.white,
              suffixIcon: Icon(Icons.calendar_today, color: AppColors.greyText),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.grey2),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: AppColors.grey2),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: BorderSide(color: AppColors.primary, width: 1.5),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(8),
                borderSide: const BorderSide(color: Colors.red, width: 1.5),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 12,
              ),
              errorStyle: GoogleFonts.almarai(color: Colors.red, fontSize: 12),
              isDense: true,
            ),
            onTap: () => _selectDate(context),
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _dateController.dispose();
    super.dispose();
  }
}
