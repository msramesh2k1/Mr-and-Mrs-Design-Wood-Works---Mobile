class ProductModel {
  String title;
  String url;
  int price;
  int oriprice;
  String category;
  String roomtype;
  int id;
  String material;
  String finish;
  int width;
  int height;
  int dimension;

  ProductModel(
      {this.title,
      this.url,
      this.price,
      this.oriprice,
      this.category,
      this.roomtype,
      this.id,
      this.material,
      this.finish,
      this.width,
      this.height,
      this.dimension});

  ProductModel.fromJson(Map<String, dynamic> parsedJSON)
      : title = parsedJSON['title'],
        url = parsedJSON['url'],
        price = parsedJSON['price'],
        oriprice = parsedJSON['oriprice'],
        category = parsedJSON['category'],
        roomtype = parsedJSON['roomtype'],
        id = parsedJSON['id'],
        material = parsedJSON['material'],
        finish = parsedJSON['finish'],
        width = parsedJSON['width'],
        height = parsedJSON['height'],
        dimension = parsedJSON['dimension'];
}
