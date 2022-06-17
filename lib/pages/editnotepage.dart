import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../NoteRepo/noteController.dart';


class EditNotePage extends StatelessWidget {
  final NoteController controller = Get.find();

  final List<String> items = [
    'Data Mining 😄',
    'Discrete Math 😻',
    'Scalability 💹',
    'Deep learning 😘',
    'Programming 🍌',
    'Database 👮🏾‍',
    'Algorithms 💖',
    'Calculus 💘',
    'Architectures 🎯',
    'Networking 🍇',
    'Low-Level Programming 💯',
    'Operating System 📦',
    'Mobile Application Development ☕',
    'Web Development ❤️‍',
    'Data Science 💴',
    'Other 🍅'
  ];
  String? selectedValue;

  @override
  Widget build(BuildContext context) {
    dynamic index = Get.arguments - 1;
    controller.subjectController.text = controller.notes[index].subject!;
    controller.titleController.text = controller.notes[index].title!;
    controller.contentController.text = controller.notes[index].content!;
    return Scaffold(
      backgroundColor: Colors.green[50],
      appBar: AppBar(
        iconTheme: const IconThemeData(
          color: Colors.black,
        ),
        title: const Text(
          "Editing Note",
          style: TextStyle(
            color: Colors.black,
          ),
        ),
        backgroundColor: Colors.blue[200],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.only(
            top: 15,
            left: 15,
            right: 15,
          ),
          child: Column(
            children: [
              TextField(
                controller: controller.subjectController,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  suffixIcon: PopupMenuButton<String>(
                    icon: const Icon(Icons.arrow_drop_down),
                    onSelected: (String value) {
                      controller.subjectController.text = value;
                    },
                    itemBuilder: (BuildContext context) {
                      return items
                          .map<PopupMenuItem<String>>((String value) {
                        return new PopupMenuItem(
                            child: new Text(value), value: value);
                      }).toList();
                    },
                  ),
                ),
              ),
              TextField(
                controller: controller.titleController,
                style: const TextStyle(
                  fontSize: 27,
                  fontWeight: FontWeight.bold,
                ),
                decoration: InputDecoration(
                  hintText: "Title",
                  hintStyle: TextStyle(
                    fontSize: 27,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[600],
                    letterSpacing: 1,
                  ),
                  border: InputBorder.none,
                ),
              ),
              TextField(
                style: const TextStyle(
                  fontSize: 22,
                ),
                controller: controller.contentController,
                decoration: const InputDecoration(
                  hintText: "Content",
                  hintStyle: TextStyle(
                    fontSize: 17,
                  ),
                  border: InputBorder.none,
                ),
                keyboardType: TextInputType.multiline,
                maxLines: null,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          controller.updateNote(
              controller.notes[index].id, controller.notes[index].dateTimeCreated);
        },
        child: Icon(Icons.save),
      ),
    );
  }
}