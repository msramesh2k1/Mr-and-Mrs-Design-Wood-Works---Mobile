import 'package:mr_and_mrs/categorypage.dart';

class CategoryModel {
  String title;
  String url;
  String category;

  CategoryModel({this.title, this.url, this.category});

  CategoryModel.fromJson(Map<String, dynamic> parsedJSON)
      : title = parsedJSON['name'],
        url = parsedJSON['url'],
        category = parsedJSON['category'];
}
