import 'package:intl/intl.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:tester/model/post_model.dart';

class ServiceLearn {
  List<PostModel>? _items;
  bool _isloading = false;
  late final Dio _dio;
  final _baseUrl = "http://10.0.2.2:8000/";
  late String selectedMeal;
  String selectedDate = '';

  @override
  void initState() {
    _dio = Dio(BaseOptions(baseUrl: _baseUrl));
    final currentHour = DateTime.now().hour;
    selectedMeal = (currentHour >= 12) ? "Aksam" : "Kahvaltı";
    selectedDate = DateFormat('yyyy-MM-dd').format(DateTime.now());

    fetchPostItems();
  }

/*
  void _changeLoading() {
    setState(() {
      _isloading = !_isloading;
    });
  }
*/
  Future<List<PostModel>?> fetchPostItems() async {
    // _changeLoading();
    final response = await _dio.get("tasks/$selectedDate/$selectedMeal/");

    final _datas = response.data;

    if (_datas is List) {
      _items = _datas.map((e) => PostModel.fromJson(e)).toList();
      return _items;
    }

    // _changeLoading();
  }
}
 /*
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: _items?.length ?? 0,
      itemBuilder: (context, index) {
        return Card(
          child: ListTile(
              title: Text(_items?[index].task ?? 'item yok'),
              subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Yemek: ${_items?[index].food}'),
                    Text('Çorba: ${_items?[index].soup}'),
                    Text('Pilav: ${_items?[index].rice}'),
                    Text('Salata: ${_items?[index].salad}'),
                    Text('Su: ${_items?[index].bread}'),
                    Text('Ekmek: ${_items?[index].water}'),
                    Text(_items?[index].food ?? ''),
                  ])),
        );
      },
    );
  }

*/
