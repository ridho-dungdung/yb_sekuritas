import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:yb_sekuritas/article_details/view.dart';
import 'package:yb_sekuritas/models/article_model.dart';
import 'package:yb_sekuritas/services.dart';

class HomeLogic extends GetxController {
  RxList<Article> trandings = <Article>[].obs;
  RxList<Article> all = <Article>[].obs;
  RxList<Article> sports = <Article>[].obs;
  RxList<Article> business = <Article>[].obs;
  RxList<Article> entertainment = <Article>[].obs;
  RxList<Article> health = <Article>[].obs;
  RxList<Article> science = <Article>[].obs;
  RxList<Article> technology = <Article>[].obs;
  RxList<Article> search = <Article>[].obs;
  Rx<TextEditingController> searchController = TextEditingController().obs;
  RxString labelFilterActive = 'all'.obs;
  RxBool progress = true.obs;

  final ScrollController scrollController = ScrollController();
  RefreshController refreshController = RefreshController(
    initialRefresh: false,
  );

  @override
  void onInit() async {
    // TODO: implement onInit
    super.onInit();
    onRefresh();

    searchController.value.addListener(onSearch);
  }

  void onSearch() async {
    try{
      String keyword = searchController.value.text;
      await DioClient().get('https://newsapi.org/v2/everything?q=$keyword&apiKey=5497d4d2f46d4c4491b09dc7d77ac6fa')
          .then((res) => search.value = List.from(res['articles'].map((json) => Article.fromJson(json))));
      update();
    } catch(err) {
      print(err);
    }
  }

  void clearSearch() {
    searchController.value = TextEditingController(text: '');
  }

  void onRefresh() async {
    try{
      await Future.wait([
        DioClient().get('top-headlines?country=us&apiKey=5497d4d2f46d4c4491b09dc7d77ac6fa'),
        DioClient().get('top-headlines?country=us&category=general&apiKey=5497d4d2f46d4c4491b09dc7d77ac6fa'),
        DioClient().get('top-headlines?country=us&category=sports&apiKey=5497d4d2f46d4c4491b09dc7d77ac6fa'),
        DioClient().get('top-headlines?country=us&category=business&apiKey=5497d4d2f46d4c4491b09dc7d77ac6fa'),
        DioClient().get('top-headlines?country=us&category=entertainment&apiKey=5497d4d2f46d4c4491b09dc7d77ac6fa'),
        DioClient().get('top-headlines?country=us&category=health&apiKey=5497d4d2f46d4c4491b09dc7d77ac6fa'),
        DioClient().get('top-headlines?country=us&category=science&apiKey=5497d4d2f46d4c4491b09dc7d77ac6fa'),
        DioClient().get('top-headlines?country=us&category=technology&apiKey=5497d4d2f46d4c4491b09dc7d77ac6fa'),
      ]).then((res) {
        print('COGSS ${res[0]}');
        trandings.value = List.from(res[0]['articles'].map((json) => Article.fromJson(json)));
        all.value = List.from(res[1]['articles'].map((json) => Article.fromJson(json)));
        sports.value = List.from(res[2]['articles'].map((json) => Article.fromJson(json)));
        business.value = List.from(res[3]['articles'].map((json) => Article.fromJson(json)));
        entertainment.value = List.from(res[4]['articles'].map((json) => Article.fromJson(json)));
        health.value = List.from(res[5]['articles'].map((json) => Article.fromJson(json)));
        science.value = List.from(res[6]['articles'].map((json) => Article.fromJson(json)));
        technology.value = List.from(res[7]['articles'].map((json) => Article.fromJson(json)));
      });
    } catch (err) {
      print(err);
      progress.value = false;
    } finally {
      progress.value = false;
  }

    refreshController.refreshCompleted();
  }

  void selectFilter(String label) {
    labelFilterActive.value = label.toLowerCase();
    update();
  }

  void goToDetails(Article article) {
    Get.to(ArticleDetailsPage(),
      transition: Transition.rightToLeft,
      arguments: article
    );
  }
}
