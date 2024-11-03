import 'package:get/get.dart';

class AllSearchController extends GetxController {
  RxList recentSearches = [].obs;
  var searchResults = <Map<Object?, Object?>>[].obs;

  void reset() {
    recentSearches.value = [];
    searchResults.value = [];
  }
}
