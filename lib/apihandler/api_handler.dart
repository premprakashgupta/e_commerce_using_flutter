import 'dart:convert';
import 'package:e_commerce_app/model/product_model.dart';
import 'package:http/http.dart' as http;

class ApiHandler {
  Future<List<CategoryModal>> fetchCategory() async {
    List<CategoryModal> temp = [];
    final response =
        await http.get(Uri.parse('https://api.escuelajs.co/api/v1/categories'));
    for (var data in jsonDecode(response.body)) {
      temp.add(CategoryModal.fromJson(data));
    }

    return temp;
  }

  Future<List<CatelogModel>> fetchCategoryWise(
      {required String categoryIndex}) async {
    List<CatelogModel> temp = [];
    final response = await http.get(Uri.parse(
        'https://api.escuelajs.co/api/v1/categories/$categoryIndex/products'));
    for (var data in jsonDecode(response.body)) {
      temp.add(CatelogModel.fromJson(data));
    }

    return temp;
  }

  Future<SingleProductModal> fetchSingleProduct(
      {required String productId}) async {
    final response = await http
        .get(Uri.parse('https://api.escuelajs.co/api/v1/products/$productId'));

    return SingleProductModal.fromJson(jsonDecode(response.body));
  }

  Future<List<CatelogModel>> fetchRelatedProduct({
    required String categoryId,
    required String minPrice,
  }) async {
    List<CatelogModel> temp = [];
    final response = await http.get(Uri.parse(
        'https://api.escuelajs.co/api/v1/products/?price_min=$minPrice&categoryId=$categoryId'));
    for (var data in jsonDecode(response.body)) {
      temp.add(CatelogModel.fromJson(data));
    }

    return temp;
  }
}
