import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import '../controllers/real_time_web_controller.dart';

class RealTimeWebView extends GetView<RealTimeWebController> {
  const RealTimeWebView({super.key});
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors().backgroundColor,
      appBar: AppBar(
        backgroundColor: AppColors().backgroundColor,
        elevation: 0,
        title: AppText(
          Languages.of(context)!.realTimeWebSearch,
          fontSize: 18.px,
          fontFamily: FontFamily.helveticaBold,
          color: AppColors().textColor,
        ),
        centerTitle: true,
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            color: AppColors().textColor,
          ),
          onPressed: () => Get.back(),
        ),
      ),
      body: Column(
        children: [
          // Search Bar
          Container(
            margin: EdgeInsets.all(16.px),
            decoration: BoxDecoration(
              color: AppColors().cardColor,
              borderRadius: BorderRadius.circular(12.px),
              border: Border.all(color: AppColors().borderColor),
            ),
            child: TextField(
              onChanged: (value) {
                if (value.length > 2) {
                  controller.performRealTimeSearch(value);
                }
              },
              decoration: InputDecoration(
                hintText: 'Search anything in real-time...',
                hintStyle: TextStyle(
                  color: AppColors().hintColor,
                  fontSize: 14.px,
                ),
                prefixIcon: Icon(
                  Icons.search,
                  color: AppColors().iconColor,
                ),
                suffixIcon: Obx(() => controller.searchQuery.value.isNotEmpty
                    ? IconButton(
                        icon: Icon(
                          Icons.clear,
                          color: AppColors().iconColor,
                        ),
                        onPressed: controller.clearSearch,
                      )
                    : Icon(
                        Icons.real_time_search,
                        color: AppColors().iconColor,
                      )),
                border: InputBorder.none,
                contentPadding: EdgeInsets.symmetric(
                  horizontal: 16.px,
                  vertical: 12.px,
                ),
              ),
            ),
          ),
          
          // Category Filter
          Container(
            height: 50.px,
            margin: EdgeInsets.symmetric(horizontal: 16.px),
            child: Obx(() => ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: controller.categories.length,
              itemBuilder: (context, index) {
                final category = controller.categories[index];
                final isSelected = controller.selectedCategory.value == category;
                
                return Container(
                  margin: EdgeInsets.only(right: 8.px),
                  child: FilterChip(
                    label: Text(
                      category,
                      style: TextStyle(
                        color: isSelected 
                            ? Colors.white 
                            : AppColors().textColor,
                        fontSize: 12.px,
                        fontFamily: FontFamily.helveticaMedium,
                      ),
                    ),
                    selected: isSelected,
                    onSelected: (selected) {
                      controller.filterByCategory(category);
                    },
                    backgroundColor: AppColors().cardColor,
                    selectedColor: AppColors().primaryColor,
                    checkmarkColor: Colors.white,
                    side: BorderSide(
                      color: isSelected 
                          ? AppColors().primaryColor 
                          : AppColors().borderColor,
                    ),
                  ),
                );
              },
            )),
          ),
          
          // Search Results
          Expanded(
            child: Obx(() {
              if (controller.isLoading.value) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CircularProgressIndicator(
                        color: AppColors().primaryColor,
                      ),
                      SizedBox(height: 16.px),
                      AppText(
                        'Searching in real-time...',
                        fontSize: 14.px,
                        color: AppColors().textColor,
                      ),
                    ],
                  ),
                );
              }
              
              if (controller.searchResults.isEmpty) {
                return Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.search_off,
                        size: 64.px,
                        color: AppColors().iconColor,
                      ),
                      SizedBox(height: 16.px),
                      AppText(
                        'Start typing to search in real-time',
                        fontSize: 16.px,
                        color: AppColors().textColor,
                        fontFamily: FontFamily.helveticaMedium,
                      ),
                      SizedBox(height: 8.px),
                      AppText(
                        'Get instant results from the web',
                        fontSize: 14.px,
                        color: AppColors().hintColor,
                      ),
                    ],
                  ),
                );
              }
              
              return ListView.builder(
                padding: EdgeInsets.all(16.px),
                itemCount: controller.searchResults.length,
                itemBuilder: (context, index) {
                  final result = controller.searchResults[index];
                  
                  return Container(
                    margin: EdgeInsets.only(bottom: 12.px),
                    decoration: BoxDecoration(
                      color: AppColors().cardColor,
                      borderRadius: BorderRadius.circular(12.px),
                      border: Border.all(color: AppColors().borderColor),
                    ),
                    child: ListTile(
                      contentPadding: EdgeInsets.all(16.px),
                      leading: Container(
                        width: 40.px,
                        height: 40.px,
                        decoration: BoxDecoration(
                          color: AppColors().primaryColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(8.px),
                        ),
                        child: Icon(
                          Icons.public,
                          color: AppColors().primaryColor,
                          size: 20.px,
                        ),
                      ),
                      title: AppText(
                        result['title'] ?? '',
                        fontSize: 14.px,
                        fontFamily: FontFamily.helveticaBold,
                        color: AppColors().textColor,
                        maxLines: 2,
                      ),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          SizedBox(height: 4.px),
                          AppText(
                            result['description'] ?? '',
                            fontSize: 12.px,
                            color: AppColors().hintColor,
                            maxLines: 3,
                          ),
                          SizedBox(height: 8.px),
                          Row(
                            children: [
                              Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 8.px,
                                  vertical: 2.px,
                                ),
                                decoration: BoxDecoration(
                                  color: AppColors().primaryColor.withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(4.px),
                                ),
                                child: AppText(
                                  result['category'] ?? '',
                                  fontSize: 10.px,
                                  color: AppColors().primaryColor,
                                  fontFamily: FontFamily.helveticaMedium,
                                ),
                              ),
                              Spacer(),
                              AppText(
                                'Real-time',
                                fontSize: 10.px,
                                color: AppColors().successColor,
                                fontFamily: FontFamily.helveticaMedium,
                              ),
                            ],
                          ),
                        ],
                      ),
                      onTap: () {
                        // Handle result tap
                        Get.snackbar(
                          'Real-time Search',
                          'Opening: ${result['title']}',
                          backgroundColor: AppColors().primaryColor,
                          colorText: Colors.white,
                        );
                      },
                    ),
                  );
                },
              );
            }),
          ),
        ],
      ),
    );
  }
}
