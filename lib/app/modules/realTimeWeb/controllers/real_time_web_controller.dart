import 'package:get/get.dart';
import 'package:chatsy/app/helper/all_imports.dart';

class RealTimeWebController extends GetxController {
  // Real-time search functionality
  final searchQuery = ''.obs;
  final searchResults = <Map<String, dynamic>>[].obs;
  final isLoading = false.obs;
  final selectedCategory = 'All'.obs;

  // Real-time categories
  final categories = [
    'All',
    'News',
    'Weather', 
    'Sports',
    'Technology',
    'Finance',
    'Health',
    'Entertainment'
  ].obs;

  @override
  void onInit() {
    super.onInit();
    // Initialize with trending topics
    loadTrendingTopics();
  }

  @override
  void onReady() {
    super.onReady();
  }

  @override
  void onClose() {
    super.onClose();
  }

  // Load trending topics for real-time search
  void loadTrendingTopics() {
    searchResults.value = [
      {
        'title': 'Breaking News',
        'description': 'Latest breaking news from around the world',
        'category': 'News',
        'timestamp': DateTime.now().toIso8601String(),
      },
      {
        'title': 'Weather Updates',
        'description': 'Current weather conditions and forecasts',
        'category': 'Weather',
        'timestamp': DateTime.now().toIso8601String(),
      },
      {
        'title': 'Tech Updates',
        'description': 'Latest technology news and developments',
        'category': 'Technology',
        'timestamp': DateTime.now().toIso8601String(),
      },
    ];
  }

  // Perform real-time search
  void performRealTimeSearch(String query) {
    if (query.isEmpty) return;
    
    searchQuery.value = query;
    isLoading.value = true;
    
    // Simulate real-time search (replace with actual API call)
    Future.delayed(Duration(seconds: 1), () {
      searchResults.value = [
        {
          'title': 'Real-time results for: $query',
          'description': 'Latest information about $query',
          'category': selectedCategory.value,
          'timestamp': DateTime.now().toIso8601String(),
          'source': 'Real-time Web Search',
        },
      ];
      isLoading.value = false;
    });
  }

  // Filter results by category
  void filterByCategory(String category) {
    selectedCategory.value = category;
    if (category == 'All') {
      loadTrendingTopics();
    } else {
      // Filter results by category
      searchResults.value = searchResults
          .where((result) => result['category'] == category)
          .toList();
    }
  }

  // Clear search
  void clearSearch() {
    searchQuery.value = '';
    searchResults.clear();
    loadTrendingTopics();
  }
}
