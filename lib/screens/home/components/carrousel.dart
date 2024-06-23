import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:gepetrol_eguros/components/small_button.dart';
import 'package:gepetrol_eguros/constants.dart';
import 'package:gepetrol_eguros/screens/home/components/section_title.dart';
import 'package:url_launcher/url_launcher.dart';

class Carouseelhome extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
            padding: const EdgeInsets.all(20.0),
            child: SectionTitle(
              title: "Nos Actualités",
              press: () {
                print('dfvfvdsfvsdvsdv');
                _launchURL1();
              },
            )),
        CarouselSlider(
            items: [
              Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 50,
                  margin: EdgeInsets.all(10),
                  shadowColor: Colors.black,
                  child: Column(children: [
                    Image.asset(
                      'assets/images/11.jpg',
                      fit: BoxFit.fill,
                      height: 190,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //SizedBox
                            Text(
                              'GeeksforGeeks',
                              style: TextStyle(
                                fontSize: 20,
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ), //Text
                            const SizedBox(
                              height: 5,
                            ), //SizedBox
                            const Text(
                              'GeeksforGeeks is a computer science portal for geeks at geeksforgeeks .org at geeksforgeeks .org!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: kSecondaryColor,
                              ), //Textstyle
                            ), //Text
                            const SizedBox(
                              height: 8,
                            ),
                            SmallButton(
                                text: "Lire la suite",
                                press: () => {}), //SizedBox
                            /* SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () => 'Null',
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.touch_app),
                                      Text('Lire la suite')
                                    ],
                                  ),
                                ),
                            )
                          )*/
                          ]),
                    ),
                  ])),
              Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 50,
                  margin: EdgeInsets.all(10),
                  shadowColor: Colors.black,
                  child: Column(children: [
                    Image.asset(
                      'assets/images/19.jpg',
                      fit: BoxFit.fill,
                      height: 190,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //SizedBox
                            Text(
                              'GeeksforGeeks',
                              style: TextStyle(
                                fontSize: 20,
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ), //Text
                            const SizedBox(
                              height: 5,
                            ), //SizedBox
                            const Text(
                              'GeeksforGeeks is a computer science portal for geeks at geeksforgeeks .org at geeksforgeeks .org!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: kSecondaryColor,
                              ), //Textstyle
                            ), //Text
                            const SizedBox(
                              height: 8,
                            ),
                            SmallButton(
                                text: "Lire la suite",
                                press: () => {}), //SizedBox
                            /*SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () => 'Null',
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.touch_app),
                                      Text('Lire la suite')
                                    ],
                                  ),
                                ),
                            )
                          ) */
                          ]),
                    ),
                  ])),
              Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 50,
                  margin: EdgeInsets.all(10),
                  shadowColor: Colors.black,
                  child: Column(children: [
                    Image.asset(
                      'assets/images/13.jpg',
                      fit: BoxFit.fill,
                      height: 190,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //SizedBox
                            Text(
                              'GeeksforGeeks',
                              style: TextStyle(
                                fontSize: 20,
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ), //Text
                            const SizedBox(
                              height: 5,
                            ), //SizedBox
                            const Text(
                              'GeeksforGeeks is a computer science portal for geeks at geeksforgeeks .org at geeksforgeeks .org!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: kSecondaryColor,
                              ), //Textstyle
                            ), //Text
                            const SizedBox(
                              height: 8,
                            ),
                            SmallButton(
                                text: "Lire la suite",
                                press: () => {}), //SizedBox
                            /*SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () => 'Null',
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.touch_app),
                                      Text('Lire la suite')
                                    ],
                                  ),
                                ),
                            )
                          ) */
                          ]),
                    ),
                  ])),
              Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 50,
                  margin: EdgeInsets.all(10),
                  shadowColor: Colors.black,
                  child: Column(children: [
                    Image.asset(
                      'assets/images/11.jpg',
                      fit: BoxFit.fill,
                      height: 190,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //SizedBox
                            Text(
                              'GeeksforGeeks',
                              style: TextStyle(
                                fontSize: 20,
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ), //Text
                            const SizedBox(
                              height: 5,
                            ), //SizedBox
                            const Text(
                              'GeeksforGeeks is a computer science portal for geeks at geeksforgeeks .org at geeksforgeeks .org!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: kSecondaryColor,
                              ), //Textstyle
                            ), //Text
                            const SizedBox(
                              height: 8,
                            ),
                            SmallButton(
                                text: "Lire la suite",
                                press: () => {}), //SizedBox
                            /*SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () => 'Null',
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.touch_app),
                                      Text('Lire la suite')
                                    ],
                                  ),
                                ),
                            )
                          )*/
                          ]),
                    ),
                  ])),
              Card(
                  semanticContainer: true,
                  clipBehavior: Clip.antiAliasWithSaveLayer,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  elevation: 50,
                  margin: EdgeInsets.all(10),
                  shadowColor: Colors.black,
                  child: Column(children: [
                    Image.asset(
                      'assets/images/12.jpg',
                      fit: BoxFit.fill,
                      height: 190,
                      width: double.infinity,
                    ),
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            //SizedBox
                            Text(
                              'GeeksforGeeks',
                              style: TextStyle(
                                fontSize: 20,
                                color: kSecondaryColor,
                                fontWeight: FontWeight.w500,
                              ), //Textstyle
                            ), //Text
                            const SizedBox(
                              height: 5,
                            ), //SizedBox
                            const Text(
                              'GeeksforGeeks is a computer science portal for geeks at geeksforgeeks .org at geeksforgeeks .org!!',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                fontSize: 12,
                                color: kSecondaryColor,
                              ), //Textstyle
                            ), //Text
                            const SizedBox(
                              height: 8,
                            ),
                            SmallButton(
                                text: "Lire la suite",
                                press: () => {}), //SizedBox
                            /* SizedBox(
                              width: 200,
                              child: ElevatedButton(
                                onPressed: () => 'Null',
                                style: ButtonStyle(
                                    backgroundColor:
                                        MaterialStateProperty.all(Colors.blue)),
                                child: Padding(
                                  padding: const EdgeInsets.all(4),
                                  child: Row(
                                    children: const [
                                      Icon(Icons.touch_app),
                                      Text('Lire la suite')
                                    ],
                                  ),
                                ),
                            )
                          ) */
                          ]),
                    ),
                  ])),
            ],
            //Slider Container properties
            options: CarouselOptions(
              height: 400,
              enlargeCenterPage: true,
              autoPlay: true,
              aspectRatio: 16 / 9,
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              viewportFraction: 0.9,
            ))
      ],
    );
  }

  _launchURL1() async {
    final Uri url =
        Uri.parse('https://www.africabourse-am.com/fr/publications.html');
    if (!await launchUrl(url)) {
      throw Exception('Could not launch $url');
    }
  }
}
