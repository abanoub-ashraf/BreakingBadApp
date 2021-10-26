class CharacterModel {
    int? charId;
    String? name;
    String? nickName;
    String? image;
    List<dynamic>? jobs;
    String? statusIfDeadOrAlive;
    List<dynamic>? appearanceOfSeasons;
    String? actorName;
    String? categoryForTwoSeries;
    List<dynamic>? betterCallSaulAppearance;

    CharacterModel({
        this.charId,
        this.name,
        this.nickName,
        this.image,
        this.jobs,
        this.statusIfDeadOrAlive,
        this.appearanceOfSeasons,
        this.actorName,
        this.categoryForTwoSeries,
        this.betterCallSaulAppearance,
    });

    factory CharacterModel.fromJson(Map<String, dynamic> json) {
        return CharacterModel(
            charId:                     json['char_id'] as int,
            name:                       json['name'] as String,
            nickName:                   json['nickname'] as String,
            image:                      json['img'] as String,
            jobs:                       json['occupation'] as List<dynamic>,
            statusIfDeadOrAlive:        json['status'] as String,
            appearanceOfSeasons:        json['appearance'] as List<dynamic>,
            actorName:                  json['portrayed'] as String,
            categoryForTwoSeries:       json['category'] as String,
            betterCallSaulAppearance:   json['better_call_saul_appearance'] as List<dynamic>,
        );
    }
}