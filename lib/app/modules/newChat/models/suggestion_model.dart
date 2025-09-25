class SuggestionModel {
  final List<String>? questionList;

  SuggestionModel({
    this.questionList,
  });

  SuggestionModel.fromJson(Map<String, dynamic> json) : questionList = (json['question_list'] as List?)?.map((dynamic e) => e as String).toList();

  Map<String, dynamic> toJson() => {'question_list': questionList};
}
