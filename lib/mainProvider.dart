import 'dart:convert';  // For JSON decoding
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;  // For making HTTP requests

class MainProvider extends ChangeNotifier{
  TextEditingController URLcontoller = TextEditingController();
  var dataList = [];

  void pixabayvalues() async {
    // Pixabay API endpoint (replace with actual query and API key)
    final String apiKey = '46305785-9a1cf75955efa3b6393c3907c';  // Replace with your Pixabay API Key
    final String query = 'flowers';
    final String url = 'https://pixabay.com/api/?key=$apiKey';

    // Make the HTTP GET request
    var response = await http.get(Uri.parse(url));

    // Check if the request was successful
    if (response.statusCode == 200) {
      // Decode the JSON response into a Dart Map
      Map<String, dynamic> jsonData = jsonDecode(response.body);

      // Access the total number of results and total hits
      int totalResults = jsonData['total'];
      int totalHits = jsonData['totalHits'];
      print('${jsonData.keys}');

      // Access the "hits" list which contains the images data
      List<dynamic> hits = jsonData['hits'];

      // Loop through the hits and extract relevant data
     dataList = hits ;

      hits.forEach((hit) {
        print('Image ID: ${hit['id']}');
        print('Image URL: ${hit['webformatURL']}');
        print('Tags: ${hit['tags']}');
        print('User: ${hit['user']}');
        print('User Likes: ${hit['likes']}');
        print('User views: ${hit['views']}');
      });

    } else {
      // Handle request failure
      print('Request failed with status: ${response.statusCode}');
    }
    print('----------------------------------------');
    dataList.forEach((data){
      print('data list Image ID: ${data['id']}');
      print('data list Image URL: ${data['webformatURL']}');
      print('data list Tags: ${data['tags']}');
      print('data list User: ${data['user']}');
      print('data list views: ${data['views']}');
      print('data list likes: ${data['likes']}');

      var imageURl = data['webformatURL'];
      print('image link from datalist $imageURl ');
    });
  }
}
