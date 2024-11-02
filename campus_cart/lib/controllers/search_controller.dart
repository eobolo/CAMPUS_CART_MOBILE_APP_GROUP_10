import 'package:get/get.dart';

class AllSearchController extends GetxController {
  RxList recentSearches = ["pizza", "burger"].obs;
  var searchResults = <Map<Object?, Object?>>[].obs;
}
