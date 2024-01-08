import 'package:get/get.dart';
import 'package:mitsubishi_app/model/family.dart';

import '../../service/api_service.dart';



class FamilyController extends GetxController {
  var families = <Home>[].obs;
  final ApiService _apiService = ApiService();

  @override
  void onInit() {
    super.onInit();
    fetchFamilies();
  }

  void fetchFamilies() async {
    try {
      final List<Home> fetchedFamilies = await _apiService.getfamily();
      families.value = fetchedFamilies;
    } catch (e) {
      print('Error fetching families: $e');
      // Handle the error as needed
    }
  }
}