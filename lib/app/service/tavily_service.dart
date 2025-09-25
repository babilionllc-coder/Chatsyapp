import 'dart:convert';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:http/http.dart' as http;

class TavilyService {
  static const String _baseUrl = 'https://api.tavily.com';
  static const String _apiKey = Constants.tavilyApiKey;
  
  // Search web with Tavily API
  static Future<List<Map<String, dynamic>>> searchWeb({
    required String query,
    String? category,
    int maxResults = 10,
    bool includeAnswer = true,
    bool includeImages = true,
    bool includeRawContent = false,
    String? timeRange,
    String? language,
  }) async {
    try {
      printAction("🔍 TavilyService: Searching web for '$query'");
      
      final uri = Uri.parse('$_baseUrl/search');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      };
      
      final body = {
        'query': query,
        'search_depth': 'basic',
        'include_answer': includeAnswer,
        'include_images': includeImages,
        'include_raw_content': includeRawContent,
        'max_results': maxResults,
        'include_domains': [],
        'exclude_domains': [],
      };
      
      if (category != null && category != 'all') {
        body['category'] = category;
      }
      
      if (timeRange != null) {
        body['time_range'] = timeRange;
      }
      
      if (language != null) {
        body['language'] = language;
      }
      
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = <Map<String, dynamic>>[];
        
        if (data['results'] != null) {
          for (final result in data['results']) {
            results.add({
              'title': result['title'] ?? '',
              'description': result['content'] ?? '',
              'url': result['url'] ?? '',
              'category': category ?? 'general',
              'timestamp': DateTime.now(),
              'isRealTime': true,
              'source': _extractDomain(result['url'] ?? ''),
              'relevanceScore': result['score'] ?? 0.5,
              'image': result['image'] ?? '',
            });
          }
        }
        
        printAction("✅ TavilyService: Found ${results.length} results for '$query'");
        return results;
        
      } else {
        printAction("❌ TavilyService: API Error ${response.statusCode}: ${response.body}");
        throw Exception('Tavily API Error: ${response.statusCode}');
      }
      
    } catch (e) {
      printAction("❌ TavilyService: Error searching web - $e");
      throw Exception('TavilyService search failed: $e');
    }
  }
  
  // Get trending topics
  static Future<List<Map<String, dynamic>>> getTrendingTopics() async {
    try {
      printAction("📈 TavilyService: Getting trending topics");
      
      // Search for trending topics
      final results = await searchWeb(
        query: 'trending topics today',
        category: 'news',
        maxResults: 5,
        includeAnswer: true,
        includeImages: true,
      );
      
      // Format as trending topics
      final trendingTopics = results.map((result) {
        return {
          'title': result['title'],
          'description': result['description'],
          'url': result['url'],
          'category': 'trending',
          'timestamp': DateTime.now(),
          'isRealTime': true,
          'source': result['source'],
          'relevanceScore': 0.9,
          'trendingScore': 0.95,
        };
      }).toList();
      
      printAction("✅ TavilyService: Found ${trendingTopics.length} trending topics");
      return trendingTopics;
      
    } catch (e) {
      printAction("❌ TavilyService: Error getting trending topics - $e");
      return [];
    }
  }
  
  // Search news specifically
  static Future<List<Map<String, dynamic>>> searchNews({
    required String query,
    int maxResults = 10,
    String? timeRange,
  }) async {
    try {
      printAction("📰 TavilyService: Searching news for '$query'");
      
      final results = await searchWeb(
        query: query,
        category: 'news',
        maxResults: maxResults,
        timeRange: timeRange,
        includeAnswer: true,
        includeImages: true,
      );
      
      // Mark as news results
      final newsResults = results.map((result) {
        result['category'] = 'news';
        result['isNews'] = true;
        return result;
      }).toList();
      
      printAction("✅ TavilyService: Found ${newsResults.length} news results");
      return newsResults;
      
    } catch (e) {
      printAction("❌ TavilyService: Error searching news - $e");
      return [];
    }
  }
  
  // Search academic/scientific content
  static Future<List<Map<String, dynamic>>> searchAcademic({
    required String query,
    int maxResults = 10,
  }) async {
    try {
      printAction("🎓 TavilyService: Searching academic content for '$query'");
      
      final results = await searchWeb(
        query: query,
        category: 'science',
        maxResults: maxResults,
        includeAnswer: true,
        includeImages: false,
        includeRawContent: true,
      );
      
      // Mark as academic results
      final academicResults = results.map((result) {
        result['category'] = 'academic';
        result['isAcademic'] = true;
        return result;
      }).toList();
      
      printAction("✅ TavilyService: Found ${academicResults.length} academic results");
      return academicResults;
      
    } catch (e) {
      printAction("❌ TavilyService: Error searching academic content - $e");
      return [];
    }
  }
  
  // Search with specific domains
  static Future<List<Map<String, dynamic>>> searchWithDomains({
    required String query,
    required List<String> domains,
    int maxResults = 10,
  }) async {
    try {
      printAction("🌐 TavilyService: Searching '$query' in specific domains");
      
      final uri = Uri.parse('$_baseUrl/search');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      };
      
      final body = {
        'query': query,
        'search_depth': 'basic',
        'include_answer': true,
        'include_images': true,
        'include_raw_content': false,
        'max_results': maxResults,
        'include_domains': domains,
        'exclude_domains': [],
      };
      
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = <Map<String, dynamic>>[];
        
        if (data['results'] != null) {
          for (final result in data['results']) {
            results.add({
              'title': result['title'] ?? '',
              'description': result['content'] ?? '',
              'url': result['url'] ?? '',
              'category': 'domain_specific',
              'timestamp': DateTime.now(),
              'isRealTime': true,
              'source': _extractDomain(result['url'] ?? ''),
              'relevanceScore': result['score'] ?? 0.5,
              'image': result['image'] ?? '',
              'domain': _extractDomain(result['url'] ?? ''),
            });
          }
        }
        
        printAction("✅ TavilyService: Found ${results.length} domain-specific results");
        return results;
        
      } else {
        printAction("❌ TavilyService: Domain search API Error ${response.statusCode}");
        throw Exception('Tavily Domain Search Error: ${response.statusCode}');
      }
      
    } catch (e) {
      printAction("❌ TavilyService: Error searching with domains - $e");
      throw Exception('TavilyService domain search failed: $e');
    }
  }
  
  // Get answer for a specific question
  static Future<String?> getAnswer({
    required String question,
    String? context,
  }) async {
    try {
      printAction("❓ TavilyService: Getting answer for '$question'");
      
      final results = await searchWeb(
        query: question,
        maxResults: 5,
        includeAnswer: true,
        includeImages: false,
      );
      
      if (results.isNotEmpty) {
        // Extract answer from first result
        final firstResult = results.first;
        final answer = firstResult['description'] ?? '';
        
        printAction("✅ TavilyService: Answer found for '$question'");
        return answer;
      }
      
      printAction("⚠️ TavilyService: No answer found for '$question'");
      return null;
      
    } catch (e) {
      printAction("❌ TavilyService: Error getting answer - $e");
      return null;
    }
  }
  
  // Search with filters
  static Future<List<Map<String, dynamic>>> searchWithFilters({
    required String query,
    Map<String, dynamic>? filters,
    int maxResults = 10,
  }) async {
    try {
      printAction("🔍 TavilyService: Searching '$query' with filters");
      
      final uri = Uri.parse('$_baseUrl/search');
      final headers = {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $_apiKey',
      };
      
      final body = {
        'query': query,
        'search_depth': 'basic',
        'include_answer': true,
        'include_images': true,
        'include_raw_content': false,
        'max_results': maxResults,
        'include_domains': [],
        'exclude_domains': [],
      };
      
      // Apply filters
      if (filters != null) {
        filters.forEach((key, value) {
          if (value != null) {
            body[key] = value;
          }
        });
      }
      
      final response = await http.post(
        uri,
        headers: headers,
        body: jsonEncode(body),
      );
      
      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        final results = <Map<String, dynamic>>[];
        
        if (data['results'] != null) {
          for (final result in data['results']) {
            results.add({
              'title': result['title'] ?? '',
              'description': result['content'] ?? '',
              'url': result['url'] ?? '',
              'category': filters?['category'] ?? 'general',
              'timestamp': DateTime.now(),
              'isRealTime': true,
              'source': _extractDomain(result['url'] ?? ''),
              'relevanceScore': result['score'] ?? 0.5,
              'image': result['image'] ?? '',
              'filters': filters,
            });
          }
        }
        
        printAction("✅ TavilyService: Found ${results.length} filtered results");
        return results;
        
      } else {
        printAction("❌ TavilyService: Filtered search API Error ${response.statusCode}");
        throw Exception('Tavily Filtered Search Error: ${response.statusCode}');
      }
      
    } catch (e) {
      printAction("❌ TavilyService: Error searching with filters - $e");
      throw Exception('TavilyService filtered search failed: $e');
    }
  }
  
  // Helper method to extract domain from URL
  static String _extractDomain(String url) {
    try {
      final uri = Uri.parse(url);
      return uri.host;
    } catch (e) {
      return 'Unknown';
    }
  }
  
  // Validate API key
  static Future<bool> validateApiKey() async {
    try {
      printAction("🔑 TavilyService: Validating API key");
      
      final results = await searchWeb(
        query: 'test',
        maxResults: 1,
        includeAnswer: false,
        includeImages: false,
      );
      
      final isValid = results.isNotEmpty;
      printAction(isValid ? "✅ TavilyService: API key is valid" : "❌ TavilyService: API key is invalid");
      
      return isValid;
      
    } catch (e) {
      printAction("❌ TavilyService: API key validation failed - $e");
      return false;
    }
  }
  
  // Get search suggestions
  static Future<List<String>> getSearchSuggestions(String query) async {
    try {
      printAction("💡 TavilyService: Getting search suggestions for '$query'");
      
      // This would typically call a suggestions API
      // For now, we'll return some basic suggestions
      final suggestions = <String>[
        '$query news',
        '$query latest',
        '$query today',
        '$query 2024',
        '$query recent',
      ];
      
      printAction("✅ TavilyService: Generated ${suggestions.length} suggestions");
      return suggestions;
      
    } catch (e) {
      printAction("❌ TavilyService: Error getting suggestions - $e");
      return [];
    }
  }
}
