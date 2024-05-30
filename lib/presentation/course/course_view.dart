import 'package:knack_admin/presentation/style/text_style.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter/material.dart';
import 'package:knack_admin/Domain/model/course_model.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

class CourseViewScreen extends StatefulWidget {
  final CourseModel course;

  const CourseViewScreen({Key? key, required this.course}) : super(key: key);

  @override
  _CourseViewScreenState createState() => _CourseViewScreenState();
}

class _CourseViewScreenState extends State<CourseViewScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollForward() {
    final maxScrollExtent = _scrollController.position.maxScrollExtent;
    final currentPosition = _scrollController.position.pixels;
    final scrollAmount = maxScrollExtent * 0.2;

    if (currentPosition + scrollAmount <= maxScrollExtent) {
      _scrollController.animateTo(
        currentPosition + scrollAmount,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        maxScrollExtent,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollBackward() {
    final currentPosition = _scrollController.position.pixels;
    final scrollAmount = _scrollController.position.maxScrollExtent *
        0.2; // Adjust scroll amount as needed

    if (currentPosition - scrollAmount >= 0) {
      _scrollController.animateTo(
        currentPosition - scrollAmount,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      _scrollController.animateTo(
        0,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    }
  }

  void _downloadDocument(String document) async {
    Uri url = Uri.parse(document);

    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.course.title, style: TextStyle(color: Colors.white)),
        backgroundColor: Colors.green,
      ),
      body: SingleChildScrollView(
        padding:
            EdgeInsets.symmetric(vertical: 20.0, horizontal: screenWidth / 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildCourseHeader(screenWidth),
            SizedBox(height: 20.0),
            _buildSectionTitle('Chapters and Videos:', context),
            SizedBox(height: 20.0),
            _buildChaptersAndVideosList(),
            SizedBox(height: 20.0),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: _scrollBackward,
                ),
                IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: _scrollForward,
                ),
              ],
            ),
            SizedBox(height: 20.0),
            Container(
              width: screenWidth / 3,
              child: ElevatedButton(
                onPressed: () {
                  _downloadDocument(widget.course.document);
                },
                child: Text(
                  'Download Course Document',
                  style: t1.copyWith(color: Colors.green),
                ),
                style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 0, 0, 0)),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCourseHeader(width) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.green.withOpacity(.2),
          borderRadius: BorderRadius.circular(15)),
      width: width - width / 12,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Image.network(
                widget.course.photo,
                fit: BoxFit.contain,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: 16),
              Container(
                child: Text(
                  widget.course.title,
                  maxLines: 2,
                  style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 500,
                child: Text(
                  widget.course.overview,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              SizedBox(height: 8),
              Container(
                width: 500,
                child: Text(
                  "Amount : ${widget.course.amount}",
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.bold,
                      color: Colors.black),
                  textAlign: TextAlign.start,
                  maxLines: 5,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildCourseDetails(BuildContext context) {
    return Container(
      width: 400,
      padding: EdgeInsets.all(16.0),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 16.0),
              child: _buildSectionTitle('Amount:', context),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16.0),
              child: Text(
                widget.course.amount,
                style: TextStyle(fontSize: 16, color: Colors.black),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title, BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontSize: 20.0,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildChaptersAndVideosList() {
    return Container(
      height: 350,
      child: ListView.builder(
        controller: _scrollController,
        scrollDirection: Axis.horizontal,
        itemCount: widget.course.chapters.length,
        itemBuilder: (context, index) {
          return _buildChapterVideoCard(index);
        },
      ),
    );
  }

  Widget _buildChapterVideoCard(int index) {
    return FutureBuilder<String>(
      future: fetchThumbnailUrl(widget.course.videos[index]),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError || !snapshot.hasData) {
          return Center(
              child: Text('Error loading thumbnail',
                  style: TextStyle(color: Colors.red)));
        } else {
          return GestureDetector(
            onTap: () async {
              final String youtubeLink = widget.course.videos[index];
              if (await canLaunchUrl(Uri.parse(youtubeLink))) {
                await launchUrl(Uri.parse(youtubeLink));
              } else {
                throw 'Could not launch $youtubeLink';
              }
            },
            child: Container(
              width: 300,
              margin: EdgeInsets.only(right: 16.0),
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15)),
                elevation: 5,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ClipRRect(
                      borderRadius:
                          BorderRadius.vertical(top: Radius.circular(15)),
                      child: Image.network(
                        snapshot.data ?? '',
                        height: 150,
                        width: 300,
                        fit: BoxFit.cover,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.course.videos[index],
                            style: TextStyle(
                                color: Colors.black87,
                                fontSize: 14,
                                fontWeight: FontWeight.w600),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            '${index + 1}. ${widget.course.chapters[index]}',
                            style: TextStyle(
                                color: Colors.green,
                                fontSize: 12,
                                fontWeight: FontWeight.normal),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          SizedBox(height: 4),
                          Text(
                            widget.course.description[index],
                            style:
                                TextStyle(color: Colors.black54, fontSize: 12),
                            maxLines: 2,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        }
      },
    );
  }

  Future<String> fetchThumbnailUrl(String youtubeLink) async {
    final String videoId = _extractVideoId(youtubeLink);
    if (videoId.isEmpty) return '';

    final String apiKey = 'AIzaSyDXZocWHPCFa-PvXqN7tR6UbprBGqoT03c';
    final String apiUrl =
        'https://www.googleapis.com/youtube/v3/videos?id=$videoId&key=$apiKey&part=snippet';

    final response = await http.get(Uri.parse(apiUrl));
    if (response.statusCode == 200) {
      final jsonResponse = jsonDecode(response.body);
      final String thumbnailUrl =
          jsonResponse['items'][0]['snippet']['thumbnails']['default']['url'];
      return thumbnailUrl;
    } else {
      throw Exception('Failed to load video details');
    }
  }

  String _extractVideoId(String url) {
    final RegExp regExp = RegExp(
        r'(?:youtube\.com/(?:[^/]+/.+/|(?:v|e(?:mbed)?)/|.*[?&]v=)|youtu\.be/)([^"&?/ ]{11})');
    final RegExpMatch? match = regExp.firstMatch(url);
    return match?.group(1) ?? '';
  }
}
