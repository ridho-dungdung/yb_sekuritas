import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import 'logic.dart';

class ArticleDetailsPage extends StatelessWidget {
  const ArticleDetailsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: ArticleDetailsLogic(),
      builder: (c) => Scaffold(
        appBar: AppBar(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(c.article.value.source!['name']),
              Text(DateFormat('dd MMMM').format(DateTime.parse(c.article.value.publishedAt!)).toString(),
                style: TextStyle(fontSize: 12, color: Colors.grey),
              ),
            ],
          ),
          actions: [
            IconButton(
              onPressed: () => c.urlLauncher,
              icon: Icon(Icons.share_outlined, size: 22,)
            ),
            IconButton(
              onPressed: () {
                Get.snackbar(
                  'Coming soon',
                  '',
                  colorText: Colors.white,
                  backgroundColor: Colors.blue.shade600,
                  forwardAnimationCurve: Curves.elasticInOut,
                  reverseAnimationCurve: Curves.easeOut,
                );
              },
              icon: Icon(Icons.more_vert, size: 26,)
            )
          ],
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: MediaQuery.of(context).size.width/1.2,
                  margin: EdgeInsets.only(bottom: 16),
                  decoration: BoxDecoration(
                    color: Colors.grey.shade200,
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    image: DecorationImage(
                        image: NetworkImage(c.article.value.urlToImage ?? 'https://placehold.co/',),
                        fit: BoxFit.fitHeight
                    ),
                  ),
                  child: Image.network(c.article.value.urlToImage ?? 'https://placehold.co/',
                    fit: BoxFit.fitHeight,
                    loadingBuilder: (BuildContext context, Widget child, ImageChunkEvent? loadingProgress) {
                      if (loadingProgress == null) {
                        return Container(
                          color: Colors.transparent,
                        );
                      }
                      return Center(
                        child: CircularProgressIndicator(
                          value: loadingProgress.expectedTotalBytes != null
                              ? loadingProgress.cumulativeBytesLoaded / loadingProgress.expectedTotalBytes!
                              : null,
                        ),
                      );
                    },
                  ),
                ),
                Text(c.article.value.title ?? '', style: TextStyle(fontSize: 24, color: Colors.black),),
                Divider(height: 14, color: Colors.transparent,),
                Text(c.article.value.description ?? '', style: TextStyle(fontSize: 16, color: Colors.grey.shade800),)
              ],
            ),
          ),
        ),
      )
    );
  }
}
