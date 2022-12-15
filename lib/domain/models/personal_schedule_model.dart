class PersonalScheduleModel {
  String? id;
  String? date;
  String? name;
  String? timer;
  String? note;

  PersonalScheduleModel(this.date, this.name, this.timer, this.note, {this.id});

  PersonalScheduleModel.fromJson(Map<String, dynamic> data) {
    id = data['id'].toString();
    date = data['date'];
    note = data['note'];
    name = data['schedule_name'];
    timer = data['timer'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['note'] = note;
    data['date'] = date;
    data['schedule_name'] = name;
    data['timer'] = timer;
    return data;
  }
}
