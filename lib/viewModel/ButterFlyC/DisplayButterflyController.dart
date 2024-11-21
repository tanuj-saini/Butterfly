import 'package:email_app/Models/ButterflyModel.dart';
import 'package:email_app/Repositry/ButterflyRepositry.dart';
import 'package:get/get.dart';

class DisplayButterflyController extends GetxController {
  final ButterflyRepository repository;
  DisplayButterflyController(this.repository);

  final butterflies = <Butterfly>[].obs;
  final filteredButterflies = <Butterfly>[].obs;
  final page = 1.obs;
  final isLoading = false.obs;
  final hasMore = true.obs;
  final searchQuery = ''.obs;
  final int limit = 20;

  @override
  void onInit() {
    super.onInit();
    searchQuery.value = '';
    fetchButterflies();

    ever(searchQuery, (_) => filterButterflies());
  }

  void filterButterflies() {
    if (searchQuery.value.isEmpty) {
      filteredButterflies.value = butterflies;
    } else {
      filteredButterflies.value = butterflies.where((butterfly) {
        final name = butterfly.name?.toLowerCase() ?? '';
        final scientificName = butterfly.scientificName?.toLowerCase() ?? '';
        final query = searchQuery.value.toLowerCase();
        return name.contains(query) || scientificName.contains(query);
      }).toList();
    }
  }

  void updateSearchQuery(String query) {
    searchQuery.value = query;
  }

  Future<void> fetchButterflies() async {
    if (isLoading.value || !hasMore.value) return;

    isLoading.value = true;
    try {
      final fetchedButterflies =
          await repository.fetchButterflies(page.value, limit);

      if (fetchedButterflies.isNotEmpty) {
        butterflies.addAll(fetchedButterflies);
        filterButterflies(); // Update filtered results
        page.value += 1;
      } else {
        hasMore.value = false;
      }
    } catch (e) {
      print('Error fetching butterflies: $e');
    } finally {
      isLoading.value = false;
    }
  }
}
