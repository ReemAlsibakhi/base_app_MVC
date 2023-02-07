import 'dart:convert';

import 'package:base_app_mvc/helper/constants.dart';
import 'package:http/http.dart' as http;
import 'package:mvc_pattern/mvc_pattern.dart';

import '../model/PhotosModel.dart';

class PhotoController extends ControllerMVC {
  List<PhotosModel> photosList = [];
  Future<List<PhotosModel>> getPhotos() async {
    final response = await http.get(Uri.parse(Constants.url));
    return (json.decode(response.body.toString()) as List)
        .map((i) => PhotosModel.fromJson(i))
        .toList();
    // Use the compute function to run parsePhotos in a separate isolate.
    //return compute(parsePhotos, response.body);
  }

  // List<PhotosModel> parsePhotos(String responseBody) {
  //   final parsed = jsonDecode(responseBody).cast<Map<String, dynamic>>();
  //
  //   return parsed
  //       .map<PhotosModel>((json) => PhotosModel.fromJson(json))
  //       .toList();
  // }
}
