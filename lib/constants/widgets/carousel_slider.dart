import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:movies_app/constants/colors.dart';

class CarouselImageSlider extends StatefulWidget {
  const CarouselImageSlider({Key? key}) : super(key: key);

  @override
  State<CarouselImageSlider> createState() => _CarouselImageSliderState();
}

class _CarouselImageSliderState extends State<CarouselImageSlider> {
  CarouselController carouselController = CarouselController();

  int currentIndex = 0;

  List<dynamic> movieImageUrls = [
    "https://www.upf.tv/wp-content/uploads/sites/196/2021/12/upf-film-thumbnail-inside-islam-what-a-billion-muslims-really-think.jpg",
    "https://saintdominicmedia.com/wp-content/uploads/2022/11/WSL-Thumbnail-1x1-1-500x383.png",
    "https://i.pinimg.com/474x/f7/39/0b/f7390b626467d40323851f1a55686af5.jpg",
    "https://asset.gsc.com.my/dsites/promotion/cover/GSC_Nun_socialmedia.jpg?VersionId=Rfrbf7MdhNdO6efpwsd4Vy0EcKi0ngON",
    "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT6NAvpzzE7XhSg51pMpLHliid83ezmuz77oQ&usqp=CAU",
  ];

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Stack(
      children: [
        SizedBox(
          // height: height * 0.3,
          width: double.infinity,
          child: CarouselSlider(
            carouselController: carouselController,
            options: CarouselOptions(
              autoPlayAnimationDuration: const Duration(milliseconds: 1200),
              height: 270,
              aspectRatio: 2,
              scrollPhysics: const BouncingScrollPhysics(),
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(() {
                  currentIndex = index;
                });
              },
            ),
            items: movieImageUrls.map((i) {
              return Builder(
                builder: (BuildContext context) {
                  return Container(
                    height: double.infinity,
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.white60,
                      image: DecorationImage(
                        fit: BoxFit.fill,
                        image: NetworkImage(
                          i.toString(),
                        ),
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
        Positioned(
          left: 0,
          right: 0,
          bottom: 7,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: movieImageUrls.map((item) {
              int index = movieImageUrls.indexOf(item);
              return AnimatedContainer(
                duration: const Duration(milliseconds: 800),
                margin: const EdgeInsets.only(right: 5),
                width: currentIndex == index ? 20 : 6,
                height: 6,
                decoration: BoxDecoration(
                  color: currentIndex == index
                      ? AppColors.primaryColor
                      : const Color(0xffd8d8d8),
                  borderRadius: BorderRadius.circular(3),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
