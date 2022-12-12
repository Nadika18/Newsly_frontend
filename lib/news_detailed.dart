import 'package:flutter/material.dart';
import 'package:audioplayers/audioplayers.dart';
import 'models/1.dart';

final player = AudioPlayer();
bool isPlaying = false;
Duration duration = Duration.zero;
Duration position = Duration.zero;

class NewsDetailedView extends StatefulWidget {
  dynamic news = '';
  NewsDetailedView({super.key, required News news}) {
    this.news = news;
  }

  @override
  State<NewsDetailedView> createState() => _NewsDetailedViewState();
}

class _NewsDetailedViewState extends State<NewsDetailedView>
    with TickerProviderStateMixin {
  final player = AudioPlayer();
  bool isPlaying = false; // true when media is playing
  bool isBusy = false; // true when we're awaiting media
  bool isSaved = false; // true when news is saved
  Duration duration = Duration.zero;
  Duration position = Duration.zero;

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    TabController tabController = TabController(length: 2, vsync: this);
    return Scaffold(
      appBar: AppBar(
        // title: Text('${widget.news.title}'),
        automaticallyImplyLeading: false,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: const Icon(Icons.arrow_back_ios),
        ),
        // toolbarHeight: 90,
        backgroundColor: Colors.white,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Card(
          child: Column(
            children: [
              const Padding(
                padding: EdgeInsets.all(2.0),
              ),
              ListTile(
                title: Text(
                  widget.news.title,
                  style: const TextStyle(
                      fontWeight: FontWeight.bold, fontSize: 30),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(10.0),
              ),
              ClipRRect(
                  borderRadius: BorderRadius.circular(10.0),
                  child: AspectRatio(
                    aspectRatio: 16 / 10,
                    child:
                        Image.network(widget.news.imagePath, fit: BoxFit.cover),
                  )),
              const SizedBox(height: 20),
              // subtitle
              ListTile(
                subtitle: Text('Author: ' +
                    widget.news.author +
                    ' \nPublished at: ' +
                    widget.news.created),
                trailing: Wrap(
                  spacing: 0,
                  children: <Widget>[
                    IconButton(
                      icon: isBusy
                          ? Icon(Icons.arrow_downward)
                          : isPlaying
                              ? Icon(Icons.pause)
                              : Icon(Icons.play_arrow),
                      onPressed: () async {
                        if (!isBusy) {
                          if (!isPlaying) {
                            setState(() {
                              isBusy = true;
                            });
                            await player
                                .play(UrlSource(widget.news.fullBodyTts));
                            setState(() {
                              isBusy = false;
                            });
                          } else {
                            await player.pause();
                          }
                          setState(() {
                            isPlaying = !isPlaying;
                          });
                        }
                      },
                    ),
                    IconButton(
                        icon: isSaved
                            ? Icon(Icons.bookmark)
                            : Icon(Icons.bookmark_outline),
                        onPressed: () {
                          if (!isSaved) {
                            setState(() {
                              isSaved = true;
                            });
                          } else {
                            setState(() {
                              isSaved = false;
                            });
                          }
                        }),
                    // const Padding(
                    //   padding: EdgeInsets.all(12.0),
                    // ),
                  ],
                ),
              ),
              Column(
                children: [
                  SizedBox(
                    height: 45,
                    child: Card(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12)),
                      elevation: 1,
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.black.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: TabBar(
                          indicator: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: Theme.of(context).primaryColor,
                          ),
                          controller: tabController,
                          isScrollable: true,
                          labelPadding: EdgeInsets.symmetric(horizontal: 30),
                          // ignore: prefer_const_literals_to_create_immutables
                          tabs: [
                            Tab(
                              child: Text(
                                "Summary",
                                style: TextStyle(
                                    color: Color.fromARGB(255, 0, 0, 0)),
                              ),
                            ),
                            Tab(
                              child: Text(
                                "Full News",
                                style: TextStyle(color: Colors.black),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height,
                    child: TabBarView(
                      controller: tabController,
                      children: [
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                child: Text(widget.news.summary));
                          },
                        ),
                        ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: 1,
                          itemBuilder: (context, index) {
                            return Container(
                                margin: EdgeInsets.all(10),
                                padding: EdgeInsets.all(10),
                                child: Text(widget.news.description));
                          },
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
