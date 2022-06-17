import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:project1/NoteRepo/noteController.dart';
import 'package:project1/pages/viewnotepage.dart';

import 'addnotepage.dart';

class NoteHomepage extends StatelessWidget {
  final NoteController controller = Get.find();
  var subject = Get.arguments;
  // final controller = Get.put(NoteController());

  Widget emptyNotes() {
    return Container(
      child: const Center(
        child: Text(
          "Add a note right now!!",
        ),
      ),
    );
  }

  // For Testing Proposes
  Widget listNotes() {
    return Container(
      child: const Center(
        child: Text(
          "There are notes",
        ),
      ),
    );
  }

  Widget viewNotes() {
    // dynamic subject = Get.arguments;
    // print("args in homepage is " + subject);
    return Scrollbar(
      child: Container(
        padding: EdgeInsets.only(
          top: 10,
          right: 10,
          left: 10,
        ),
        child: ListView.builder(
          itemCount: controller.getNoteBySubject(subject.toString()).length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(2),
              child: GestureDetector(
                onTap: () async {
                  var data = await Get.to( () =>
                      NoteDetailPage(),
                    arguments: controller.getNoteBySubject(subject.toString())[index],
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
                      Text(
                        controller.getNoteBySubject(subject.toString())[index].title.toString(),
                        style: const TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                        softWrap: false,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Text(
                        controller.getNoteBySubject(subject.toString())[index].content.toString(),
                        style: const TextStyle(
                          fontSize: 17,
                        ),
                        maxLines: 6,
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      Row(
                        children: [
                          Text(
                            "Last Update: " + controller.getNoteBySubject(subject.toString())[index].dateTimeEdited.toString(),
                          ),
                        ],
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
        title: Text(
          "${subject}",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blue[200],
        centerTitle: true,
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
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
          builder: (_) => viewNotes(),
        ),
      ),
      // body: viewNotes(),
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