import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:newsapp/Model/CategoryModel.dart';

import '../Model/HeadlineModel.dart';
class apiview{
  Future<HeadlineModel> getapi(String channel) async {
    var url = "https://newsapi.org/v2/top-headlines?sources=${channel}&apiKey=278d284c36ba4270870525294ce95067";
    var response = await http.get(Uri.parse(url));
    var body = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      return HeadlineModel.fromJson(body);
    }
    throw Exception("error yo have");
  }
  Future<CategoryModel> getcategory(String category) async{
    var url="https://newsapi.org/v2/everything?q=${category}&apiKey=278d284c36ba4270870525294ce95067";
    var response= await http.get(Uri.parse(url));
    var body =jsonDecode(response.body.toString());
    if(response.statusCode==200){
      return CategoryModel.fromJson(body);
    }

      return throw Exception("something wrong");
  }

}