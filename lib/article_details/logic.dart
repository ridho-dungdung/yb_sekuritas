import 'package:get/get.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:yb_sekuritas/models/article_model.dart';

class ArticleDetailsLogic extends GetxController {
  Rx<Article> article = Article().obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    article.value = Get.arguments;
  }

  void urlLauncher() async {
    Uri url = Uri.parse(article.value.url!);
    if (!await launchUrl(url)) {
    throw Exception('Could not launch $url');
    }
  }
}
