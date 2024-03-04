import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/core/widgets/custom_text_field_widget.dart';
import 'package:flutter/material.dart';

class ForgetPasswordScreen extends StatelessWidget {
  const ForgetPasswordScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 22),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            CustomTextFieldWidget(
              title: Strings.email,
              controller: TextEditingController(),
              keyBoardType: TextInputType.emailAddress,
            ),
            const SizedBox(
              height: 80,
            ),
            SizedBox(
              width: MediaQuery.of(context).size.width,
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
                  child: const Text(Strings.confirm)),
            ),
          ]),
        ),
      ),
    );
  }
}
