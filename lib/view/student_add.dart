import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:student_details/controller/student_controller.dart';
import 'package:student_details/utils/constants/validators.dart';
import 'package:student_details/utils/widgets/new_text_form_field.dart';
import '../utils/widgets/new_elevated_button.dart';

class StudentAdd extends StatelessWidget {
  const StudentAdd({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
    return Consumer<StudentController>(
        builder: (context, studentController, child) {
      return Scaffold(
        backgroundColor: Colors.grey,
        floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pop(context);
              studentController.nameController.clear();
              studentController.ageController.clear();
              studentController.imageLink = '';
            },
            child: const Icon(Icons.person)),
        body: Form(
          key: formKey,
          child: Padding(
            padding: EdgeInsets.only(
                left: wt * .1, right: wt * .1, top: ht * .12, bottom: ht * .15),
            child: ListView(
              children: [
                GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return SimpleDialog(
                          title: const Text(
                            'Select Image From',
                            style: TextStyle(
                              color: Colors.green,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          children: <Widget>[
                            SimpleDialogOption(
                              onPressed: () {
                                studentController.cameraImage();
                                Navigator.pop(context); // Close the dialog
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.photo_camera),
                                    SizedBox(width: 8),
                                    Text("Camera"),
                                  ],
                                ),
                              ),
                            ),
                            SimpleDialogOption(
                              onPressed: () {
                                studentController.galleryImage();
                                Navigator.pop(context);
                              },
                              child: const Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Row(
                                  children: [
                                    Icon(Icons.image_rounded),
                                    SizedBox(width: 8),
                                    Text('Gallery'),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        );
                      },
                    );
                  },
                    child: CircleAvatar(
                        backgroundImage: studentController.imageLink!.isEmpty
                            ? null
                            : NetworkImage(
                            studentController.imageLink.toString()),
                        radius: wt * .2,
                        child: Icon(
                          CupertinoIcons.add,
                          size: ht * .1,
                        ))),
                // InkWell(
                //     onTap: () {
                //       showDialog(
                //         context: context,
                //         builder: (context) {
                //           return Padding(
                //             padding: EdgeInsets.only(
                //                 top: ht * .4,
                //                 bottom: ht * .3,
                //                 left: wt * .1,
                //                 right: wt * .1),
                //             child: Card(
                //               elevation: 5,
                //               child: Container(
                //                 decoration: BoxDecoration(
                //                     borderRadius:
                //                         BorderRadius.circular(wt * .02),
                //                     border: Border.all(width: 5)),
                //                 child: Column(
                //                   children: [
                //                     SizedBox(
                //                       height: ht * .03,
                //                     ),
                //                     NewElevatedButtonWidget(
                //                       onPressed: () {
                //                         studentController.cameraImage();
                //                       },
                //                       buttonText: 'Camera',
                //                       dark: false,
                //                       color: Colors.cyan,
                //                     ),
                //                     SizedBox(height: ht * .05),
                //                     NewElevatedButtonWidget(
                //                       onPressed: () {
                //                         studentController.galleryImage();
                //                       },
                //                       buttonText: 'Gallery',
                //                       dark: false,
                //                       color: Colors.cyan,
                //                     )
                //                   ],
                //                 ),
                //               ),
                //             ),
                //           );
                //         },
                //       );
                //     },
                //     child: CircleAvatar(
                //         backgroundImage: studentController.imageLink!.isEmpty
                //             ? null
                //             : NetworkImage(
                //                 studentController.imageLink.toString()),
                //         radius: wt * .2,
                //         child: Icon(
                //           CupertinoIcons.add,
                //           size: ht * .1,
                //         ))),
                SizedBox(
                  height: ht * .05,
                ),
                NewTextFieldWidget(
                  keyBoardType: TextInputType.text,
                  controller: studentController.nameController,
                  iconData: Icons.person,
                  labelText: 'Student name',
                  validator: MyValidator.validateName,
                  dark: false,
                ),
                SizedBox(
                  height: ht * .05,
                ),
                NewTextFieldWidget(
                  keyBoardType: TextInputType.number,
                  controller: studentController.ageController,
                  iconData: CupertinoIcons.number_square_fill,
                  labelText: 'Age',
                  validator: MyValidator.validateAge,
                  dark: false,
                ),
                SizedBox(
                  height: ht * .05,
                ),
                SizedBox(
                  width: 250,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () async {
                      final url = await SharedPreferences.getInstance();
                      final imageUrl = url.getString('url');

                      if (formKey.currentState!.validate()) {
                        if (imageUrl!.isNotEmpty) {
                          studentController.uploadFirebase({
                            "name": studentController.nameController.text,
                            "age":
                                int.parse(studentController.ageController.text),
                            "imageUrl": imageUrl
                          });
                        }
                      }
                      await studentController.nameController;
                      await studentController.ageController;
                      url.setString("url", "");
                      Navigator.pop(context);
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.greenAccent,
                    ),
                    child: const Text(
                      'Save',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                // Padding(
                //   padding: EdgeInsets.only(left: wt * .15, right: wt * .15),
                //   child: NewElevatedButtonWidget(
                //     onPressed: () async {
                //       final url = await SharedPreferences.getInstance();
                //       final imageUrl = url.getString('url');
                //
                //       if (formKey.currentState!.validate()) {
                //         if (imageUrl!.isNotEmpty) {
                //           studentController.uploadFirebase({
                //             "name": studentController.nameController.text,
                //             "age": int.parse(
                //                 studentController.ageController.text),
                //             "imageUrl": imageUrl
                //           });
                //         }
                //       }
                //       studentController.nameController.clear();
                //       studentController.ageController.clear();
                //       Navigator.pop(context);
                //       url.setString("url", "");
                //     },
                //     buttonText: 'Add Student',
                //     dark: true, color: Colors.greenAccent,
                //   ),
                // )
              ],
            ),
          ),
        ),
      );
    });
  }
}
