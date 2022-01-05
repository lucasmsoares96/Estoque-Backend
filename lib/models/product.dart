class Product {
  int? _id;
  String? _name;
  String? _productType;

  Product.fromProduct(Map<String, dynamic> u) {
    setName(u['name']);
    setProductType(u['productType']);
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'name': getName(),
      'productType': getProductType(),
    };
  }

  setId(int id) {
    _id = id;
  }

  int? getId() {
    return _id;
  }

  setName(String name) {
    _name = name;
  }

  String? getName() {
    return _name;
  }

  setProductType(String productType) {
    _productType = productType;
  }

  String? getProductType() {
    return _productType;
  }
}
