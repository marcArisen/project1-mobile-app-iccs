class Note {
  int? id;
  String? subject;
  String? title;
  String? content;
  String? dateTimeEdited;
  String? dateTimeCreated;

  Note({
    this.id,
    this.subject,
    this.content,
    this.title,
    this.dateTimeEdited,
    this.dateTimeCreated,
  });

  Map<String, dynamic> toMap() {
    return {
      "id": id,
      "subject": subject,
      "title": title,
      "content": content,
      "dateTimeEdited": dateTimeEdited,
      "dateTimeCreated": dateTimeCreated,
    };
  }
}
