import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:navigation_2/core/constants/icon_asset_url.dart';
import 'package:navigation_2/core/theme/app_button.dart';
import 'package:navigation_2/core/theme/app_colors.dart';
import 'package:navigation_2/core/theme/app_text_field.dart';
import 'package:navigation_2/feature/home/data/data_source/data_local.dart';
import 'package:navigation_2/feature/home/data/repositories/place_dog_walk_repository_iml.dart';
import 'package:navigation_2/feature/home/domain/entities/place_dog_walk_entity.dart'
    show PlaceDogWalkEntity;
import 'package:navigation_2/feature/home/domain/usecases/place_dog_walk_usecase.dart';
import 'package:navigation_2/feature/home/presentaions/widgets/item_place_widget.dart';
import 'package:navigation_2/feature/home/presentaions/widgets/title_selection_all_widget.dart';

/// [MyHomePage] là trang chủ chính của ứng dụng.
/// Hiển thị nội dung tổng quan và các phím tắt điều hướng.
class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late final PlaceDogWalkUsecase placeDogWalkUsecase;

  List<PlaceDogWalkEntity> listPlace = [];
  List<PlaceDogWalkEntity> listNearYou = [];
  List<PlaceDogWalkEntity> listSuggested = [];

  bool isLoading = true;

  @override
  void initState() {
    final PlaceDogWalkDataLocalSource placeDogWalkDataLocalSource =
        PlaceDogWalkDataLocalSource();
    final PlaceDogWalkRepositoryIml placeDogWalkRepositoryIml =
        PlaceDogWalkRepositoryIml(
          placeDogWalkDataLocalSource: placeDogWalkDataLocalSource,
        );
    placeDogWalkUsecase = PlaceDogWalkUsecase(
      placeDogWalkRepository: placeDogWalkRepositoryIml,
    );

    fectListPlace();

    super.initState();
  }

  void fectListPlace() async {
    listPlace = await placeDogWalkUsecase.getPlaceDogWalks();

    listNearYou = listPlace.where((place) => place.distance <= 3.0).toList();

    listSuggested = listPlace.where((place) => place.distance > 3.0 ).toList();

    setState(() {
      isLoading = false;
    });
  }

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
      body: isLoading
          ? Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
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
