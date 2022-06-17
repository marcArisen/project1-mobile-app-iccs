import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project1/NoteRepo/noteController.dart';
import 'package:project1/pages/homepage.dart';
import 'package:project1/pages/summarypage.dart';
import 'package:project1/pages/viewnotepage.dart';

import 'addnotepage.dart';

class SubjectHomepage extends StatelessWidget {
  SubjectHomepage({Key? key}) : super(key: key);
  final controller = Get.put(NoteController());

  Widget emptySubject() {
    return Container(
      child: const Center(
        child: Text(
          "No Note!!",
        ),
      ),
    );
  }


  Widget viewSubjects() {
    return Scrollbar(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child: ListView.builder(
          itemCount: controller.subjects.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(2),
              child: GestureDetector(
                onTap: () async {
                  var data = await Get.to( () =>
                      NoteHomepage(),
                    arguments: controller.subjects[index],
                  );
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: Colors.blue[100],
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: const EdgeInsets.all(15),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Center(
                        child: Text(
                          controller.subjects[index].toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        title: const Text(
          "🌈CS NOTE🌈",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blue[200],
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        actions: [
          IconButton(
            icon: const Icon(
            Icons.details ,
            color: Colors.pink, size: 36.0,
            ),
          onPressed: () {
            Get.to( () =>
                SummaryPage(),
            );
          },
          ),
        ]
      ),
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage("assets/background.jpg"),
              fit: BoxFit.cover),
        ),
        child: GetBuilder<NoteController>(
          builder: (_) => controller.isSubjectEmpty() ? emptySubject() : viewSubjects(),
        ),
      ),
      floatingActionButton: Stack(
          children: [
            Align(
              alignment: Alignment.bottomRight,
              child: FloatingActionButton(
                heroTag: null,
                onPressed: () {
                  Get.to(() => AddNewNotePage());
                },
                child: const Icon(
                  Icons.add,
                ),
              ),
            ),
          ]
      ),
    );
  }

}