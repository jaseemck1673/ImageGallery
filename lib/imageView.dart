import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:provider/provider.dart';

import 'mainProvider.dart';

class ImageGallery extends StatelessWidget {
  const ImageGallery({super.key});

  @override
  Widget build(BuildContext context) {
    MainProvider mainprovider = Provider.of(context, listen: false);
    mainprovider.pixabayvalues();

    double screenwidth = MediaQuery.of(context).size.width;
    int crossAxisCount = screenwidth > 600 ? 4 : (screenwidth > 400 ? 3 : 2);
    return Scaffold(
      appBar: AppBar(
        title: Text("Image Gallery"),
        backgroundColor: Colors.green.shade500,

      ),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: crossAxisCount,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10),
        itemBuilder: (context, index) {
          return Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(mainprovider.dataList[index]['webformatURL'].toString()),

                  fit: BoxFit.cover)
                ),
                height: 160,
                width: 160,

              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Row(
                    children: [
                      Icon(Icons.favorite),
                      Text(mainprovider.dataList[index]['likes'].toString()),
                    ],
                  ),
                  Row(
                    children: [
                      Icon(Icons.remove_red_eye),
                      Text(mainprovider.dataList[index]['views'].toString()),
                    ],
                  )
                ],
              ),
              
            ],
          );
        },
        itemCount: mainprovider.dataList.length,
      ),
    );
  }
}



class PixabayService {
  final String apiKey = '46305785-9a1cf75955efa3b6393c3907c'; // Replace with your API key

  Future<List<String>> fetchImages(String query) async {
    final response = await http.get(
      Uri.parse('https://pixabay.com/api/?key=$apiKey&q=$query&image_type=photo'),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      List<String> imageUrls = [];
      for (var item in data['hits']) {
        imageUrls.add(item['webformatURL']);
      }
      return imageUrls;
    } else {
      throw Exception('Failed to load images');
    }
  }
}
