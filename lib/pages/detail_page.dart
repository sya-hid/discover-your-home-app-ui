import 'package:discover_your_home/consts.dart';
import 'package:discover_your_home/models/planets.dart';
import 'package:flutter/material.dart';
import 'package:discover_your_home/widgets/category_item.dart';
import 'package:intl/intl.dart';

class DetailPage extends StatefulWidget {
  final PlanetsModel planet;
  const DetailPage({super.key, required this.planet});

  @override
  State<DetailPage> createState() => _DetailPageState();
}

class _DetailPageState extends State<DetailPage> {
  List<String> categories = ['360', 'information', 'gallery'];
  int selectedCategory = 0;
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    PlanetsModel planet = widget.planet;
    return Scaffold(
      body: Stack(
        children: [
          Container(
              width: size.width,
              height: size.height,
              decoration: BoxDecoration(
                  image: DecorationImage(
                      colorFilter: ColorFilter.mode(
                          black.withOpacity(0.75), BlendMode.darken),
                      image: const AssetImage('assets/images/background.jpg'),
                      fit: BoxFit.cover))),
          Column(
            children: [
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pop();
                      },
                      child: Container(
                        height: 44,
                        width: 44,
                        decoration: BoxDecoration(
                            color: darkBlue.withOpacity(0.5),
                            borderRadius: BorderRadius.circular(12)),
                        child: const Icon(
                          Icons.arrow_back_ios_rounded,
                          color: darkBlue,
                        ),
                      ),
                    ),
                    Container(
                      height: 44,
                      width: 44,
                      decoration: BoxDecoration(
                          color: darkBlue.withOpacity(0.5),
                          borderRadius: BorderRadius.circular(12)),
                      child: const Icon(
                        Icons.more_vert_rounded,
                        color: darkBlue,
                      ),
                    ),
                  ],
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
              const SizedBox(height: 80),
              Hero(
                  tag: planet.image!,
                  child: Image.asset(
                    'assets/images/${planet.image}',
                    width: size.width * 0.9,
                  )),
              const SizedBox(height: 70),
              Text(
                planet.name!,
                style: proportional.copyWith(fontSize: 32),
              ),
              const SizedBox(height: 40),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 22),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'size',
                          style:
                              proportional.copyWith(color: blue, fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          'd = ${NumberFormat('###,000.#', "id_ID").format(planet.size).replaceAll('.', ' ')} km',
                          style: montserrat.copyWith(
                              color: white, fontWeight: FontWeight.bold),
                        )
                      ],
                    ),
                    Column(
                      children: [
                        Text(
                          'distance from Sun',
                          style:
                              proportional.copyWith(color: blue, fontSize: 18),
                        ),
                        const SizedBox(height: 20),
                        Text(
                          '${NumberFormat('###,000.#', "id_ID").format(planet.distanceFromSun).replaceAll('.', ' ')} km',
                          style: montserrat.copyWith(
                              color: white, fontWeight: FontWeight.bold),
                        )
                      ],
                    )
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
