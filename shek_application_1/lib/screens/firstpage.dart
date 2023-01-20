import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:another_transformer_page_view/another_transformer_page_view.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shek_application_1/screens/coffehomepage.dart';
import 'package:animate_do/animate_do.dart';

class FirstPage extends StatefulWidget {
  @override
  State<FirstPage> createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage> {
  TransformerPageController controller = TransformerPageController();

  @override
  Widget build(BuildContext context) {
    var sk_width = MediaQuery.of(context).size.width;
    var sk_height = MediaQuery.of(context).size.height;
    // TODO: implement build
    return Scaffold(
      body: Container(
        width: sk_width,
        height: sk_height,
        decoration: const BoxDecoration(
            image: DecorationImage(
                image: AssetImage("images/coffee_back.jpg"),
                fit: BoxFit.cover)),
        child: Stack(alignment: Alignment.center, children: [
          TransformerPageView(
              physics: const BouncingScrollPhysics(),
              transformer: ScaleAndFadeTransformer(),
              pageController: controller,
              itemBuilder: (c, index) {
                return Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: sk_height * 0.12,
                    ),
                    Text("SK Coffee Shop \n Quality is Our Priority",
                        style: GoogleFonts.lato(
                            fontSize: 30,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                            color: Colors.white)),
                    SizedBox(
                      height: sk_height * 0.02,
                    ),
                    FadeInDown(
                      child: Container(
                        padding: const EdgeInsets.only(left: 30),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.location_on_rounded,
                              color: Color(0xFFD09B6B),
                            ),
                            SizedBox(
                              width: sk_width * 0.02,
                            ),
                            const Text(
                              "Romolo,",
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white),
                            ),
                            const Text("Milano",
                                style: TextStyle(color: Colors.white)),
                          ],
                        ),
                      ),
                    ),
                    SizedBox(height: sk_height * 0.5),
                    const Text(
                      "The best Coffee, you can ever get with best quality and flavor",
                      style: TextStyle(color: Colors.white),
                    )
                  ],
                );
              },
              itemCount: 3),
          Positioned(
            left: sk_width * 0.42,
            top: sk_height * 0.84,
            child: SmoothPageIndicator(
              count: 3,
              effect: const ExpandingDotsEffect(
                  activeDotColor: Color.fromARGB(255, 0, 255, 4),
                  dotHeight: 9.5,
                  dotWidth: 9.5,
                  dotColor: Colors.white),
              controller: controller,
            ),
          ),
          SizedBox(
            height: sk_height * 0.01,
          ),
          Positioned(
            left: sk_width * 0.12,
            top: sk_height * 0.89,
            child: ElevatedButton(
                onPressed: () {
                  Navigator.pushReplacement(
                      context,
                      PageTransition(
                          child: const CoffeePage(),
                          type: PageTransitionType.fade));
                },
                style: ElevatedButton.styleFrom(
                    primary: Colors.orangeAccent,
                    padding: EdgeInsets.symmetric(
                        horizontal: sk_width * 0.3, vertical: 25),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(40))),
                child: const Text("Create an Order",
                    style: TextStyle(color: Colors.white))),
          ),
        ]),
      ),
    );
  }
}

class ScaleAndFadeTransformer extends PageTransformer {
  final double _scale;
  final double _fade;

  ScaleAndFadeTransformer({double fade: 0.2, double scale: 0.8})
      : _fade = fade,
        _scale = scale;

  @override
  Widget transform(Widget item, TransformInfo info) {
    double? position = info.position;
    // double scaleFactor = (1 - position!.abs()) * (1 - _scale);
    // double fadeFactor = (1 - position!.abs()) * (1 - _fade);
    double opacity = (1 - position!.abs()) * 1;
    // double scale = _scale + scaleFactor;
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 800),
      opacity: opacity,
      child: item,
    );
  }
}
