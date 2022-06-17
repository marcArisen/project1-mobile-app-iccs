import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../NoteRepo/noteController.dart';
import 'editnotepage.dart';

class SummaryPage extends StatelessWidget {
  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        iconTheme: const IconThemeData(
          color: Colors.green,
        ),
        title: const Text(
          "Summary Page",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
      ),
      body: GetBuilder<NoteController>(
        builder: (_) => ListView.builder(
          itemCount: controller.listsubjects.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.all(2),
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
                          controller.listsubjects[index].toString(),
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                          softWrap: false,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SelectableText(
                        "All written notes : ${controller.getNoteBySubject(controller.listsubjects[index]).length}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SelectableText(
                        "Notes written in previous 7 days: ${controller.getNoteBySubject(controller.listsubjects[index]).length}",
                        style: const TextStyle(
                          fontSize: 22,
                          fontStyle: FontStyle.italic,
                          fontWeight: FontWeight.w700,
                          color: Colors.blueGrey,
                        ),
                      ),
                    ],
                  ),
                ),
            );
          },
        ),
      ),
    );
  }
}
