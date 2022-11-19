class OnBoardModel {
  final String title;
  final String description;
  final String imageName;

  OnBoardModel(this.title, this.description, this.imageName);

  String get imageWithPath => 'asset/images/$imageName.png';
}

class OnBoardModels {
  static final List<OnBoardModel> onBoardItems = [
    OnBoardModel('Title 1', 'Description-Description-Description-Description-Description-Description-Description', 'ic_chef'),
    OnBoardModel('Title 1', 'Description-Description-Description-Description-Description-Description-Description', 'ic_delivery'),
    OnBoardModel('Title 1', 'Description-Description-Description-Description-Description-Description-Description', 'ic_order'),
  ];
}
