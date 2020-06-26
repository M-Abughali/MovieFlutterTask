class Task {
  Task({
    this.id,
    this.type,
    this.title,
    this.description,
    this.dose,
    this.dueDate,
    this.patientId,
    this.completedAt,
  });

  String id;
  int type;
  String title;
  String description;
  String dose;
  DateTime dueDate;
  String patientId;
  String completedAt;

  factory Task.fromJson(Map<String, dynamic> json) {
    // String date = json["dueDate"];
    // String dateWithT = date.substring(0, 8) ;//+ 'T' + date.substring(8);
    // DateTime dateTime = DateTime.parse(dateWithT);

    return Task(
      id: json["id"],
      type: json["type"],
      title: json["title"],
      description: json["description"],
      dose: json["dose"],
      dueDate: DateTime.parse(json["dueDate"]),
      patientId: json["patientID"],
      completedAt: json["completedAt"],
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "type": type,
        "title": title,
        "description": description,
        "dose": dose,
        "dueDate": dueDate.toIso8601String(),
        "patientID": patientId,
        "completedAt": completedAt,
      };

  bool isTaskForDate(DateTime dateTime) {
    if (dueDate.day == dateTime.day &&
        dueDate.month == dateTime.month &&
        dueDate.year == dateTime.year) {
      return true;
    }

    return false;
  }

  bool isTaskNotDone() {
    if (completedAt.isEmpty) {
      return true;
    }

    return false;
  }

  bool isTaskForDateAndNotDone(DateTime dateTime) {
    if (isTaskNotDone() && isTaskForDate(dateTime)) {
      return true;
    }

    return false;
  }
}
