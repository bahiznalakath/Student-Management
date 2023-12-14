import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:student_details/controller/auth_controller.dart';
import 'package:student_details/controller/student_controller.dart';

class StudentView extends StatelessWidget {
  const StudentView({super.key});

  @override
  Widget build(BuildContext context) {
    final ht = MediaQuery.sizeOf(context).height;
    final wt = MediaQuery.sizeOf(context).width;
    return Scaffold(
      body: Consumer2<StudentController, AuthController>(
          builder: (context, studentController, authController, child) {
        return Scaffold(
          floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
          appBar: AppBar(
            leading: null,
            backgroundColor: Colors.greenAccent,
            title: TextFormField(
              decoration: const InputDecoration(
                prefixIcon: Icon(Icons.search_rounded),
                hintText: 'search',
                filled: true,
                fillColor: Colors.white,
                border: InputBorder.none,
              ),
              onChanged: (value) {
                if (value == '' || value == ' ') {
                  studentController.fetchData(null);
                } else {
                  studentController.fetchData(value);
                }
              },
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    authController.signOut(context);
                  },
                  icon: const Icon(
                    Icons.logout,
                  ))
            ],
          ),
          floatingActionButton: FloatingActionButton(
              elevation: 10,
              backgroundColor: Colors.greenAccent,
              onPressed: () async {
                await Navigator.pushNamed(context, '/studAdd');
                studentController.fetchData(null);
              },
              child: const Icon(
                Icons.add,
                size: 40,
              )),
          body: Column(
            children: [
              Padding(
                padding: EdgeInsets.only(left: wt * .1),
                child: SizedBox(
                  width: wt * .9,
                  child: Row(
                    children: [
                      Text(
                        "AGE (${studentController.ageRange.start.toInt()} -- ${studentController.ageRange.end.toInt()} )",
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      RangeSlider(
                        divisions: 50,
                        activeColor: Colors.teal,
                        labels: RangeLabels(
                            "Age :${studentController.ageRange.start.toInt()}",
                            "Age: ${studentController.ageRange.end.toInt()}"),
                        mouseCursor: MaterialStateMouseCursor.clickable,
                        values: studentController.ageRange,
                        min: 0,
                        max: 50,
                        onChanged: (value) {
                          studentController.updateAgeRange(value);
                        },
                        onChangeEnd: (value) {
                          studentController.filterByAge();
                        },
                      ),
                    ],
                  ),
                ),
              ),
              studentController.filteredList.isEmpty
                  ? Padding(
                      padding: EdgeInsets.only(top: ht * .3),
                      child: InkWell(
                          onDoubleTap: () {
                            Navigator.pushNamed(context, '/studAdd');
                          },
                          child: Column(children: [
                            const CircularProgressIndicator(),
                            SizedBox(
                              height: ht * .05,
                            ),
                            SizedBox(
                                width: wt * .25,
                                child: const Text(
                                  "ADD STUDENT",
                                ))
                          ])),
                    )
                  : Expanded(
                      child: ListView.builder(
                        itemCount: studentController.filteredList.length,
                        itemBuilder: (context, index) => Card(
                          elevation: 0,
                          margin: EdgeInsets.only(
                              left: wt * .1, right: wt * .1, top: ht * .02),
                          child: Padding(
                            padding: EdgeInsets.only(
                                top: ht * .005, bottom: ht * .01),
                            child: ListTile(
                              leading: Padding(
                                padding: EdgeInsets.only(top: ht * .01),
                                child: ClipOval(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    height: ht * .08,
                                    width: wt * .13,
                                    imageUrl: studentController
                                            .filteredList[index].imageUrl ??
                                        'n/a',
                                    placeholder: (context, url) =>
                                        const CircularProgressIndicator(),
                                    // Display a placeholder while loading.
                                    errorWidget: (context, url, error) =>
                                        const CircleAvatar(
                                            child: Icon(Icons.error)),
                                  ),
                                ),
                              ),
                              title: SizedBox(
                                height: ht * .05,
                                child: Text(
                                  studentController.filteredList[index].name ??
                                      'n/a',
                                ),
                              ),
                              subtitle: Text(
                                'AGE: ${studentController.filteredList[index].age.toString()}',
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
            ],
          ),
        );
      }),
    );
  }
}
