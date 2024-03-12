import 'package:autiscope_app/core/resources/contants.dart';
import 'package:autiscope_app/core/resources/images.dart';
import 'package:autiscope_app/core/resources/resources.dart';
import 'package:autiscope_app/core/widgets/custom_text_field_widget.dart';
import 'package:autiscope_app/features/add_child/presentation/cubit/add_child_cubit.dart';
import 'package:autiscope_app/features/add_child/presentation/widgets/check_boxes_widget.dart';
import 'package:autiscope_app/features/login/presentation/cubit/login_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class AddChildScreen extends StatefulWidget {
  const AddChildScreen({super.key});

  @override
  State<AddChildScreen> createState() => _AddChildScreenState();
}

class _AddChildScreenState extends State<AddChildScreen> {
  @override
  void initState() {
    AddChildCubit.get(context)
        .getChildren(userId: LoginCubit.get(context).userId);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: BlocConsumer<AddChildCubit, AddChildState>(
        listener: (context, state) {
          if (state is AddChildLoaded) {
            if (state.success) {
              ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(content: Text('تم اضافة الطفل بنجاح')));
              AddChildCubit.get(context)
                  .getChildren(userId: LoginCubit.get(context).userId);
            }
          }
        },
        builder: (context, state) {
          return Scaffold(
            body: SizedBox(
              width: double.infinity,
              height: double.infinity,
              child: SingleChildScrollView(
                physics: const BouncingScrollPhysics(),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 70,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 35),
                      child: SizedBox(
                        width: MediaQuery.of(context).size.width,
                        child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.blue,
                              foregroundColor: Colors.white,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(
                                    8), // Border radius here
                              ),
                            ),
                            onPressed: () {
                              AddChildCubit.get(context).setCheck = true;
                              if (AddChildCubit.get(context).validateFields()) {
                                AddChildCubit.get(context).addChild(
                                    userId: LoginCubit.get(context).userId);
                              }
                            },
                            child: const Text(Strings.addChild)),
                      ),
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    if (state is AddChildLoading) ...[
                      const Padding(
                        padding: EdgeInsets.only(top: 150),
                        child: Center(
                            child: CircularProgressIndicator(
                          color: Colors.blue,
                        )),
                      ),
                    ] else ...[
                      SingleChildScrollView(
                        physics: const BouncingScrollPhysics(),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 35),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  CustomTextFieldWidget(
                                    title: Strings.childName,
                                    controller: AddChildCubit.get(context).name,
                                    check: AddChildCubit.get(context).getCheck,
                                    keyBoardType: TextInputType.name,
                                  ),
                                  CustomTextFieldWidget(
                                    title: Strings.childNicName,
                                    controller:
                                        AddChildCubit.get(context).nickName,
                                    check: AddChildCubit.get(context).getCheck,
                                    keyBoardType: TextInputType.name,
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
                                  const CheckBoxesWidget(),
                                ],
                              ),
                            ),
                            AddChildCubit.get(context).children.isNotEmpty
                                ? Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        const SizedBox(
                                          height: 40,
                                        ),
                                        const Padding(
                                          padding: EdgeInsetsDirectional.only(
                                              start: 25),
                                          child: Text(
                                            Strings.children,
                                            style: TextStyle(
                                              fontSize: 12,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ...AddChildCubit.get(context)
                                            .children
                                            .map((child) {
                                          return ListTile(
                                            dense: true,
                                            onTap: () {
                                              child.age ==
                                                      Constants.oneThreeAgeGroup
                                                  ? Navigator.pushNamed(
                                                      context,
                                                      Routes
                                                          .parentQuestionsScreen)
                                                  : Navigator.pushNamed(
                                                      context,
                                                      Routes
                                                          .charQuestionOneScreen);
                                            },
                                            leading: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                              child: Image.asset(
                                                Images.boyLogo,
                                                fit: BoxFit.fill,
                                                width: 50,
                                                height: 40,
                                                color: Colors.black,
                                              ),
                                            ),
                                            title: Text(child.name),
                                            subtitle: Text(child.nickName),
                                          );
                                        })
                                      ],
                                    ),
                                  )
                                : const SizedBox()
                          ],
                        ),
                      )
                    ]
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
