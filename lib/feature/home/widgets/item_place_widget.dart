// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:navigation_2/core/constants/icon_asset_url.dart';
import 'package:navigation_2/core/theme/app_button.dart';
import 'package:navigation_2/core/theme/app_colors.dart';

class PlaceDogWalk {
  final String imageUrl;
  final String address;
  final double distance;
  final double pricePerHour;
  PlaceDogWalk({
    required this.imageUrl,
    required this.address,
    required this.distance,
    required this.pricePerHour,
  });
}

class PlaceItemWidget extends StatelessWidget {
  final PlaceDogWalk placeDogWalk;
  final VoidCallback onTap;
  const PlaceItemWidget({
    super.key,
    required this.placeDogWalk,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 230,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
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
                    Text(
                      placeDogWalk.address,
                      overflow: TextOverflow.ellipsis,
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Row(
                      children: [
                        SvgPicture.asset(AppIconUrl.iconPlace, height: 16),
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
    );
  }
}
