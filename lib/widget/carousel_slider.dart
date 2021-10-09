import 'package:flutter/material.dart';
import 'package:flutter03/model/model_movie.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselImage extends StatefulWidget {
  final List<Movie> movies;
  CarouselImage({required this.movies});
  @override
  _CarouselImageState createState() => _CarouselImageState();
}

class _CarouselImageState extends State<CarouselImage> {
  late List<Movie> movies;
  late List<Widget> images;
  late List<String> keywords;
  late List<bool> likes;
  int _currentPage = 0;
  late String _currentKeyword;

  @override
  void initState() {
    super.initState();
    movies = widget.movies;
    images = movies.map((m) => Image.asset('./images/' + m.poster)).toList();
    keywords = movies.map((m) => m.keyword).toList();
    likes = movies.map((m) => m.like).toList();
    _currentKeyword = keywords[0];
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(20),
        ),
        CarouselSlider(
          items: images,
          options: CarouselOptions(onPageChanged: (index, reason) {
            setState(() {
              _currentPage = index;
              _currentKeyword = keywords[_currentPage];
            });
          }),
        ),
        Container(
          padding: const EdgeInsets.fromLTRB(0, 10, 0, 3),
          child: Text(_currentKeyword, style: TextStyle(fontSize: 12)),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Column(
              children: [
                likes[_currentPage]
                    ? IconButton(onPressed: () {}, icon: Icon(Icons.check))
                    : IconButton(onPressed: () {}, icon: Icon(Icons.add)),
                const Text(
                  '내가 찜한 콘텐츠',
                  style: TextStyle(fontSize: 11),
                )
              ],
            ),
            Container(
              padding: EdgeInsets.only(right: 10),
              child: FlatButton(
                color: Colors.white,
                onPressed: () {},
                child: Row(
                  children: [
                    Icon(
                      Icons.play_arrow,
                      color: Colors.black,
                    ),
                    Padding(
                      padding: EdgeInsets.all(3),
                    ),
                    Text(
                      '재생',
                      style: TextStyle(color: Colors.black),
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: const EdgeInsets.only(right: 10),
              child: Column(
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.info),
                  ),
                  const Text(
                    '정보',
                    style: TextStyle(fontSize: 11),
                  ),
                ],
              ),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: makeIndicator(likes, _currentPage),
        ),
      ],
    );
  }
}

List<Widget> makeIndicator(List list, int _currentPage) {
  List<Widget> result = [];
  for (var i = 0; i < list.length; i++) {
    result.add(Container(
      width: 8,
      height: 8,
      margin: const EdgeInsets.symmetric(vertical: 10.0, horizontal: 2.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == i
            ? const Color.fromRGBO(255, 255, 255, 0.9)
            : const Color.fromRGBO(255, 255, 255, 0.4),
      ),
    ));
  }

  return result;
}
