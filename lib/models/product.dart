class Product {
  int? id;
  String? _name;
  String? _productType;

  Product.fromMap(Map<String, dynamic> u) {
    id = u["id"];
    _name = u["name"];
    _productType = u["productType"];
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': _name,
      'productType': productType,
    };
  }

  set name(String name) {
    if (!name.toString().contains(RegExp('^[a-zA-Z ]{1,50}\$'))) {
      print('Falha ao carregar o usuário: Nome do produto inválido');
      throw Exception('Falha ao carregar o usuário: Nome do produto inválido');
    }
    _name = name;
  }

  String get name => _name!;

  set productType(String productType) {
    if (!productType.toString().contains(RegExp('^[a-zA-Z ]{1,50}\$'))) {
      print('Falha ao carregar o usuário: Tipo de produto inválido');
      throw Exception('Falha ao carregar o usuário: Tipo de produto inválido');
    }
    _productType = productType;
  }

  String get productType => _productType!;
}
