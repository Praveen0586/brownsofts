// ignore_for_file: file_names

class BSService {
  String? name;
  String? category;
  String? categoryCode;
  String? image;
  List? fAQ;
  Map? price;
  List? description;
  BSService(
      {this.name,
      this.category,
      this.categoryCode,
      this.image,
      this.fAQ,
      this.description,
      this.price});

  static fromJson(Map json) async {
    return BSService(
        name: json["name"],
        category: json["category"],
        categoryCode: json["category_code"],
        image: json["image"],
        fAQ: json["FAQ"],
        price: json["price"],
        description: json["description"]);
  }
}

class Price {
  int? priced;
  int? crosscut;
  int? delivery;
  int? revisions;
  List? restrictions;
  Price(
      {this.crosscut,
      this.delivery,
      this.priced,
      this.restrictions,
      this.revisions});

  static fromJson(json) {
    return Price(
        priced: json["price"],
        crosscut: json["cross cut"],
        delivery: json["delivery"],
        restrictions: json["revisions"],
        revisions: json["restrictions"]);
  }
}

