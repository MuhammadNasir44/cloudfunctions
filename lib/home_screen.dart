import 'package:cloudfunleanrning/home_detail_screen.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Home Screen Detail"),
      ),
      body: Column(
        children: [
          Text("This is Home Screeen offfffffffff"),
          Center(
            child: FloatingActionButton(
              // color: Colors.grey,
              onPressed: () {
                Navigator.popAndPushNamed(context, 'Home_Detail_Screen',
                    arguments: HomeDetailScreen(
                        getDetail: "Hello there", getTitle: "My Title"));
                // Navigator.pushNamed(context, 'Home_Detail_Screen');
              },
              child: Text("Click me"),
            ),
          ),
        ],
      ),
    );
  }
}
