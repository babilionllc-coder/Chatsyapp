import 'dart:async';
import 'dart:io';

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:chatsy/app/common_widget/common_button.dart';
import 'package:chatsy/app/common_widget/common_container.dart';
import 'package:chatsy/app/common_widget/rx_common_model.dart';
import 'package:chatsy/app/modules/chat_gpt/controllers/chat_gpt_controller.dart';
import 'package:chatsy/app/modules/chat_gpt/views/chat_gpt_view.dart';
import 'package:chatsy/app/modules/home/controllers/user_profile_model.dart';
import 'package:chatsy/app/modules/newChat/component/new_chat_helper.dart';
import 'package:chatsy/app/modules/promptChat/controllers/prompt_chat_controller.dart';
import 'package:chatsy/appIcons_icons.dart';
import 'package:chatsy/extension.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter_svg/svg.dart';
import 'package:shimmer/shimmer.dart';

// import 'package:super_context_menu/super_context_menu.dart';
import '../../../Localization/local_language.dart';
import '../../../helper/Global.dart';
import '../../../helper/all_imports.dart';
import '../../../helper/font_family.dart';
import '../../../helper/image_path.dart';
import '../../bottom_navigation/controllers/bottom_navigation_controller.dart';
import '../../home/controllers/ai_assistants_model.dart';
import '../../home/controllers/all_prompt_model.dart';
import '../../imageGeneration/controllers/image_generation_controller.dart';
import '../../splash/controllers/login_model.dart';
import '../component/text_to_speech.dart';

class NewChatController extends GetxController
    with WidgetsBindingObserver, ModelSwitcher {
  LoginData? loginData;
  RxInt apiCall = 0.obs;
  ToolsModel? toolModel;

  bool isRealTime = false;

  RxInt mainListIndex = 1.obs;
  List<AssistantQuestion> textList = [
    AssistantQuestion(question: "How i can manage my time?"),
    AssistantQuestion(question: "Write me an 500 words essay"),
    AssistantQuestion(question: "Best online courses to boost your career"),
    AssistantQuestion(question: "Learning a new language effectively"),
    AssistantQuestion(question: "How to write a research paper"),
    AssistantQuestion(question: "How to write a research paper"),
    AssistantQuestion(question: "Educational apps for kids"),
  ];

  List<CategoryCard> mainList = [
    CategoryCard(
      image: ImagePath.icFun,
      title: "FUN",
      items: [
        CategoryCardSub(
          title: "Funny story",
          backendName:
              "Tell me a funny story about a cat that accidentally becomes a social media celebrity.",
        ),
        CategoryCardSub(
          title: "Weird fact",
          backendName:
              "Give me a weird but true fact about ancient civilizations that most people don't know.",
        ),
        CategoryCardSub(
          title: "Joke",
          backendName: "Tell me a clever, clean joke about space exploration.",
        ),
        CategoryCardSub(
          title: "Meme idea",
          backendName:
              "Give me a meme idea about how people feel on Monday mornings.",
        ),
        CategoryCardSub(
          title: "Surprise me",
          backendName:
              "Surprise me with a random and unexpected fun fact about space exploration.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icGame,
      title: "GAMES & QUIZZES",
      items: [
        CategoryCardSub(
          title: "Trivia question",
          backendName:
              "Give me a challenging trivia question about European history.",
        ),
        CategoryCardSub(
          title: "Brain teaser",
          backendName:
              "Give me a tricky brain teaser that requires logical thinking to solve.",
        ),
        CategoryCardSub(
          title: "Number puzzle",
          backendName:
              "Give me a fun number puzzle that involves simple arithmetic and logic.",
        ),
        CategoryCardSub(
          title: "Word challenge",
          backendName:
              "Challenge me with a word puzzle where I have to create new words from the letters in 'imagination.'",
        ),
        CategoryCardSub(
          title: "Quiz me",
          backendName:
              "Quiz me with five geography-related questions about continents and countries.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icFitness,
      title: "FITNESS",
      items: [
        CategoryCardSub(
          title: "Home workout",
          backendName:
              "Create a 20-minute home workout routine with no equipment that focuses on the upper body.",
        ),
        CategoryCardSub(
          title: "Yoga",
          backendName:
              "Suggest a 20-minute beginner yoga routine focusing on flexibility and relaxation.",
        ),
        CategoryCardSub(
          title: "Running plan",
          backendName:
              "Create a 4-week running plan for beginners who want to work up to running 5K.",
        ),
        CategoryCardSub(
          title: "Challenge",
          backendName:
              "Create a 30-day workout challenge to improve my upper body strength with no equipment.",
        ),
        CategoryCardSub(
          title: "Recovery",
          backendName:
              "Suggest recovery stretches and tips for muscle soreness after an intense workout.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icTravel,
      title: "TRAVEL",
      items: [
        CategoryCardSub(
          title: "Travel advice",
          backendName:
              "Give me advice on how to stay safe while traveling solo in Southeast Asia.",
        ),
        CategoryCardSub(
          title: "Best places",
          backendName:
              "Suggest the best places to visit in Japan for food lovers.",
        ),
        CategoryCardSub(
          title: "Packing essentials",
          backendName:
              "What are the must-pack essentials for a two-week backpacking trip through Europe?",
        ),
        CategoryCardSub(
          title: "Weekend getaway",
          backendName:
              "Recommend a relaxing weekend getaway near New York City with nature and outdoor activities.",
        ),
        CategoryCardSub(
          title: "Local tips",
          backendName:
              "Share local travel tips for visiting hidden gems in Rome that aren’t overrun by tourists.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icMoney,
      title: "MONEY",
      items: [
        CategoryCardSub(
          title: "Invest tips",
          backendName:
              "Give me three tips for beginners who want to start investing in the stock market.",
        ),
        CategoryCardSub(
          title: "Save money",
          backendName:
              "Suggest practical ways I can save \$500 a month on everyday expenses without drastically changing my lifestyle.",
        ),
        CategoryCardSub(
          title: "Side hustle",
          backendName:
              "Recommend side hustles I can do in my spare time to earn an extra \$1,000 a month.",
        ),
        CategoryCardSub(
          title: "Budget plan",
          backendName:
              "Help me create a simple monthly budget plan that focuses on saving 20% of my income.",
        ),
        CategoryCardSub(
          title: "Pay debt",
          backendName:
              "Give me a strategy to pay off \$10,000 in credit card debt within a year, while still managing other expenses.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icFood,
      title: "FOOD & DRINK",
      items: [
        CategoryCardSub(
          title: "Quick dinner",
          backendName:
              "Suggest a quick and healthy dinner recipe I can make in 20 minutes with chicken and vegetables.",
        ),
        CategoryCardSub(
          title: "Breakfast idea",
          backendName:
              "Give me a simple breakfast idea that’s high in protein and quick to prepare.",
        ),
        CategoryCardSub(
          title: "Cocktail recipe",
          backendName:
              "Recommend a refreshing summer cocktail that uses gin, lemon, and herbs.",
        ),
        CategoryCardSub(
          title: "Meal prep",
          backendName:
              "Create a meal prep plan for the week with easy-to-store lunches and dinners that are low-carb.",
        ),
        CategoryCardSub(
          title: "Vegan dessert",
          backendName:
              "Give me a simple recipe for a vegan dessert that doesn’t require baking.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icEducation,
      title: "EDUCATION",
      items: [
        CategoryCardSub(
          title: "Science fact",
          backendName:
              "Share a fascinating fact about the solar system that most people don’t know.",
        ),
        CategoryCardSub(
          title: "Math help",
          backendName:
              "Solve this math problem and explain it to me step by step: 4x - 7 = 21.",
        ),
        CategoryCardSub(
          title: "Book summary",
          backendName:
              "Summarize the main plot and themes of 'To Kill a Mockingbird' in under 100 words.",
        ),
        CategoryCardSub(
          title: "History lesson",
          backendName:
              "Give me a brief history lesson about the French Revolution and its impact on Europe.",
        ),
        CategoryCardSub(
          title: "Study tips",
          backendName:
              "Give me study tips to help me stay focused while preparing for a college-level exam.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icPersonal,
      title: "PERSONAL DEVELOPMENT",
      items: [
        CategoryCardSub(
          title: "Boost confidence",
          backendName:
              "Give me three techniques to boost my confidence when speaking in front of a large audience.",
        ),
        CategoryCardSub(
          title: "Set goals",
          backendName:
              "Help me set realistic and achievable goals for my career growth over the next six months.",
        ),
        CategoryCardSub(
          title: "Mindfulness tip",
          backendName:
              "Share a quick 5-minute mindfulness practice that I can do in the morning to start my day calmly.",
        ),
        CategoryCardSub(
          title: "Daily habit",
          backendName:
              "Help me create a daily habit of journaling by giving tips on how to stay consistent.",
        ),
        CategoryCardSub(
          title: "Motivate me",
          backendName:
              "Give me a motivational quote and advice for staying focused on long-term goals despite challenges.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icLanguage,
      title: "LANGUAGE & TRANSLATION",
      items: [
        CategoryCardSub(
          title: "Translate text",
          backendName:
              "Translate this sentence into German: 'I am looking forward to traveling to Berlin next summer.",
        ),
        CategoryCardSub(
          title: "Grammar check",
          backendName:
              "Check this sentence for any grammatical errors: 'She gone to the store before he arrived.",
        ),
        CategoryCardSub(
          title: "Learn phrase",
          backendName:
              "Teach me a common phrase in Italian used when asking for directions.",
        ),
        CategoryCardSub(
          title: "Find synonym",
          backendName:
              "Suggest a synonym for 'important' that is more formal and professional.",
        ),
        CategoryCardSub(
          title: "New vocabulary",
          backendName:
              "Teach me five new advanced vocabulary words and use each in a sentence to explain their meaning.",
        ),
      ],
    ),
    CategoryCard(
      image: ImagePath.icFashion,
      title: "FASHION & BEAUTY",
      items: [
        CategoryCardSub(
          title: "Outfit idea",
          backendName:
              "Suggest a trendy casual outfit for a spring day that includes accessories and shoes.",
        ),
        CategoryCardSub(
          title: "Hair advice",
          backendName:
              "Give me advice on how to style medium-length curly hair for a formal event.",
        ),
        CategoryCardSub(
          title: "Makeup tip",
          backendName:
              "Give me a makeup tip for achieving a natural look that works for everyday wear.",
        ),
        CategoryCardSub(
          title: "Fashion trends",
          backendName:
              "Tell me about the latest winter fashion trends for 2024 and how to style them",
        ),
        CategoryCardSub(
          title: "Skincare routine",
          backendName:
              "Suggest a simple nighttime skincare routine for combination skin that focuses on hydration.",
        ),
      ],
    ),
  ];

  ///TODO: normal, text scan and model use the API call
  String type = "";

  String? modelTitle = "";

  var menu = false.obs;

  textListUpdate(int index) {
    mainListIndex.value = index;
    textList =
        mainList[index].items
            .map(
              (e) => AssistantQuestion(
                question: e.title,
                assistantQuestionId: e.backendName,
              ),
            )
            .toList();

    update();
  }

  String userId = "";
  String isSubscription = "";

  getLoginData() async {
    if (getStorageData.containKey(getStorageData.loginData)) {
      loginData = LoginData.fromJson(
        getStorageData.readObject(getStorageData.loginData),
      );
      userId = loginData!.userId!;
      isSubscription = loginData!.isSubscription!;
    }
    update();
  }

  List<Prompts> dummyDataAdd() {
    return [
      Prompts(
        name: "Personal Productivity",
        formFields: [
          FormFields(name: "How can I manage my time better?"),
          FormFields(name: "Tips for maintaining work-life balance"),
          FormFields(name: "Best apps for task management"),
          FormFields(name: "How to stay motivated while working from home"),
        ],
      ),
      Prompts(
        name: "Health & Wellness",
        formFields: [
          FormFields(name: "Healthy diet plans for beginners"),
          FormFields(name: "Effective home workouts"),
          FormFields(name: "How to meditate effectively"),
          FormFields(name: "Tips for managing stress at work"),
        ],
      ),
      Prompts(
        name: "Sports & Fitness",
        formFields: [
          FormFields(name: "Best exercises for core strength"),
          FormFields(name: "How to improve your running speed"),
          FormFields(name: "Tips for yoga beginners"),
          FormFields(name: "Tips for yoga beginners"),
        ],
      ),
      Prompts(
        name: "Travel & Destinations",
        formFields: [
          FormFields(name: "Top 10 cities to visit in Europe"),
          FormFields(name: "Packing essentials for a beach holiday"),
          FormFields(name: "Best travel apps for 2024"),
          FormFields(name: "Tips for solo travelers"),
        ],
      ),
      Prompts(
        name: "Education & Learning",
        formFields: [
          FormFields(name: "Best online courses to boost your career"),
          FormFields(name: "Learning a new language effectively"),
          FormFields(name: "How to write a research paper"),
          FormFields(name: "Educational apps for kids"),
        ],
      ),
      Prompts(
        name: "Cooking & Recipes",
        formFields: [
          FormFields(name: "Quick healthy breakfast ideas"),
          FormFields(name: "How to make a vegan cake"),
          FormFields(name: "Best cooking tips for beginners"),
          FormFields(name: "World cuisines to try at home"),
        ],
      ),
      Prompts(
        name: "Entertainment",
        formFields: [
          FormFields(name: "Upcoming movie releases this year"),
          FormFields(name: "Best TV shows for binge-watching"),
          FormFields(name: "Top video games of the decade"),
          FormFields(name: "Book recommendations by genre"),
          FormFields(name: "What are some good sci-fi movies?"),
          FormFields(name: "Can you recommend a book about ancient Rome?"),
        ],
      ),
      Prompts(
        name: "Parenting & Family",
        formFields: [
          FormFields(name: "Fun family activities for the weekend"),
          FormFields(name: "Parenting tips for toddlers"),
          FormFields(name: "Educational games for children"),
          FormFields(name: "How to balance work and family life"),
        ],
      ),
      Prompts(
        name: "Pets & Animals",
        formFields: [
          FormFields(name: "How to train your dog"),
          FormFields(name: "Best pets for apartment living"),
          FormFields(name: "Tips for caring for a cat"),
          FormFields(name: "Interesting facts about marine life"),
        ],
      ),
      Prompts(
        name: "Personal Development",
        formFields: [
          FormFields(name: "How can I improve my public speaking skills?"),
          FormFields(name: "What are the best productivity tools?"),
        ],
      ),
      Prompts(
        name: "Finance & Investments",
        formFields: [
          FormFields(name: "How to start investing in stocks"),
          FormFields(name: "Tips for saving money effectively"),
          FormFields(name: "Best budgeting apps in 2024"),
          FormFields(name: "Understanding cryptocurrency basics"),
        ],
      ),
      Prompts(
        name: "General Knowledge",
        formFields: [
          FormFields(name: "Who won the Nobel Prize in Physics last year?"),
          FormFields(name: "What are the main causes of climate change?"),
        ],
      ),
      Prompts(
        name: "Homework Help",
        formFields: [
          FormFields(name: "Can you explain the Pythagorean theorem?"),
          FormFields(
            name: "What is the main theme of 'To Kill a Mockingbird'?",
          ),
        ],
      ),
      Prompts(
        name: "Travel Recommendations",
        formFields: [
          FormFields(name: "What are the top attractions in Paris?"),
          FormFields(name: "What's the best time of year to visit Japan?"),
        ],
      ),
      Prompts(
        name: "Cooking Recipes",
        formFields: [
          FormFields(name: "How do I make a chocolate cake?"),
          FormFields(name: "What are some quick vegan dinner ideas?"),
        ],
      ),
      Prompts(
        name: "Fitness and Health",
        formFields: [
          FormFields(name: "What are some effective workouts for beginners?"),
          FormFields(name: "How many calories are in a banana?"),
        ],
      ),
      Prompts(
        name: "Tech Support",
        formFields: [
          FormFields(name: "Why won't my laptop turn on?"),
          FormFields(name: "How to recover deleted files from my computer?"),
        ],
      ),
      Prompts(
        name: "Financial Advice",
        formFields: [
          FormFields(name: "How do I start investing in stocks?"),
          FormFields(name: "What are the benefits of a Roth IRA?"),
        ],
      ),
      Prompts(
        name: "Daily Fun",
        formFields: [
          FormFields(name: "Tell me a joke."),
          FormFields(name: "What's the word of the day?"),
        ],
      ),
      Prompts(
        name: "Language Learning",
        formFields: [
          FormFields(name: "How do I say 'thank you' in Japanese?"),
          FormFields(name: "Can you help me practice Spanish grammar?"),
        ],
      ),
      Prompts(
        name: "Career Advice",
        formFields: [
          FormFields(
            name:
                "What are some common interview questions for a marketing position?",
          ),
          FormFields(
            name: "How do I write a cover letter for a job application?",
          ),
        ],
      ),
      Prompts(
        name: "Science and Technology",
        formFields: [
          FormFields(name: "Can you explain how a black hole works?"),
          FormFields(
            name:
                "What are the latest advancements in artificial intelligence?",
          ),
        ],
      ),
      Prompts(
        name: "News and Current Events",
        formFields: [
          FormFields(name: "What are today's top news stories?"),
          FormFields(name: "Can you give me an update on the stock market?"),
        ],
      ),
      Prompts(
        name: "Cultural Insights",
        formFields: [
          FormFields(name: "What are some traditional festivals in India?"),
          FormFields(
            name: "How do people celebrate New Year's Eve around the world?",
          ),
        ],
      ),
      Prompts(
        name: "Pet Care",
        formFields: [
          FormFields(name: "How often should I take my dog to the vet?"),
          FormFields(name: "What's a healthy diet for a young cat?"),
        ],
      ),
      Prompts(
        name: "Gardening Tips",
        formFields: [
          FormFields(name: "How do I start a vegetable garden in my backyard?"),
          FormFields(name: "What are some easy-to-care-for indoor plants?"),
        ],
      ),
      Prompts(
        name: "Mindfulness and Meditation",
        formFields: [
          FormFields(name: "Can you guide me through a short meditation?"),
          FormFields(name: "What are some effective stress-relief techniques?"),
        ],
      ),
      Prompts(
        name: "DIY Projects",
        formFields: [
          FormFields(name: "How do I build a simple bookshelf?"),
          FormFields(name: "What are some crafting ideas for kids?"),
        ],
      ),
      Prompts(
        name: "Music and Art",
        formFields: [
          FormFields(name: "Can you teach me about the history of jazz?"),
          FormFields(
            name: "What are some basic painting techniques for beginners?",
          ),
        ],
      ),
    ];
  }

  bool isAssistant = false;
  bool isTextScan = false;

  AssistantData assistantsData = AssistantData();

  List<AllPromptData> promptTitleList = [];
  List<bool> status = [];
  List<Prompts> prompts = [];
  List<String> questionList = [];
  TextEditingController newChatController = TextEditingController();
  FocusNode newChatFocusNode = FocusNode();

  ToolsModel modelType = ToolsModel();
  String pickedImage = "";

  List<RxCommonModel> addOtherProntsList = [
    RxCommonModel(
      title: Languages.of(Get.context!)!.imageScan,
      image: ImagePath.imageScanIcon,
    ),
    // RxCommonModel(title: Languages.of(Get.context!)!.chooseFromLibrary, image: ImagePath.gallery),
    RxCommonModel(
      title: Languages.of(Get.context!)!.uploadFile,
      image: ImagePath.file,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.summarizeWeb,
      image: ImagePath.link,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.generateImage,
      image: ImagePath.generateImagesIcon,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.scanText,
      image: ImagePath.scan,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.aiAssistants,
      image: ImagePath.assistants,
    ),
    RxCommonModel(
      title: Languages.of(Get.context!)!.templates,
      image: ImagePath.templates,
    ),
  ];

  File? imagePath;

  RxList<ChatItem> chatItem = <ChatItem>[].obs;
  ScrollController scrollController = ScrollController();

  @override
  Future<void> onInit() async {
    if (ChatApi.isStreamingData.value) {
      ChatApi.isStreamingData.value = false;
    }
    if (Get.arguments[HttpUtil.chatItemList] != null) {
      chatItem.value = Get.arguments[HttpUtil.chatItemList];
      WidgetsBinding.instance.addObserver(this);

      WidgetsBinding.instance.addPostFrameCallback((_) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      });
    }
    if (Get.arguments[HttpUtil.isRealTime] != null) {
      isRealTime = Get.arguments[HttpUtil.isRealTime];
      printAction("isRealTime isRealTime isRealTime  $isRealTime");

      mainList = [
        CategoryCard(
          image: ImagePath.newspaper,
          title: "NEWS",
          items: [
            CategoryCardSub(
              title: "Breaking news",
              backendName:
                  "Find the latest breaking news happening around the world right now.",
            ),
            CategoryCardSub(
              title: "Tech updates",
              backendName:
                  "Search for the most recent technology advancements and news in AI and robotics.",
            ),
            CategoryCardSub(
              title: "Political updates",
              backendName:
                  "Provide current updates on political events in the United States.",
            ),
            CategoryCardSub(
              title: "Sports news",
              backendName:
                  "What's the latest news in the Premier League today?",
            ),
            CategoryCardSub(
              title: "Weather alerts",
              backendName:
                  "Give me real-time weather updates and warnings for my current location.",
            ),
          ],
        ),
        CategoryCard(
          image: ImagePath.entertainment,
          title: "ENTERTAINMENT",
          items: [
            CategoryCardSub(
              title: "Celebrity gossip",
              backendName:
                  "Find the latest celebrity news and trending gossip for today.",
            ),
            CategoryCardSub(
              title: "Movie reviews",
              backendName:
                  "What are the newest movie reviews for films released this week?",
            ),
            CategoryCardSub(
              title: "TV show updates",
              backendName:
                  "What’s the latest news about the next season of 'Stranger Things'?",
            ),
            CategoryCardSub(
              title: "Music trends",
              backendName:
                  "Show me the top trending songs and albums this week worldwide.",
            ),
            CategoryCardSub(
              title: "Award shows",
              backendName:
                  "Who were the winners at the most recent Grammy Awards?",
            ),
          ],
        ),
        CategoryCard(
          image: ImagePath.icMoney,
          title: "WEATHER",
          items: [
            CategoryCardSub(
              title: "Current weather",
              backendName:
                  "What are the current weather conditions, including temperature and wind speed, in Delhi?",
            ),
            CategoryCardSub(
              title: "7-day forecast",
              backendName:
                  "Provide the 7-day weather forecast for New York with highs, lows, and precipitation chances.",
            ),
            CategoryCardSub(
              title: "Global temperatures",
              backendName:
                  "What are the highest and lowest recorded temperatures around the world today?",
            ),
            CategoryCardSub(
              title: "Sunrise and sunset",
              backendName: "What time is sunrise and sunset in Dubai today?",
            ),
            CategoryCardSub(
              title: "Weather trends",
              backendName:
                  "What are the latest global weather trends, including unusual patterns or anomalies?",
            ),
          ],
        ),
        CategoryCard(
          image: ImagePath.icHealth,
          title: "HEALTH",
          items: [
            CategoryCardSub(
              title: "Health trends",
              backendName:
                  "What are the current trends in mental health awareness globally?",
            ),
            CategoryCardSub(
              title: "Disease updates",
              backendName:
                  "Provide the latest updates on flu outbreaks in my country.",
            ),
            CategoryCardSub(
              title: "Fitness trends",
              backendName:
                  "What are the most popular fitness trends this year?",
            ),
            CategoryCardSub(
              title: "Diet tips",
              backendName:
                  "Find real-time tips for maintaining a balanced diet during the holiday season.",
            ),
            CategoryCardSub(
              title: "Medical research",
              backendName:
                  "What are the latest advancements in cancer research?",
            ),
          ],
        ),
        CategoryCard(
          image: ImagePath.icTravel,
          title: "TRAVEL",
          items: [
            CategoryCardSub(
              title: "Flight deals",
              backendName:
                  "Search for the best last-minute flight deals to Europe this week.",
            ),
            CategoryCardSub(
              title: "Local attractions",
              backendName: "What are the top-rated attractions in Paris today?",
            ),
            CategoryCardSub(
              title: "Cruise deals",
              backendName:
                  "What are the best deals for Caribbean cruises departing in December?",
            ),
            CategoryCardSub(
              title: "Hotel reviews",
              backendName:
                  "Find the most recent reviews of affordable hotels in New York City.",
            ),
            CategoryCardSub(
              title: "Cultural festivals",
              backendName:
                  "What cultural festivals are happening in India this month?",
            ),
          ],
        ),
        CategoryCard(
          image: ImagePath.spirituality,
          title: "SPIRITUALITY",
          items: [
            CategoryCardSub(
              title: "Daily affirmations",
              backendName:
                  "Find powerful daily affirmations shared by spiritual leaders today.",
            ),
            CategoryCardSub(
              title: "Meditation guides",
              backendName:
                  "What are the latest guided meditations available online for stress relief?",
            ),
            CategoryCardSub(
              title: "Spiritual event",
              backendName:
                  "What spiritual retreats, yoga workshops, or mindfulness events are happening this month in Tulum?",
            ),
            CategoryCardSub(
              title: "Astrology insights",
              backendName:
                  "What are today's horoscope predictions for all zodiac signs?",
            ),
            CategoryCardSub(
              title: "Manifestation practices",
              backendName:
                  "What are the latest techniques and tips for effective manifestation shared online?",
            ),
          ],
        ),
        CategoryCard(
          image: ImagePath.shopping,
          title: "SHOPPING",
          items: [
            CategoryCardSub(
              title: "Deals today",
              backendName:
                  "What are the best online shopping deals happening right now?",
            ),
            CategoryCardSub(
              title: "Product reviews",
              backendName:
                  "Find real-time reviews for the latest iPhone model and how it compares to other smartphones.",
            ),
            CategoryCardSub(
              title: "Fashion sales",
              backendName:
                  "Search for top discounts on winter fashion trends for 2024.",
            ),
            CategoryCardSub(
              title: "Product reviews",
              backendName:
                  "Find real-time reviews for the newest iPhone model.",
            ),
            CategoryCardSub(
              title: "Holiday gifts",
              backendName:
                  "What are the most popular holiday gifts people are buying this year?",
            ),
          ],
        ),
        CategoryCard(
          image: ImagePath.sports,
          title: "SPORTS",
          items: [
            CategoryCardSub(
              title: "Match results",
              backendName:
                  "What are the latest match results for the NBA today?",
            ),
            CategoryCardSub(
              title: "Upcoming games",
              backendName:
                  "Find the schedule for upcoming FIFA World Cup matches.",
            ),
            CategoryCardSub(
              title: "Player stats",
              backendName:
                  "Show me the current stats for Lionel Messi in this season.",
            ),
            CategoryCardSub(
              title: "Sports headlines",
              backendName:
                  "What are the top trending sports headlines globally right now?",
            ),
            CategoryCardSub(
              title: "Sports news",
              backendName:
                  "What are the top trending sports headlines globally?",
            ),
          ],
        ),
        CategoryCard(
          image: ImagePath.icFood,
          title: "FOOD & DRINK",
          items: [
            CategoryCardSub(
              title: "Trending recipes",
              backendName:
                  "What are the most popular recipes trending online today?",
            ),
            CategoryCardSub(
              title: "Restaurant reviews",
              backendName:
                  "Find the latest reviews for fine-dining restaurants in Los Angeles.",
            ),
            CategoryCardSub(
              title: "Coffee trends",
              backendName:
                  "What are the latest trends in specialty coffee this year?",
            ),
            CategoryCardSub(
              title: "New food products",
              backendName:
                  "What are the newest food products launched this month?",
            ),
            CategoryCardSub(
              title: "Event catering",
              backendName:
                  "Search for trending catering services for weddings in New York.",
            ),
          ],
        ),
        CategoryCard(
          image: ImagePath.icEducation,
          title: "EDUCATION",
          items: [
            CategoryCardSub(
              title: "Online courses",
              backendName:
                  "Find the most popular online courses for learning Python programming.",
            ),
            CategoryCardSub(
              title: "Scholarships",
              backendName:
                  "What are the latest scholarships available for international students in 2024?",
            ),
            CategoryCardSub(
              title: "Study tools",
              backendName:
                  "Search for trending tools to help students improve their study habits.",
            ),
            CategoryCardSub(
              title: "University rankings",
              backendName:
                  "What are the updated rankings for the top universities globally in 2024?",
            ),
            CategoryCardSub(
              title: "Research topics",
              backendName:
                  "What are the most current research topics in environmental science?",
            ),
          ],
        ),
        CategoryCard(
          image: ImagePath.technology,
          title: "TECHNOLOGY",
          items: [
            CategoryCardSub(
              title: "Tech launches",
              backendName: "Find the latest tech products launched this week.",
            ),
            CategoryCardSub(
              title: "AI trends",
              backendName:
                  "What are the current advancements in artificial intelligence?",
            ),
            CategoryCardSub(
              title: "Gadget reviews",
              backendName: "Search for reviews on the latest wireless earbuds.",
            ),
            CategoryCardSub(
              title: "Cybersecurity tips",
              backendName:
                  "What are the best tips for staying safe online in 2024?",
            ),
            CategoryCardSub(
              title: "Tech events",
              backendName:
                  "Find upcoming tech conferences in the United States.",
            ),
          ],
        ),
      ];
    }

    getStorageData.saveSend(value: false);
    getStorageData.saveListening(value: false);
    WidgetsBinding.instance.addObserver(this);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // scrollController.jumpTo(scrollController.position.maxScrollExtent);
    });

    textListUpdate(0);
    getLoginData();
    List<Prompts> list = dummyDataAdd();
    AllPromptData prompt = AllPromptData(name: "Suggestion", prompts: list);

    promptTitleList.insert(0, prompt);
    status = List.generate(
      promptTitleList[0].prompts!.length,
      (index) => false,
    );
    status[0] = true;
    questionList =
        promptTitleList[0].prompts![0].formFields!
            .map((e) => e.name ?? "")
            .toList();
    if (Get.arguments != null) {
      toolModel = Get.arguments["toolModel"];

      if (Get.arguments[HttpUtil.isAssistant]) {
        isAssistant = Get.arguments[HttpUtil.isAssistant];
        assistantsData =
            Get.arguments[HttpUtil.assistantData] ?? AssistantData();
        var model = switch (assistantsData.model) {
          null => null,
          AIModel.gpt4o => ModelType.chatGPT4o,
          AIModel.gemini => ModelType.gemini,
        };
        if (model != null) {
          var index = Get.find<BottomNavigationController>().selectAiModelList
              .indexWhere((element) => element.modelType == model);

          if (!index.isNegative) {
            getStorageData.saveString(
              getStorageData.selectModelIndex,
              index.toString(),
            );
            modelTypeForDropDown = Rx(
              Get.find<BottomNavigationController>().selectAiModelList[index],
            );
          }
        } else {
          getInitialModel();
        }
        textList = assistantsData.assistantQuestion ?? [];
        mainList = [];
        printAction("assistantId--------------${assistantsData.assistantId}");

        update();
      } else if (Get.arguments.containsKey(HttpUtil.isTextScan)) {
        isTextScan = true;
        textList = [
          AssistantQuestion(question: "Calculate this."),
          AssistantQuestion(question: "Simplify this."),
          AssistantQuestion(question: "Try to understand it."),
        ];
        mainList = [];
        Future.delayed(const Duration(milliseconds: 500), () async {
          imagePath = await imagePickerBottomSheet(isSub: true);
          debugPrint("*file.path----------------- $imagePath");

          if (imagePath != null) {
            newChatController.text = await imageToText(file: imagePath!);
            if (newChatController.text.isNotEmpty) {
              getStorageData.saveSend(value: true);
              if (newChatFocusNode.hasFocus) {
                newChatFocusNode.unfocus();
              }

              printAction(
                "readSendreadSendreadSendreadSend ${getStorageData.readSend()}",
              );
              getStorageData.saveListening(value: false);
              await Get.put(BottomNavigationController()).speechToText.stop();

              Future.delayed(const Duration(milliseconds: 100), () {
                newChatFocusNode.requestFocus();
              });
              update();
            }
          }
        });
        getInitialModel();
      } else if (Get.arguments.containsKey(HttpUtil.isModel)) {
        modelType = Get.arguments[HttpUtil.isModel];
      } else {
        getInitialModel();
      }
    }

    super.onInit();
  }

  String get aiModelName =>
      modelTypeForDropDown?.value?.model ??
      (Get.put(BottomNavigationController()).selectAiModelList.isEmpty
          ? "gpt-3.5-trbuo"
          : Get.put(BottomNavigationController())
                  .selectAiModelList[(getStorageData.containKey(
                        getStorageData.selectModelIndex,
                      ))
                      ? int.parse(
                        getStorageData.readString(
                              getStorageData.selectModelIndex,
                            ) ??
                            "0",
                      )
                      : 0]
                  .model ??
              "gpt-3.5-turbo");

  ModelType? get aiModelType {
    if (assistantsData.model != null) {
      return switch (assistantsData.model!) {
        AIModel.gpt4o => ModelType.chatGPT4o,
        AIModel.gemini => ModelType.gemini,
      };
    }

    return modelTypeForDropDown.log?.value?.modelType ?? modelType.modelType;
  }

  @override
  Future<void> onClose() async {
    ChatApi.stopStreaming();
    HttpUtil.cancelRequests();

    modelsHistoryAPI(
      chatItem,
      modelType.model.toString(),
      aiModelName,
      assistantId:
          (!Utils().isValidationEmpty(assistantsData.assistantId))
              ? assistantsData.assistantId
              : "",
      type: type,
    );
    Get.put(
      BottomNavigationController(),
    ).backToTemplateOrAssistants(apiCall: apiCall);

    super.onClose();
  }
}

class CategoryCard {
  final String title;
  final String? image;
  final List<CategoryCardSub> items;

  CategoryCard({required this.title, this.image, required this.items});
}

class CategoryCardSub {
  final String? title;
  final String? backendName;

  CategoryCardSub({this.title, this.backendName});
}

class ChatItem {
  String? question;
  Rx<String?> audioFile = Rx(null);
  String? answer;
  String? phmID;
  bool isHistorySave;
  bool? isUpgraded;
  String? modelLogo;
  RxList<String>? suggestionList;

  ChatItem({
    this.question,
    this.answer,
    this.phmID,
    this.isUpgraded,
    this.modelLogo,
    this.isHistorySave = false,
    this.suggestionList,
  });

  Map<String, dynamic> toJson() => {
    'question': question,
    'answer': answer,
    'phmID': phmID,
    'isUpgraded': isUpgraded,
    'modelLogo': modelLogo,
    'isHistorySave': isHistorySave,
    'suggestionList': suggestionList,
  };
}

goIt({RxList<String>? suggestionList}) {
  showDialog(
    context: Get.context!,
    builder: (context) {
      return AlertDialog(
        insetPadding: EdgeInsets.symmetric(horizontal: 10.px),
        backgroundColor: AppColors().whiteAndDark,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Align(
              alignment: Alignment.centerLeft,
              child: Icon(Icons.settings, color: AppColors.primary, size: 24),
            ),
            SizedBox(height: 20.px),
            AppText(
              Languages.of(Get.context!)!.managingFollowUpQuestions,
              fontSize: 18.px,
              fontFamily: FontFamily.helveticaBold,
            ),
            AppText(
              Languages.of(Get.context!)!.youCanEnableOrDisable,
              fontSize: 16.px,
            ),
            SizedBox(height: 20.px),
            CommonButton(
              onTap: () {
                HapticFeedback.mediumImpact();
                suggestionList?.value = [];
                getStorageData.saveString(getStorageData.suggestionView, "0");
                Get.back();
              },
              title: Languages.of(context)!.gotIt,
            ),
          ],
        ),
      );
    },
  );
}

Widget chatQuestionAnsView({
  ScrollController? scrollController,
  String? question,
  String? questionIcon,
  Rx<String?>? audioFile,
  RxList<String>? suggestionList,
  Function(String data)? suggestionOnTap,
  String? questionImage,
  String? ansImage,
  String? ans,
  bool isEdit = false,
  String? ansIcon,
  bool? isUpgrade,
  bool isBorder = true,
  bool isAnimatedText = false,
  bool isRealTime = false,
  bool? isImageScan = false,
  Function(LongPressStartDetails)? onTap,
  Function()? onTapAns,
  Function(String)? onTapEdit,
  Function()? regenerateResponseOnTap,
  Function()? onFinished,
}) {
  if (isUpgrade ?? false || suggestionList != null) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController?.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  return Column(
    mainAxisSize: MainAxisSize.min,
    mainAxisAlignment: MainAxisAlignment.start,
    crossAxisAlignment: CrossAxisAlignment.start,
    children: [
      if (!utils.isValidationEmpty(question))
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (utils.isValidationEmpty(questionIcon))
              if (!utils.isValidationEmpty(
                    getStorageData.readString(getStorageData.profile),
                  ) &&
                  getStorageData
                          .readString(getStorageData.profile)
                          .toString()
                          .compareTo("https//aichatsy.com") ==
                      1)
                ClipOval(
                  child: CachedNetworkImage(
                    imageUrl:
                        getStorageData
                            .readString(getStorageData.profile)
                            .toString(),
                    progressIndicatorBuilder:
                        (context, url, progress) =>
                            progressIndicatorView(circle: true),
                    errorWidget:
                        (context, url, uri) =>
                            errorWidgetView(height: 32.px, wight: 32.px),
                    height: 25.px,
                    width: 25.px,
                    fit: BoxFit.cover,
                  ),
                )
              else
                Image.asset(
                  (!utils.isValidationEmpty(
                        getStorageData.readString(getStorageData.profile),
                      )
                      ? getStorageData.readString(getStorageData.profile) ?? ""
                      : ImagePath.user4),
                  height: 25.px,
                )
            else if (questionIcon!.compareTo("https//aichatsy.com") == 1)
              ClipOval(
                child: CachedNetworkImage(
                  imageUrl: questionIcon,
                  progressIndicatorBuilder:
                      (context, url, progress) =>
                          progressIndicatorView(circle: true),
                  errorWidget:
                      (context, url, uri) =>
                          errorWidgetView(height: 32.px, wight: 32.px),
                  height: 25.px,
                  width: 25.px,
                  fit: BoxFit.cover,
                ),
              )
            else
              Image.asset(questionIcon, height: 25.px),
            SizedBox(width: 8.px),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (!utils.isValidationEmpty(questionImage))
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(12.px)),
                      child:
                          (questionImage!.contains("https://aichatsy.com"))
                              ? CachedNetworkImage(
                                imageUrl: questionImage,
                                progressIndicatorBuilder:
                                    (context, url, progress) =>
                                        progressIndicatorView(
                                          borderRadius: 12.px,
                                        ),
                                errorWidget:
                                    (context, url, uri) => errorWidgetView(
                                      height: 32.px,
                                      wight: 32.px,
                                    ),
                                width: 150.px,
                                height: 150.px,
                                fit: BoxFit.cover,
                              )
                              : Image.file(
                                File(questionImage),
                                width: 150.px,
                                height: 150.px,
                                fit: BoxFit.cover,
                              ),
                    ).paddingOnly(bottom: 5.px),
                  if (!utils.isValidationEmpty(question))
                    Stack(
                      alignment: Alignment.bottomLeft,
                      children: [
                        AppContextMenuWidget(
                          text: question ?? "",
                          isQuestion: true,
                          isEdit: isEdit,
                          onTap: (text, title) {
                            if (title == Languages.of(Get.context!)!.edit) {
                              if (onTapEdit != null) {
                                onTapEdit(question?.trim() ?? '');
                              }
                            } else if (title ==
                                Languages.of(Get.context!)!.readLoud) {
                              showDialog(
                                barrierDismissible: false,
                                context: Get.context!,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    alignment: Alignment.bottomCenter,
                                    content: TextToSpeechView(
                                      text: (question ?? "").obs,
                                      isShowElevenLab:
                                          Constants.isShowElevenLab,
                                      resultData: audioFile,
                                    ),
                                  );
                                },
                              );
                            }
                          },
                          child: GestureDetector(
                            onLongPressStart:
                                onTap ??
                                (value) {
                                  FocusManager.instance.primaryFocus?.unfocus();

                                  Navigator.of(Get.context!)
                                      .push(
                                        PageRouteBuilder(
                                          pageBuilder:
                                              (context, _, __) => NewChatHelper(
                                                text: question ?? "",
                                                isQuestion: true,
                                                isEdit: isEdit,
                                                imageView:
                                                    ((!utils.isValidationEmpty(
                                                              getStorageData
                                                                  .readString(
                                                                    getStorageData
                                                                        .profile,
                                                                  ),
                                                            ) &&
                                                            getStorageData
                                                                    .readString(
                                                                      getStorageData
                                                                          .profile,
                                                                    )
                                                                    .toString()
                                                                    .compareTo(
                                                                      "https//aichatsy.com",
                                                                    ) ==
                                                                1)
                                                        ? ClipOval(
                                                          child: CachedNetworkImage(
                                                            imageUrl:
                                                                getStorageData
                                                                    .readString(
                                                                      getStorageData
                                                                          .profile,
                                                                    )
                                                                    .toString(),
                                                            progressIndicatorBuilder:
                                                                (
                                                                  context,
                                                                  url,
                                                                  progress,
                                                                ) =>
                                                                    progressIndicatorView(
                                                                      circle:
                                                                          true,
                                                                    ),
                                                            errorWidget:
                                                                (
                                                                  context,
                                                                  url,
                                                                  uri,
                                                                ) =>
                                                                    errorWidgetView(
                                                                      height:
                                                                          32.px,
                                                                      wight:
                                                                          32.px,
                                                                    ),
                                                            height: 25.px,
                                                            width: 25.px,
                                                            fit: BoxFit.cover,
                                                          ),
                                                        )
                                                        : Image.asset(
                                                          questionIcon ??
                                                              (!utils.isValidationEmpty(
                                                                    getStorageData.readString(
                                                                      getStorageData
                                                                          .profile,
                                                                    ),
                                                                  )
                                                                  ? getStorageData.readString(
                                                                        getStorageData
                                                                            .profile,
                                                                      ) ??
                                                                      ""
                                                                  : ImagePath
                                                                      .user4),
                                                          height: 25.px,
                                                        )),
                                              ),
                                          opaque: false,
                                        ),
                                      )
                                      .then((value) {
                                        if (value != null) {
                                          if (value[HttpUtil.type] ==
                                              Languages.of(
                                                Get.context!,
                                              )!.edit) {
                                            if (onTapEdit != null) {
                                              onTapEdit(question?.trim() ?? '');
                                            }
                                          } else if (value[HttpUtil.type] ==
                                              Languages.of(
                                                Get.context!,
                                              )!.readLoud) {
                                            showDialog(
                                              barrierDismissible: false,
                                              context: Get.context!,
                                              builder: (context) {
                                                return AlertDialog(
                                                  backgroundColor:
                                                      Colors.transparent,
                                                  alignment:
                                                      Alignment.bottomCenter,
                                                  content: TextToSpeechView(
                                                    text: (question ?? "").obs,
                                                    isShowElevenLab:
                                                        Constants
                                                            .isShowElevenLab,
                                                    resultData: audioFile,
                                                  ),
                                                );
                                              },
                                            );
                                          }
                                        }
                                      });
                                },
                            child: Container(
                              // width: double.infinity,
                              margin: EdgeInsets.only(left: 6.px),
                              decoration: BoxDecoration(
                                color: AppColors.question,
                                borderRadius: BorderRadius.all(
                                  Radius.circular(10.px),
                                ),
                              ),
                              padding: EdgeInsets.symmetric(
                                vertical: 7.px,
                                horizontal: 12.px,
                              ),
                              child: AppText(
                                question?.trim() ?? '',
                                fontSize: 14.px,
                                color: AppColors.white,
                              ),
                            ),
                          ),
                        ),
                        SvgPicture.asset(
                          ImagePath.arrowChat,
                          width: 12.px,
                          height: 12.px,
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ).marginOnly(bottom: 8.px, top: 8.px),
      if ((!utils.isValidationEmpty(ans)) ||
          (!utils.isValidationEmpty(ansImage)) ||
          isUpgrade != null ||
          isImageScan != null)
        Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            if (isUpgrade == null && isImageScan != null && isImageScan)
              Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 20.px,
                    width: 20.px,
                    child: const CircularProgressIndicator(
                      color: AppColors.primary,
                      strokeWidth: 2,
                    ),
                  ),
                  SvgPicture.asset(
                    ImagePath.icImageLoading,
                    width: 15.px,
                    height: 15.px,
                  ),
                  // Container(
                  //   height: 12.px,
                  //   width: 12.px,
                  //   decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                  // )
                ],
              )
            else
              Container(
                height: 25.px,
                width: 25.px,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border:
                      isBorder
                          ? Border.all(
                            color: AppColors().darkAndWhite.changeOpacity(0.05),
                          )
                          : null,
                ),
                child:
                    ansIcon?.contains("https://aichatsy.com") ?? false
                        ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: ansIcon ?? "",
                            progressIndicatorBuilder:
                                (context, url, progress) =>
                                    progressIndicatorView(circle: true),
                            errorWidget:
                                (context, url, uri) => errorWidgetView(
                                  height: 25.px,
                                  wight: 25.px,
                                ),
                            height: 25.px,
                            width: 25.px,
                            fit: BoxFit.cover,
                          ),
                        )
                        : (ansIcon != null)
                        ? ClipOval(
                          child:
                              (ansIcon.contains(".svg"))
                                  ? SvgPicture.asset(
                                    ansIcon,
                                    height: isBorder ? 13.px : 23.px,
                                  )
                                  : Image.asset(
                                    ansIcon,
                                    height: isBorder ? 18.px : 30.px,
                                  ),
                        )
                        : Image.asset(
                          ((isLight) ? ImagePath.darkLogo : ImagePath.logo),
                          height: isBorder ? 13.px : 23.px,
                        ),
              ),
            SizedBox(width: 8.px),
            Flexible(
              child:
                  (isUpgrade != null && isUpgrade)
                      ? Column(
                        children: [
                          AnimatedTextKit(
                            isRepeatingAnimation: false,
                            onFinished: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                scrollController?.jumpTo(
                                  scrollController.position.maxScrollExtent,
                                );
                              });
                              Global.isVibrate = false;
                              Global.showTheReview();
                            },
                            onNext: (p0, p1) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                scrollController?.jumpTo(
                                  scrollController.position.maxScrollExtent,
                                );
                              });
                              printAction("onNextintp0 $p0 ");
                              printAction("onNextboolp1 $p1 ");
                            },
                            onNextBeforePause: (p0, p1) {
                              printAction("onNextBeforePauseintp0 $p0 ");
                              printAction("onNextBeforePauseboolp1 $p1 ");
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                scrollController?.jumpTo(
                                  scrollController.position.maxScrollExtent,
                                );
                              });
                            },
                            animatedTexts: [
                              TyperAnimatedText(
                                Languages.of(
                                  Get.context!,
                                )!.oopsYouReachedYourDailyMessaging,
                                speed: const Duration(milliseconds: 10),
                                textStyle: TextStyle(
                                  fontSize: 14.px,
                                  color: AppColors().darkAndWhite,
                                  fontFamily: FontFamily.helveticaRegular,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                            onTap: () {
                              if (kDebugMode) {
                                debugPrint("I am executing");
                              }
                            },
                          ),
                          GestureDetector(
                            onTap: () {
                              // if (Global.isSubscription.value != "1") {
                              Get.put(ChatGptController()).goToPurchasePage();
                              // } else {
                              //   Get.delete<PurchaseController>();
                              //   Get.toNamed(Routes.PURCHASE)!.then((value) {
                              //     if (value != null && value == "plan_purchase") {
                              //       // controller.getHomeAPI();
                              //     }
                              //   });
                              // }
                            },
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              margin: EdgeInsets.only(top: 10.px),
                              padding: EdgeInsets.symmetric(
                                vertical: 10.px,
                                horizontal: 10.w,
                              ),
                              decoration: BoxDecoration(
                                border: Border.all(
                                  color: AppColors().darkAndWhite.changeOpacity(
                                    0.04,
                                  ),
                                ),
                                borderRadius: BorderRadius.circular(25.px),
                                color: AppColors().bgColor,
                              ),
                              child: RichText(
                                text: TextSpan(
                                  children: [
                                    TextSpan(
                                      text:
                                          Languages.of(
                                            Get.context!,
                                          )!.upgradeToPRO,
                                      style: TextStyle(
                                        fontSize: 16.px,
                                        color: AppColors().darkAndWhite,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                    TextSpan(
                                      text: Languages.of(Get.context!)!.pro,
                                      style: TextStyle(
                                        fontSize: 18.px,
                                        color: AppColors.primary,
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      )
                      : AppContextMenuWidget(
                        text: ans ?? "",
                        isQuestion: false,
                        isEdit: isEdit,
                        onTap: (text, title) {
                          if (title == Languages.of(Get.context!)!.edit) {
                            // ChatItem askData = value[HttpUtil.data];
                            // Utils().showToast(message: askData.question.toString());
                          } else if (title ==
                              Languages.of(Get.context!)!.readLoud) {
                            showDialog(
                              barrierDismissible: false,
                              context: Get.context!,
                              builder: (context) {
                                return AlertDialog(
                                  backgroundColor: Colors.transparent,
                                  alignment: Alignment.bottomCenter,
                                  content: TextToSpeechView(
                                    text: (ans ?? "").obs,
                                    isShowElevenLab: Constants.isShowElevenLab,
                                    resultData: audioFile,
                                  ),
                                );
                              },
                            );
                          } else if (title ==
                              Languages.of(Get.context!)!.regenerateResponse) {
                            regenerateResponseOnTap?.call();
                          }
                        },
                        child: GestureDetector(
                          onTap:
                              (ansImage == ImagePath.icImageLoading)
                                  ? () {}
                                  : onTapAns,
                          onLongPressStart:
                              (onTapAns != null ||
                                      (isImageScan != null && isImageScan))
                                  ? (value) {}
                                  : (value) {
                                    FocusManager.instance.primaryFocus
                                        ?.unfocus();

                                    Navigator.of(Get.context!)
                                        .push(
                                          PageRouteBuilder(
                                            pageBuilder:
                                                (
                                                  context,
                                                  _,
                                                  __,
                                                ) => NewChatHelper(
                                                  text: ans ?? "",
                                                  isQuestion: false,
                                                  isEdit: isEdit,
                                                  imageView:
                                                      ansIcon?.contains(
                                                                "https://aichatsy.com",
                                                              ) ??
                                                              false
                                                          ? ClipOval(
                                                            child: CachedNetworkImage(
                                                              imageUrl:
                                                                  ansIcon ?? "",
                                                              progressIndicatorBuilder:
                                                                  (
                                                                    context,
                                                                    url,
                                                                    progress,
                                                                  ) => progressIndicatorView(
                                                                    circle:
                                                                        true,
                                                                  ),
                                                              errorWidget:
                                                                  (
                                                                    context,
                                                                    url,
                                                                    uri,
                                                                  ) => errorWidgetView(
                                                                    height:
                                                                        25.px,
                                                                    wight:
                                                                        25.px,
                                                                  ),
                                                              height: 25.px,
                                                              width: 25.px,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          )
                                                          : (ansIcon != null)
                                                          ? ClipOval(
                                                            child:
                                                                (ansIcon.contains(
                                                                      ".svg",
                                                                    ))
                                                                    ? SvgPicture.asset(
                                                                      ansIcon,
                                                                      height:
                                                                          isBorder
                                                                              ? 13.px
                                                                              : 23.px,
                                                                    )
                                                                    : Image.asset(
                                                                      ansIcon,
                                                                      height:
                                                                          isBorder
                                                                              ? 18.px
                                                                              : 30.px,
                                                                    ),
                                                          )
                                                          : Image.asset(
                                                            ((isLight)
                                                                ? ImagePath
                                                                    .darkLogo
                                                                : ImagePath
                                                                    .logo),
                                                            height:
                                                                isBorder
                                                                    ? 13.px
                                                                    : 23.px,
                                                          ),
                                                ),
                                            opaque: false,
                                          ),
                                        )
                                        .then((value) {
                                          if (value != null) {
                                            if (value[HttpUtil.type] ==
                                                Languages.of(
                                                  Get.context!,
                                                )!.edit) {
                                              ChatItem askData =
                                                  value[HttpUtil.data];
                                              Utils().showToast(
                                                message:
                                                    askData.question.toString(),
                                              );
                                            } else if (value[HttpUtil.type] ==
                                                Languages.of(
                                                  Get.context!,
                                                )!.readLoud) {
                                              showDialog(
                                                barrierDismissible: false,
                                                context: Get.context!,
                                                builder: (context) {
                                                  return AlertDialog(
                                                    backgroundColor:
                                                        Colors.transparent,
                                                    alignment:
                                                        Alignment.bottomCenter,
                                                    content: TextToSpeechView(
                                                      text: (ans ?? "").obs,
                                                      isShowElevenLab:
                                                          Constants
                                                              .isShowElevenLab,
                                                      resultData: audioFile,
                                                    ),
                                                  );
                                                },
                                              );
                                            } else if (value[HttpUtil.type] ==
                                                Languages.of(
                                                  Get.context!,
                                                )!.regenerateResponse) {
                                              regenerateResponseOnTap?.call();
                                            }
                                          }
                                        });
                                  },
                          child:
                              !utils.isValidationEmpty(ansImage)
                                  ? (ansImage == ImagePath.icImageLoading)
                                      ? Container(
                                        // width: double.infinity,
                                        // height: Get.size.width / 1.3,
                                        decoration: BoxDecoration(
                                          color: AppColors().ansColor,
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(20.px),
                                          ),
                                        ),
                                        padding: EdgeInsets.symmetric(
                                          vertical: 8.px,
                                          horizontal: 8.px,
                                        ),
                                        child: ClipRRect(
                                          borderRadius: BorderRadius.circular(
                                            17.px,
                                          ),
                                          child: imageGenerationLoadingImage(),
                                        ),
                                      )
                                      // Shimmer.fromColors(
                                      //     baseColor: Colors.grey,
                                      //     highlightColor: AppColors().darkAndWhite,
                                      //     child: Text(
                                      //       'Creating Image',
                                      //       textAlign: TextAlign.center,
                                      //       style: TextStyle(fontSize: 16.px, fontFamily: FontFamily.helveticaBold),
                                      //     ))
                                      : Hero(
                                        tag: ansImage ?? "",
                                        child: Container(
                                          // width: double.infinity,
                                          // height: Get.size.width / 1.3,
                                          decoration: BoxDecoration(
                                            color: AppColors().ansColor,
                                            borderRadius: BorderRadius.all(
                                              Radius.circular(20.px),
                                            ),
                                          ),
                                          padding: EdgeInsets.symmetric(
                                            vertical: 8.px,
                                            horizontal: 8.px,
                                          ),
                                          child: ClipRRect(
                                            borderRadius: BorderRadius.circular(
                                              17.px,
                                            ),
                                            child: CachedNetworkImage(
                                              imageUrl: ansImage ?? "",
                                              progressIndicatorBuilder:
                                                  (context, url, progress) =>
                                                      imageGenerationLoadingImage(),
                                              errorWidget:
                                                  (context, url, uri) =>
                                                      errorWidgetView(
                                                        height: 25.px,
                                                        wight: 25.px,
                                                      ),
                                              // height: 25.px,
                                              // width: 25.px,
                                              fit: BoxFit.scaleDown,
                                            ),
                                          ),
                                        ),
                                      )
                                  : Obx(() {
                                    ChatApi.isStreamingData.value;
                                    return Container(
                                      decoration: BoxDecoration(
                                        color: AppColors().ansColor,
                                        borderRadius: BorderRadius.all(
                                          Radius.circular(10.px),
                                        ),
                                      ),
                                      padding: EdgeInsets.symmetric(
                                        vertical: 7.px,
                                        horizontal: 12.px,
                                      ),
                                      child:
                                          (isRealTime &&
                                                  utils.isValidationEmpty(
                                                    ans?.trim(),
                                                  ) &&
                                                  isEdit &&
                                                  ChatApi.isStreamingData.value)
                                              ? Shimmer.fromColors(
                                                baseColor: Colors.grey,
                                                highlightColor:
                                                    AppColors().darkAndWhite,
                                                child: Text(
                                                  Languages.of(Get.context!)!
                                                      .realTimeWebSearch
                                                      .capitalize
                                                      .toString(),
                                                  textAlign: TextAlign.center,
                                                  style: TextStyle(
                                                    fontSize: 16.px,
                                                    fontFamily:
                                                        FontFamily
                                                            .helveticaBold,
                                                  ),
                                                ),
                                              )
                                              : isAnimatedText
                                              ? AnimatedTextKit(
                                                key: ValueKey<String>(
                                                  ans?.trim() ?? "",
                                                ),
                                                isRepeatingAnimation: false,
                                                onFinished: () {
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        scrollController?.jumpTo(
                                                          scrollController
                                                              .position
                                                              .maxScrollExtent,
                                                        );
                                                      });
                                                  if (isImageScan == null &&
                                                      (!(isImageScan ??
                                                          true))) {
                                                    Global.showTheReview();
                                                  }
                                                  if (onFinished != null) {
                                                    onFinished();
                                                  }
                                                },
                                                onNext: (p0, p1) {
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        scrollController?.jumpTo(
                                                          scrollController
                                                              .position
                                                              .maxScrollExtent,
                                                        );
                                                      });
                                                },
                                                onNextBeforePause: (p0, p1) {
                                                  printAction(
                                                    "onNextBeforePauseintp0 $p0",
                                                  );
                                                  printAction(
                                                    "onNextBeforePauseboolp1 $p1",
                                                  );
                                                  WidgetsBinding.instance
                                                      .addPostFrameCallback((
                                                        _,
                                                      ) {
                                                        scrollController?.jumpTo(
                                                          scrollController
                                                              .position
                                                              .maxScrollExtent,
                                                        );
                                                      });
                                                },
                                                animatedTexts: [
                                                  TyperAnimatedText(
                                                    ans?.trim() ?? "",
                                                    speed: const Duration(
                                                      milliseconds: 10,
                                                    ),
                                                    textStyle: TextStyle(
                                                      fontSize: 14.px,
                                                      color:
                                                          AppColors()
                                                              .darkAndWhite,
                                                      fontFamily:
                                                          FontFamily
                                                              .helveticaRegular,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                    ),
                                                  ),
                                                ],
                                                onTap: () {
                                                  if (kDebugMode) {
                                                    debugPrint(
                                                      "I am executing",
                                                    );
                                                  }
                                                },
                                              )
                                              : RichText(
                                                softWrap: true,
                                                text: TextSpan(
                                                  children: [
                                                    // TextSpan(
                                                    //   text: ans?.trim() ?? "",
                                                    //   style: TextStyle(
                                                    //     fontSize: 14.px,
                                                    //     height: 1.4,
                                                    //     overflow: TextOverflow.ellipsis,
                                                    //     fontFamily: FontFamily.helveticaReg5ular,
                                                    //     color: AppColors().darkAndWhite,
                                                    //     backgroundColor: AppColors.yellow,
                                                    //   ),
                                                    // ),
                                                    WidgetSpan(
                                                      alignment:
                                                          PlaceholderAlignment
                                                              .top,
                                                      child: CommonMarkDownText(
                                                        text: ans?.trim() ?? "",
                                                      ),
                                                    ),
                                                    if (ChatApi
                                                            .isStreamingData
                                                            .value &&
                                                        isEdit)
                                                      WidgetSpan(
                                                        alignment:
                                                            PlaceholderAlignment
                                                                .middle,
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets.only(
                                                                left: 4.0,
                                                              ),
                                                          // child: SvgPicture.asset(ImagePath.icImageLoading, width: 15.px, height: 15.px),
                                                          child: Image.asset(
                                                            ImagePath
                                                                .loadingGif,
                                                            width: 30.px,
                                                            height: 30.px,
                                                          ),
                                                        ),
                                                      ),
                                                  ],
                                                ),
                                              ),
                                    );
                                  }),
                        ),
                      ),
            ),
          ],
        ),
      Obx(() {
        ChatApi.isStreamingData.value;
        if ((suggestionList != null &&
            suggestionList.isNotEmpty &&
            isEdit &&
            (!ChatApi.isStreamingData.value) &&
            (getStorageData.readString(getStorageData.suggestionView) !=
                "0"))) {
          return Column(
            children: [
              ListView.separated(
                padding: EdgeInsets.symmetric(vertical: 8.px),
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: suggestionList.length,
                separatorBuilder: (context, index) {
                  return SizedBox(height: 2.px);
                },
                itemBuilder: (context, index) {
                  String data = suggestionList[index];
                  return GestureDetector(
                    onTap: () {
                      if (suggestionOnTap != null) {
                        suggestionOnTap(data);
                        suggestionList.clear();
                      }
                    },
                    child: CommonContainer(
                      isBorder: false,
                      color: AppColors().ansColor,
                      // border: Border.all(color: AppColors().ansColor),
                      padding: EdgeInsets.symmetric(
                        vertical: 10.px,
                        horizontal: 12.px,
                      ),
                      child: AppText(
                        data,
                        fontFamily: FontFamily.helveticaRegular,
                        fontSize: 14.px,
                        color: AppColors().darkAndWhite,
                      ),
                    ),
                  );
                },
              ),
              SizedBox(height: 4.px),
              AppText(
                Languages.of(Get.context!)!.doYouWantToKeepSeeing,
                fontSize: 12.px,
              ),
              SizedBox(height: 5.px),
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        HapticFeedback.mediumImpact();

                        goIt(suggestionList: suggestionList);
                      },
                      child: CommonContainer(
                        color: AppColors().ansColor,
                        alignment: Alignment.center,
                        radius: 10.px,
                        padding: EdgeInsets.symmetric(vertical: 5.px),
                        child: AppText(
                          Languages.of(Get.context!)!.noHideThem,
                          fontSize: 14.px,
                        ),
                      ),
                    ),
                  ),
                  SizedBox(width: 10.px),
                  Expanded(
                    child: CommonContainer(
                      radius: 10.px,
                      color: AppColors().ansColor,
                      alignment: Alignment.center,
                      padding: EdgeInsets.symmetric(vertical: 5.px),
                      child: AppText(
                        Languages.of(Get.context!)!.yesKeepThem,
                        color: AppColors.primary,
                        fontSize: 14.px,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ).paddingOnly(left: 25.px + 8.px);
        }

        return const SizedBox();
      }),
    ],
  );
}

/*Container(
decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(10.px))),
padding: isAnimatedText ? EdgeInsets.symmetric(vertical: 7.px, horizontal: 12.px) : null,
child: isAnimatedText
? AnimatedTextKit(
key: ValueKey<String>(ans?.trim() ?? ""),
isRepeatingAnimation: false,
onFinished: () {
WidgetsBinding.instance.addPostFrameCallback((_) {
scrollController?.jumpTo(scrollController.position.maxScrollExtent);
});
if (isImageScan == null && (!(isImageScan ?? true))) {
                Global.showTheReview();

});
}
},
onNext: (p0, p1) {
WidgetsBinding.instance.addPostFrameCallback((_) {
scrollController?.jumpTo(scrollController.position.maxScrollExtent);
});
},
onNextBeforePause: (p0, p1) {
printAction("onNextBeforePauseintp0 ${p0}");
printAction("onNextBeforePauseboolp1 ${p1}");
WidgetsBinding.instance.addPostFrameCallback((_) {
scrollController?.jumpTo(scrollController.position.maxScrollExtent);
});
},
animatedTexts: [
TyperAnimatedText(
ans?.trim() ?? "",
speed: const Duration(milliseconds: 10),
textStyle: TextStyle(
fontSize: 14.px,
color: AppColors().darkAndWhite,
fontFamily: FontFamily.helveticaRegular,
fontWeight: FontWeight.w500,
),
),
],
onTap: () {
debugPrint("I am executing");
},
)
    : RichText(
// textAlign: TextAlign.center,
text: TextSpan(
children: [
WidgetSpan(
// alignment: PlaceholderAlignment.middle,
child: Markdown(
padding: EdgeInsets.zero,
data: ans?.trim() ?? "",
shrinkWrap: true,
physics: const NeverScrollableScrollPhysics(),
selectable: false,
onTapText: () {
printAction("asihvauhsyvfa");
},
onTapLink: (text, href, title) {
utils.urlLaunch(Uri.parse(href ?? "www.google.com"));
},
styleSheet: MarkdownStyleSheet.fromTheme(Theme.of(Get.context!)).copyWith(
p: Theme.of(Get.context!).textTheme.bodyLarge?.copyWith(
fontSize: 14.px,
overflow: TextOverflow.ellipsis,
fontFamily: FontFamily.helveticaRegular,
color: AppColors().darkAndWhite,
),
),
),
),
TextSpan(text: "akskjbdkjsbdjksb"),
// if (ChatApi.isStreamingData.value && isEdit)
WidgetSpan(
// alignment: PlaceholderAlignment.middle,
child: SvgPicture.asset(
ImagePath.icImageLoading,
width: 15.px,
height: 15.px,
),
),
],
),
),
)*/

// extension ELog<T> on T {
//   T get log {
//     dev.log(toString());
//     return this;
//   }
// }

/*chatQuestionAnsView({
  ScrollController? scrollController,
  String? question,
  String? questionIcon,
  String? questionImage,
  String? ansImage,
  String? ans,
  bool isEdit = false,
  String? ansIcon,
  bool? isUpgrade,
  bool isBorder = true,
  RxBool? isAnimatedText,
  bool? isImageScan = false,
  Function(LongPressStartDetails)? onTap,
  Function()? onTapAns,
  Function(String)? onTapEdit,
  Function()? regenerateResponseOnTap,
}) {
  List<ChatSelectItem> chatSelectItem = [
    ChatSelectItem(Languages.of(Get.context!)!.copy, ImagePath.copy, false, 1),
    ChatSelectItem(Languages.of(Get.context!)!.selectText, ImagePath.select, true, 1),
    if (isEdit) ChatSelectItem(Languages.of(Get.context!)!.edit, ImagePath.editSvg, true, 1),
    ChatSelectItem(Languages.of(Get.context!)!.readLoud, ImagePath.read, true, 1),
    ChatSelectItem(Languages.of(Get.context!)!.share.capitalizeFirst.toString(), ImagePath.share, true, 8),
  ];
  List<ChatSelectItem> chatSelectItem2 = [
    ChatSelectItem(Languages.of(Get.context!)!.copy, ImagePath.copy, false, 1),
    ChatSelectItem(Languages.of(Get.context!)!.selectText, ImagePath.select, true, 1),
    ChatSelectItem(Languages.of(Get.context!)!.readLoud, ImagePath.read, true, 1),
    ChatSelectItem(Languages.of(Get.context!)!.share.capitalizeFirst.toString(), ImagePath.share, true, 8),
    if (isEdit) ChatSelectItem(Languages.of(Get.context!)!.regenerateResponse, ImagePath.regenerate, true, 8),
  ];

  if (isUpgrade ?? false) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollController?.jumpTo(scrollController.position.maxScrollExtent);
    });
  }

  Widget aiWidget(bool scrollText) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        (isUpgrade == null && isImageScan != null && isImageScan)
            ? Stack(
                alignment: Alignment.center,
                children: [
                  SizedBox(
                    height: 20.px,
                    width: 20.px,
                    child: const CircularProgressIndicator(color: AppColors.primary, strokeWidth: 2),
                  ),
                  SvgPicture.asset(
                    ImagePath.icImageLoading,
                    width: 15.px,
                    height: 15.px,
                  ),
                  // Container(
                  //   height: 12.px,
                  //   width: 12.px,
                  //   decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.primary),
                  // )
                ],
              )
            : Container(
                height: 25.px,
                width: 25.px,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  border: isBorder ? Border.all(color: AppColors().darkAndWhite.changeOpacity(0.05)) : null,
                ),
                child: ansIcon?.contains("https://aichatsy.com") ?? false
                    ? ClipOval(
                        child: CachedNetworkImage(
                          imageUrl: ansIcon ?? "",
                          progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
                          errorWidget: (context, url, uri) => errorWidgetView(height: 25.px, wight: 25.px),
                          height: 25.px,
                          width: 25.px,
                          fit: BoxFit.cover,
                        ),
                      )
                    : (ansIcon != null)
                        ? ClipOval(child: (ansIcon.contains(".svg")) ? SvgPicture.asset(ansIcon, height: isBorder ? 13.px : 23.px) : Image.asset(ansIcon, height: isBorder ? 18.px : 30.px))
                        : Image.asset(((isLight) ? ImagePath.darkLogo : ImagePath.logo), height: isBorder ? 13.px : 23.px)),
        SizedBox(width: 8.px),
        Flexible(
          child: (isUpgrade != null && isUpgrade)
              ? Column(
                  children: [
                    AnimatedTextKit(
                      isRepeatingAnimation: false,
                      onFinished: () {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          scrollController?.jumpTo(scrollController.position.maxScrollExtent);
                        });
                        Global.isVibrate = false;
                                       Global.showTheReview();

                      },
                      onNext: (p0, p1) {
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          scrollController?.jumpTo(scrollController.position.maxScrollExtent);
                        });
                        printAction("onNextintp0 ${p0} ");
                        printAction("onNextboolp1 ${p1} ");
                      },
                      onNextBeforePause: (p0, p1) {
                        printAction("onNextBeforePauseintp0 ${p0} ");
                        printAction("onNextBeforePauseboolp1 ${p1} ");
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          scrollController?.jumpTo(scrollController.position.maxScrollExtent);
                        });
                      },
                      animatedTexts: [
                        TyperAnimatedText(
                          Languages.of(Get.context!)!.oopsYouReachedYourDailyMessaging,
                          speed: const Duration(milliseconds: 10),
                          textStyle: TextStyle(
                            fontSize: 14.px,
                            color: AppColors().darkAndWhite,
                            fontFamily: FontFamily.helveticaRegular,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                      onTap: () {
                        debugPrint("I am executing");
                      },
                    ),
                    GestureDetector(
                      onTap: () {
                        if (Global.isSubscription.value != "1") {
                          Get.put(ChatGptController()).creditBottomSheet();
                        } else {
                          Get.delete<PurchaseController>();
                          Get.toNamed(Routes.PURCHASE)!.then((value) {
                            if (value != null && value == "plan_purchase") {
                              // controller.getHomeAPI();
                            }
                          });
                        }
                      },
                      child: Container(
                        margin: EdgeInsets.only(top: 10.px),
                        padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 10.w),
                        decoration: BoxDecoration(border: Border.all(color: AppColors().darkAndWhite.changeOpacity(0.04)), borderRadius: BorderRadius.circular(25.px), color: AppColors().bgColor3),
                        child: AppText(
                          Languages.of(Get.context!)!.upgradeToPRO,
                          fontSize: 16.px,
                          color: AppColors().darkAndWhite,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                )
              : !utils.isValidationEmpty(ansImage)
                  ? (ansImage == ImagePath.icImageLoading)
                      ? */ /*Container(
                                    decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(10.px))),
                                    padding: EdgeInsets.symmetric(vertical: 10.px, horizontal: 12.px),
                                    child: SvgPicture.asset(
                                      ansImage!,
                                      width: 12.px,
                                      height: 12.px,
                                    ),
                                  )*/ /*
                      Container(
                          // width: double.infinity,
                          // height: Get.size.width / 1.3,
                          decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(20.px))),
                          padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 8.px),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(17.px),
                            child: imageGenerationLoadingImage(),
                          ),
                        )

                      // Shimmer.fromColors(
                      //     baseColor: Colors.grey,
                      //     highlightColor: AppColors().darkAndWhi1te,
                      //     child: Text(
                      //       'Creating Image',
                      //       textAlign: TextAlign.center,
                      //       style: TextStyle(fontSize: 16.px, fontFamily: FontFamily.helveticaBold),
                      //     ))
                      : GestureDetector(
                          onTap: onTapAns,
                          child: Hero(
                            tag: ansImage ?? "",
                            child: Container(
                              // width: double.infinity,
                              // height: Get.size.width / 1.3,
                              decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(20.px))),
                              padding: EdgeInsets.symmetric(vertical: 8.px, horizontal: 8.px),
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(17.px),
                                child: CachedNetworkImage(
                                  imageUrl: ansImage ?? "",
                                  progressIndicatorBuilder: (context, url, progress) => imageGenerationLoadingImage(),
                                  errorWidget: (context, url, uri) => errorWidgetView(height: 25.px, wight: 25.px),
                                  // height: 25.px,
                                  // width: 25.px,
                                  fit: BoxFit.scaleDown,
                                ),
                              ),
                            ),
                          ),
                        )
                  : Container(
                      decoration: BoxDecoration(color: AppColors().ansColor, borderRadius: BorderRadius.all(Radius.circular(10.px))),
                      padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 12.px),
                      child: Obx(() {
                        debugPrint('Anim or not== ${isAnimatedText?.value}');
                        if (isAnimatedText?.value == true) {
                          return AnimatedTextKit(
                            key: ValueKey<String>(ans?.trim() ?? ""),
                            isRepeatingAnimation: false,
                            onFinished: () {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                scrollController?.jumpTo(scrollController.position.maxScrollExtent);
                              });
                              if (isImageScan == null && (!(isImageScan ?? true))) {
                                               Global.showTheReview();

                              }
                              isAnimatedText?.value = false;
                            },
                            onNext: (p0, p1) {
                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                scrollController?.jumpTo(scrollController.position.maxScrollExtent);
                              });
                            },
                            onNextBeforePause: (p0, p1) {
                              printAction("onNextBeforePauseintp0 ${p0}");
                              debugPrint('dfhsghdfghdfgjdfsg${isAnimatedText?.value}');
                              printAction("onNextBeforePauseboolp1 ${p1}");

                              WidgetsBinding.instance.addPostFrameCallback((_) {
                                scrollController?.jumpTo(scrollController.position.maxScrollExtent);
                              });
                            },
                            animatedTexts: [
                              TyperAnimatedText(
                                ans?.trim() ?? "",
                                speed: const Duration(milliseconds: 10),
                                textStyle: TextStyle(
                                  fontSize: 14.px,
                                  color: AppColors().darkAndWhite,
                                  fontFamily: FontFamily.helveticaRegular,
                                  fontWeight: FontWeight.w500,
                                ),
                              ),
                            ],
                            onTap: () {
                              debugPrint("I am executing");
                            },
                          );
                        }
                        var text = RichText(
                          text: TextSpan(
                            children: [
                              TextSpan(
                                text: ans?.trim() ?? "",
                                style: TextStyle(
                                  fontSize: 14.px,
                                  height: 1.4,
                                  overflow: TextOverflow.ellipsis,
                                  fontFamily: FontFamily.helveticaRegular,
                                  color: AppColors().darkAndWhite,
                                ),
                              ),
                              if (ChatApi.isStreamingData.value && isEdit)
                                WidgetSpan(
                                  alignment: PlaceholderAlignment.middle,
                                  child: SvgPicture.asset(
                                    ImagePath.icImageLoading,
                                    width: 15.px,
                                    height: 15.px,
                                  ),
                                ),
                            ],
                          ),
                        );

                        if (scrollText) {
                          return SingleChildScrollView(
                            child: text,
                          );
                        }
                        return text;
                      }),
                    ),
        )
      ],
    );
  }

  return GestureDetector(
    onTap: () {
      utils.hideKeyboard();
    },
    child: Column(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (!utils.isValidationEmpty(question))
          CupertinoContextMenu.builder(
            actions: [
              if ((onTapAns == null || (isImageScan == null && isImageScan == false)))
                if (isUpgrade == null)
                  ...List.generate(chatSelectItem.length, (index) {
                    return CupertinoContextMenuAction(
                      onPressed: () {
                        Get.back();

                        if (chatSelectItem[index].title == Languages.of(Get.context!)!.copy) {
                          Clipboard.setData(ClipboardData(text: question?.trim() ?? ''));
                          Utils().showToast(message: "Text copied");
                        } else if (chatSelectItem[index].title == Languages.of(Get.context!)!.selectText) {
                          CommonShowModelBottomSheet(child: SelectTextView(askData: question?.trim() ?? ''));
                        } else if (chatSelectItem[index].title == Languages.of(Get.context!)!.edit) {
                          if (onTapEdit != null) {
                            onTapEdit(question?.trim() ?? '');
                          }
                        } else if (chatSelectItem[index].title == Languages.of(Get.context!)!.share.capitalizeFirst.toString()) {
                          Share.share(question?.trim() ?? '');
                        } else if (chatSelectItem[index].title == Languages.of(Get.context!)!.readLoud) {
                          showDialog(
                            barrierDismissible: false,
                            context: Get.context!,
                            builder: (context) {
                              return AlertDialog(
                                backgroundColor: Colors.transparent,
                                alignment: Alignment.bottomCenter,
                                content: TextToSpeechView(text: (ans ?? "").obs),
                              );
                            },
                          );
                        }
                      },
                      isDefaultAction: true,
                      // trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
                      child: Row(
                        children: [
                          Expanded(
                            child: AppText(
                              chatSelectItem[index].title,
                              fontSize: 16.px,
                              overflow: TextOverflow.ellipsis,
                              maxLines: 1,
                              color: AppColors.black,
                            ),
                          ),
                          SvgPicture.asset(
                            chatSelectItem[index].icon,
                            height: 16.px,
                            width: 16.px,
                            color: AppColors.black,
                          ),
                        ],
                      ),
                    );
                  })
                else
                  const SizedBox()
              else
                const SizedBox()
            ],
            builder: (BuildContext context, Animation<double> animation) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ((!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) && getStorageData.readString(getStorageData.profile).toString().compareTo("https//aichatsy.com") == 1)
                      ? ClipOval(
                          child: CachedNetworkImage(
                            imageUrl: getStorageData.readString(getStorageData.profile).toString(),
                            progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(circle: true),
                            errorWidget: (context, url, uri) => errorWidgetView(height: 32.px, wight: 32.px),
                            height: 25.px,
                            width: 25.px,
                            fit: BoxFit.cover,
                          ),
                        )
                      : Image.asset(
                          questionIcon ?? (!utils.isValidationEmpty(getStorageData.readString(getStorageData.profile)) ? getStorageData.readString(getStorageData.profile) : ImagePath.user4),
                          height: 25.px,
                        )),
                  SizedBox(width: 8.px),
                  Expanded(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        if (!utils.isValidationEmpty(questionImage))
                          ClipRRect(
                            borderRadius: BorderRadius.all(Radius.circular(12.px)),
                            child: (questionImage!.contains("https://aichatsy.com"))
                                ? CachedNetworkImage(
                                    imageUrl: questionImage,
                                    progressIndicatorBuilder: (context, url, progress) => progressIndicatorView(borderRadius: 12.px),
                                    errorWidget: (context, url, uri) => errorWidgetView(height: 32.px, wight: 32.px),
                                    width: 150.px,
                                    height: 150.px,
                                    fit: BoxFit.cover,
                                  )
                                : Image.file(
                                    File(questionImage),
                                    width: 150.px,
                                    height: 150.px,
                                    fit: BoxFit.cover,
                                  ),
                          ).paddingOnly(bottom: 5.px),
                        if (!utils.isValidationEmpty(question))
                          Stack(
                            alignment: Alignment.bottomLeft,
                            children: [
                              Container(
                                // width: double.infinity,
                                margin: EdgeInsets.only(left: 6.px),
                                decoration: BoxDecoration(color: AppColors.question, borderRadius: BorderRadius.all(Radius.circular(10.px))),
                                padding: EdgeInsets.symmetric(vertical: 7.px, horizontal: 12.px),
                                child: AppText(
                                  question?.trim() ?? '',
                                  fontSize: 14.px,
                                  color: AppColors.white,
                                ),
                              ),
                              SvgPicture.asset(
                                ImagePath.arrowChat,
                                width: 12.px,
                                height: 12.px,
                              )
                            ],
                          ),
                      ],
                    ),
                  )
                ],
              ).marginOnly(bottom: 8.px, top: 8.px);
            },
          ),
        if ((!utils.isValidationEmpty(ans)) || (!utils.isValidationEmpty(ansImage)) || isUpgrade != null || isImageScan != null) ...[
          if ((!(isUpgrade != null && isUpgrade)) && (!utils.isValidationEmpty(ansImage)))
            aiWidget(false)
          else
            CupertinoContextMenu.builder(
                actions: [
                  if ((onTapAns == null || (isImageScan == null && isImageScan == false)))
                    if (isUpgrade == null)
                      ...List.generate(chatSelectItem2.length, (index) {
                        return CupertinoContextMenuAction(
                          onPressed: () {
                            Get.back();

                            if (chatSelectItem2[index].title == Languages.of(Get.context!)!.copy) {
                              Clipboard.setData(ClipboardData(text: ans?.trim() ?? ''));
                              Utils().showToast(message: "Text copied");
                            } else if (chatSelectItem2[index].title == Languages.of(Get.context!)!.selectText) {
                              CommonShowModelBottomSheet(child: SelectTextView(askData: ans?.trim() ?? ''));
                            } else if (chatSelectItem2[index].title.toLowerCase() == Languages.of(Get.context!)!.share.toLowerCase().toString()) {
                              Share.share(ans?.trim() ?? '');
                            } else if (chatSelectItem2[index].title == Languages.of(Get.context!)!.regenerateResponse) {
                              if (regenerateResponseOnTap != null) {
                                regenerateResponseOnTap();
                              }
                            } else if (chatSelectItem2[index].title == Languages.of(Get.context!)!.readLoud) {
                              showDialog(
                                barrierDismissible: false,
                                context: Get.context!,
                                builder: (context) {
                                  return AlertDialog(
                                    backgroundColor: Colors.transparent,
                                    alignment: Alignment.bottomCenter,
                                    content: TextToSpeechView(text: (ans ?? "").obs),
                                  );
                                },
                              );
                            }
                          },
                          isDefaultAction: true,
                          // trailingIcon: CupertinoIcons.doc_on_clipboard_fill,
                          child: Row(
                            children: [
                              Expanded(
                                child: AppText(
                                  chatSelectItem2[index].title,
                                  fontSize: 16.px,
                                  overflow: TextOverflow.ellipsis,
                                  maxLines: 1,
                                  color: AppColors.black,
                                ),
                              ),
                              SvgPicture.asset(
                                chatSelectItem2[index].icon,
                                height: 16.px,
                                width: 16.px,
                                color: AppColors.black,
                              ),
                            ],
                          ),
                        );
                      })
                    else
                      const SizedBox()
                  else
                    const SizedBox(),
                ],
                builder: (BuildContext context, Animation<double> animation) {
                  if (animation.value > 0) {
                    isAnimatedText?.value = false;
                  }

                  bool scrollText = (animation.value == 1);

                  return aiWidget(scrollText);
                }),
        ]
      ],
    ),
  );
}*/

class AppContextMenuWidget extends StatelessWidget {
  const AppContextMenuWidget({
    super.key,
    required this.child,
    required this.isQuestion,
    this.isEdit,
    required this.text,
    required this.onTap,
  });

  final void Function(String text, String title) onTap;

  final String text;

  final bool isQuestion;
  final bool? isEdit;

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return child;
    // if (!kDebugMode) {
    //   return child;
    // }

    var chatSelectItem = [
      ChatSelectItem(
        Languages.of(context)!.copy,
        ImagePath.copy,
        false,
        1,
        iconData: AppIcons.copy,
      ),
      ChatSelectItem(
        Languages.of(context)!.selectText,
        ImagePath.select,
        true,
        1,
        iconData: AppIcons.textSelection,
      ),
      if ((isQuestion) && (isEdit ?? false))
        ChatSelectItem(
          Languages.of(context)!.edit,
          ImagePath.editSvg,
          true,
          1,
          iconData: Icons.edit_outlined,
        ),
      ChatSelectItem(
        Languages.of(context)!.readLoud,
        ImagePath.read,
        true,
        1,
        iconData: AppIcons.readLoud,
      ),
      if (!isQuestion)
        ChatSelectItem(
          Languages.of(context)!.share.capitalizeFirst.toString(),
          ImagePath.share,
          true,
          8,
          iconData: AppIcons.share,
        ),
      if ((!isQuestion) && (isEdit ?? false))
        ChatSelectItem(
          Languages.of(context)!.regenerateResponse,
          ImagePath.regenerate,
          true,
          8,
          iconData: AppIcons.regenerate,
        ),
      if ((!isQuestion) &&
          (isEdit ?? false) &&
          (!utils.isValidationEmpty(text)))
        ChatSelectItem(
          Languages.of(context)!.report.capitalizeFirst.toString(),
          ImagePath.report,
          true,
          8,
          iconData: Icons.report_outlined,
        ),
    ];

    // return CupertinoContextMenu.builder(
    //   actions:
    //       chatSelectItem
    //           .map(
    //             (e) => CupertinoContextMenuAction(
    //               child: Row(
    //                 children: [
    //                   SvgPicture.asset(e.icon, width: 20, height: 20),
    //                   // Image.asset(e.icon, width: 20, height: 20),
    //                   const SizedBox(width: 8),
    //                   Text(e.title),
    //                 ],
    //               ),
    //               onPressed: () {
    //                 Navigator.of(context).pop();
    //                 if (e.title == Languages.of(context)!.copy) {
    //                   Clipboard.setData(ClipboardData(text: text));
    //                   Utils().showToast(message: "Text copied");
    //                 } else if (e.title == Languages.of(context)!.selectText) {
    //                   CommonShowModelBottomSheet(
    //                     child: SelectTextView(askData: text, isQuestion: isQuestion),
    //                   );
    //                 } else if (e.title == Languages.of(context)!.edit ||
    //                     e.title == Languages.of(context)!.readLoud ||
    //                     e.title == Languages.of(context)!.regenerateResponse) {
    //                   onTap(text, e.title);
    //                 } else if (e.title.toLowerCase() ==
    //                     Languages.of(context)!.share.toLowerCase()) {
    //                   SharePlus.instance.share(ShareParams(text: text));
    //                 } else if (e.title.toLowerCase() ==
    //                     Languages.of(context)!.report.toLowerCase()) {
    //                   Get.toNamed(Routes.REASON, arguments: {'reason': text});
    //                 }
    //               },
    //             ),
    //           )
    //           .toList(),
    //   builder: (context, animation) {
    //     return AbsorbPointer(
    //       child: Padding(
    //         padding: Tween(begin: EdgeInsets.zero, end: EdgeInsets.all(16)).evaluate(animation),
    //         child: child,
    //       ),
    //     );
    //   },
    // );

    /*     return Builder(
      builder: (context) {
        return ContextMenuWidget(
          iconTheme: IconThemeData(
            color: switch (MediaQuery.platformBrightnessOf(context)) {
              ui.Brightness.dark => Colors.white,
              ui.Brightness.light => Colors.black,
            },
          ),
          mobileMenuWidgetBuilder: DefaultMobileMenuWidgetBuilder(
            brightness: isLight ? Brightness.light : Brightness.dark,
          ),
          // desktopMenuWidgetBuilder: DefaultDesktopMenuWidgetBuilder(
          //   brightness: isLight ? Brightness.light : Brightness.dark,
          // ),
          menuProvider: (request) {
            return Menu(
              children:
                  chatSelectItem
                      .map(
                        (e) => MenuAction(
                          image:
                              (Platform.isIOS && e.iconData != null)
                                  ? MenuImage.icon(e.iconData!)
                                  : AppMenuIcon(assetName: e.icon, context: context),
                          title: e.title,
                          callback: () {
                            if (e.title == Languages.of(context)!.copy) {
                              Clipboard.setData(ClipboardData(text: text));
                              Utils().showToast(message: "Text copied");
                            } else if (e.title == Languages.of(context)!.selectText) {
                              CommonShowModelBottomSheet(
                                child: SelectTextView(askData: text, isQuestion: isQuestion),
                              );

                              // Navigator.of(context).push(
                              //   MaterialPageRoute(builder: (context) => SelectTextView(askData: widget.text)),
                              // );
                            } else if (e.title == Languages.of(context)!.edit ||
                                e.title == Languages.of(context)!.readLoud ||
                                e.title == Languages.of(context)!.regenerateResponse) {
                              onTap(text, e.title);
                              // Get.back(result: {HttpUtil.data: text, HttpUtil.type: e.title});
                            } else if (e.title.toLowerCase() ==
                                Languages.of(context)!.share.toLowerCase()) {
                              SharePlus.instance.share(ShareParams(text: text));
                            } else if (e.title.toLowerCase() ==
                                Languages.of(context)!.report.toLowerCase()) {
                              Get.toNamed(Routes.REASON, arguments: {'reason': text});
                            }
                          },
                        ),
                      )
                      .toList(),
            );
          },
          child: child,
        );
      },
    ); */
  }
}

// class AppMenuIcon extends MenuImage {
//   AppMenuIcon({required this.assetName, required this.context});

//   final String assetName;

//   final BuildContext context;

//   @override
//   Future<ui.Image?> asImage(IconThemeData theme, double devicePixelRatio) async {
//     return decodeImageFromList(
//       (await SvgAssetLoader(assetName).loadBytes(context)).buffer.asUint8List(),
//     );
//   }

//   @override
//   Widget? asWidget(IconThemeData theme) {
//     ColorFilter? colorFilter;
//     if (theme.color != null) {
//       colorFilter = ColorFilter.mode(theme.color!, BlendMode.srcATop);
//     }
//     return SizedBox.square(
//       dimension: 18.px,
//       child: SvgPicture.asset(assetName, colorFilter: colorFilter),
//     );
//   }
// }
