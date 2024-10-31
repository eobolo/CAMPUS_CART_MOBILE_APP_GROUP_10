import 'package:get/get.dart';

class AllSearchController extends GetxController {
  RxString query = "".obs;
  RxList recentSearches = ["pizza", "burger"].obs;
  var searchResults = <Map<Object?, Object?>>[].obs;
}
