import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shop/data/dummy_data.dart';
import 'package:shop/models/product.dart';

class ProductList with ChangeNotifier {
  final List<Product> _items = dummyProducts;

  List<Product> get items =>  [..._items];
  List<Product> get favoriteItems => 
    _items.where((prod) => prod.isFavorite).toList();

  int get itemsCount {
    return _items.length;
  }

  void saveProduct(Map<String,Object> data){
    
    bool hasId = data['id'] != null;

    final newProduct = Product(
      id: hasId ? data['ida'] as String : Random().nextDouble().toString(),
      name: data['name'] as String,
      description: data['description'] as String,
      price:data['price'] as double,
      imageUrl: data['imageUrl'] as String );

      if(hasId){
        updateProduct(newProduct);
      }else{
        addProduct(newProduct);
      }

    addProduct(newProduct);
  }

  void addProduct(Product product){
    _items.add(product);
    notifyListeners();
  }

  void updateProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);
    
    if(index >= 0){
      _items[index] = product;
    }

    notifyListeners();
  }

  void removeProduct(Product product){
    int index = _items.indexWhere((p) => p.id == product.id);

    if(index >= 0){
      _items.removeWhere((p) => p.id == product.id);
    }  
    notifyListeners();
  }

} 