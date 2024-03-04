import 'dart:developer';

import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/core/widgets/custom_text_field_widget.dart';
import 'package:autiscope_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class AddChildScreen extends StatelessWidget {
  const AddChildScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Directionality(
        textDirection: TextDirection.rtl,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 35),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 70,
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
                    onPressed: () {
                      getAllChildren(LoginCubit.get(context).user.uid);
                    },
                    child: const Text(Strings.addChild)),
              ),
              const SizedBox(
                height: 40,
              ),
              CustomTextFieldWidget(
                title: Strings.childName,
                controller: TextEditingController(),
              ),
              CustomTextFieldWidget(
                title: Strings.childNicName,
                controller: TextEditingController(),
              ),
              const SizedBox(
                height: 40,
              ),
              const Text(
                Strings.childAge,
                style: TextStyle(
                  fontSize: 12,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Transform.translate(
                offset: const Offset(9, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity.compact,
                      value: false,
                      onChanged: (bool? value) {},
                      activeColor: AppColors.darkYellow,
                      side: const BorderSide(
                        color: AppColors.darkYellow,
                        width: 1.5, // Border width
                      ),
                    ),
                    const Text(
                      Strings.oneYearToThree,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
              ),
              Transform.translate(
                offset: const Offset(9, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Checkbox(
                      visualDensity: VisualDensity.compact,
                      value: false,
                      onChanged: (bool? value) {},
                      activeColor: AppColors.darkYellow,
                      side: const BorderSide(
                        color: AppColors.darkYellow,
                        width: 1.5, // Border width
                      ),
                    ),
                    const Text(
                      Strings.threeYearToFour,
                      style:
                          TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> addChildToUser(BuildContext context) async {
    try {
      CollectionReference childrenCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(LoginCubit.get(context).user.uid)
          .collection('children');
      await childrenCollection.add({
        'name': 'Ahmad',
        'nickname': 'Hamdan',
        'age': '1.5',
      });

      log('Child added successfully!');
    } catch (e) {
      log('Failed to add child: $e');
      rethrow;
    }
  }

  Future<void> getAllChildren(String userId) async {
    try {
      CollectionReference childrenCollection = FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .collection('children');
      QuerySnapshot querySnapshot = await childrenCollection.get();
      Map<String, dynamic> data =
          querySnapshot.docs.first.data() as Map<String, dynamic>;
      log('======================== vv ${data['name']}');
    } catch (e) {
      print('Failed to get children: $e');
      throw e;
    }
  }
}
