class StudentScores {
  double? avgScore;
  String? className;
  int? failedSubjects;
  String? id;
  String? name;
  int? passedSubjects;
  List<Score>? scores;

  StudentScores(
      {this.avgScore,
      this.className,
      this.failedSubjects,
      this.id,
      this.name,
      this.passedSubjects,
      this.scores});

  StudentScores.fromJson(Map<String, dynamic> json) {
    avgScore = json['avgScore'];
    className = json['class'];
    failedSubjects = json['failedSubjects'];
    id = json['id'];
    name = json['name'];
    passedSubjects = json['passedSubjects'];
    if (json['scores'] != null) {
      scores = <Score>[];
      json['scores'].forEach((v) {
        scores!.add(Score.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['avgScore'] = avgScore;
    data['class'] = className;
    data['failedSubjects'] = failedSubjects;
    data['id'] = id;
    data['name'] = name;
    data['passedSubjects'] = passedSubjects;
    if (scores != null) {
      data['scores'] = scores!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Score {
  Subject? subject;
  String? firstComponentScore;
  String? secondComponentScore;
  String? examScore;
  String? avgScore;
  String? alphabetScore;

  Score(
      {this.subject,
      this.firstComponentScore,
      this.secondComponentScore,
      this.examScore,
      this.avgScore,
      this.alphabetScore});

  Score.fromJson(Map<String, dynamic> json) {
    subject =
        json['subject'] != null ? Subject.fromJson(json['subject']) : null;
    firstComponentScore = (json['firstComponentScore'] as String? ?? "").replaceAll(",", ".");
    secondComponentScore = (json['secondComponentScore'] as String? ?? "").replaceAll(",", ".");
    examScore = (json['examScore'] as String? ?? "").replaceAll(",", ".");
    avgScore = (json['avgScore'] as String? ?? "").replaceAll(",", ".");
    alphabetScore = json['alphabetScore'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (subject != null) {
      data['subject'] = subject!.toJson();
    }
    data['firstComponentScore'] = firstComponentScore;
    data['secondComponentScore'] = secondComponentScore;
    data['examScore'] = examScore;
    data['avgScore'] = avgScore;
    data['alphabetScore'] = alphabetScore;
    return data;
  }
}

class Subject {
  String? id;
  String? name;
  int? numberOfCredits;

  Subject({this.id, this.name, this.numberOfCredits});

  Subject.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    numberOfCredits = json['numberOfCredits'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['numberOfCredits'] = numberOfCredits;
    return data;
  }
}
