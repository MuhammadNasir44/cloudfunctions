





import 'package:flutter/material.dart';
class HomeDetailScreen extends StatelessWidget {

  final getTitle;
  final getDetail;
  HomeDetailScreen({this.getTitle,this.getDetail});

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text(getTitle),
      ),


      body: Column(
        children: [

          Text("this is home Detail Screen ${getDetail}"),

        ],
      ),
    );
  }
}
