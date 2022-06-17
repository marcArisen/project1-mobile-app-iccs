import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../NoteRepo/noteController.dart';
import 'editnotepage.dart';
import 'newhomepage.dart';

class NoteDetailPage extends StatelessWidget {
  final NoteController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    dynamic note = Get.arguments;
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        backgroundColor: Colors.blue[200],
        iconTheme: const IconThemeData(
          color: Colors.green,
        ),
        actions: [
          IconButton(
            icon: const Icon(
              Icons.delete,
            ),
            onPressed: () {
              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                    content: Text(
                      "Are you sure you want to delete the note?",
                    ),
                    actions: [
                      TextButton(
                        onPressed: () {
                          controller.deleteNote(note.id);
                          Get.offAll(SubjectHomepage());
                        },
                        child: Text("Yes"),
                      ),
                      TextButton(
                        onPressed: () => {
                          Get.back()
                        },
                        child: Text("No"),
                      ),
                    ],
                  );
                },
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.edit,
            ),
            onPressed: () {
              Get.to( () =>
                  EditNotePage(),
                arguments: note.id,
              );
            },
          ),
          IconButton(
            icon: const Icon(
              Icons.more_vert,
            ),
            onPressed: () {
              Get.bottomSheet(
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    TextButton(
                      onPressed: () {
                        controller.shareNote(
                          note.title.toString(),
                          note.content.toString(),
                          note.dateTimeEdited.toString(),
                        );
                      },
                      child: Row(
                        children: const [
                          SizedBox(
                            width: 30,
                          ),
                          Icon(
                            Icons.share,
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          Text(
                            "Share This Note",
                            style: TextStyle(
                              fontSize: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 20,
                        top: 20,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Created :  " +
                                note.dateTimeCreated.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Text(
                            "Note's ID :  " +
                                note.id.toString(),
                            style: const TextStyle(
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                backgroundColor: Colors.blue[50],
              );
            },
          ),
        ],
      ),
      body: GetBuilder<NoteController>(
        builder: (_) => Scrollbar(
          child: Container(
            padding: const EdgeInsets.only(
              left: 15,
              right: 15,
            ),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  SelectableText(
                    note.subject.toString(),
                    style: const TextStyle(
                      fontSize: 30,
                      fontStyle: FontStyle.italic,
                      fontWeight: FontWeight.w700,
                      color: Colors.blueGrey,
                    ),
                  ),
                  const Divider(
                    height: 10,
                    thickness: 2,
                    indent: 10,
                    endIndent: 0,
                    color: Colors.black,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  SelectableText(
                    note.title.toString(),
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
                    note.content.toString(),
                    style: const TextStyle(
                      fontSize: 22,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
