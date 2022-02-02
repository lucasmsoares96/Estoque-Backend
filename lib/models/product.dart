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
      'id': getId()
    };
  }

  setId(int id) {
    _id = id;
  }

  int? getId() {
    return _id;
  }

  setName(String name) {
    if (!name.toString().contains(RegExp('^[a-zA-Z ]{1,50}\$'))) {
      print('Falha ao carregar o usuário: Nome do produto inválido');
      throw Exception('Falha ao carregar o usuário: Nome do produto inválido');
    }
    _name = name;
  }

  String? getName() {
    return _name;
  }

  setProductType(String productType) {
    if (!productType.toString().contains(RegExp('^[a-zA-Z ]{1,50}\$'))) {
      print('Falha ao carregar o usuário: Tipo de produto inválido');
      throw Exception('Falha ao carregar o usuário: Tipo de produto inválido');
    }
    _productType = productType;
  }

  String? getProductType() {
    return _productType;
  }
}
