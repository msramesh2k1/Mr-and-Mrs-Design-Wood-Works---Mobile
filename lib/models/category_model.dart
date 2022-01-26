class CategoryModel {
  String title;
  String url;

  CategoryModel({this.title, this.url});

  CategoryModel.fromJson(Map<String, dynamic> parsedJSON)
      : title = parsedJSON['name'],
        url = parsedJSON['age'];
}
