import '../../../helper/all_imports.dart';
import '../../../service/tavily_service.dart';

class RealTimeWebController extends GetxController {
  // Enhanced Real-time Web Search Controller with Tavily Integration
  
  // Observable variables
  RxString searchQuery = "".obs;
  RxList<Map<String, dynamic>> searchResults = <Map<String, dynamic>>[].obs;
  RxBool isLoading = false.obs;
  RxString selectedCategory = "all".obs;
  RxString searchStatus = "Ready to search".obs;
  RxInt totalResults = 0.obs;
  
  // Categories for filtering
  final List<String> categories = [
    "all",
    "news",
    "technology",
    "science",
    "business",
    "entertainment",
    "sports",
    "health",
    "politics",
    "world"
  ];
  
  // Search history
  RxList<String> searchHistory = <String>[].obs;
  RxList<Map<String, dynamic>> trendingTopics = <Map<String, dynamic>>[].obs;
  
  @override
  void onInit() {
    super.onInit();
    _initializeRealTimeWeb();
  }
  
  void _initializeRealTimeWeb() {
    printAction("🌐 Real-time Web: Initializing enhanced search functionality...");
    _loadTrendingTopics();
    _loadSearchHistory();
    printAction("✅ Real-time Web: Ready for real-time search with Tavily");
  }
  
  // Load trending topics on initialization
  void loadTrendingTopics() async {
    try {
      isLoading.value = true;
      searchStatus.value = "Loading trending topics...";
      
      // Get trending topics from Tavily
      final topics = await TavilyService.getTrendingTopics();
      
      if (topics.isNotEmpty) {
        trendingTopics.value = topics;
        searchResults.value = topics;
        totalResults.value = topics.length;
        printAction("✅ Real-time Web: ${topics.length} trending topics loaded");
      } else {
        // Fallback to default topics
        _loadDefaultTrendingTopics();
      }
      
      isLoading.value = false;
      searchStatus.value = "Ready to search";
      
    } catch (e) {
      printAction("❌ Real-time Web: Error loading trending topics - $e");
      _loadDefaultTrendingTopics();
      isLoading.value = false;
      searchStatus.value = "Ready to search";
    }
  }
  
  void _loadDefaultTrendingTopics() {
    trendingTopics.value = [
      {
        "title": "Latest AI Developments",
        "description": "Recent breakthroughs in artificial intelligence technology",
        "url": "https://example.com/ai-news",
        "category": "technology",
        "timestamp": DateTime.now().subtract(Duration(minutes: 5)),
        "isRealTime": true,
        "source": "Tech News",
        "relevanceScore": 0.95,
      },
      {
        "title": "Market Updates",
        "description": "Current financial market trends and analysis",
        "url": "https://example.com/market",
        "category": "business",
        "timestamp": DateTime.now().subtract(Duration(minutes: 10)),
        "isRealTime": true,
        "source": "Financial Times",
        "relevanceScore": 0.88,
      },
      {
        "title": "Climate Change Report",
        "description": "Latest findings on global climate patterns",
        "url": "https://example.com/climate",
        "category": "science",
        "timestamp": DateTime.now().subtract(Duration(minutes: 15)),
        "isRealTime": true,
        "source": "Science Daily",
        "relevanceScore": 0.92,
      },
    ];
    searchResults.value = trendingTopics.value;
    totalResults.value = trendingTopics.length;
  }
  
  // Perform real-time search with Tavily
  Future<void> performRealTimeSearch(String query) async {
    if (query.trim().isEmpty) return;
    
    try {
      isLoading.value = true;
      searchQuery.value = query;
      searchStatus.value = "Searching for '$query'...";
      
      printAction("🔍 Real-time Web: Searching for '$query' with Tavily");
      
      // Add to search history
      _addToSearchHistory(query);
      
      // Perform search with Tavily
      final results = await TavilyService.searchWeb(
        query: query,
        category: selectedCategory.value == "all" ? null : selectedCategory.value,
        maxResults: 10,
        includeAnswer: true,
        includeImages: true,
        includeRawContent: false,
      );
      
      if (results.isNotEmpty) {
        searchResults.value = results;
        totalResults.value = results.length;
        searchStatus.value = "Found ${results.length} results for '$query'";
        printAction("✅ Real-time Web: Found ${results.length} results for '$query'");
      } else {
        searchStatus.value = "No results found for '$query'";
        printAction("⚠️ Real-time Web: No results found for '$query'");
      }
      
    } catch (e) {
      printAction("❌ Real-time Web: Error performing search - $e");
      searchStatus.value = "Search failed: $e";
      utils.showSnackBar("Search failed: $e");
    } finally {
      isLoading.value = false;
    }
  }
  
  // Perform advanced search with filters
  Future<void> performAdvancedSearch({
    required String query,
    String? category,
    String? timeRange,
    String? language,
    bool includeImages = true,
    bool includeAnswer = true,
  }) async {
    try {
      isLoading.value = true;
      searchQuery.value = query;
      searchStatus.value = "Performing advanced search...";
      
      printAction("🔍 Real-time Web: Advanced search for '$query'");
      
      final results = await TavilyService.searchWeb(
        query: query,
        category: category,
        maxResults: 20,
        includeAnswer: includeAnswer,
        includeImages: includeImages,
        includeRawContent: false,
      );
      
      if (results.isNotEmpty) {
        searchResults.value = results;
        totalResults.value = results.length;
        searchStatus.value = "Advanced search completed";
        printAction("✅ Real-time Web: Advanced search completed");
      }
      
    } catch (e) {
      printAction("❌ Real-time Web: Error in advanced search - $e");
      searchStatus.value = "Advanced search failed";
    } finally {
      isLoading.value = false;
    }
  }
  
  // Filter results by category
  void filterByCategory(String category) {
    selectedCategory.value = category;
    printAction("🔍 Real-time Web: Filtering by category: $category");
    
    if (category == "all") {
      searchResults.value = trendingTopics.value;
    } else {
      searchResults.value = trendingTopics.where((result) {
        return result["category"] == category;
      }).toList();
    }
    
    totalResults.value = searchResults.length;
  }
  
  // Clear search results
  void clearSearch() {
    searchQuery.value = "";
    searchResults.value = trendingTopics.value;
    selectedCategory.value = "all";
    totalResults.value = trendingTopics.length;
    searchStatus.value = "Ready to search";
    printAction("🧹 Real-time Web: Search cleared");
  }
  
  // Add query to search history
  void _addToSearchHistory(String query) {
    if (!searchHistory.contains(query)) {
      searchHistory.insert(0, query);
      if (searchHistory.length > 10) {
        searchHistory.removeLast();
      }
    }
  }
  
  // Load search history from storage
  void _loadSearchHistory() {
    try {
      final history = getStorageData.readStringList('search_history') ?? [];
      searchHistory.value = history;
    } catch (e) {
      printAction("❌ Real-time Web: Error loading search history - $e");
    }
  }
  
  // Save search history to storage
  void _saveSearchHistory() {
    try {
      getStorageData.saveStringList('search_history', searchHistory);
    } catch (e) {
      printAction("❌ Real-time Web: Error saving search history - $e");
    }
  }
  
  // Clear search history
  void clearSearchHistory() {
    searchHistory.clear();
    getStorageData.removeData('search_history');
    printAction("🧹 Real-time Web: Search history cleared");
  }
  
  // Get filtered results
  List<Map<String, dynamic>> getFilteredResults() {
    if (selectedCategory.value == "all") {
      return searchResults;
    }
    
    return searchResults.where((result) {
      return result["category"] == selectedCategory.value;
    }).toList();
  }
  
  // Check if result is recent (within last hour)
  bool isRecentResult(Map<String, dynamic> result) {
    final timestamp = result["timestamp"] as DateTime;
    final now = DateTime.now();
    return now.difference(timestamp).inHours < 1;
  }
  
  // Get result age in human readable format
  String getResultAge(Map<String, dynamic> result) {
    final timestamp = result["timestamp"] as DateTime;
    final now = DateTime.now();
    final difference = now.difference(timestamp);
    
    if (difference.inMinutes < 1) {
      return "Just now";
    } else if (difference.inMinutes < 60) {
      return "${difference.inMinutes}m ago";
    } else if (difference.inHours < 24) {
      return "${difference.inHours}h ago";
    } else {
      return "${difference.inDays}d ago";
    }
  }
  
  // Get relevance score color
  Color getRelevanceColor(double score) {
    if (score >= 0.9) return AppColors.success;
    if (score >= 0.7) return AppColors.warning;
    if (score >= 0.5) return AppColors.accent;
    return AppColors.error;
  }
  
  // Refresh search results
  Future<void> refreshResults() async {
    if (searchQuery.value.isNotEmpty) {
      await performRealTimeSearch(searchQuery.value);
    } else {
      await loadTrendingTopics();
    }
  }
  
  @override
  void onClose() {
    _saveSearchHistory();
    super.onClose();
  }
}