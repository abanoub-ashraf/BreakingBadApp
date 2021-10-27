class CharacterQuotesModel {
    String? quote;

    CharacterQuotesModel({
        this.quote
    });

    factory CharacterQuotesModel.fromJson(Map<String, dynamic> json) {
        return CharacterQuotesModel(
            quote: json['quote'] as String,
        );
    }
}