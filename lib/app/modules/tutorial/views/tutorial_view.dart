import '../../../helper/all_imports.dart';
import '../controllers/tutorial_controller.dart';

class TutorialView extends StatelessWidget {
  const TutorialView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<TutorialController>(
      init: TutorialController(),
      builder: (controller) {
        return Obx(() {
          if (controller.isTutorialActive.value) {
            return _buildTutorialOverlay(controller);
          } else if (controller.showWhatsNew.value) {
            return _buildWhatsNewOverlay(controller);
          } else {
            return SizedBox.shrink();
          }
        });
      },
    );
  }

  Widget _buildTutorialOverlay(TutorialController controller) {
    return Material(
      color: Colors.black.withOpacity(0.8),
      child: Stack(
        children: [
          // Background overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.8),
          ),
          
          // Tutorial content
          Center(
            child: Container(
              margin: EdgeInsets.all(20.px),
              constraints: BoxConstraints(
                maxWidth: 400.px,
                maxHeight: 600.px,
              ),
              decoration: BoxDecoration(
                color: AppColors().darkAndWhite,
                borderRadius: BorderRadius.circular(20.px),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.px),
                child: _buildTutorialContent(controller),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildTutorialContent(TutorialController controller) {
    final currentStep = controller.getCurrentTutorialStep();
    if (currentStep == null) return SizedBox.shrink();

    return Column(
      children: [
        // Header with progress
        _buildTutorialHeader(controller, currentStep),
        
        // Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.px),
            child: Column(
              children: [
                // Icon
                Container(
                  width: 80.px,
                  height: 80.px,
                  decoration: BoxDecoration(
                    color: currentStep.color.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40.px),
                  ),
                  child: Icon(
                    currentStep.icon,
                    size: 40.px,
                    color: currentStep.color,
                  ),
                ),
                
                SizedBox(height: 24.px),
                
                // Title
                Text(
                  currentStep.title,
                  style: TextStyle(
                    fontSize: 24.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 12.px),
                
                // Description
                Text(
                  currentStep.description,
                  style: TextStyle(
                    fontSize: 16.px,
                    color: AppColors().darkAndWhite.withOpacity(0.7),
                    height: 1.5,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 24.px),
                
                // Features
                _buildFeaturesList(currentStep.features),
              ],
            ),
          ),
        ),
        
        // Footer with navigation
        _buildTutorialFooter(controller),
      ],
    );
  }

  Widget _buildTutorialHeader(TutorialController controller, TutorialStep currentStep) {
    return Container(
      padding: EdgeInsets.all(20.px),
      decoration: BoxDecoration(
        color: currentStep.color.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.px),
          topRight: Radius.circular(20.px),
        ),
      ),
      child: Column(
        children: [
          // Progress bar
          Row(
            children: [
              Expanded(
                child: LinearProgressIndicator(
                  value: controller.tutorialProgress.value,
                  backgroundColor: Colors.white.withOpacity(0.3),
                  valueColor: AlwaysStoppedAnimation<Color>(currentStep.color),
                ),
              ),
              SizedBox(width: 12.px),
              Text(
                '${controller.tutorialProgressPercentage.toInt()}%',
                style: TextStyle(
                  fontSize: 14.px,
                  fontWeight: FontWeight.bold,
                  color: currentStep.color,
                ),
              ),
            ],
          ),
          
          SizedBox(height: 12.px),
          
          // Step indicator
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Step ${controller.currentTutorialIndex.value + 1} of ${controller.tutorialSteps.length}',
                style: TextStyle(
                  fontSize: 14.px,
                  color: AppColors().darkAndWhite.withOpacity(0.7),
                ),
              ),
              if (controller.canSkipTutorial.value)
                TextButton(
                  onPressed: () => controller.skipTutorial(),
                  child: Text(
                    'Skip',
                    style: TextStyle(
                      fontSize: 14.px,
                      color: currentStep.color,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildFeaturesList(List<String> features) {
    return Column(
      children: features.map((feature) {
        return Container(
          margin: EdgeInsets.symmetric(vertical: 4.px),
          padding: EdgeInsets.symmetric(horizontal: 16.px, vertical: 12.px),
          decoration: BoxDecoration(
            color: AppColors().darkAndWhite.withOpacity(0.05),
            borderRadius: BorderRadius.circular(12.px),
            border: Border.all(
              color: AppColors().darkAndWhite.withOpacity(0.1),
            ),
          ),
          child: Row(
            children: [
              Icon(
                Icons.check_circle,
                size: 20.px,
                color: AppColors.success,
              ),
              SizedBox(width: 12.px),
              Expanded(
                child: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 14.px,
                    color: AppColors().darkAndWhite.withOpacity(0.8),
                  ),
                ),
              ),
            ],
          ),
        );
      }).toList(),
    );
  }

  Widget _buildTutorialFooter(TutorialController controller) {
    return Container(
      padding: EdgeInsets.all(20.px),
      decoration: BoxDecoration(
        color: AppColors().darkAndWhite.withOpacity(0.05),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.px),
          bottomRight: Radius.circular(20.px),
        ),
      ),
      child: Row(
        children: [
          // Previous button
          if (!controller.isFirstTutorialStep)
            Expanded(
              child: OutlinedButton(
                onPressed: () => controller.previousTutorialStep(),
                style: OutlinedButton.styleFrom(
                  padding: EdgeInsets.symmetric(vertical: 12.px),
                  side: BorderSide(color: AppColors().darkAndWhite.withOpacity(0.3)),
                ),
                child: Text('Previous'),
              ),
            ),
          
          if (!controller.isFirstTutorialStep) SizedBox(width: 12.px),
          
          // Next/Complete button
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () => controller.nextTutorialStep(),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.px),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.px),
                ),
              ),
              child: Text(
                controller.isLastTutorialStep ? 'Get Started!' : 'Next',
                style: TextStyle(
                  fontSize: 16.px,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsNewOverlay(TutorialController controller) {
    return Material(
      color: Colors.black.withOpacity(0.8),
      child: Stack(
        children: [
          // Background overlay
          Container(
            width: double.infinity,
            height: double.infinity,
            color: Colors.black.withOpacity(0.8),
          ),
          
          // What's New content
          Center(
            child: Container(
              margin: EdgeInsets.all(20.px),
              constraints: BoxConstraints(
                maxWidth: 400.px,
                maxHeight: 700.px,
              ),
              decoration: BoxDecoration(
                color: AppColors().darkAndWhite,
                borderRadius: BorderRadius.circular(20.px),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.3),
                    blurRadius: 20,
                    offset: Offset(0, 10),
                  ),
                ],
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20.px),
                child: _buildWhatsNewContent(controller),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsNewContent(TutorialController controller) {
    return Column(
      children: [
        // Header
        _buildWhatsNewHeader(controller),
        
        // Content
        Expanded(
          child: SingleChildScrollView(
            padding: EdgeInsets.all(24.px),
            child: Column(
              children: [
                // Welcome message
                Container(
                  width: 80.px,
                  height: 80.px,
                  decoration: BoxDecoration(
                    color: AppColors.primary.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(40.px),
                  ),
                  child: Icon(
                    Icons.celebration,
                    size: 40.px,
                    color: AppColors.primary,
                  ),
                ),
                
                SizedBox(height: 24.px),
                
                Text(
                  'What\'s New in Chatsy!',
                  style: TextStyle(
                    fontSize: 24.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 12.px),
                
                Text(
                  'Discover the latest features and improvements',
                  style: TextStyle(
                    fontSize: 16.px,
                    color: AppColors().darkAndWhite.withOpacity(0.7),
                  ),
                  textAlign: TextAlign.center,
                ),
                
                SizedBox(height: 24.px),
                
                // What's New items
                Obx(() => Column(
                  children: controller.whatsNewItems.map((item) {
                    return _buildWhatsNewItem(item);
                  }).toList(),
                )),
              ],
            ),
          ),
        ),
        
        // Footer
        _buildWhatsNewFooter(controller),
      ],
    );
  }

  Widget _buildWhatsNewHeader(TutorialController controller) {
    return Container(
      padding: EdgeInsets.all(20.px),
      decoration: BoxDecoration(
        color: AppColors.primary.withOpacity(0.1),
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20.px),
          topRight: Radius.circular(20.px),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Version 1.5.0',
                  style: TextStyle(
                    fontSize: 16.px,
                    fontWeight: FontWeight.bold,
                    color: AppColors().darkAndWhite,
                  ),
                ),
                Text(
                  '${controller.newFeaturesCount} new features',
                  style: TextStyle(
                    fontSize: 14.px,
                    color: AppColors().darkAndWhite.withOpacity(0.7),
                  ),
                ),
              ],
            ),
          ),
          IconButton(
            onPressed: () => controller.hideWhatsNew(),
            icon: Icon(
              Icons.close,
              color: AppColors().darkAndWhite.withOpacity(0.7),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsNewItem(WhatsNewItem item) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 8.px),
      padding: EdgeInsets.all(16.px),
      decoration: BoxDecoration(
        color: item.color.withOpacity(0.05),
        borderRadius: BorderRadius.circular(12.px),
        border: Border.all(
          color: item.color.withOpacity(0.2),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                width: 40.px,
                height: 40.px,
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20.px),
                ),
                child: Icon(
                  item.icon,
                  size: 20.px,
                  color: item.color,
                ),
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
                            item.title,
                            style: TextStyle(
                              fontSize: 16.px,
                              fontWeight: FontWeight.bold,
                              color: AppColors().darkAndWhite,
                            ),
                          ),
                        ),
                        if (item.isNew)
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
                    Text(
                      item.subtitle,
                      style: TextStyle(
                        fontSize: 14.px,
                        color: AppColors().darkAndWhite.withOpacity(0.7),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
          
          SizedBox(height: 12.px),
          
          Text(
            item.description,
            style: TextStyle(
              fontSize: 14.px,
              color: AppColors().darkAndWhite.withOpacity(0.8),
              height: 1.4,
            ),
          ),
          
          SizedBox(height: 12.px),
          
          // Features
          Wrap(
            spacing: 8.px,
            runSpacing: 4.px,
            children: item.features.take(3).map((feature) {
              return Container(
                padding: EdgeInsets.symmetric(horizontal: 8.px, vertical: 4.px),
                decoration: BoxDecoration(
                  color: item.color.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8.px),
                ),
                child: Text(
                  feature,
                  style: TextStyle(
                    fontSize: 12.px,
                    color: item.color,
                  ),
                ),
              );
            }).toList(),
          ),
          
          SizedBox(height: 12.px),
          
          // Action button
          SizedBox(
            width: double.infinity,
            child: ElevatedButton(
              onPressed: () {
                Get.find<TutorialController>().hideWhatsNew();
                Get.toNamed(item.actionRoute);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: item.color,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 8.px),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8.px),
                ),
              ),
              child: Text(item.actionText),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildWhatsNewFooter(TutorialController controller) {
    return Container(
      padding: EdgeInsets.all(20.px),
      decoration: BoxDecoration(
        color: AppColors().darkAndWhite.withOpacity(0.05),
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(20.px),
          bottomRight: Radius.circular(20.px),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: OutlinedButton(
              onPressed: () => controller.hideWhatsNew(),
              style: OutlinedButton.styleFrom(
                padding: EdgeInsets.symmetric(vertical: 12.px),
                side: BorderSide(color: AppColors().darkAndWhite.withOpacity(0.3)),
              ),
              child: Text('Maybe Later'),
            ),
          ),
          SizedBox(width: 12.px),
          Expanded(
            flex: 2,
            child: ElevatedButton(
              onPressed: () {
                Get.find<TutorialController>().hideWhatsNew();
                Get.toNamed('/home');
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary,
                foregroundColor: Colors.white,
                padding: EdgeInsets.symmetric(vertical: 12.px),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12.px),
                ),
              ),
              child: Text(
                'Explore Now',
                style: TextStyle(
                  fontSize: 16.px,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
