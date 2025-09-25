import 'dart:developer';
import '../../../helper/all_imports.dart';

class TutorialController extends GetxController {
  // Tutorial System Controller - Professional Onboarding Experience
  
  // Tutorial State
  RxBool isTutorialActive = false.obs;
  RxInt currentTutorialIndex = 0.obs;
  RxBool isFirstTimeUser = true.obs;
  RxBool showWhatsNew = false.obs;
  
  // Tutorial Data
  RxList<TutorialStep> tutorialSteps = <TutorialStep>[].obs;
  RxList<WhatsNewItem> whatsNewItems = <WhatsNewItem>[].obs;
  
  // Tutorial Progress
  RxDouble tutorialProgress = 0.0.obs;
  RxBool canSkipTutorial = false.obs;
  
  @override
  void onInit() {
    super.onInit();
    _initializeTutorialSystem();
  }
  
  void _initializeTutorialSystem() {
    printAction("🎓 Tutorial System: Initializing...");
    _loadTutorialSteps();
    _loadWhatsNewItems();
    _checkFirstTimeUser();
    printAction("✅ Tutorial System: Ready");
  }
  
  void _loadTutorialSteps() {
    tutorialSteps.value = [
      TutorialStep(
        id: 'welcome',
        title: 'Welcome to Chatsy!',
        description: 'Your advanced AI companion powered by GPT-5 and DeepSeek',
        icon: Icons.waving_hand,
        color: AppColors.primary,
        image: 'assets/images/tutorial/welcome.png',
        features: [
          'Advanced AI conversations with GPT-5',
          'DeepSeek integration for specialized tasks',
          'Real-time search and analysis',
          'Voice synthesis with ElevenLabs',
          'Image generation and scanning',
        ],
      ),
      TutorialStep(
        id: 'gpt5_upgrade',
        title: 'GPT-5 Integration',
        description: 'Experience the most advanced AI model with enhanced capabilities',
        icon: Icons.psychology,
        color: AppColors.accent,
        image: 'assets/images/tutorial/gpt5.png',
        features: [
          'Advanced reasoning and problem-solving',
          'Enhanced creativity and analysis',
          'Improved response quality',
          'Better context understanding',
          'Faster response times',
        ],
      ),
      TutorialStep(
        id: 'deepseek_integration',
        title: 'DeepSeek AI Integration',
        description: 'Specialized AI models for coding, math, and reasoning tasks',
        icon: Icons.code,
        color: AppColors.info,
        image: 'assets/images/tutorial/deepseek.png',
        features: [
          'DeepSeek Coder for programming',
          'DeepSeek Math for calculations',
          'DeepSeek Reasoning for analysis',
          'Specialized model selection',
          'Enhanced task performance',
        ],
      ),
      TutorialStep(
        id: 'chat_features',
        title: 'Advanced Chat Features',
        description: 'Discover powerful chat capabilities and AI tools',
        icon: Icons.chat_bubble_outline,
        color: AppColors.success,
        image: 'assets/images/tutorial/chat.png',
        features: [
          'Real-time web search with Tavily',
          'Document and website summarization',
          'YouTube video analysis',
          'Multi-language translation',
          'Image generation and scanning',
        ],
      ),
      TutorialStep(
        id: 'voice_features',
        title: 'Voice Synthesis',
        description: 'Natural voice generation with ElevenLabs integration',
        icon: Icons.record_voice_over,
        color: AppColors.warning,
        image: 'assets/images/tutorial/voice.png',
        features: [
          'Natural voice synthesis',
          'Multiple voice options',
          'Real-time voice generation',
          'Voice customization',
          'High-quality audio output',
        ],
      ),
      TutorialStep(
        id: 'ai_agents',
        title: 'AI Agents & Monitoring',
        description: 'Advanced AI agents for quality assurance and deployment',
        icon: Icons.smart_toy,
        color: AppColors.primary,
        image: 'assets/images/tutorial/agents.png',
        features: [
          'AI Quality Assurance Agent',
          'AI Deployment Assistant',
          'Real-time monitoring',
          'Automated testing',
          'Store deployment automation',
        ],
      ),
      TutorialStep(
        id: 'security',
        title: 'Security & Privacy',
        description: 'Your data is protected with enterprise-grade security',
        icon: Icons.security,
        color: AppColors.error,
        image: 'assets/images/tutorial/security.png',
        features: [
          'Secure API key management',
          'Data encryption',
          'Privacy protection',
          'Secure storage',
          'Compliance with regulations',
        ],
      ),
      TutorialStep(
        id: 'get_started',
        title: 'Ready to Get Started!',
        description: 'You\'re all set to explore the power of advanced AI',
        icon: Icons.rocket_launch,
        color: AppColors.accent,
        image: 'assets/images/tutorial/get_started.png',
        features: [
          'Start chatting with GPT-5',
          'Try DeepSeek specialized models',
          'Explore voice synthesis',
          'Test image generation',
          'Use real-time search',
        ],
      ),
    ];
  }
  
  void _loadWhatsNewItems() {
    whatsNewItems.value = [
      WhatsNewItem(
        id: 'gpt5_upgrade',
        title: 'GPT-5 Integration',
        subtitle: 'The most advanced AI model',
        description: 'Experience enhanced AI capabilities with GPT-5, featuring improved reasoning, creativity, and response quality.',
        icon: Icons.psychology,
        color: AppColors.primary,
        isNew: true,
        features: [
          'Advanced reasoning and problem-solving',
          'Enhanced creativity and analysis',
          'Improved response quality',
          'Better context understanding',
        ],
        actionText: 'Try GPT-5',
        actionRoute: '/new-chat',
      ),
      WhatsNewItem(
        id: 'deepseek_integration',
        title: 'DeepSeek AI Integration',
        subtitle: 'Specialized AI models',
        description: 'Access specialized AI models for coding, mathematics, and advanced reasoning tasks.',
        icon: Icons.code,
        color: AppColors.accent,
        isNew: true,
        features: [
          'DeepSeek Coder for programming',
          'DeepSeek Math for calculations',
          'DeepSeek Reasoning for analysis',
          'Automatic model selection',
        ],
        actionText: 'Explore DeepSeek',
        actionRoute: '/new-chat',
      ),
      WhatsNewItem(
        id: 'ai_agents',
        title: 'AI Agents & Monitoring',
        subtitle: 'Advanced automation',
        description: 'New AI agents for quality assurance, deployment automation, and comprehensive monitoring.',
        icon: Icons.smart_toy,
        color: AppColors.info,
        isNew: true,
        features: [
          'AI Quality Assurance Agent',
          'AI Deployment Assistant',
          'Real-time monitoring',
          'Automated testing',
        ],
        actionText: 'View Agents',
        actionRoute: '/ai-agent',
      ),
      WhatsNewItem(
        id: 'security_upgrade',
        title: 'Enhanced Security',
        subtitle: 'Enterprise-grade protection',
        description: 'Improved security with secure API key management and enhanced data protection.',
        icon: Icons.security,
        color: AppColors.success,
        isNew: false,
        features: [
          'Secure API key management',
          'Enhanced data encryption',
          'Privacy protection',
          'Compliance validation',
        ],
        actionText: 'Learn More',
        actionRoute: '/settings',
      ),
      WhatsNewItem(
        id: 'performance_optimization',
        title: 'Performance Optimization',
        subtitle: 'Faster and smoother',
        description: 'Optimized performance with improved response times and enhanced user experience.',
        icon: Icons.speed,
        color: AppColors.warning,
        isNew: false,
        features: [
          'Faster response times',
          'Improved memory usage',
          'Enhanced UI performance',
          'Better battery optimization',
        ],
        actionText: 'Experience Now',
        actionRoute: '/home',
      ),
    ];
  }
  
  void _checkFirstTimeUser() {
    // Check if user has completed tutorial before
    final hasCompletedTutorial = getStorageData.readBool('tutorial_completed') ?? false;
    isFirstTimeUser.value = !hasCompletedTutorial;
    
    if (isFirstTimeUser.value) {
      printAction("🎓 New user detected - showing tutorial");
    } else {
      printAction("🎓 Returning user - checking for updates");
      _checkForUpdates();
    }
  }
  
  void _checkForUpdates() {
    // Check if user has seen the latest updates
    final lastSeenVersion = getStorageData.readString('last_seen_version') ?? '1.0.0';
    final currentVersion = '1.5.0'; // Current app version
    
    if (lastSeenVersion != currentVersion) {
      showWhatsNew.value = true;
      printAction("🆕 New updates available - showing What's New");
    }
  }
  
  // Start Tutorial
  void startTutorial() {
    isTutorialActive.value = true;
    currentTutorialIndex.value = 0;
    tutorialProgress.value = 0.0;
    canSkipTutorial.value = false;
    
    printAction("🎓 Starting tutorial for user");
  }
  
  // Next Tutorial Step
  void nextTutorialStep() {
    if (currentTutorialIndex.value < tutorialSteps.length - 1) {
      currentTutorialIndex.value++;
      tutorialProgress.value = (currentTutorialIndex.value + 1) / tutorialSteps.length;
      
      // Allow skipping after first few steps
      if (currentTutorialIndex.value >= 2) {
        canSkipTutorial.value = true;
      }
    } else {
      completeTutorial();
    }
  }
  
  // Previous Tutorial Step
  void previousTutorialStep() {
    if (currentTutorialIndex.value > 0) {
      currentTutorialIndex.value--;
      tutorialProgress.value = (currentTutorialIndex.value + 1) / tutorialSteps.length;
    }
  }
  
  // Skip Tutorial
  void skipTutorial() {
    completeTutorial();
    printAction("🎓 Tutorial skipped by user");
  }
  
  // Complete Tutorial
  void completeTutorial() {
    isTutorialActive.value = false;
    isFirstTimeUser.value = false;
    tutorialProgress.value = 1.0;
    
    // Mark tutorial as completed
    getStorageData.writeBool('tutorial_completed', true);
    getStorageData.writeString('tutorial_completed_date', DateTime.now().toIso8601String());
    
    printAction("🎓 Tutorial completed successfully");
  }
  
  // Show What's New
  void showWhatsNewDialog() {
    showWhatsNew.value = true;
    printAction("🆕 Showing What's New dialog");
  }
  
  // Hide What's New
  void hideWhatsNew() {
    showWhatsNew.value = false;
    
    // Mark current version as seen
    getStorageData.writeString('last_seen_version', '1.5.0');
    getStorageData.writeString('last_seen_date', DateTime.now().toIso8601String());
    
    printAction("🆕 What's New dialog closed");
  }
  
  // Get Current Tutorial Step
  TutorialStep? getCurrentTutorialStep() {
    if (currentTutorialIndex.value < tutorialSteps.length) {
      return tutorialSteps[currentTutorialIndex.value];
    }
    return null;
  }
  
  // Check if tutorial step is last
  bool get isLastTutorialStep => currentTutorialIndex.value == tutorialSteps.length - 1;
  
  // Check if tutorial step is first
  bool get isFirstTutorialStep => currentTutorialIndex.value == 0;
  
  // Get tutorial progress percentage
  double get tutorialProgressPercentage => tutorialProgress.value * 100;
  
  // Get new features count
  int get newFeaturesCount => whatsNewItems.where((item) => item.isNew).length;
  
  // Mark feature as seen
  void markFeatureAsSeen(String featureId) {
    getStorageData.writeBool('feature_seen_$featureId', true);
  }
  
  // Check if feature is new
  bool isFeatureNew(String featureId) {
    return !(getStorageData.readBool('feature_seen_$featureId') ?? false);
  }
  
  // Reset tutorial (for testing)
  void resetTutorial() {
    getStorageData.remove('tutorial_completed');
    getStorageData.remove('tutorial_completed_date');
    getStorageData.remove('last_seen_version');
    getStorageData.remove('last_seen_date');
    
    isFirstTimeUser.value = true;
    showWhatsNew.value = false;
    
    printAction("🎓 Tutorial system reset");
  }
}

// Data Models
class TutorialStep {
  final String id;
  final String title;
  final String description;
  final IconData icon;
  final Color color;
  final String image;
  final List<String> features;
  
  TutorialStep({
    required this.id,
    required this.title,
    required this.description,
    required this.icon,
    required this.color,
    required this.image,
    required this.features,
  });
}

class WhatsNewItem {
  final String id;
  final String title;
  final String subtitle;
  final String description;
  final IconData icon;
  final Color color;
  final bool isNew;
  final List<String> features;
  final String actionText;
  final String actionRoute;
  
  WhatsNewItem({
    required this.id,
    required this.title,
    required this.subtitle,
    required this.description,
    required this.icon,
    required this.color,
    required this.isNew,
    required this.features,
    required this.actionText,
    required this.actionRoute,
  });
}
