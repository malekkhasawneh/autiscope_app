import 'package:autiscope_app/core/resources/resources.dart';
import 'package:flutter/material.dart';

class QuestionTipScreen extends StatelessWidget {
  const QuestionTipScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const Center(
            child: Text(
              Strings.questionTipTitle,
              style: TextStyle(
                  color: AppColors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 16),
              textAlign: TextAlign.center,
            ),
          ),
          Positioned(
            bottom: 50,
            right: 20,
            child: SizedBox(
              width: 90,
              height: 30,
              child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8), // Border radius here
                    ),
                  ),
                  onPressed: () {},
                  child: const Text(Strings.next)),
            ),
          ),
        ],
      ),
    );
  }
}
