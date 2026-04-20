import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_2/core/constants/icon_asset_url.dart';
import 'package:navigation_2/core/theme/app_button.dart';
import 'package:navigation_2/core/theme/app_colors.dart';
import 'package:navigation_2/core/theme/app_text_field.dart';
import 'package:navigation_2/feature/home/widgets/item_place_widget.dart';
import 'package:navigation_2/feature/home/widgets/title_selection_all_widget.dart';

/// [MyHomePage] là trang chủ chính của ứng dụng.
/// Hiển thị nội dung tổng quan và các phím tắt điều hướng.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var listNearYou = [
    PlaceDogWalk(
      imageUrl:
          "https://d3544la1u8djza.cloudfront.net/APHI/Blog/2024/October/Walking-Dog-Hero.jpg",
      address: "123 Đường ABC, Quận 1",
      distance: 1.2,
      pricePerHour: 5,
      id: '1',
    ),
    PlaceDogWalk(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcR1TeCOD1seLGHrgHPfbnhUINNWw6EG_uSyvQ&s",
      address: "45 Đường Lê Lợi, Quận 3",
      distance: 2.5,
      pricePerHour: 4,
      id: '2',
    ),
    PlaceDogWalk(
      imageUrl:
          "https://simplyhelping.com.au/wp-content/uploads/2023/12/SH-Summer-Dog-Walking-Tips-Every-Pet-Owner-Should-Know-Blog-Image.png",
      address: "89 Công viên Gia Định, Gò Vấp",
      distance: 3.8,
      pricePerHour: 3,
      id: '3',
    ),
  ];

  var listSuggested = [
    PlaceDogWalk(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcToUPuqZ48k_xIR6uelL5uYOMB1h9ynG2zWHQ&s",
      address: "Khu đô thị Sala, Quận 2",
      distance: 5.0,
      pricePerHour: 8,
      id: '4',
    ),
    PlaceDogWalk(
      imageUrl:
          "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcQBDn5Mv4gyOxQKpW9UvJ6WLBFTFPsTLG6mRg&s",
      address: "Công viên Vinhomes Central Park",
      distance: 6.2,
      pricePerHour: 7,
      id: '5',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        centerTitle: false,
        backgroundColor: AppColors.white,
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "HOME",
              style: GoogleFonts.poppins(fontWeight: FontWeight.bold),
            ),
            Text(
              'Explore dog walkers',
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                color: AppColors.greyB0,
                fontSize: 16,
              ),
            ),
          ],
        ),
        actions: [
          MyButtonPrimary(
            title: 'Book a walk',
            icon: Icon(Icons.add),
            onPress: () {},
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: MyTextFieldPrimary(
                hinText: 'Kiyv, Ukraine',
                prefixIcon: SvgPicture.asset(
                  AppIconUrl.iconLocation,
                  width: 20,
                  height: 20,
                ),
                suffixIcon: SvgPicture.asset(
                  AppIconUrl.iconFilter,
                  width: 20,
                  height: 20,
                ),
              ),
            ),
            SelectionTitleAllWidget(
              title: "Near you",
              onTap: () {
                context.go(
                  "/home/myListPlace/?title=Near you",
                  extra: listNearYou,
                );
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 270,
              child: ListView.builder(
                itemCount: listNearYou.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var placeDogWalk = listNearYou[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 16 : 0,
                      right: 16.0,
                    ),
                    child: PlaceItemWidget(
                      placeDogWalk: placeDogWalk,
                      onTap: () {
                        context.go(
                          "/home/myDetail/${placeDogWalk.id}",
                          extra: listNearYou,
                        );
                      },
                    ),
                  );
                },
              ),
            ),
            SelectionTitleAllWidget(
              title: "Suggested",
              onTap: () {
                context.go(
                  "/home/myListPlace/?title=Suggested",
                  extra: listSuggested,
                );
              },
            ),
            const SizedBox(height: 16),
            SizedBox(
              height: 270,
              child: ListView.builder(
                itemCount: listSuggested.length,
                scrollDirection: Axis.horizontal,
                itemBuilder: (context, index) {
                  var placeDogWalk = listSuggested[index];
                  return Padding(
                    padding: EdgeInsets.only(
                      left: index == 0 ? 16 : 0,
                      right: 16.0,
                    ),
                    child: PlaceItemWidget(
                      placeDogWalk: placeDogWalk,
                      onTap: () {
                        context.go("/home/myDetail/${placeDogWalk.id}");
                      },
                    ),
                  );
                },
              ),
            ),
            // Center(
            //   child: TextButton(
            //     onPressed: () {
            //       // Điều hướng đến trang con của Home
            //       context.go("/home/myListPlace");
            //     },
            //     child: const Text("Go sub home"),
            //   ),
            // ),
          ],
        ),
      ),
    );
  }
}
