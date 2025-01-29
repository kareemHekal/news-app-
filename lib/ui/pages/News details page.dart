import 'package:flutter/material.dart';
import 'package:news_app/models/newDataResponce.dart';
import 'package:url_launcher/url_launcher.dart';

class NewsDetailsPage extends StatelessWidget {
  Articles article;

  NewsDetailsPage({required this.article, super.key});
  Future<void> _launchUrl() async {
    final Uri _url = Uri.parse(article.url??"");
    if (!await launchUrl(_url)) {
      throw Exception('Could not launch $_url');
    }
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
          color: Colors.white,
          image:
              DecorationImage(image: AssetImage("assets/images/pattern.png"))),
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.white),
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(25)),
          centerTitle: true,
          toolbarHeight: 100,
          backgroundColor: Colors.green,
          title: Text(
            article.title ?? "",
            style: const TextStyle(
                color: Colors.white, fontSize: 30, fontWeight: FontWeight.w300),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                child: article.urlToImage != null &&
                        article.urlToImage!.isNotEmpty
                    ? Image.network(
                        article.urlToImage!,
                        height: 200,
                        width: double.infinity,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          return Container(
                            height: 200,
                            width: double.infinity,
                            color: Colors.grey[300],
                            alignment: Alignment.center,
                            child: const Text(
                              'Image Load Failed',
                              style: TextStyle(
                                color: Colors.black54,
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                              ),
                            ),
                          );
                        },
                      )
                    : Container(
                        height: 200,
                        width: double.infinity,
                        color: Colors.grey[300],
                        alignment: Alignment.center,
                        child: const Text(
                          'No Image Available',
                          style: TextStyle(
                            color: Colors.black54,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  textAlign: TextAlign.start,
                  article.author ?? "",
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Text(
                  textAlign: TextAlign.start,
                  article.title ?? "",
                  style: const TextStyle(
                      fontSize: 15, fontWeight: FontWeight.w700),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  article.publishedAt != null &&
                          article.publishedAt!.length >= 10
                      ? article.publishedAt!.substring(0, 10)
                      : article.publishedAt ?? "",
                  textAlign: TextAlign.end,
                  style: const TextStyle(
                      fontSize: 10, fontWeight: FontWeight.w400),
                ),
              ),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: Card(
                  color: Colors.grey[300],
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: SingleChildScrollView(
                          child: Text(
                            article.content ?? "",
                            textAlign: TextAlign.start,
                            style: const TextStyle(
                                fontSize: 15, fontWeight: FontWeight.w400),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 50,
                      ),
                       GestureDetector(
                        onTap: () {
                          _launchUrl();
                        },
                        child: const Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text("View Full Article"),
                            SizedBox(
                              width: 5,
                            ),
                            Icon(Icons.play_arrow,color: Colors.black,)
                            ,SizedBox(
                              width: 5,
                            ),
                          ],
                        ),

                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
