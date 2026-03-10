import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yb_sekuritas/home/components/list_article_item.dart';
import 'package:yb_sekuritas/home/components/loading_shimmer.dart';

import 'logic.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder(
      init: HomeLogic(),
      builder: (c) {
        return Scaffold(
          appBar: AppBar(),
          body: Obx(() {
            List<String> labelFilter = ['All', 'Sports', 'Business', 'Entertainment', 'Health', 'Science', 'Technology'];
            if(c.progress.value) {
              return loadingShimmer(context);
            }

            if(c.searchController.value.text != '') {
              return Padding(
                padding: const EdgeInsets.only(bottom: 20, left: 16, right: 16),
                child: ListView(
                  children: [
                    TextFormField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(6))
                        ),
                        prefixIcon: Icon(Icons.search),
                        suffixIcon: GestureDetector(
                            onTap: () => c.clearSearch(),
                            child: Icon(Icons.close)
                        ),
                        hintText: 'Search',
                      ),
                      controller: c.searchController.value,
                    ),
                    Divider(color: Colors.transparent, height: 20,),
                    for(final article in c.search) listArticleItem(context, article,  () => c.goToDetails(article))
                  ]
                ),
              );
            }

            return Container(
              margin: EdgeInsets.only(left: 14, right: 14),
              child: SmartRefresher(
                controller: c.refreshController,
                onRefresh: c.onRefresh,
                child: SingleChildScrollView(
                  controller: c.scrollController,
                  child: Column(
                      children: [
                        TextFormField(
                          decoration: InputDecoration(
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.all(Radius.circular(6))
                            ),
                            prefixIcon: Icon(Icons.search),
                            suffixIcon: c.searchController.value.text != '' ?  GestureDetector(
                              onTap: () => c.clearSearch(),
                              child: Icon(Icons.close)
                            ) : null,
                            hintText: 'Search',
                          ),
                          controller: c.searchController.value,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Tranding', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                              // GestureDetector(
                              //     onTap: () {},
                              //     child: Text('See all', style: TextStyle(fontSize: 14, color: Colors.grey),)
                              // ),
                            ],
                          ),
                        ),
                        if(c.trandings.isNotEmpty) Container(
                          margin: EdgeInsets.symmetric(horizontal: 4),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Container(
                                height: MediaQuery.of(context).size.width/1.8,
                                decoration: BoxDecoration(
                                  color: Colors.grey.shade200,
                                  borderRadius: BorderRadius.all(Radius.circular(8)),
                                  image: DecorationImage(
                                      image: NetworkImage(c.trandings.first.urlToImage!,),
                                      fit: BoxFit.fitHeight
                                  ),
                                ),
                                child: Image.network(c.trandings.first.urlToImage!,
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
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 4),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(c.trandings.first.source!['name'] ?? '',
                                      style: TextStyle(color: Colors.grey, fontSize: 14, fontWeight: FontWeight.bold),
                                    ),
                                    Text(DateFormat('dd MMMM').format(DateTime.parse(c.trandings.first.publishedAt!)).toString(),
                                        style: TextStyle(color: Colors.grey, fontSize: 14,)
                                    ),
                                  ],
                                ),
                              ),
                              Text(c.trandings.first.title ?? '')
                            ],
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 14),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('Latest', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
                              // GestureDetector(
                              //     onTap: () {},
                              //     child: Text('See all', style: TextStyle(fontSize: 14, color: Colors.grey),)
                              // ),
                            ],
                          ),
                        ),
                        Container(
                          alignment: Alignment.centerLeft,
                          height: 34,
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            shrinkWrap: true,
                            physics: ClampingScrollPhysics(),
                            itemCount: labelFilter.length,
                            itemBuilder: (ctx, idx) {
                              String label = labelFilter[idx];
                              bool active = c.labelFilterActive.value == label.toLowerCase();
                              return GestureDetector(
                                onTap: () => c.selectFilter(label),
                                child: Container(
                                  padding: EdgeInsets.symmetric(horizontal: 12),
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      border: active ? Border(
                                          bottom: BorderSide(color: Color(0xFF1877F2))
                                      ) : null,
                                      borderRadius: BorderRadius.all(Radius.circular(4))
                                  ),
                                  child: Text(label,
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: active ? FontWeight.bold : FontWeight.normal
                                    ),),
                                ),
                              );
                            },
                          ),
                        ),
                        if(c.all.isNotEmpty && c.labelFilterActive.value == 'all')
                          for(final article in c.all) listArticleItem(context, article, () => c.goToDetails(article)),
                        if(c.sports.isNotEmpty && c.labelFilterActive.value == 'sports')
                          for(final article in c.sports) listArticleItem(context, article, () => c.goToDetails(article)),
                        if(c.business.isNotEmpty && c.labelFilterActive.value == 'business')
                          for(final article in c.business) listArticleItem(context, article, () => c.goToDetails(article)),
                        if(c.entertainment.isNotEmpty && c.labelFilterActive.value == 'entertainment')
                          for(final article in c.entertainment) listArticleItem(context, article, () => c.goToDetails(article)),
                        if(c.health.isNotEmpty && c.labelFilterActive.value == 'health')
                          for(final article in c.health) listArticleItem(context, article, () => c.goToDetails(article)),
                        if(c.science.isNotEmpty && c.labelFilterActive.value == 'science')
                          for(final article in c.science) listArticleItem(context, article, () => c.goToDetails(article)),
                        if(c.technology.isNotEmpty && c.labelFilterActive.value == 'technology')
                          for(final article in c.technology) listArticleItem(context, article, () => c.goToDetails(article)),
                      ]
                  ),
                ),
              ),
            );
          }),
        );
      }
    );
  }
}
