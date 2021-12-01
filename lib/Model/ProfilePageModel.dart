class ProfilePageModel {
  int? id;
  String? level;
  String? description;
  String? levelProgress;
  String? popQuizProgress;

  ProfilePageModel(
      {this.id,
        this.level,
        this.description,
        this.levelProgress,
        this.popQuizProgress,});

  factory ProfilePageModel.fromJson(Map<String, dynamic> json) => ProfilePageModel(
    id: json["id"],
    level: json["level"],
    description: json["description"],
    levelProgress: json["levelProgress"],
    popQuizProgress: json["popQuizProgress"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "level": level,
    "description": description,
    "levelProgress": levelProgress,
    "popQuizProgress": popQuizProgress,
  };
}
