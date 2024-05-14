class CreateFormModel {
  CreateFormModel({this.question, this.option});

  String? question;
  List<ListOptionModel>? option;
}

class ListOptionModel {
  ListOptionModel(
      {this.idOption, this.option, this.isOther = false, this.isParagraph = false});

  String? option;
  String? idOption;
  bool? isOther;
  bool? isParagraph;
}
