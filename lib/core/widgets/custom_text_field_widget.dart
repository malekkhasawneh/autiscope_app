import 'package:flutter/material.dart';

class CustomTextFieldWidget extends StatelessWidget {
  const CustomTextFieldWidget({
    super.key,
    required this.title,
    this.isSecure = false,
    this.check = false,
    required this.controller,
    required this.keyBoardType,
  });

  final String title;
  final bool isSecure;
  final TextEditingController controller;
  final bool check;
final TextInputType keyBoardType;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: controller.text.isEmpty && check ? 19 : 20,
        ),
        Text(
          title,
          style: const TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        Container(
          width: MediaQuery.of(context).size.width,
          height: 40,
          padding: const EdgeInsets.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
          ),
          child: TextFormField(
            obscureText: isSecure,
            keyboardType: keyBoardType,
            decoration: const InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.only(bottom: 10)),
            validator: (value) {
              if (value!.isEmpty) {
                return '';
              }
              return null;
            },
            onChanged: (value){
              controller.text = value;
            },
          ),
        ),
        Text(
          controller.text.isEmpty && check ? 'هذا الحقل اجباري' : '',
          style: const TextStyle(fontSize: 12, color: Colors.red),
        ),
      ],
    );
  }
}
