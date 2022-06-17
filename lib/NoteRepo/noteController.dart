import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:share/share.dart';
import 'package:string_stats/string_stats.dart';

import '../pages/newhomepage.dart';
import 'note.dart';
import 'noteDatabase.dart';

class NoteController extends GetxController {
  final subjectController = TextEditingController();
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  var notes = <Note>[];
  var subjects = [];
  var subNotes = [];
  int contentWordCount = 0;
  int contentCharCount = 0;

  final List<String> listsubjects = [
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

  @override
  void onInit() {
    getAllNotes();
    getAllSubject();
    super.onInit();
  }

  bool isEmpty() {
    return notes.isEmpty;
  }

  bool isSubjectEmpty() {
    return subjects.isEmpty;
  }

  int previousWeekNotes(String subject) {
    DateTime dateTime = DateFormat("MMM dd, yyyy  HH:mm:ss").parse(DateFormat("MMM dd, yyyy  HH:mm:ss").format(DateTime.now()));
    DateTime d = DateFormat("MMM dd, yyyy  HH:mm:ss").parse(notes[0].dateTimeCreated.toString());
    // print("now is ${d.toString()}");
    var toReturn = 0;
    var temp = getNoteBySubject(subject);
    for (int i = 0; i < temp.length; i++) {
      var noteTime = DateFormat("MMM dd, yyyy  HH:mm:ss").parse(temp[i].dateTimeCreated.toString());
      // print(temp[i].dateTimeCreated);
      if (dateTime.difference(noteTime).inDays <= 6){
        toReturn++;
      }
    }
    getAllNotes();
    getAllSubject();
    update();
    return toReturn;
  }

  void addNoteToDatabase() async {
    String subject = subjectController.text;
    String title = titleController.text;
    String content = contentController.text;
    title = (title.isBlank) ? title = "Unnamed" : title;
    Note note = Note(
      subject: subject,
      title: title,
      content: content,
      dateTimeEdited:
      DateFormat("MMM dd, yyyy  HH:mm:ss").format(DateTime.now()),
      dateTimeCreated:
      DateFormat("MMM dd, yyyy HH:mm:ss").format(DateTime.now()),
    );
    await NoteDatabase.databaseManager.addNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    getAllSubject();
    update();
    Get.back();
  }

  void deleteNote(int? id) async {
    Note note = Note(
      id: id,
    );
    await NoteDatabase.databaseManager.deleteNote(note);
    getAllNotes();
    getAllSubject();
    update();
  }

  void deleteAllNotes() async {
    await NoteDatabase.databaseManager.deleteAllNotes();
    getAllNotes();
    getAllSubject();
    update();
  }

  void updateNote(int? id, String? dTCreated) async {
    final subject = subjectController.text;
    final title = titleController.text;
    final content = contentController.text;
    Note note = Note(
      id: id,
      subject: subject,
      title: title,
      content: content,
      dateTimeEdited:
      DateFormat("MMM dd, yyyy HH:mm:ss").format(DateTime.now()),
      dateTimeCreated: dTCreated,
    );
    await NoteDatabase.databaseManager.updateNote(note);
    contentWordCount = wordCount(content);
    contentCharCount = charCount(content);
    titleController.text = "";
    contentController.text = "";
    getAllNotes();
    getAllSubject();
    update();
    Get.off(SubjectHomepage());
  }

  void getAllNotes() async {
    notes = await NoteDatabase.databaseManager.getNoteList();
    update();
  }

  void getAllSubject() async {
    notes = await NoteDatabase.databaseManager.getNoteList();
    subjects = notes.map((e) => e.subject).toSet().toList();
    update();
  }

  List<dynamic> getNoteBySubject(String subject)  {
    subNotes = notes.where((element) => element.subject == subject).toList();
    update();
    return subNotes;
  }

  // imported library
  void shareNote(String title, String content, String dateTimeEdited) {
    Share.share("$title \n\n$dateTimeEdited\n\n$content");
  }
}