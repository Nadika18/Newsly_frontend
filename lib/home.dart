import 'package:flutter/material.dart';
// ignore: depend_on_referenced_packages
import 'package:getwidget/getwidget.dart';
import 'dart:convert';
import 'package:flutter/services.dart';
import 'models/1.dart';
// import 'dart:async' show Future;

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: const Text("Newsly"),
          
          bottom: const TabBar(
            tabs: [
              Tab(text:"For You"),
              Tab(text:"Popular"),
              Tab(text:"Saved")
            ]
            ),
        ),
        
        body: TabBarView(children: [
              ListView(
          children: const <Widget>[
            
            ElevatedCard(),
            ElevatedCard(),
            ElevatedCard(),
            ElevatedCard(),
          ],
        ),
        const Text("Popular"),
        const Text("Saved"),
        ],));
  }
}

class ElevatedCard extends StatefulWidget {
  const ElevatedCard({super.key});

  @override
  State<ElevatedCard> createState() => _ElevatedCardState();
}

// Future<String> _loadData() async {
//   return await rootBundle.loadString('assets/1.json');
// }



class _ElevatedCardState extends State<ElevatedCard> {
  // Future loadData() async {
  //   String jsonString = await _loadData();
  //   final jsonResponse = json.decode(jsonString);
  //   News news = new News.fromJson(jsonResponse);
  //   print('${news.title}');
  // }
  
  // void initState() {
  //   super.initState();
  //   loadData();
    
  // }

  @override

  // final growableList= <NewsCategory>[]

  Widget build(BuildContext context) {
    return GFCard(
      boxFit: BoxFit.cover,
      titlePosition: GFPosition.start,
      image: Image.asset(
        "assets/image1.png",
        height: MediaQuery.of(context).size.height * 0.2,
        width: MediaQuery.of(context).size.width,
        fit: BoxFit.cover,
      ),
      showImage: true,
      title: const GFListTile(
        titleText: "newstitle",
        subTitleText: 'Author | Published date',
      ),
      content: const Text(
          "Some quick example text to build on the card Some quick example text to build on the card Some quick example text to build on the card Some quick example text to build on the card"),
    );
  }
}
