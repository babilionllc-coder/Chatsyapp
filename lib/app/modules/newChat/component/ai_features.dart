import 'package:flutter/material.dart';
import 'package:chatsy/app/common_widget/modern_card.dart';
import 'package:chatsy/app/helper/all_imports.dart';
import 'package:chatsy/extension.dart';

class AIFeatures {
  static List<Map<String, dynamic>> getQuickFeatures() {
    return [
      {
        'title': 'Smart Writing',
        'subtitle': 'Generate content, emails, essays',
        'icon': Icons.edit_note,
        'color': AppColors.primary,
        'features': [
          'Email writing',
          'Essay generation',
          'Creative writing',
          'Professional documents',
        ],
      },
      {
        'title': 'Code Assistant',
        'subtitle': 'Write, debug, and explain code',
        'icon': Icons.code,
        'color': AppColors.accent,
        'features': [
          'Code generation',
          'Bug fixing',
          'Code explanation',
          'Multiple languages',
        ],
      },
      {
        'title': 'Data Analysis',
        'subtitle': 'Analyze and visualize data',
        'icon': Icons.analytics,
        'color': AppColors.info,
        'features': [
          'Data interpretation',
          'Chart generation',
          'Statistical analysis',
          'Report creation',
        ],
      },
      {
        'title': 'Language Learning',
        'subtitle': 'Practice and improve languages',
        'icon': Icons.translate,
        'color': AppColors.success,
        'features': [
          'Translation',
          'Grammar checking',
          'Conversation practice',
          'Vocabulary building',
        ],
      },
      {
        'title': 'Creative Arts',
        'subtitle': 'Generate images and creative content',
        'icon': Icons.palette,
        'color': AppColors.warning,
        'features': [
          'Image generation',
          'Art creation',
          'Design ideas',
          'Creative writing',
        ],
      },
      {
        'title': 'Business Tools',
        'subtitle': 'Professional business assistance',
        'icon': Icons.business,
        'color': AppColors.error,
        'features': [
          'Business plans',
          'Marketing strategies',
          'Financial analysis',
          'Presentation creation',
        ],
      },
    ];
  }

  static Widget buildFeatureCard(Map<String, dynamic> feature) {
    return ModernCard(
      onTap: () {
        // Handle feature tap
        print('Tapped on ${feature['title']}');
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.all(12.px),
                decoration: BoxDecoration(
                  color: (feature['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.px),
                ),
                child: Icon(
                  feature['icon'] as IconData,
                  color: feature['color'] as Color,
                  size: 24.px,
                ),
              ),
              SizedBox(width: 12.px),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      feature['title'] as String,
                      style: TextStyle(
                        fontSize: 16.px,
                        fontWeight: FontWeight.bold,
                        color: AppColors().darkAndWhite,
                      ),
                    ),
                    SizedBox(height: 4.px),
                    Text(
                      feature['subtitle'] as String,
                      style: TextStyle(
                        fontSize: 14.px,
                        color: AppColors.grey1,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 12.px),
          Wrap(
            spacing: 8.px,
            runSpacing: 4.px,
            children: (feature['features'] as List<String>).map((featureText) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
                decoration: BoxDecoration(
                  color: (feature['color'] as Color).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(12.px),
                ),
                child: Text(
                  featureText,
                  style: TextStyle(
                    fontSize: 12.px,
                    color: feature['color'] as Color,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }

  static Widget buildFeatureGrid() {
    final features = getQuickFeatures();
    
    return GridView.builder(
      padding: EdgeInsets.all(16.px),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.2,
        crossAxisSpacing: 12.px,
        mainAxisSpacing: 12.px,
      ),
      itemCount: features.length,
      itemBuilder: (context, index) {
        return buildFeatureCard(features[index]);
      },
    );
  }
}

class AIAssistantCard extends StatelessWidget {
  final String name;
  final String description;
  final String? avatar;
  final VoidCallback? onTap;
  final bool isPremium;
  final double rating;

  const AIAssistantCard({
    super.key,
    required this.name,
    required this.description,
    this.avatar,
    this.onTap,
    this.isPremium = false,
    this.rating = 4.5,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      onTap: onTap,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 20.px,
                backgroundImage: avatar != null ? NetworkImage(avatar!) : null,
                child: avatar == null ? Icon(Icons.person, size: 20.px) : null,
              ),
              SizedBox(width: 12.px),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            name,
                            style: TextStyle(
                              fontSize: 16.px,
                              fontWeight: FontWeight.bold,
                              color: AppColors().darkAndWhite,
                            ),
                          ),
                        ),
                        if (isPremium)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 6.px, vertical: 2.px),
                            decoration: BoxDecoration(
                              color: AppColors.warning,
                              borderRadius: BorderRadius.circular(8.px),
                            ),
                            child: Text(
                              'PRO',
                              style: TextStyle(
                                fontSize: 8.px,
                                fontWeight: FontWeight.bold,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4.px),
                    Row(
                      children: [
                        Icon(Icons.star, size: 14.px, color: AppColors.warning),
                        SizedBox(width: 4.px),
                        Text(
                          rating.toString(),
                          style: TextStyle(
                            fontSize: 12.px,
                            color: AppColors.grey1,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 8.px),
          Text(
            description,
            style: TextStyle(
              fontSize: 14.px,
              color: AppColors.grey1,
            ),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
        ],
      ),
    );
  }
}

class RecentActivityCard extends StatelessWidget {
  final String title;
  final String subtitle;
  final IconData icon;
  final Color iconColor;
  final String timeAgo;
  final VoidCallback? onTap;

  const RecentActivityCard({
    super.key,
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.iconColor,
    required this.timeAgo,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ModernCard(
      onTap: onTap,
      child: Row(
        children: [
          Container(
            padding: EdgeInsets.all(8.px),
            decoration: BoxDecoration(
              color: iconColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(8.px),
            ),
            child: Icon(
              icon,
              color: iconColor,
              size: 20.px,
            ),
          ),
          SizedBox(width: 12.px),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 14.px,
                    fontWeight: FontWeight.w600,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                SizedBox(height: 2.px),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: 12.px,
                    color: AppColors.grey1,
                  ),
                ),
              ],
            ),
          ),
          Text(
            timeAgo,
            style: TextStyle(
              fontSize: 12.px,
              color: AppColors.grey2,
            ),
          ),
        ],
      ),
    );
  }
}

