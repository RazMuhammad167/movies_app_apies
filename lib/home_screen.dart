
import 'dart:convert';

// import 'package:firebase_project1/model/color_api_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'ColorApiModel.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _ColorApiState();
}

class _ColorApiState extends State<HomeScreen> {
  //create a list
  List<ColorApiModel> colorList = [];

  //future function
  Future<List<ColorApiModel>> getColorAPi() async {
    //Base Url
    var BaseUrl = 'https://www.colourlovers.com/api/colors/new?format=json';

    // get response
    final response = await http.get(Uri.parse(BaseUrl));

    //decode the  response

    var data = jsonDecode(response.body.toString());

    //loop on data

    if (response.statusCode == 200) {
      for (Map i in data) {
        //add data to the list
        colorList.add(ColorApiModel.fromJson(i));
      }
    }

    return [];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: getColorAPi(),
        builder: (context, snapshot) {
          return ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: colorList.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    color: Colors.green.withOpacity(0.3),
                    border: Border.all(color: Colors.black, width: 2),
                  ),
                  child: Column(
                    children: [
                      Text(colorList[index].id.toString()),
                      Text(colorList[index].title.toString()),
                      Text(colorList[index].dateCreated.toString()),
                      Image.network(colorList[index].badgeUrl.toString()),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
