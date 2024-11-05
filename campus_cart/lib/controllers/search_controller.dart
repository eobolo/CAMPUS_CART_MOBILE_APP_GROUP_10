import 'package:get/get.dart';

class AllSearchController extends GetxController {
  RxList recentSearches = [].obs;
  var searchResults = <Map<Object?, Object?>>[].obs;
  var allKitchenSearchResults = <Map<Object?, Object?>>[].obs;
  var mealDealsSearchResults = <Map<Object?, Object?>>[].obs;

  void reset() {
    recentSearches.clear();
    searchResults.clear();
    allKitchenSearchResults.clear();
    mealDealsSearchResults.clear();
  }
}
