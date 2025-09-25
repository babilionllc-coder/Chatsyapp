import '../helper/all_imports.dart';
import '../modules/tutorial/controllers/tutorial_controller.dart';

class WhatsNewWidget extends StatelessWidget {
  final bool showAsCard;
  final VoidCallback? onTap;
  
  const WhatsNewWidget({
    Key? key,
    this.showAsCard = true,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TutorialController>(
      init: TutorialController(),
      builder: (controller) {
        return Obx(() {
          if (!controller.showWhatsNew.value && !controller.isFirstTimeUser.value) {
            return SizedBox.shrink();
          }
          
          if (showAsCard) {
            return _buildWhatsNewCard(controller);
          } else {
            return _buildWhatsNewButton(controller);
          }
        });
      },
    );
  }

  Widget _buildWhatsNewCard(TutorialController controller) {
    return Container(
      margin: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            AppColors.primary.withOpacity(0.1),
            AppColors.accent.withOpacity(0.1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(
          color: AppColors.primary.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap ?? () => controller.showWhatsNewDialog(),
          borderRadius: BorderRadius.circular(16.px),
          child: Padding(
            padding: EdgeInsets.all(20.px),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Container(
                      width: 50.px,
                      height: 50.px,
                      decoration: BoxDecoration(
                        color: AppColors.primary.withOpacity(0.2),
                        borderRadius: BorderRadius.circular(25.px),
                      ),
                      child: Icon(
                        Icons.celebration,
                        size: 25.px,
                        color: AppColors.primary,
                      ),
                    ),
                    SizedBox(width: 16.px),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'What\'s New!',
                            style: TextStyle(
                              fontSize: 18.px,
                              fontWeight: FontWeight.bold,
                              color: AppColors().darkAndWhite,
                            ),
                          ),
                          Text(
                            'Version 1.5.0 • ${controller.newFeaturesCount} new features',
                            style: TextStyle(
                              fontSize: 14.px,
                              color: AppColors().darkAndWhite.withOpacity(0.7),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Icon(
                      Icons.arrow_forward_ios,
                      size: 16.px,
                      color: AppColors().darkAndWhite.withOpacity(0.5),
                    ),
                  ],
                ),
                
                SizedBox(height: 16.px),
                
                Text(
                  'Discover GPT-5 integration, DeepSeek AI, and advanced AI agents!',
                  style: TextStyle(
                    fontSize: 14.px,
                    color: AppColors().darkAndWhite.withOpacity(0.8),
                    height: 1.4,
                  ),
                ),
                
                SizedBox(height: 16.px),
                
                // Feature highlights
                Row(
                  children: [
                    _buildFeatureChip('GPT-5', AppColors.primary),
                    SizedBox(width: 8.px),
                    _buildFeatureChip('DeepSeek', AppColors.accent),
                    SizedBox(width: 8.px),
                    _buildFeatureChip('AI Agents', AppColors.info),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildWhatsNewButton(TutorialController controller) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 16.px, vertical: 8.px),
      child: ElevatedButton.icon(
        onPressed: onTap ?? () => controller.showWhatsNewDialog(),
        icon: Icon(
          Icons.celebration,
          size: 18.px,
        ),
        label: Text('What\'s New'),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          padding: EdgeInsets.symmetric(horizontal: 20.px, vertical: 12.px),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.px),
          ),
        ),
      ),
    );
  }

  Widget _buildFeatureChip(String label, Color color) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 12.px, vertical: 6.px),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(16.px),
        border: Border.all(
          color: color.withOpacity(0.3),
          width: 1,
        ),
      ),
      child: Text(
        label,
        style: TextStyle(
          fontSize: 12.px,
          color: color,
          fontWeight: FontWeight.w500,
        ),
      ),
    );
  }
}

// Tutorial Trigger Widget
class TutorialTriggerWidget extends StatelessWidget {
  final Widget child;
  final bool showTutorial;
  
  const TutorialTriggerWidget({
    Key? key,
    required this.child,
    this.showTutorial = true,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TutorialController>(
      init: TutorialController(),
      builder: (controller) {
        return Stack(
          children: [
            child,
            if (showTutorial && controller.isFirstTimeUser.value)
              Positioned(
                top: 0,
                right: 0,
                child: Container(
                  width: 20.px,
                  height: 20.px,
                  decoration: BoxDecoration(
                    color: AppColors.primary,
                    borderRadius: BorderRadius.circular(10.px),
                  ),
                  child: Icon(
                    Icons.help_outline,
                    size: 12.px,
                    color: Colors.white,
                  ),
                ),
              ),
          ],
        );
      },
    );
  }
}

// Feature Highlight Widget
class FeatureHighlightWidget extends StatelessWidget {
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final bool isNew;
  final VoidCallback? onTap;
  
  const FeatureHighlightWidget({
    Key? key,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    this.isNew = false,
    this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.px),
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.px),
        border: Border.all(
          color: color.withOpacity(0.2),
          width: 1,
        ),
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(12.px),
          child: Row(
            children: [
              Container(
                width: 50.px,
                height: 50.px,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(25.px),
                ),
                child: Icon(
                  icon,
                  size: 25.px,
                  color: color,
                ),
              ),
              SizedBox(width: 16.px),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: Text(
                            title,
                            style: TextStyle(
                              fontSize: 16.px,
                              fontWeight: FontWeight.bold,
                              color: AppColors().darkAndWhite,
                            ),
                          ),
                        ),
                        if (isNew)
                          Container(
                            padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 2.px),
                            decoration: BoxDecoration(
                              color: AppColors.success,
                              borderRadius: BorderRadius.circular(12.px),
                            ),
                            child: Text(
                              'NEW',
                              style: TextStyle(
                                fontSize: 10.px,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                      ],
                    ),
                    SizedBox(height: 4.px),
                    Text(
                      description,
                      style: TextStyle(
                        fontSize: 14.px,
                        color: AppColors().darkAndWhite.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
              Icon(
                Icons.arrow_forward_ios,
                size: 16.px,
                color: AppColors().darkAndWhite.withOpacity(0.5),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
