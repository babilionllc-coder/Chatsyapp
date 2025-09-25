import 'dart:io';

import '../helper/constants.dart';
import 'local_language.dart';

class LanguageEn extends Languages {
  @override
  String get appName => Constants.appName;

  @override
  String get dashboard => "Dashboard";

  @override
  String get eliteTools => "Elite Tools";

  @override
  String get tools => "Tools";

  @override
  String get uploadAndAsk => "Upload & Ask";

  @override
  String get doYouLikeUsAsMuchAsW => "Do you like us as much as we like you?";

  @override
  String get weDetailedReview =>
      (Platform.isAndroid)
          ? "Spread the love! We would be thankful if you could leave a detailed review on the Google Play Store. Your feedback means the world to us! ❤️"
          : "Spread the love! We would be thankful if you could leave a detailed review on the App Store. Your feedback means the world to us! ❤️";

  @override
  String get helpAiChatSy => "Help ${Constants.appName}";

  @override
  String get hiHowCanIHelpYou => "Hi! How can I help you?";

  @override
  String get suggestions => "Suggestions";

  @override
  String get linkAndAsk => "Link & Ask";

  @override
  String get exitAlertMessage =>
      "Tap the back button once more to \nexit the app";

  @override
  String get doYouLike => "Do you like us as much as we like you?";

  @override
  String get searchOrAsk => "Search or ask about anything in a document";

  @override
  String get searchOrWebPage => "Search or ask about anything in a webpage";

  @override
  String get myHistory => "My History";

  @override
  String get getText => "Get text";

  @override
  String get templates => "Templates";

  @override
  String get newChat => "New Chat";

  @override
  String get startNewChat => "Start a new chat";

  @override
  String get chatHistory => "Chat History";

  @override
  String get chat => "CHAT";

  @override
  String get promptChat => "PROMPT CHAT";

  @override
  String get deleteAll => "Delete All";

  @override
  String get sendAMessage => "Send a message";

  @override
  String get takePicture => "Take picture";

  @override
  String get chooseFromLibrary => "Choose from library";

  @override
  String get uploadFile => "Upload file";

  @override
  String get analyzeWebsite => "Analyze website";

  @override
  String get generateImage => "Generate image";

  @override
  String get scanText => "Scan text";

  @override
  String get viewTemplates => "View templates";

  @override
  String get deleteThisChat => "Delete This Chat?";

  @override
  String get deleteThisChatSub => "Are you sure you want to delete\nthis chat?";

  @override
  String get cancel => "Cancel";

  @override
  String get delete => "delete";

  @override
  String get deleteAllChat => "Delete All Chat History?";

  @override
  String get deleteAllChatSub =>
      "Are you sure you want to delete\nall of your chat history?";

  @override
  String get settings => "Settings";

  @override
  String get followUs => "Follow Us";

  @override
  String get language => "Language";

  @override
  String get rateUs => "Rate Us";

  @override
  String get selectAIModel => "Select AI Model";

  @override
  String get darkMode => "Dark Mode";

  @override
  String get lightMode => "Light Mode";

  @override
  String get userID => "User ID";

  @override
  String get aboutUs => "About Us";

  @override
  String get contactUs => "Contact Us";

  @override
  String get privacyPolicy => "Privacy Policy";

  @override
  String get termsOfUse => "Terms of Use";

  @override
  String get aboutUsSub =>
      "${Constants.appName} is AI chatbot assistant powered by ChatGPT-4 technology that will help you to solve any task and answer any questions. By writing prompts for what you need, you can ask anything and get answer for any question or solution for any problem/task!\n\nOur AI chatbot assistant designed to cater to your every need - All AI features in one app!\n\nAI modules available:\n  - ChatGPT\n  - GPT-4 \n\n\nYou can easily check your chat & prompt history, and localize the app for prefered language (English, Spanish, Hindi, French, Portuguese).\n\nOur app combines the best of AI chatbot brilliance and virtual assistant features, powered by the advanced Chat GPT-4 technology.\n\nMain features:\n- Essay Writer\n- Photo Generator & Recognition\n- Text-to-Audio\n- Email Writer\n- Text Scan\n- Grammar Check\n- Translation\n- Summarize Articles & Websites\n- Plagiarism Checker\n- Password Generator\n- Meeting Summary\n- Paraphrasing Tool\n- Joke Generator\n- Problem Solver\n- Voice Interaction/Command\n- Analyze Website\n- Analyze Files\n- Dream Interpreter\n- Competitor Analysis\n- Social Content\n- Coding Resources\n- And many others!\n\nWe’re committed to continuous innovation, always exploring new ways to enhance your interaction with technology.\n\nYour experience is at the heart of our development process. We listen to your feedback and tailor our services to fit your life.\n\nEnjoy the benefits that our AI Chatbot Assistant offers - ${Constants.appName} is here for you 24/7! Feel free to contact us for anything via mail@aichatsy.com.";

  @override
  String get name => "Name";

  @override
  String get url => "Please enter url";

  @override
  String get subject => "Subject";

  @override
  String get poweredBy => "Powered by";

  @override
  String get message => "Message";

  @override
  String get submit => "SUBMIT";

  @override
  String get errorMessageValidYourName => "Please enter your name";

  @override
  String get errorMessageEmail => "Please enter your email";

  @override
  String get errorMessageValidEmail => "Please enter valid email";

  @override
  String get errorMessageSubject => "Please enter subject";

  @override
  String get errorMessagePassword => "Please enter password";

  @override
  String get errorMessageMessage => "Please enter message";

  @override
  String get email => "Email";

  @override
  String get letAiChtSyUnlockYourInnerGenius =>
      "Let ${Constants.appName} Unlock Your Inner Genius!";

  @override
  String get bestSeller => "Best Seller";

  @override
  String get off => "55% Off";

  @override
  String get byContinuingYouAccept => "By continuing you accept ";

  @override
  String get tosPrivacyPolicy => "Terms & Conditions, Privacy Policy";

  @override
  String get and => "and ";

  @override
  String get billingTeam => "Billing team";

  @override
  String get purchase => "Purchase";

  @override
  String get restore => "Restore";

  @override
  String get aiChatSy => Constants.appName;

  @override
  String get chatGPT4 => "ChatGPT & GPT-4";

  @override
  String get joinMillionsOf => "Join Millions of ";

  @override
  String get happyUsers => "Happy Users ";

  @override
  String get unlockThePotential => "Unlock the Potential of Advanced ";

  @override
  String get aICamera => "AI Camera  ";

  @override
  String get technology => "Technology";

  @override
  String get elevateYourExperienceWith => "Elevate Your Experience with ";

  @override
  String get eliteFeatures => " Elite Features. ";

  @override
  String get aiChatSyMsg =>
      "Type below to get answers\nAsk any open ended questions";

  @override
  String get imageGeneration => "Image Generation";

  @override
  String get effortlesslyCraftYourSearch =>
      "Effortlessly craft your search with our handy";

  @override
  String get textToImage => "Text-to-image";

  @override
  String get photoIdentification => "Photo Identification";

  @override
  String get camera => "Camera";

  @override
  String get gallery => "Gallery";

  @override
  String get uploadYourImage => "Upload Your Image";

  @override
  String get uploadAndIdentify => "Upload and identify";

  @override
  String get weLoveToGetADetailed =>
      "We'd love to get a detailed review from you on the App Store, telling the world why you enjoy ${Constants.appName}!";

  @override
  String get askSomething => "Ask something";

  @override
  String get uploadAndAskSubTitle =>
      "You can ask about or search anything in a document. For summarization, please use summarize section on homepage.\n\nPlease ensure the file is either a .pdf, .docx or .txt file";

  @override
  String get typeYourQuestionHere => "Type your question here";

  @override
  String get typeYourTextHere => "Type your text here";

  @override
  String get pleaseUploadFile =>
      "File is not supported. please insert .pdf, .docx or .txt files only";

  @override
  String get pleaseUploadPDF =>
      "File is not supported. please insert .pdf files only";

  @override
  String pleaseEnterValid({String? title}) {
    return "Please enter valid $title";
  }

  @override
  String get pleaseEnterValidQuestion => "Please enter valid question";

  @override
  String get pleaseEnterImage => "Please enter Image";

  @override
  String get done => "Done";

  @override
  String get linkAndAskSubTitle =>
      "You can ask about or search anything in a webpage. For summarization, please use summarize section on homepage.";

  @override
  String get pasteYourLink => "Paste your link";

  @override
  String get pleaseEnterValidUrl => "Please enter valid url link";

  @override
  String get pleaseEnterUrl => "Please enter url link";

  @override
  String get summarizeArticle => "Summarize Article";

  @override
  String get summarizeArticleMsg => "Get detailed article summarization";

  @override
  String get summarizeWeb => "Summarize Website";

  @override
  String get summarizeWebMsg => "Get detailed webpage summarization";

  @override
  String get summarizeArticleTitle =>
      "You can add your document and ${Constants.appName} to summarize it.\n\nPlease ensure the file is either a .pdf, .docx or .txt file";

  @override
  String get summarizeArticleWeb =>
      "You can add your document and ${Constants.appName} to summarize it.";

  @override
  String get summarizeIn => "Summarize In";

  @override
  String get summarize => "Summarize";

  @override
  String get chatGPT => "ChatGPT";

  @override
  String get chatGPTMsg => "Default chatbot model provided\nby OpenAl";

  @override
  String get GPT4 => "GPT-4";

  @override
  String get paLM2 => "PaLM 2";

  @override
  String get aCreativeAndHelpfulCollaborator =>
      "A creative and helpful collaborator,\ndeveloped by Google A1";

  @override
  String get convertTextBasedDescriptions =>
      "Convert text-based descriptions into visual dato";

  @override
  String get GPT4Msg =>
      "A more advanced system, producing\nsafer and more useful responses";

  @override
  String get copy => "Copy";

  @override
  String get selectText => "Select Text";

  @override
  String get regenerateResponse => "Regenerate Response";

  @override
  String get ok => "Ok";

  @override
  String get appUpdate => "App Update Required!";

  @override
  String get update => "Update";

  @override
  String get english => "English";

  @override
  String get spanish => "Spanish";

  @override
  String get hindi => "Hindi";

  @override
  String get french => "French";

  @override
  String get portuguese => "Portuguese";

  @override
  String get pleaseFillThe => "Please fill the";

  @override
  String get inTheFormForBetterResults => "in the form for better results";

  @override
  String get aiAssistants => "AI Assistants";

  @override
  String get examples => "Examples";

  @override
  String get aiChatSyCanGenerateUnique =>
      "visuals based on your description. To create an image, you can send a message to describe it or use a pre- made prompt!";

  @override
  String get freeTrialEnabled => "Free Trial Enabled";

  @override
  String get explore => "Explore";

  @override
  String get yourListIsEmpty => "Your list is empty";

  @override
  String get seeAll => "See All";

  @override
  String get hide => "Hide";

  @override
  String get download => "download";

  @override
  String get share => "share";

  @override
  String get chooseYourLanguage => "Choose Your Language";

  @override
  String get assistants => "Assistants";

  @override
  String get home => "Home";

  @override
  String get fullAccessTo => "Full Access to";

  @override
  String get pro => " PRO ";

  @override
  String get aICHATSYUnlimited => "${Constants.appName} Unlimited";

  @override
  String get poweredByGPT4GeminiPaLM => "Powered by GPT 4o, Gemini";

  @override
  String get premiumAiTools => "Premium Ai Tools";

  @override
  String get fasterConversation => "Faster Conversation";

  @override
  String get unlimitedChatImages => "Unlimited Chat & Images";

  @override
  String get pDFURLSummary => "PDF & URL Summary";

  @override
  String get unlimitedYearly => "Unlimited Yearly";

  @override
  String get save80 => "Save 80%";

  @override
  String get save25 => "Save 25%";

  @override
  String get mostPopular => "Most Popular";

  @override
  String get unlimitedMonthly => "Unlimited Monthly";

  @override
  String get unlimitedWeekly => "Unlimited Weekly";

  @override
  String get lifetimeAccess => "Lifetime Access";

  @override
  String get limitedOffer => "LIMITED OFFER";

  @override
  String get oneTimeBuy => "ONE-TIME BUY";

  @override
  String get anyTimeCancel => "Any Time Cancel";

  @override
  String get unlockLifetimeAccess => "Unlock Lifetime Access";

  @override
  String get subscribe => "Subscribe";

  @override
  String get autoRenewable => "Auto Renewable";

  @override
  String get unlimitedUsage => "Unlimited Usage";

  @override
  String get noCommitment => "No Commitment";

  @override
  String get cancelAnytime => "Cancel Anytime";

  @override
  String get imageScan => "Image Scan";

  @override
  String get textScan => "Text Scan";

  @override
  String get summarizePDF => "Summarize PDF";

  @override
  String get textsFromImages => "Texts from Images";

  @override
  String get whatNew => "What’s New?";

  @override
  String get news => "New";

  @override
  @override
  @override
  String get aIModules => "AI Modules";

  @override
  String get yourDailyFreeCredits => "Your Daily free Credits";

  @override
  String get youHave => "You have";

  @override
  String get creditLeft => "Credit Left";

  @override
  String get upgradeToPremium => "Upgrade to Premium";

  @override
  String get getUnlimitedAccessToAllFeatures =>
      "Get unlimited access to all features";

  @override
  String get unlimitedAccess => "Unlimited Access";

  @override
  String get yearly => "Yearly";

  @override
  String get monthly => "Monthly";

  @override
  String get threeDaysFreeTrial => "3-Days free trial";

  @override
  String get startFreeTrial => "Start free trial";

  @override
  String get uploadAndAAsk => "Upload and Ask";

  @override
  String get unlockTheFullPotentialOfAichatsy =>
      "Unlock the full potential of ${Constants.appName}'s AI by using the Upload and Ask feature. Easily upload any document and get quick, accurate responses.";

  @override
  String get uploadYourDocument => "Upload Your Document";

  @override
  String get clickTheUploadButtonAndSelectYourFile =>
      "Click the upload button and select your file.";

  @override
  String get askQuestion => "Ask Question";

  @override
  String get typeInYourQueryBboutTheDocument =>
      "Type in your query about the document.";

  @override
  String get getAnswer => "Get Answer";

  @override
  String get receiveInstantAIGeneratedResponses =>
      "Receive instant, AI-generated responses.";

  @override
  String get letsGo => "Let’s Go";

  @override
  String get visionScan => "Vision Scan";

  @override
  String get experienceThePowerOfAichatsy =>
      "Experience the power of ${Constants.appName}'s Vision Scan feature. Easily scan documents or images and get instant AI-generated insights.";

  @override
  String get scanDocumentsImages => "Scan Documents or Images";

  @override
  String get transformYourVisionIntoArt => "Transform Your Vision into Art";

  @override
  String get scanDocument => "Scan Document";

  @override
  String get captureYourDocumentOrImage => "Capture your document or image.";

  @override
  String get enterYourQuestion => "Enter your question.";

  @override
  String get getInsights => "Get Insights";

  @override
  String get transformYourIdeasIntoVisualsWithAichatsy =>
      "Transform your ideas into visuals with ${Constants.appName}'s Image Generation feature. Perfect for creating custom images effortlessly.";

  @override
  String get describeImage => "Describe Image";

  @override
  String get enterBriefDescriptionOfTheImageYouWant =>
      "Enter brief description of the image you want.";

  @override
  String get selectStyle => "Select Style";

  @override
  String get pickStyleOrTemplateThatSuitsYourVision =>
      "Pick style or template that suits your vision.";

  @override
  String get generate => "Generate";

  @override
  String get clickToCreateYourImage => "Click to create your image.";

  @override
  String get receiveInstantAIGeneratedAnswers =>
      "Receive instant AI-generated answers.";

  @override
  String get enterALink => "Enter a Link";

  @override
  String get enterTheURLToSummarize =>
      "Enter the URL to summarize, rewrite, translate, or analyze its content.";

  @override
  String get pasteALink => "Paste a link";

  @override
  String get pasteALinkEG => "Paste a link (e:g www.aichatsy.com)";

  @override
  String get continues => "Continue";

  @override
  String get uploadYourPDF => "Upload your PDF";

  @override
  String get itMustBe10MBMax => "It must be 10.0 MB max.";

  @override
  String get uploadPDF => "Upload PDF";

  @override
  String get uploadImage => "Upload Image";

  @override
  String get uploadImageToScan => "Upload image to scan";

  @override
  String get oopsYouReachedYourDailyMessaging =>
      "Oops, you’ve reached your daily messaging limit! You can send 4 messages per day on free plan. Upgrade to unlock unlimited messages.";

  @override
  String get upgradeToPRO => "Upgrade to";

  @override
  String get premium => "Premium";

  @override
  String get length => "Length";

  @override
  String get auto => "Auto";

  @override
  String get short => "Short";

  @override
  String get medium => "Medium";

  @override
  String get long => "Long";

  @override
  String get defaults => "🤖 Default";

  @override
  String get professional => "🧐 Professional";

  @override
  String get friendly => "😃 Friendly";

  @override
  String get inspirational => "😇 Inspirational";

  @override
  String get joyful => "😂 Joyful";

  @override
  String get persuasive => "😉 Persuasive";

  @override
  String get empathetic => "️🙂 Empathetic";

  @override
  String get surprised => "😯 Surprised";

  @override
  String get optimistic => "😋 Optimistic";

  @override
  String get worried => "😟 Worried";

  @override
  String get curious => "😏 Curious";

  @override
  String get assertive => "😎 Assertive";

  @override
  String get cooperative => "😌 Cooperative";

  @override
  String get romantic => "🥰 Romantic";

  @override
  String get passionate => "😍 Passionate";

  @override
  String get critical => "🤬 Critical";

  @override
  String get responseTone => "Response Tone";

  @override
  String get save => "Save";

  @override
  String get selectImageSizeStyle => "Select Image Size & Style";

  @override
  String get selectSize => "Select Size";

  @override
  String get chooseAvatar => "Choose Avatar";

  @override
  String get chooseImage => "Choose the image";

  @override
  String get pleaseEnterName => "Please enter name";

  @override
  String get summarizeIt => "Summarize it";

  @override
  String get rewriteIt => "Rewrite it";

  @override
  String get welcomeToAICHATSY => "Welcome to ${Constants.appName}";

  @override
  String get wereDelightedToHaveYouHere => "We're delighted to have you here.";

  @override
  String get howShouldWeCallYou => "How should we call you?";

  @override
  String get optional => "Optional";

  @override
  String get enterName => "Enter Name";

  @override
  String get theme => "Theme";

  @override
  String get chatGPTIsYourAIAssistant =>
      "ChatGPT is your AI assistant for quick answers and creative help, offering personalized responses to enhance your experience.";

  @override
  String get knowledgeBase => "Knowledge Base:";

  @override
  String get deliversAccurateInformativeResponses =>
      "Delivers accurate, informative responses.";

  @override
  String get creativity => "Creativity:";

  @override
  String get helpsGenerateIdeasAndWriteContent =>
      "Helps generate ideas and write content.";

  @override
  String get efficiency => "Efficiency:";

  @override
  String get providesQuickReliableAnswers =>
      "Provides quick, reliable answers.";

  @override
  String get chatGPT4IsYourAdvancedAIAssistant =>
      "ChatGPT-4 is your advanced AI assistant, designed to provide accurate answers, assist with creative tasks, and offer personalized support.";

  @override
  String get enhancedUnderstanding => "Enhanced Understanding:";

  @override
  String get deliversMoreAccurateResponses =>
      "Delivers more accurate responses.";

  @override
  String get creativeAssistance => "Creative Assistance:";

  @override
  String get generatesIdeasAndContentEffortlessly =>
      "Generates ideas and content effortlessly.";

  @override
  String get realTimeUpdates => "Real-Time Updates:";

  @override
  String get accessesLiveInfoForRealTimeResponses =>
      "Accesses live info for real-time responses.";

  @override
  String get paLMIsAnAILanguageModelDevelopedByGoogleAI =>
      "PaLM is an AI language model developed by GOOGLE AI, known for its advanced capabilities in natural language processing and generation.";

  @override
  String get advancedPatternRecognition => "Advanced Pattern Recognition:";

  @override
  String get enhancesPatternRecognitionCapabilities =>
      "Enhances pattern recognition capabilities.";

  @override
  String get contextualUnderstanding => "Contextual Understanding:";

  @override
  String get improvesModelsComprehensionOfContext =>
      "Improves models' comprehension of context.";

  @override
  String get enhancedPerformance => "Enhanced Performance:";

  @override
  String get boostOverallModelCapabilitiesEffectively =>
      "Boosts overall model capabilities effectively.";

  @override
  String get palm => "PaLM";

  @override
  String get geminiIsAnInnovativeAITechnology =>
      "Gemini is an innovative AI technology known for enabling seamless interactions and enhancing task efficiency with advanced capabilities.";

  @override
  String get smoothInteractions => "Smooth Interactions:";

  @override
  String get enablesIntuitiveUserEngagement =>
      "Enables intuitive user engagement.";

  @override
  String get efficientTasks => "Efficient Tasks:";

  @override
  String get enhancesProductivity => "Enhances productivity.";

  @override
  String get advancedIntegration => "Advanced Integration:";

  @override
  String get cuttingEdgeAIOptimization => "Cutting-edge AI optimization.";

  @override
  String get letTry => "Let’s Try";

  @override
  String get websiteInsightsWithAIChatSY =>
      "Website Insights with ${Constants.appName}";

  @override
  String get addWebsiteURL => "Add Website URL";

  @override
  String get pasteTheWebsiteLink => "Paste the website link";

  @override
  String get summarizeAnyPDF => "Summarize any PDF";

  @override
  String get clickSummarize => "Click Summarize";

  @override
  String get hitTheSummarizeButtonStart => "Hit the Summarize button to start";

  @override
  String get uploadAnyDocumentOrPdf => "Upload any document or pdf";

  @override
  String get readSummary => "Read Summary";

  @override
  String get getConciseSummaryWebpage => "Get a concise summary of the webpage";

  @override
  String get askAnything => "Ask Anything";

  @override
  String get askAICHATSYWhatDocument =>
      "Ask ${Constants.appName} what to do with document";

  @override
  String get getResponses => "Get Responses";

  @override
  String get getQuickResponsesInSeconds => "Get quick responses in seconds";

  @override
  String get cancellationCancelAnytimeDuring =>
      "Cancellation: Cancel anytime during the first 3 days";

  @override
  String get summarizeDocument => "Summarize Document";

  @override
  String get youtubeSummary => "Youtube Summary";

  @override
  String get realTimeWeb => "Real time Web";

  @override
  String get scanAnyText => "Scan any Text";

  @override
  String get uploadOrCapture => "Upload or Capture";

  @override
  String get uploadAnyDocumentOrPicture => "Upload any document or picture";

  @override
  String get askWhatToDoWithDocument =>
      "Ask ${Constants.appName} what to do with document";

  @override
  String get getRespondOnScan => "Get Respond on Scan";

  @override
  String get sendFeedback => "Send Feedback";

  @override
  String get useCamera => "Use Camera";

  @override
  String get addWebsite => "Add Website";

  @override
  String get searchAndAskAboutYouTubeVideoContent =>
      "Search and Ask About YouTube Video Content";

  @override
  String get takeOrChoosePhoto => "Take or choose a photo";

  @override
  String get recognize => "Recognize";

  @override
  String get pasteLink => "Paste a link (e:g www.aichatsy.com)";

  @override
  String get addWebsiteDesc =>
      "Enter the URL to summarize, rewrite, translate, or analyze its content.";

  @override
  String get enterYoutubeLink => "Enter youtube link";

  @override
  String get documentUpload => "Document Upload";

  @override
  String get summarizeYourDocument => "Summarize Your Document";

  @override
  String get summarizeYourDocumentDesc =>
      "Please ensure that file is either .pdf .docx or .txt file";

  @override
  String get imageUpload => "Image Upload";

  @override
  String get edit => "Edit";

  @override
  String get readLoud => "Read Loud";

  @override
  String get recentImages => "Recent Images";

  @override
  String get clearAll => "Clear All";

  @override
  String get areYouSureYouWantToClearAllImage =>
      "Are you sure you want to clear \nall image?";

  @override
  String get yes => "Yes";

  @override
  String get allHistory => "All History";

  @override
  String get favorites => "Favorites";

  @override
  String get today => "Today";

  @override
  String get yesterday => "Yesterday";

  @override
  String get thisWeek => "This Week";

  @override
  String get noDataFound => "No data found";

  @override
  String get upgradeToAICHATSY => "Upgrade to ${Constants.appName}";

  @override
  String get wouldYouLikeToDeleteAll =>
      "Would you like to delete all the chats?";

  @override
  String get legal => "Legal";

  @override
  String get creditsLeftToday => "Credits left today";

  @override
  String get setLanguages => "Set Languages";

  @override
  String get search => "Search";

  @override
  String get languagesNotFound => "Languages not found";

  @override
  String grantPermission({String? title}) {
    return "Grant $title permission";
  }

  @override
  String permissionFromTheAppAppSettings({String? title}) {
    return "Please grant $title permission from the app setting";
  }

  @override
  String get hiAiChatsyPoweredByChatGPT =>
      "Hi, I'm ${Constants.appName}! Powered by ChatGPT.";

  @override
  String get imHereToAssistYouWithGuidance =>
      "I'm here to assist you with guidance on crafting an impressive CV, writing effective emails, boosting productivity, getting thoughtful gift suggestions, or discovering unique first-date locations.";

  @override
  String get startAskingQuestions => "Start asking questions!";

  @override
  String get youAre => "You are";

  @override
  String get user => "user";

  @override
  String get allAIModules => "All AI Modules";

  @override
  String get aIImageRecognition => "AI image recognition";

  @override
  String get freeTrial => "Free trial";

  @override
  String get startWithFreeTrial => "Start with free trial";

  @override
  String get pleasePurchasePlanForAccess =>
      "Please purchase plan for access this model";

  @override
  String get login => "Login";

  @override
  String get welcomeBack => "Welcome Back!";

  @override
  String get continueWithApple => "Continue with Apple";

  @override
  String get continueWithGoogle => "Continue with Google";

  @override
  String get docIos =>
      "By clicking on Sign in with apple or Sign in with google, you agree to our";

  @override
  String get docAndroid =>
      "By clicking on Sign in with google, you agree to our";

  @override
  String get logOut => "Log out";

  @override
  String get password => "Password";

  @override
  String get createYourFreeAccount => "Create your free account";

  @override
  String get skip => "Skip";

  @override
  String get signIn => "Sign in";

  @override
  String get free => "Free";

  @override
  String get profile => "Profile";

  @override
  String get clickToChangeAvatar => "Click to change avatar";

  @override
  String get logInSuccessful => "Log in successful";

  @override
  String get syncYourHistoryAcross => "Sync your history across your devices.";

  @override
  String get creatingCustomizedAnd =>
      "Creating a customized and improved experience.";

  @override
  String get syncingYourChatHistoryFor =>
      "Syncing your chat history for better experience";

  @override
  String get restoringYourPurchasesSoThat =>
      "Restoring your purchases so that you don’t miss out a thing";

  @override
  String get areYouSureTo => "Are you sure to log out?";

  @override
  String get youWillNotLooseYourDataIf =>
      "You will not loose your data if you log out. You can still log in to this account.";

  @override
  String get gotIt => "Got it";

  @override
  String get realTimeWebSearch => "Real time web search";

  @override
  String get upgradeTo => "Upgrade to";

  @override
  String get forFullAccess => "for Full Access!";

  @override
  String get saveTimeDoMoreAnd => "Save time, do more, and achieve faster";

  @override
  String get bestOffer => "Best Offer";

  @override
  String get unlimited => "Unlimited";

  @override
  String get deleteAccount => "Delete Account";

  @override
  String get itSpam => "It's a Spam";

  @override
  String get falseInformation => "False Information";

  @override
  String get privacyConcerns => "Privacy Concerns";

  @override
  String get violenceThreats => "Violence Threats";

  @override
  String get other => "Other";

  @override
  String get writeYourReason => "Write Your Reason";

  @override
  String get hateSpeechSymbols => "Hate Speech or Symbols";

  @override
  String get bullyingOrHarassment => "Bullying or Harassment";

  @override
  String get scamOrFraud => "Scam or Fraud";

  @override
  String get areYouSureYouWantTo =>
      "Are you sure you want to delete your account?";

  @override
  String get youWilLoseAllYourData =>
      "You will lose all your data and your account will not be recovered.";

  @override
  String get chooseAReason => "Choose a Reason";

  @override
  String get pleaseEnterReason => "Please enter reason";

  @override
  String get report => "Report";

  @override
  String get more => "More";

  @override
  String get no => "No";

  @override
  String get doYouLikeTheApp => "Do you like the app?";

  @override
  String get maybeLater => "Maybe Later";

  @override
  String get specialOffer => "Special Offer";

  @override
  String get offAnnualPlan => "25% Off Annual Plan";

  @override
  String get pROAITools => "PRO AI Tools";

  @override
  String get aIAssistantsTemplates => "AI Assistants & Templates";

  @override
  String get aIImageGenerations => "AI Image Generations";

  @override
  String get accessAllAIModels => "Access all AI Models";

  @override
  String get accessHumanLikeChat => "Access human-like Chat";

  @override
  String get onlyForYou => "ONLY FOR YOU";

  @override
  String get thisOfferExpiresIn => "This offer expires in";

  @override
  String get just => "Just";

  @override
  String get perFirstYear => "per first year";

  @override
  String get lessThan => "(less than";

  @override
  String get perWeek => "per week)";

  @override
  String get grabThisDeal => "Grab this Deal";

  @override
  String get tryTodayFor => "Try Today for \$0";

  @override
  String get freeAccount => "Free Account";

  @override
  String get proAccount => "Pro Account";

  @override
  String get subscribeForJust => "Subscribe for just";

  @override
  String get offForYearlyPlan => "15% off for yearly plan";

  @override
  String get powerfulAIModelsGPTGemini =>
      "Powerful AI Models GPT, Gemini & Claude in one APP";

  @override
  String get weekly => "Weekly";

  @override
  String get unlockAccessTo => "Unlock access to";

  @override
  String get forUnlimitedCredits => "for unlimited credits.";

  @override
  String get redeemYourFreeTrial => "Redeem Your Free Trial";

  @override
  String dayFreeTrialWeekCancelAnytime({String? price}) {
    return "3 - day free trial, $price/week. Cancel anytime";
  }

  @override
  String get tapToSignIn => "Tap to sign in";

  @override
  String get todayCredits => "Today’s Credits";

  @override
  String get notifications => "Notifications";

  @override
  String get voice => "Voice";

  @override
  String get systemVoices => "System Voices";

  @override
  String get congratulations => "Congratulations!";

  @override
  String get youAreNowChatSYPro =>
      "You are now ChatSY Pro Member Enjoy all Pro features.";

  @override
  String get doYouWantToKeepSeeing =>
      "Do you want to keep seeing the follow-up question?";

  @override
  String get noHideThem => "No, Hide Them";

  @override
  String get yesKeepThem => "Yes, Keep Them";

  @override
  String get managingFollowUpQuestions => "Managing Follow-Up Questions";

  @override
  String get youCanEnableOrDisable =>
      "You can enable or disable the quetions in Chatsy Settings.";

  @override
  String get followUpQuestions => "Follow-Up Questions";

  @override
  String get wait => "Wait!";

  @override
  String get justOneLastThing => "Just one last thing...";

  @override
  String get beforeWeShowYouAround =>
      "Before we show you around, We have gift for you";

  @override
  String get openGift => "Open Gift";

  @override
  String get noThanks => "No Thanks!";

  @override
  String get feelThe => "Feel the";

  @override
  String get love => "LOVE!";

  @override
  String get lowestPriceOfTheYear => "Lowest price of the year";

  @override
  String get unlimitedCredits => "Unlimited credits";

  @override
  String get proFeatures => "Pro Features";

  @override
  String get closeThisBannerAndTtGone =>
      "⚠ Close this banner, and it’s gone for good!";

  @override
  String get weSavedTheBestForLast => "We saved the best for last, ";

  @override
  String get offPro => "35% off Pro";

  @override
  String get defaultVoice => "Default voice";

  @override
  String get yourGift => "Your Gift";

  @override
  String get activated => "Activated";

  @override
  String get justForYou => "Just for you";

  @override
  String get here => "Here’s a";

  @override
  String get save115 => "Save 45%";

  @override
  String get discount => "Discount";

  @override
  String get lowestPriceEver => "Lowest Price Ever";

  @override
  String get claimYourLimitedOffer => "Claim your limited offer now!";

  @override
  String get only => "Only";

  @override
  String get week => "Week";

  @override
  String get enterEmail => "Enter email";

  @override
  String get enterSubject => "Enter subject";

  @override
  String get writeHere => "Write here";

  @override
  String get yourCreditsRefilled => "Your credits refilled";

  @override
  String get doHaveAnAccount => "Don’t have an account?";

  @override
  String get pleaseSignInToContinue => "Please sign in to continue";

  @override
  String get enterPassword => "Enter password";

  @override
  String get forgotPassword => "Forgot Password?";

  @override
  String get signUp => "Sign Up";

  @override
  String get noWorriesHelpYou =>
      "No worries, we'll help you reset your password";

  @override
  String get send => "Send";

  @override
  String get authentication => "Authentication";

  @override
  String get enterTheVerificationCodeSent =>
      "Enter the verification code sent to your email";

  @override
  String get verify => "Verify";

  @override
  String get resetPassword => "Reset Password";

  @override
  String get yourNewPasswordMustBe =>
      "Your new password must be different from your previous one";

  @override
  String get enterNewPassword => "Enter new password";

  @override
  String get enterConfirmNewPassword => "Enter confirm new password";

  @override
  String get updatePassword => "Update Password";

  @override
  String get successful => "Successful!";

  @override
  String get yourPasswordHasBeen => "Your password has been reset";

  @override
  String get successfully => "successfully";

  @override
  String get createNewAccount => "Create New Account";

  @override
  String get enterYourDetailsBelowTo => "Enter your details below to continue";

  @override
  String get enterFullName => "Enter full name";

  @override
  String get enterConfirmPassword => "Enter confirm password";

  @override
  String get iAgreeToThe => "I agree to the";

  @override
  String get alreadyHaveAnAccount => "Already have an account?";

  @override
  String get yourProfileHasBeenCreated =>
      "Your profile has been created successfully";

  @override
  String get didReceiveTheCode => "Didn’t receive the code?";

  @override
  String get resend => "Resend";

  @override
  String get fullName => "Full name";

  @override
  String get confirmPassword => "Confirm password";

  @override
  String get newPassword => "New password";

  @override
  String get newConfirmPassword => "New confirm password";

  @override
  String get continueWithEmail => "Continue With Email";

  @override
  String passwordMustBeMoreThan8Characters({String? title}) {
    if (title == null) {
      return "Password must be more than 8 characters long including lower case, upper case, number and a special character";
    }
    return "$title Password must be more than 8 characters long including lower case, upper case, number and a special character";
  }

  @override
  String get passwordAndConfirmPassword =>
      "Password and confirm password does not match";

  @override
  String get errorMessagePrivacyAndTerms =>
      "Please agree to our Privacy Policy and Term & Conditions";

  @override
  String get errorMessageOtp => "Please enter otp";

  @override
  String get errorMessageValidOTP => "Please enter valid OTP";

  @override
  String get newName => "New";

  @override
  String get pleaseEnterNewPassword => "Please enter new password";

  @override
  String get pleaseEnterNewConfirmPassword =>
      "Please enter new confirm password";

  @override
  String get newPasswordAndNewConfirmPassword =>
      "New password and new confirm password does not match";

  @override
  String get oops => "Oops!";

  @override
  String get looksLikeYouReNotLoggedIn =>
      "Looks like you’re not logged in. To unlock all the awesome features of the app, please sign in or create an account. Guest mode has its limits!";

  @override
  String get unlockMoreWith => "Unlock more with";

  @override
  String get yourDayFreeTrialUnlockedClaim =>
      "Your 3 day Free Trial Unlocked. Claim Now 🎁";

  @override
  String get claimYourFreeTrial => "Claim Your 3-Day Free Trial 🎁";

  @override
  String get microphone => "microphone";

  @override
  String get joinHappyPROUsers => "Join 10K+ Happy";

  @override
  String get users => "users";

  @override
  String get offFirstYear => "45% Off First Year";

  @override
  String get rating => "4.9/5 Rating";

  @override
  String get by => "By";

  @override
  String get purchaseLifetimePlanAtNoCost =>
      'Lifetime access limited time only';

  @override
  String get apiError => "An error occurred. Please try again later";

  @override
  String get apiErrorDescription =>
      "Oops! Something went wrong. Please try again later.";

  @override
  String get connectionTimeout => "Connection Timeout";

  @override
  String get connectionTimeoutDesc =>
      "Oops! It seems the connection timed out. Please check your internet connection and try again.";

  @override
  String get sendTimeout => "Connection Timeout";

  @override
  String get sendTimeoutDesc =>
      "Oops! It seems the connection timed out. Please check your internet connection and try again.";

  @override
  String get receiveTimeout => "Data Reception Issue";

  @override
  String get receiveTimeoutDesc =>
      "Oops! We're having trouble receiving data right now. Please try again later.";

  @override
  String get badCertificate => "Security Certificate Problem";

  @override
  String get badCertificateDesc =>
      "Sorry, there's a problem with the security certificate. Please contact support for assistance.";

  @override
  String get badResponse => "Unexpected Server Response";

  @override
  String get badResponseDesc =>
      "Oh no! We received an unexpected response from the server. Please try again later.";

  @override
  String get reqCancel => "Request Cancelled";

  @override
  String get reqCancelDesc =>
      "Your request has been cancelled. Please try again.";

  @override
  String get connectionError => "Connection Issue";

  @override
  String get connectionErrorDesc =>
      "We're having trouble connecting to the server. Please check your internet connection and try again.";

  @override
  String get unknown => "Unknown Error";

  @override
  String get unknownDesc =>
      "Oops! Something went wrong. Please try again later.";

  @override
  String get code200 => "The request was successful.";

  @override
  String get code201 => "A new resource was created successfully.";

  @override
  String get code202 =>
      "The request was accepted for processing, but the processing has not been completed.";

  @override
  String get code301 =>
      "The resource has been permanently moved to a new location.";

  @override
  String get code302 =>
      "The resource has been temporarily moved to a new location.";

  @override
  String get code304 =>
      "The resource has not been modified since the last request.";

  @override
  String get code400 =>
      "The server could not understand the request due to malformed syntax.";

  @override
  String get code401 => "The request requires user authentication.";

  @override
  String get code403 =>
      "The server understood the request, but refuses to fulfill it.";

  @override
  String get code404 => "The requested resource could not be found.";

  @override
  String get code405 =>
      "The method specified in the request is not allowed for the requested resource.";

  @override
  String get code409 =>
      "The request could not be completed due to a conflict with the current state of the resource.";

  @override
  String get code500 =>
      "The server encountered an unexpected condition which prevented it from fulfilling the request.";

  @override
  String get code503 => "The server is currently unable to handle the request.";

  @override
  String get backendPromptInputEx =>
      'Example: "You are a writing assistant, and your task is to automatically generate excellent articles based on the content i provide”.';
  @override
  String get aiAssistantPrompt => 'AI Assistant Prompt';
  @override
  String get aiModels => 'AI Models';
  @override
  @override
  String get mostPowerfulAiModel => 'Most Powerful AI Model';
  @override
  String get moreHumanlyResponses => 'More Humanly Responses';
  @override
  String get create => "Create";
  @override
  String get pleaseEnterPrompt => "Please enter prompt";
  @override
  String get pleaseSelectImage => "Please select image";
  @override
  String get retry => "Try again";
  @override
  String get deleteAssistant => "Delete Assistant";
  @override
  String get deleteAssistantDesc =>
      "Are you sure you want to delete this assistant?";
}
