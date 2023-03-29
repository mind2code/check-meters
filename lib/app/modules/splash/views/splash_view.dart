import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'package:get/get.dart';

import '../controllers/splash_controller.dart';

class SplashView extends GetView<SplashController> {
  @override
  Widget build(BuildContext context) {
    return  Scaffold(
        backgroundColor: Colors.white,
        body: Stack(
          fit: StackFit.expand,
          children: [
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(.03),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                        topLeft: Radius.circular(150))),
              ),
              height: 170,
              width: 170,
              right: 10,
              top: -10,
            ),
            Positioned(
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(.03),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                        topLeft: Radius.circular(150))),
              ),
              height: 140,
              width: 140,
              left: -45,
              bottom: 100,
            ),
            FractionallySizedBox(
              heightFactor: .25,
              widthFactor: .6,
              child: Container(
                decoration: BoxDecoration(
                    color: Colors.orange.withOpacity(.03),
                    borderRadius: BorderRadius.only(
                        topRight: Radius.circular(50),
                        bottomRight: Radius.circular(100),
                        bottomLeft: Radius.circular(100),
                        topLeft: Radius.circular(150))),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset(
                  "assets/Logo_CIE.png",
                  height: 130,
                ),
                SizedBox(height: 15,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Meters',
                      style:
                      TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Checker',
                      style: TextStyle(
                          fontSize: 20,
                          color: Colors.orange,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                )
              ],
            ),
            FractionallySizedBox(
              heightFactor: .2,
              alignment: Alignment.bottomCenter,
              child: SpinKitFadingCircle(
                color: Colors.orange,
                size: 30,
              ),
            )
          ],
        ));
  }
}
