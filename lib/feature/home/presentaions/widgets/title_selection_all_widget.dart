import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

/// [SelectionTitleAllWidget] hiển thị một hàng chứa tiêu đề của phần danh sách
/// và một nút "View all" để xem tất cả các mục trong phần đó.
class SelectionTitleAllWidget extends StatelessWidget {
  /// Tiêu đề của phần (ví dụ: "Near you", "Suggested")
  final String title;

  /// Sự kiện khi nhấn vào chữ "View all"
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
          // Tiêu đề phần với phong cách in đậm
          Text(
            title,
            style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Spacer(),
          // Nút "View all" có gạch chân
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
