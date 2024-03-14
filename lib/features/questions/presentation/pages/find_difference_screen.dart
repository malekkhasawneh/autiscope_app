import 'dart:developer';

import 'package:autiscope_app/core/resources/images.dart';
import 'package:flutter/material.dart';

class FindDifferenceScreen extends StatelessWidget {
  const FindDifferenceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage(Images.bearImage),
            fit: BoxFit.fill,
          ),
        ),
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height,
        child: Stack(
          alignment: Alignment.topCenter,
          children: [
            Positioned(
              top: 152,
              right: 195,
              child: GestureDetector(
                onTap: () {
                  log('======================================= 1');
                },
                child: Container(
                  color: Colors.red,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
            Positioned(
              top: 445,
              right: 183,
              child: GestureDetector(
                onTap: () {
                  log('======================================= 1');
                },
                child: Container(
                  color: Colors.red,
                  width: 25,
                  height: 25,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
