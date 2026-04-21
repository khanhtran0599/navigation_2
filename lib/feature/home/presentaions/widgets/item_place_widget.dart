// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_2/core/constants/icon_asset_url.dart';
import 'package:navigation_2/core/theme/app_button.dart';
import 'package:navigation_2/core/theme/app_colors.dart';
import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart';



/// [PlaceItemWidget] hiển thị thông tin tóm tắt của một địa điểm dắt chó đi dạo.
/// Bao gồm hình ảnh, địa chỉ, khoảng cách và giá cả.
class PlaceItemWidget extends StatelessWidget {
  /// Thực thể chứa dữ liệu của địa điểm
  final PlaceDogWalkEntity placeDogWalk;

  /// Sự kiện xảy ra khi người dùng nhấn vào widget này
  final VoidCallback onTap;

  const PlaceItemWidget({
    super.key,
    required this.placeDogWalk,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 230,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Hiển thị hình ảnh địa điểm với bo góc
            ClipRRect(
              borderRadius: BorderRadiusGeometry.circular(14),
              child: Image.network(
                placeDogWalk.imageUrl,
                width: 230,
                height: 175,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hiển thị địa chỉ (rút gọn nếu quá dài)
                      Text(
                        placeDogWalk.address,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.poppins(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      // Hiển thị khoảng cách kèm icon
                      Row(
                        children: [
                          SvgPicture.asset(AppIconUrl.iconLocation, height: 16),
                          Text(
                            "${placeDogWalk.distance} km from you",
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: AppColors.lightGreyA1,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 12),
                // Nút hiển thị giá thuê theo giờ
                SizedBox(
                  height: 24,
                  width: 40,
                  child: MyButtonBase(
                    title:
                        "${placeDogWalk.pricePerHour.toStringAsFixed(1)}"
                        r"$/h",
                    paddingHorizontal: 0,
                    fontSize: 10,
                    onPress: onTap,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
