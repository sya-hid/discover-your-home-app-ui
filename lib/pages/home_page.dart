import 'dart:math';

import 'package:discover_your_home/consts.dart';
import 'package:discover_your_home/models/planets.dart';
import 'package:discover_your_home/pages/detail_page.dart';
import 'package:discover_your_home/widgets/news_item.dart';
import 'package:discover_your_home/widgets/planet_item.dart';
import 'package:flutter/material.dart';
import 'package:discover_your_home/widgets/category_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<String> categories = ['all', 'planets', 'comets', 'stars', 'satellites'];
  PageController? pageController;
  double? pageOffset = 1;
  double viewPortFraction = 0.85;

  int selectedCategory = 1;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    pageController =
        PageController(initialPage: 1, viewportFraction: viewPortFraction)
          ..addListener(() {
            setState(() {
              pageOffset = pageController!.page;
            });
          });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    pageController!.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          // Image.asset(
          //   'assets/images/background.jpg',

          //   width: size.width,
          //   height: size.height,
          //   fit: BoxFit.cover,
          // ),
          Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          black.withOpacity(0.75), BlendMode.darken),
                      image: const AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover))),
          SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                            color: darkBlue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(
                          Icons.grid_view_rounded,
                          color: darkBlue,
                        ),
                      ),
                      Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                            color: darkBlue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(
                          Icons.search,
                          color: darkBlue,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Text(
                    'welcome !',
                    style: proportional.copyWith(fontSize: 32),
                  ),
                ),
                const SizedBox(height: 20),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  physics: const BouncingScrollPhysics(),
                  child: Row(
                    children: List.generate(
                        categories.length,
                        (index) => GestureDetector(
                              onTap: () {
                                setState(() {
                                  selectedCategory = index;
                                });
                              },
                              child: Padding(
                                padding: index == 0
                                    ? const EdgeInsets.only(left: 22, right: 30)
                                    : index == categories.length - 1
                                        ? const EdgeInsets.only(right: 22)
                                        : const EdgeInsets.only(right: 30),
                                child: CategoryItem(
                                    category: categories[index],
                                    selected: selectedCategory == index),
                              ),
                            )),
                  ),
                ),
                const SizedBox(height: 20),
                SizedBox(
                  height: size.height * 0.5,
                  child: PageView.builder(
                    physics: const BouncingScrollPhysics(),
                    controller: pageController,
                    itemCount: planets.length,
                    itemBuilder: (context, index) {
                      double scale = max(viewPortFraction,
                          (1 - (pageOffset! - index).abs() + viewPortFraction));
                      return GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      DetailPage(planet: planets[index])));
                        },
                        child: PlanetItem(
                            planet: planets[index],
                            size: size,
                            viewPortFraction: viewPortFraction,
                            scale: scale),
                      );
                    },
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text('astronomical news',
                          style: proportional.copyWith(
                              fontSize: 20, color: white)),
                      Text('see all',
                          style: proportional.copyWith(
                              fontSize: 20, color: white.withOpacity(0.5))),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                const NewsItem(),
                const SizedBox(height: 20),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
