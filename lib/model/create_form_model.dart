class CreateFormModel {
  CreateFormModel(
      {this.question = 'Untitled question',
      this.option,
      this.isRequired = false,
      this.isParagraph = false});

  String? question;
  bool? isRequired;
  bool? isParagraph;
  List<ListOptionModel>? option;
}

class ListOptionModel {
  ListOptionModel({
    this.idOption,
    this.option,
    this.isOther = false,
    this.isParagraph = false,
    this.isChecked = false,
    this.percentChoice = 1,
  });

  String? option;
  String? idOption;
  bool? isOther;
  bool? isParagraph;
  bool? isChecked;
  int? percentChoice;
}
