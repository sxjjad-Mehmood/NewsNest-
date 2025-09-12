import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:newsapp/Model/CategoryModel.dart';
import 'package:newsapp/view/apiview.dart';

import '../Model/HeadlineModel.dart';

class viewmodel{
  final api= apiview();

  Future<HeadlineModel> getapi(String channel) async{
    var response= await api.getapi(channel);
    return response;

  }
  Future<CategoryModel> getcategory(String category) async{
    var response=await api.getcategory(category);
    return response;
  }

}