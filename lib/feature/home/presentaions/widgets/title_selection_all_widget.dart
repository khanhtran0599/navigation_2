import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectionTitleAllWidget extends StatelessWidget {
  final String title;
  final VoidCallback onTap;
  const SelectionTitleAllWidget({
    super.key,
    required this.title,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Spacer(),
          InkWell(
            onTap: onTap,
            child: Text(
              "View all",
              style: GoogleFonts.poppins(decoration: TextDecoration.underline),
            ),
          ),
        ],
      ),
    );
  }
}
