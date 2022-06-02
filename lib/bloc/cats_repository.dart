import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:cat_api/model/cats_model.dart';
import 'package:http/http.dart' as http;

abstract class CatsRepository {
  Future<List<CatsFacts>> getCatsFromApi();
}

class SampleCatsRepository implements CatsRepository {
  final baseUrl = Uri.parse('https://cat-fact.herokuapp.com/facts/');
  @override
  Future<List<CatsFacts>> getCatsFromApi() async {
    final response = await http.get(baseUrl);
    return (jsonDecode(response.body) as List)
        .map((e) => CatsFacts.fromJson(e))
        .toList();
  }
}
 