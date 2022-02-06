class Product {
  int? id;
  String? _name;
  String? _productType;

  Product.fromMap(Map<String, dynamic> u) {
    id = u["id"];
    name = u["name"];
    productType = u["productType"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': _name,
      'productType': productType,
    };
  }

  set name(String name) {
    if (!name.toString().contains(RegExp(
          r'[a-zA-Z\u00C0-\u00FF0-9 ]+',
          caseSensitive: false,
        ))) {
      print('Nome do produto inválido');
      throw Exception('Nome do produto inválido');
    }
    _name = name;
  }

  String get name => _name!;

  set productType(String productType) {
    if (!productType.toString().contains(RegExp(
          r'[a-zA-Z\u00C0-\u00FF0-9 ]+',
          caseSensitive: false,
        ))) {
      print('Tipo de produto inválido');
      throw Exception('Tipo de produto inválido');
    }
    _productType = productType;
  }

  String get productType => _productType!;
}
