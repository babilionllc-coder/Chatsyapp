import 'dart:io';

import '../helper/constants.dart';
import 'local_language.dart';

class LanguageHin extends Languages {
  @override
  String get appName => Constants.appName;

  @override
  String get dashboard => "डैशबोर्ड";

  @override
  String get setLanguages => "भाषाएँ सेट करें";

  @override
  String get eliteTools => "एलीट टूल्स";

  @override
  String get chooseImage => "छवि चुनें";

  @override
  String get scanDocumentsImages => "दस्तावेज़ या छवियाँ स्कैन करें";

  @override
  String get transformYourVisionIntoArt => "अपनी दृष्टि को कला में बदलें";

  @override
  String get search => "खोज";

  @override
  String get languagesNotFound => "भाषाएँ नहीं मिलीं";

  @override
  String get tools => "टूल्स";

  @override
  String get legal => "कानूनी";

  @override
  String get uploadAndAsk => "अपलोड करें और पूछें";

  @override
  String get doYouLikeUsAsMuchAsW =>
      "क्या आप हमें उतना ही पसंद करते हैं जितना हम आपको?";

  @override
  String get weDetailedReview =>
      (Platform.isAndroid)
          ? "प्रेम का प्रसार! यदि आप Google Play Store पर एक विस्तृत समीक्षा छोड़ सकें तो हम आभारी होंगे। आपकी प्रतिक्रिया हमारे लिए बहुत मायने रखती है! ❤️"
          : "प्रेम का प्रसार! यदि आप ऐप स्टोर पर विस्तृत समीक्षा छोड़ सकें तो हम आभारी होंगे। आपकी प्रतिक्रिया हमारे लिए बहुत मायने रखती है! ❤️";

  @override
  String get helpAiChatSy => "${Constants.appName} की मदद करें";

  @override
  String get hiHowCanIHelpYou => "हाय! मैं आपकी कैसे मदद कर सकता हूँ?";

  @override
  String get suggestions => "सुझाव";

  @override
  String get linkAndAsk => "लिंक करें और पूछें";

  @override
  String get exitAlertMessage =>
      "ऐप से बाहर निकलने के लिए बैक बटन को एक बार और दबाएं";

  @override
  String get doYouLike => "क्या आप हमें उतना ही पसंद करते हैं जितना हम आपको?";

  @override
  String get searchOrAsk => "किसी दस्तावेज़ में कुछ भी खोजें या पूछें";

  @override
  String get searchOrWebPage => "किसी वेबपेज में कुछ भी खोजें या पूछें";

  @override
  String get myHistory => "मेरा इतिहास";

  @override
  String get getText => "पाठ प्राप्त करें";

  @override
  String get templates => "टेम्पलेट्स";

  @override
  String get newChat => "नई चैट";

  @override
  String get startNewChat => "एक नई चैट शुरू करें";

  @override
  String get chatHistory => "चैट इतिहास";

  @override
  String get chat => "चैट";

  @override
  String get promptChat => "प्रॉम्प्ट चैट";

  @override
  String get deleteAll => "सभी हटाएँ";

  @override
  String get sendAMessage => "एक संदेश भेजें";

  @override
  String get takePicture => "तस्वीर लें";

  @override
  String get chooseFromLibrary => "लाइब्रेरी से चुनें";

  @override
  String get uploadFile => "फाइल अपलोड करें";

  @override
  String get analyzeWebsite => "वेबसाइट का विश्लेषण करें";

  @override
  String get generateImage => "छवि उत्पन्न करें";

  @override
  String get scanText => "पाठ स्कैन करें";

  @override
  String get viewTemplates => "टेम्पलेट्स देखें";

  @override
  String get deleteThisChat => "इस चैट को हटाएँ?";

  @override
  String get deleteThisChatSub => "क्या आप वाकई इस चैट को हटाना चाहते हैं?";

  @override
  String get cancel => "रद्द करें";

  @override
  String get delete => "हटाएँ";

  @override
  String get deleteAllChat => "सभी चैट इतिहास हटाएं?";

  @override
  String get deleteAllChatSub =>
      "क्या आप वाकई में अपनी सभी चैट हिस्ट्री को हटाना चाहते हैं?";

  @override
  String get settings => "सेटिंग्स";

  @override
  String get followUs => "हमें फॉलो करें";

  @override
  String get language => "भाषा";

  @override
  String get rateUs => "हमें रेट करें";

  @override
  String get selectAIModel => "AI मॉडल चुनें";

  @override
  String get darkMode => "डार्क मोड";

  @override
  String get lightMode => "लाइट मोड";

  @override
  String get userID => "उपयोगकर्ता आईडी";

  @override
  String get aboutUs => "हमारे बारे में";

  @override
  String get contactUs => "संपर्क करें";

  @override
  String get privacyPolicy => "गोपनीयता नीति";

  @override
  String get termsOfUse => "उपयोग की शर्तें";

  @override
  String get aboutUsSub =>
      "${Constants.appName} एक AI चैटबॉट सहायक है जो चैटजीपीटी-4 तकनीक द्वारा संचालित है जो आपको किसी भी कार्य को हल करने और किसी भी प्रश्न का उत्तर देने में मदद करेगा। आपको जो चाहिए उसके लिए संकेत लिखकर, आप कुछ भी पूछ सकते हैं और किसी भी समस्या/कार्य के लिए किसी भी प्रश्न या समाधान का उत्तर प्राप्त कर सकते हैं!\n\nहमारा एआई चैटबॉट सहायक आपकी हर जरूरत को पूरा करने के लिए डिज़ाइन किया गया है-एक ऐप में सभी एआई सुविधाएँ!\n\nai मॉड्यूल उपलब्धः\n- चैट जी. पी. टी. \n- जी. पी. टी.-4\n- पी. ए. एल. एम. 2\n\nआप आसानी से अपनी चैट और प्रॉम्प्ट हिस्ट्री की जांच कर सकते हैं और पसंदीदा भाषा के लिए ऐप को स्थानीयकृत कर सकते हैं। (English, Spanish, Hindi, French, Portuguese).\n\nआमार ऐप एआई चैटबॉट ब्रिलियंस और वर्चुअल असिस्टेंट सुविधाओं का सबसे अच्छा संयोजन है, जो उन्नत चैट जीपीटी-4 तकनीक द्वारा संचालित है।\n\n मुख्य विशेषताएँः\n - निबंध लेखक\n - फोटो जनरेटर और रिकग्निशन\n - टेक्स्ट-टू-ऑडियो\n - ईमेल लेखक\n - टेक्स्ट स्कैन\n - व्याकरण जांच\n - अनुवाद\n - लेखों और वेबसाइटों का सारांश\n - साहित्यिक चोरी जांचकर्ता\n - पासवर्ड जनरेटर\n - बैठक सारांश\n - व्याख्या उपकरण\n - मजाक जनरेटर\n - समस्या समाधान उपकरण\n - वॉयस इंटरैक्शन/कमांड\n -वेबसाइट का विश्लेषण\n - फाइलों का विश्लेषण\n - ड्रीम इंटरप्रेटर\n - प्रतियोगी विश्लेषण\n - सामाजिक सामग्री\n - कोडिंग संसाधन और कई अन्य!\n\nहम निरंतर नवाचार के लिए प्रतिबद्ध हैं, हमेशा प्रौद्योगिकी के साथ आपकी बातचीत को बढ़ाने के लिए नए तरीकों की खोज करते हैं।\n\nआपका अनुभव हमारी विकास प्रक्रिया के केंद्र में है। हम आपकी प्रतिक्रिया सुनते हैं और अपनी सेवाओं को आपके जीवन के अनुरूप बनाते हैं।\n\nहमारे AI चैटबॉट सहायक द्वारा प्रदान किए जाने वाले लाभों का आनंद लें-${Constants.appName} आपके लिए 24/7 है! मेल @aichatsy.com के माध्यम से किसी भी चीज़ के लिए हमसे संपर्क करने के लिए स्वतंत्र महसूस करें।";

  @override
  String get name => "नाम";

  @override
  String get url => "कृपया url दर्ज करें";

  @override
  String get subject => "विषय";

  @override
  String get poweredBy => "द्वारा संचालित";

  @override
  String get message => "संदेश";

  @override
  String get submit => "जमा करें";

  @override
  String get errorMessageValidYourName => "कृपया अपना नाम दर्ज करें";

  @override
  String get errorMessageEmail => "कृपया अपना ईमेल दर्ज करें";

  @override
  String get errorMessageValidEmail => "कृपया मान्य ईमेल दर्ज करें";

  @override
  String get errorMessageSubject => "कृपया विषय दर्ज करें";

  @override
  String get errorMessageMessage => "कृपया संदेश दर्ज करें";

  @override
  String get email => "ईमेल";

  @override
  String get letAiChtSyUnlockYourInnerGenius =>
      "अपनी आंतरिक प्रतिभा को ${Constants.appName} के साथ अनलॉक करें!";

  @override
  String get bestSeller => "सर्वश्रेष्ठ विक्रेता";

  @override
  String get off => "55% छूट";

  @override
  String get byContinuingYouAccept => "जारी रखकर आप स्वीकार करते हैं ";

  @override
  String get tosPrivacyPolicy => "नियम और शर्तें, गोपनीयता नीति";

  @override
  String get and => "और ";

  @override
  String get billingTeam => "बिलिंग टीम";

  @override
  String get purchase => "खरीद फरोख्त";

  @override
  String get restore => "पुनः स्थापित करें";

  @override
  String get aiChatSy => Constants.appName;

  @override
  String get chatGPT4 => "चैटजीपीटी और जीपीटी-4";

  @override
  String get joinMillionsOf => "लाखों का साथ दें ";

  @override
  String get happyUsers => "खुश उपयोगकर्ता ";

  @override
  String get unlockThePotential => "उन्नत की संभावनाओं को अनलॉक करें ";

  @override
  String get aICamera => "एआई कैमरा  ";

  @override
  String get technology => "प्रौद्योगिकी";

  @override
  String get elevateYourExperienceWith =>
      "के साथ अपने अनुभव को ऊंचाई पर ले जाएँ ";

  @override
  String get eliteFeatures => " एलीट फीचर्स। ";

  @override
  String get aiChatSyMsg =>
      "नीचे टाइप करें उत्तर पाने के लिए\nकोई भी खुले प्रश्न पूछें";

  @override
  String get imageGeneration => "छवि निर्माण";

  @override
  String get effortlesslyCraftYourSearch =>
      "आसानी से अपनी खोज को हमारे हैंडी के साथ तैयार करें";

  @override
  String get textToImage => "टेक्स्ट से इमेज";

  @override
  String get photoIdentification => "फोटो पहचान";

  @override
  String get camera => "कैमरा";

  @override
  String get gallery => "गैलरी";

  @override
  String get uploadYourImage => "अपनी इमेज अपलोड करें";

  @override
  String get uploadAndIdentify => "अपलोड करें और पहचानें";

  @override
  String get weLoveToGetADetailed =>
      "हमें ऐप स्टोर पर आपसे एक विस्तृत समीक्षा प्राप्त करना पसंद होगा, बताएं कि आपको ${Constants.appName} क्यों पसंद है!";

  @override
  String get askSomething => "कुछ पूछिए";

  @override
  String get uploadAndAskSubTitle =>
      "आप किसी दस्तावेज़ में कुछ भी पूछ सकते हैं या खोज सकते हैं। सारांश के लिए, कृपया होमपेज पर समराइज़ सेक्शन का उपयोग करें।\n\nकृपया सुनिश्चित करें कि फ़ाइल या तो .pdf, .docx या .txt फ़ाइल हो";

  @override
  String get typeYourQuestionHere => "अपना प्रश्न यहाँ लिखें";

  @override
  String get typeYourTextHere => "अपना टेक्स्ट यहाँ लिखें";

  @override
  String get pleaseUploadFile =>
      "फ़ाइल समर्थित नहीं है। कृपया केवल .pdf, .docx या .txt फ़ाइलें ही डालें";

  @override
  String pleaseEnterValid({String? title}) {
    return "कृपया वैध दर्ज करें  $title";
  }

  @override
  String get pleaseEnterValidQuestion => "कृपया मान्य प्रश्न दर्ज करें";

  @override
  String get pleaseEnterImage => "कृपया छवि दर्ज करें";

  @override
  String get done => "हो गया";

  @override
  String get linkAndAskSubTitle =>
      "आप किसी वेबपेज में कुछ भी पूछ सकते हैं या खोज सकते हैं। सारांश के लिए, कृपया होमपेज पर समराइज़ सेक्शन का उपयोग करें।";

  @override
  String get pasteYourLink => "अपना लिंक पेस्ट करें";

  @override
  String get pleaseEnterValidUrl => "कृपया मान्य यूआरएल लिंक दर्ज करें";

  @override
  String get pleaseEnterUrl => "कृपया यूआरएल लिंक दर्ज करें";

  @override
  String get summarizeArticle => "लेख सारांशित करें";

  @override
  String get summarizeArticleMsg => "विस्तृत लेख सारांश प्राप्त करें";

  @override
  String get summarizeWeb => "वेबसाइट सारांशित करें";

  @override
  String get summarizeWebMsg => "विस्तृत वेबपेज सारांश प्राप्त करें";

  @override
  String get summarizeArticleTitle =>
      "आप अपना दस्तावेज़ जोड़ सकते हैं और ${Constants.appName} इसे सारांशित कर सकता है।\n\nकृपया सुनिश्चित करें कि फ़ाइल या तो .pdf, .docx या .txt फ़ाइल हो";

  @override
  String get summarizeArticleWeb =>
      "आप अपना दस्तावेज़ जोड़ सकते हैं और ${Constants.appName} इसे सारांशित कर सकता है।";

  @override
  String get summarizeIn => "में सारांशित करें";

  @override
  String get summarize => "सारांशित करें";

  @override
  String get chatGPT => "ChatGPT";

  @override
  String get chatGPTMsg => "ओपनएआई द्वारा प्रदान किया गया\nमूल चैटबोट मॉडल";

  @override
  String get GPT4 => "GPT-4";

  @override
  String get paLM2 => "PaLM 2";

  @override
  String get aCreativeAndHelpfulCollaborator =>
      "एक रचनात्मक और सहायक सहयोगी,\nगूगल A1 द्वारा विकसित";

  @override
  String get convertTextBasedDescriptions =>
      "पाठ-आधारित विवरणों को दृश्य डेटो में परिवर्तित करें";

  @override
  String get GPT4Msg =>
      "एक अधिक उन्नत प्रणाली, जो\nसुरक्षित और अधिक उपयोगी प्रतिक्रियाएँ प्रदान करती है";

  @override
  String get copy => "कॉपी";

  @override
  String get selectText => "टेक्स्ट चुनें";

  @override
  String get regenerateResponse => "प्रतिक्रिया पुनः उत्पन्न करें";

  @override
  String get ok => "ठीक है";

  @override
  String get appUpdate => "ऐप अपडेट आवश्यक!";

  @override
  String get update => "अपडेट";

  @override
  String get english => "अंग्रेज़ी";

  @override
  String get spanish => "स्पैनिश";

  @override
  String get hindi => "हिंदी";

  @override
  String get french => "फ्रेंच";

  @override
  String get portuguese => "पुर्तगाली";

  @override
  String get pleaseFillThe => "कृपया भरें";

  @override
  String get inTheFormForBetterResults =>
      "बेहतर परिणामों के लिए कृपया फॉर्म भरें";

  @override
  String get aiAssistants => "एआई सहायक";

  @override
  String get examples => "उदाहरण";

  @override
  String get aiChatSyCanGenerateUnique =>
      "आपके वर्णन के आधार पर विज़ुअल्स तैयार कर सकता है। एक इमेज बनाने के लिए, आप इसे वर्णन करने के लिए एक संदेश भेज सकते हैं या एक पहले से बना हुआ प्रॉम्प्ट का उपयोग कर सकते हैं!";

  @override
  String get freeTrialEnabled => "मुफ्त परीक्षण सक्षम";

  @override
  String get explore => "खोजें";

  @override
  String get yourListIsEmpty => "आपकी सूची खाली है";

  @override
  String get seeAll => "सभी देखें";

  @override
  String get hide => "छुपाएँ";

  @override
  String get download => "डाउनलोड करें";

  @override
  String get share => "साझा करें";

  @override
  String get chooseYourLanguage => "अपनी भाषा चुनें";

  @override
  String get assistants => "सहायकों";

  @override
  String get home => "घर";

  @override
  String get fullAccessTo => "तक पूर्ण पहुंच";

  @override
  String get pro => " प्रो ";

  @override
  String get aICHATSYUnlimited => "${Constants.appName} असीमित";

  @override
  String get poweredByGPT4GeminiPaLM => "Powered by GPT 4o, Gemini";

  @override
  String get premiumAiTools => "प्रीमियम एआई उपकरण";

  @override
  String get fasterConversation => "तेज़ बातचीत";

  @override
  String get unlimitedChatImages => "असीमित चैट और छवियाँ";

  @override
  String get pDFURLSummary => "पीडीएफ और यूआरएल सारांश";

  @override
  String get unlimitedYearly => "असीमित वार्षिक";

  @override
  String get save80 => "80% बचाएं";

  @override
  String get save25 => "25% बचाएं";

  @override
  String get mostPopular => "सबसे लोकप्रिय";

  @override
  String get lowestPrice => "सबसे कम कीमत";

  @override
  String get unlimitedMonthly => "असीमित मासिक";

  @override
  String get unlimitedWeekly => "असीमित साप्ताहिक";

  @override
  String get lifetimeAccess => "आजीवन प्रवेश";

  @override
  String get limitedOffer => "सीमित ऑफ़र";

  @override
  String get oneTimeBuy => "एक बार खरीदें";

  @override
  String get unlockLifetimeAccess => "लाइफटाइम एक्सेस अनलॉक करें";

  @override
  String get subscribe => "सदस्यता लें";

  @override
  String get autoRenewable => "स्वतः नवीकरणीय";

  @override
  String get unlimitedUsage => "असीमित उपयोग";

  @override
  String get noCommitment => "कोई वादा नहीं";

  @override
  String get cancelAnytime => "किसी भी समय रद्द करें";

  @override
  String get imageScan => "छवि स्कैन";

  @override
  String get textScan => "टेक्स्ट स्कैन";

  @override
  String get summarizePDF => "पीडीएफ को सारांशित करें";

  @override
  String get textsFromImages => "छवियों से पाठ";

  @override
  String get whatNew => "नया क्या है?";

  @override
  String get news => "नया";

  @override
  @override
  @override
  String get aIModules => "AI मॉड्यूल";

  @override
  String get yourDailyFreeCredits => "आपके दैनिक निःशुल्क क्रेडिट";

  @override
  String get youHave => "आपके पास";

  @override
  String get creditLeft => "श्रेय वाम";

  @override
  String get upgradeToPremium => "प्रीमियम में अपग्रेड करें";

  @override
  String get getUnlimitedAccessToAllFeatures =>
      "सभी सुविधाओं तक असीमित पहुंच प्राप्त करें";

  @override
  String get unlimitedAccess => "असीमित पहुंच";

  @override
  String get yearly => "सालाना";

  @override
  String get monthly => "महीने के";

  @override
  String get threeDaysFreeTrial => "3 दिन का निःशुल्क परीक्षण";

  @override
  String get startFreeTrial => "निशुल्क आजमाइश शुरु करें";

  @override
  String get uploadAndAAsk => "अपलोड करें और पूछें";

  @override
  String get unlockTheFullPotentialOfAichatsy =>
      "अपलोड और आस्क सुविधा का उपयोग करके ${Constants.appName} की AI की पूरी क्षमता को अनलॉक करें। किसी भी दस्तावेज़ को आसानी से अपलोड करें और त्वरित, सटीक प्रतिक्रियाएँ प्राप्त करें।";

  @override
  String get uploadYourDocument => "अपना दस्तावेज़ अपलोड करें";

  @override
  String get clickTheUploadButtonAndSelectYourFile =>
      "अपलोड बटन पर क्लिक करें और अपनी फ़ाइल चुनें।";

  @override
  String get askQuestion => "प्रश्न पूछो";

  @override
  String get typeInYourQueryBboutTheDocument =>
      "दस्तावेज़ के बारे में अपनी क्वेरी टाइप करें।";

  @override
  String get getAnswer => "उत्तर प्राप्त करें";

  @override
  String get receiveInstantAIGeneratedResponses =>
      "तुरंत, AI-जनित प्रतिक्रियाएँ प्राप्त करें।";

  @override
  String get letsGo => "चल दर";

  @override
  String get visionScan => "दृष्टि स्कैन";

  @override
  String get experienceThePowerOfAichatsy =>
      "आइचात्सी के विज़न स्कैन सुविधा की शक्ति का अनुभव करें। दस्तावेज़ों या छवियों को आसानी से स्कैन करें और तुरंत AI-जनित जानकारी प्राप्त करें।";

  @override
  String get scanDocument => "दस्तावेज़ स्कैन करें";

  @override
  String get captureYourDocumentOrImage => "अपना दस्तावेज़ या छवि कैप्चर करें.";

  @override
  String get enterYourQuestion => "अपना प्रश्न दर्ज करें.";

  @override
  String get getInsights => "जानकारी प्राप्त करें";

  @override
  String get transformYourIdeasIntoVisualsWithAichatsy =>
      "${Constants.appName} की इमेज जेनरेशन सुविधा के साथ अपने विचारों को दृश्यों में बदलें। सहजता से कस्टम चित्र बनाने के लिए बिल्कुल सही।";

  @override
  String get describeImage => "छवि का वर्णन करें";

  @override
  String get enterBriefDescriptionOfTheImageYouWant =>
      "अपनी इच्छित छवि का संक्षिप्त विवरण दर्ज करें।";

  @override
  String get selectStyle => "शैली चुनें";

  @override
  String get pickStyleOrTemplateThatSuitsYourVision =>
      "वह शैली या टेम्पलेट चुनें जो आपकी दृष्टि के अनुकूल हो।";

  @override
  String get generate => "उत्पन्न";

  @override
  String get clickToCreateYourImage => "अपनी छवि बनाने के लिए क्लिक करें.";

  @override
  String get receiveInstantAIGeneratedAnswers =>
      "तुरंत AI-जनित उत्तर प्राप्त करें।";

  @override
  String get enterALink => "एक लिंक दर्ज करें";

  @override
  String get enterTheURLToSummarize =>
      "इसकी सामग्री को सारांशित करने, पुनः लिखने, अनुवाद करने या विश्लेषण करने के लिए URL दर्ज करें।";

  @override
  String get pasteALink => "एक लिंक चिपकाएँ";

  @override
  String get pasteALinkEG => "एक लिंक चिपकाएँ (e:g www.aichatsy.com)";

  @override
  String get continues => "जारी रखना";

  @override
  String get uploadYourPDF => "अपना पीडीएफ अपलोड करें";

  @override
  String get itMustBe10MBMax => "यह अधिकतम 10.0 एमबी होना चाहिए।";

  @override
  String get uploadPDF => "पीडीएफ अपलोड करें";

  @override
  String get uploadImage => "तस्विर अपलोड करना";

  @override
  String get uploadImageToScan => "स्कैन करने के लिए छवि अपलोड करें";

  @override
  String get oopsYouReachedYourDailyMessaging =>
      "उफ़, आप अपनी दैनिक संदेश-सेवा सीमा तक पहुँच गए हैं! फ्री प्लान पर आप प्रतिदिन 4 मैसेज भेज सकते हैं। असीमित संदेशों को अनलॉक करने के लिए अपग्रेड करें।";

  @override
  String get upgradeToPRO => "समर्थक में";

  @override
  String get premium => "अधिमूल्य";

  @override
  String get length => "लंबाई";

  @override
  String get auto => "ऑटो";

  @override
  String get short => "छोटा";

  @override
  String get medium => "मध्यम";

  @override
  String get long => "लंबा";

  @override
  String get defaults => "🤖 डिफ़ॉल्ट";

  @override
  String get professional => "🧐 पेशेवर";

  @override
  String get friendly => "😃 मिलनसार";

  @override
  String get inspirational => "😇प्रेरणादायक";

  @override
  String get joyful => "😂 हर्षित";

  @override
  String get persuasive => "😉 प्रेरक";

  @override
  String get empathetic => "️️🙂 सहानुभूतिपूर्ण";

  @override
  String get surprised => "😯आश्चर्यचकित";

  @override
  String get optimistic => "😋 आशावादी";

  @override
  String get worried => "😟चिंतित";

  @override
  String get curious => "😏 जिज्ञासु";

  @override
  String get assertive => "😎मुखर";

  @override
  String get cooperative => "😌सहकारिता";

  @override
  String get romantic => "🥰रोमांटिक";

  @override
  String get passionate => "😍 भावुक";

  @override
  String get critical => "🤬 गंभीर";

  @override
  String get responseTone => "प्रतिक्रिया स्वर";

  @override
  String get save => "बचाना";

  @override
  String get selectImageSizeStyle => "छवि का आकार और शैली चुनें";

  @override
  String get selectSize => "आकार चुना";

  @override
  String get pleaseUploadPDF =>
      "फ़ाइल समर्थित नहीं है. कृपया केवल .pdf फ़ाइलें ही डालें";

  @override
  String get chooseAvatar => "अवतार चुनें";

  @override
  String get anyTimeCancel => "किसी भी समय रद्द करें";

  @override
  String get pleaseEnterName => "कृपया नाम दर्ज करें";

  @override
  String get summarizeIt => "इसे संक्षेप में प्रस्तुत करें";

  @override
  String get rewriteIt => "इसे फिर से लिखें";

  @override
  String get welcomeToAICHATSY => "${Constants.appName} में आपका स्वागत है";

  @override
  String get wereDelightedToHaveYouHere => "हमें आपको यहाँ पाकर ख़ुशी हुई है।";

  @override
  String get howShouldWeCallYou => "हमें आपको कैसे कॉल करना चाहिए?";

  @override
  String get optional => "वैकल्पिक";

  @override
  String get enterName => "नाम दर्ज करें";

  @override
  String get theme => "विषय";

  @override
  String get chatGPTIsYourAIAssistant =>
      "चैटजीपीटी त्वरित उत्तरों और रचनात्मक सहायता के लिए आपका एआई सहायक है, जो आपके अनुभव को बढ़ाने के लिए वैयक्तिकृत प्रतिक्रियाएं प्रदान करता है।";

  @override
  String get knowledgeBase => "ज्ञानधार:";

  @override
  String get deliversAccurateInformativeResponses =>
      "सटीक, सूचनाप्रद प्रतिक्रियाएँ देता है।";

  @override
  String get creativity => "रचनात्मकता:";

  @override
  String get helpsGenerateIdeasAndWriteContent =>
      "विचार उत्पन्न करने और सामग्री लिखने में मदद करता है।";

  @override
  String get efficiency => "क्षमता:";

  @override
  String get providesQuickReliableAnswers =>
      "त्वरित, विश्वसनीय उत्तर प्रदान करता है।";

  @override
  String get chatGPT4IsYourAdvancedAIAssistant =>
      "ChatGPT-4 आपका उन्नत AI सहायक है, जिसे सटीक उत्तर देने, रचनात्मक कार्यों में सहायता करने और व्यक्तिगत सहायता प्रदान करने के लिए डिज़ाइन किया गया है।";

  @override
  String get enhancedUnderstanding => "बढ़ी हुई समझ:";

  @override
  String get deliversMoreAccurateResponses =>
      "अधिक सटीक प्रतिक्रियाएँ देता है.";

  @override
  String get creativeAssistance => "रचनात्मक सहायता:";

  @override
  String get generatesIdeasAndContentEffortlessly =>
      "सहजता से विचार और सामग्री उत्पन्न करता है।";

  @override
  String get realTimeUpdates => "वास्तविक समय अपडेट:";

  @override
  String get accessesLiveInfoForRealTimeResponses =>
      "वास्तविक समय की प्रतिक्रियाओं के लिए लाइव जानकारी तक पहुँचता है।";

  @override
  String get paLMIsAnAILanguageModelDevelopedByGoogleAI =>
      "PaLM GOOGLE AI द्वारा विकसित एक AI भाषा मॉडल है, जो प्राकृतिक भाषा प्रसंस्करण और पीढ़ी में अपनी उन्नत क्षमताओं के लिए जाना जाता है।";

  @override
  String get advancedPatternRecognition => "उन्नत पैटर्न पहचान:";

  @override
  String get enhancesPatternRecognitionCapabilities =>
      "पैटर्न पहचान क्षमताओं को बढ़ाता है।";

  @override
  String get contextualUnderstanding => "प्रासंगिक समझ:";

  @override
  String get improvesModelsComprehensionOfContext =>
      "मॉडलों की संदर्भ की समझ में सुधार होता है।";

  @override
  String get enhancedPerformance => "बढ़ा हुआ प्रदर्शन:";

  @override
  String get boostOverallModelCapabilitiesEffectively =>
      "समग्र मॉडल क्षमताओं को प्रभावी ढंग से बढ़ाता है।";

  @override
  String get palm => "हथेली";

  @override
  String get geminiIsAnInnovativeAITechnology =>
      "जेमिनी एक नवोन्मेषी एआई तकनीक है जो निर्बाध बातचीत को सक्षम करने और उन्नत क्षमताओं के साथ कार्य कुशलता बढ़ाने के लिए जानी जाती है।";

  @override
  String get smoothInteractions => "सहज बातचीत:";

  @override
  String get enablesIntuitiveUserEngagement =>
      "सहज उपयोगकर्ता जुड़ाव को सक्षम बनाता है।";

  @override
  String get efficientTasks => "कुशल कार्य:";

  @override
  String get enhancesProductivity => "उत्पादकता बढ़ाता है.";

  @override
  String get advancedIntegration => "उन्नत एकीकरण:";

  @override
  String get cuttingEdgeAIOptimization => "अत्याधुनिक एआई अनुकूलन।";

  @override
  String get letTry => "आओ कोशिश करते हैं";

  @override
  String get websiteInsightsWithAIChatSY =>
      "${Constants.appName} के साथ वेबसाइट अंतर्दृष्टि";

  @override
  String get addWebsiteURL => "वेबसाइट यूआरएल जोड़ें";

  @override
  String get pasteTheWebsiteLink => "वेबसाइट लिंक चिपकाएँ";

  @override
  String get summarizeAnyPDF => "किसी भी पीडीएफ को सारांशित करें";

  @override
  String get clickSummarize => "सारांशित करें पर क्लिक करें";

  @override
  String get hitTheSummarizeButtonStart =>
      "प्रारंभ करने के लिए सारांश बटन दबाएँ";

  @override
  String get uploadAnyDocumentOrPdf => "कोई भी दस्तावेज़ या पीडीएफ अपलोड करें";

  @override
  String get readSummary => "सारांश पढ़ें";

  @override
  String get getConciseSummaryWebpage =>
      "वेबपेज का संक्षिप्त सारांश प्राप्त करें";

  @override
  String get askAnything => "कुछ भी पूछें";

  @override
  String get askAICHATSYWhatDocument =>
      "${Constants.appName} से पूछें कि दस्तावेज़ के साथ क्या करना है";

  @override
  String get getResponses => "प्रतिक्रियाएँ प्राप्त करें";

  @override
  String get getQuickResponsesInSeconds =>
      "सेकंडों में त्वरित प्रतिक्रियाएँ प्राप्त करें";

  @override
  String get cancellationCancelAnytimeDuring =>
      "रद्दीकरण: पहले तीन दिनों के दौरान किसी भी समय रद्द करें";

  @override
  String get summarizeDocument => "संक्षेप करें दस्तावेज़";

  @override
  String get youtubeSummary => "यूट्यूब सारांश";

  @override
  String get realTimeWeb => "रियल टाइम वेब";

  @override
  String get scanAnyText => "किसी भी टेक्स्ट को स्कैन करें";

  @override
  String get uploadOrCapture => "अपलोड करें या कैप्चर करें";

  @override
  String get uploadAnyDocumentOrPicture => "कोई दस्तावेज़ या चित्र अपलोड करें";

  @override
  String get askWhatToDoWithDocument =>
      "${Constants.appName} से पूछें कि दस्तावेज़ के साथ क्या करना है";

  @override
  String get getRespondOnScan => "स्कैन पर प्रतिक्रिया प्राप्त करें";

  @override
  String get useCamera => "कैमरे का प्रयोग करें";

  @override
  String get addWebsite => "वेबसाइट जोड़ें";

  @override
  String get searchAndAskAboutYouTubeVideoContent =>
      "यूट्यूब वीडियो सामग्री के बारे में खोजें और पूछें";

  @override
  String get takeOrChoosePhoto => "फ़ोटो लें या चुनें";

  @override
  String get recognize => "पहचानना";

  @override
  String get addWebsiteDesc =>
      "इसकी सामग्री को सारांशित करने, पुनः लिखने, अनुवाद करने या विश्लेषण करने के लिए URL दर्ज करें।";

  @override
  String get pasteLink => "एक लिंक चिपकाएँ (e:g www.aichatsy.com)";

  @override
  String get enterYoutubeLink => "यूट्यूब लिंक दर्ज करें";

  @override
  String get documentUpload => "दस्तावेज़ अपलोड करें";

  @override
  String get summarizeYourDocument => "अपने दस्तावेज़ को सारांशित करें";

  @override
  String get summarizeYourDocumentDesc =>
      "कृपया सुनिश्चित करें कि फ़ाइल या तो .pdf .docx या .txt फ़ाइल है";

  @override
  String get imageUpload => "छवि अपलोड करें";

  @override
  String get sendFeedback => "प्रतिक्रिया भेजें";

  @override
  String get edit => "संपादन करना";

  @override
  String get readLoud => "जोर से पढ़ें";

  @override
  String get recentImages => "हाल की छवियाँ";

  @override
  String get clearAll => "सभी साफ करें";

  @override
  String get areYouSureYouWantToClearAllImage =>
      "क्या आप वाकई \nसभी छवि साफ़ करना चाहते हैं?";

  @override
  String get yes => "हाँ";

  @override
  String get allHistory => "सारा इतिहास";

  @override
  String get favorites => "पसंदीदा";

  @override
  String get today => "आज";

  @override
  String get yesterday => "कल";

  @override
  String get thisWeek => "इस सप्ताह";

  @override
  String get noDataFound => "डाटा प्राप्त नहीं हुआ";

  @override
  String get upgradeToAICHATSY => "${Constants.appName} में अपग्रेड करें";

  @override
  String get wouldYouLikeToDeleteAll => "क्या आप सभी चैट हटाना चाहेंगे?";

  @override
  String get creditsLeftToday => "आज क्रेडिट बचे हैं";

  @override
  String grantPermission({String? title}) {
    return "$title अनुमति प्रदान करें";
  }

  @override
  String permissionFromTheAppAppSettings({String? title}) {
    return "कृपया ऐप सेटिंग से $title की अनुमति दें";
  }

  @override
  String get hiAiChatsyPoweredByChatGPT =>
      "नमस्ते, मैं ऐचैट्सी हूं! चैटजीपीटी द्वारा संचालित.";

  @override
  String get imHereToAssistYouWithGuidance =>
      "मैं एक प्रभावशाली सीवी तैयार करने, प्रभावी ईमेल लिखने, उत्पादकता बढ़ाने, विचारशील उपहार सुझाव प्राप्त करने, या अद्वितीय पहली-डेट स्थानों की खोज करने पर मार्गदर्शन में आपकी सहायता करने के लिए यहां हूं।";

  @override
  String get startAskingQuestions => "प्रश्न पूछना शुरू करें!";

  @override
  String get youAre => "तुम हो";

  @override
  String get user => "उपयोगकर्ता";

  @override
  String get allAIModules => "सभी एआई मॉड्यूल";

  @override
  String get aIImageRecognition => "एआई छवि पहचान";

  @override
  String get freeTrial => "मुफ्त परीक्षण";

  @override
  String get startWithFreeTrial => "निःशुल्क परीक्षण से शुरुआत करें";

  @override
  String get pleasePurchasePlanForAccess =>
      "कृपया इस मॉडल तक पहुंच के लिए योजना खरीदें";

  @override
  String get login => "लॉग इन करें";

  @override
  String get welcomeBack => "वापसी पर स्वागत है!";

  @override
  String get continueWithApple => "एप्पल के साथ जारी रखें";

  @override
  String get continueWithGoogle => "Google के साथ जारी रखें";

  @override
  String get docIos =>
      "साइन इन विद एप्पल या साइन इन विद गूगल पर क्लिक करके आप हमारी बात से सहमत होते हैं";

  @override
  String get docAndroid =>
      "साइन इन विद गूगल पर क्लिक करके आप हमारी बात से सहमत होते हैं";

  @override
  String get logOut => "लॉग आउट";

  @override
  String get password => "पासवर्ड";

  @override
  String get errorMessagePassword => "कृपया पासवर्ड दर्ज करें";

  @override
  String get createYourFreeAccount => "अपना निःशुल्क खाता बनाएँ";

  @override
  String get skip => "छोडना";

  @override
  String get signIn => "दाखिल करना";

  @override
  String get free => "मुक्त";

  @override
  String get profile => "प्रोफ़ाइल";

  @override
  String get clickToChangeAvatar => "अवतार बदलने के लिए क्लिक करें";

  @override
  String get logInSuccessful => "लॉग इन सफल";

  @override
  String get syncYourHistoryAcross =>
      "अपने इतिहास को अपने डिवाइसों में सिंक करें।";

  @override
  String get creatingCustomizedAnd => "एक अनुकूलित और बेहतर अनुभव बनाना।";

  @override
  String get syncingYourChatHistoryFor =>
      "बेहतर अनुभव के लिए अपने चैट इतिहास को सिंक करना";

  @override
  String get restoringYourPurchasesSoThat =>
      "अपनी खरीदारी बहाल करना ताकि आप कोई भी चीज़ न चूकें";

  @override
  String get areYouSureTo => "क्या आप निश्चित रूप से लॉग आउट हैं?";

  @override
  String get youWillNotLooseYourDataIf =>
      "यदि आप लॉग आउट करते हैं तो आपका डेटा नहीं खोएगा। आप अभी भी इस खाते में लॉग इन कर सकते हैं.";

  @override
  String get gotIt => "समझ गया";

  @override
  String get realTimeWebSearch => "वास्तविक समय वेब खोज";

  @override
  String get upgradeTo => "में अपग्रेड";

  @override
  String get forFullAccess => "पूर्ण पहुँच के लिए!";

  @override
  String get saveTimeDoMoreAnd => "समय बचाएं, अधिक करें और तेजी से हासिल करें";

  @override
  String get bestOffer => "सबसे अच्छा प्रस्ताव";

  @override
  String get unlimited => "असीमित";

  @override
  String get deleteAccount => "खाता हटा दो";

  @override
  String get itSpam => "यह एक स्पैम है";

  @override
  String get falseInformation => "झूठी सूचना";

  @override
  String get privacyConcerns => "सुरक्षा की सोच";

  @override
  String get violenceThreats => "हिंसा की धमकियाँ";

  @override
  String get other => "अन्य";

  @override
  String get writeYourReason => "अपना कारण लिखें";

  @override
  String get hateSpeechSymbols => "नफरत फैलाने वाले भाषण या प्रतीक";

  @override
  String get bullyingOrHarassment => "धमकाना या उत्पीड़न";

  @override
  String get scamOrFraud => "घोटाला या धोखाधड़ी";

  @override
  String get areYouSureYouWantTo =>
      "क्या आप इस खाते को हटाने के लिए सुनिश्चित हैं?";

  @override
  String get youWilLoseAllYourData =>
      "आप अपना सारा डेटा खो देंगे और आपका खाता पुनर्प्राप्त नहीं किया जाएगा।";

  @override
  String get chooseAReason => "एक कारण चुनें";

  @override
  String get pleaseEnterReason => "कृपया कारण दर्ज करें";

  @override
  String get report => "प्रतिवेदन";

  @override
  String get more => "अधिक";

  @override
  String get no => "नहीं";

  @override
  String get doYouLikeTheApp => "क्या आपको ऐप पसंद है?";

  @override
  String get maybeLater => "शायद बाद में";

  @override
  String get specialOffer => "विशेष पेशकश";

  @override
  String get offAnnualPlan => "वार्षिक योजना पर 25% की छूट";

  @override
  String get pROAITools => "प्रो एआई उपकरण";

  @override
  String get aIAssistantsTemplates => "एआई सहायक और टेम्पलेट";

  @override
  String get aIImageGenerations => "एआई छवि पीढ़ी";

  @override
  String get accessAllAIModels => "सभी AI मॉडल तक पहुंचें";

  @override
  String get accessHumanLikeChat => "मानव जैसी चैट तक पहुंचें";

  @override
  String get onlyForYou => "केवल आपके लिए";

  @override
  String get thisOfferExpiresIn => "यह ऑफर समाप्त हो रहा है";

  @override
  String get just => "अभी";

  @override
  String get perFirstYear => "प्रति प्रथम वर्ष";

  @override
  String get lessThan => "(से कम";

  @override
  String get perWeek => "प्रति सप्ताह)";

  @override
  String get grabThisDeal => "इस सौदे को पकड़ो";

  @override
  String get tryTodayFor => "\$0 के लिए आज ही प्रयास करें";

  @override
  String get freeAccount => "मुफ़्त खाता";

  @override
  String get proAccount => "प्रो खाता";

  @override
  String get subscribeForJust => "बस के लिए सदस्यता लें";

  @override
  String get offForYearlyPlan => "वार्षिक योजना के लिए 15% की छूट";

  @override
  String get powerfulAIModelsGPTGemini =>
      "एक ऐप में शक्तिशाली एआई मॉडल जीपीटी, जेमिनी और क्लाउड";

  @override
  String get weekly => "साप्ताहिक";

  @override
  String get unlockAccessTo => "तक पहुंच अनलॉक करें";

  @override
  String get forUnlimitedCredits => "असीमित क्रेडिट के लिए।";

  @override
  String get redeemYourFreeTrial => "अपना निःशुल्क परीक्षण भुनाएँ";

  @override
  String dayFreeTrialWeekCancelAnytime({String? price}) {
    return "3-दिन का निःशुल्क परीक्षण, $price/सप्ताह। किसी भी समय रद्द करें";
  }

  @override
  String get tapToSignIn => "साइन इन करने के लिए टैप करें";

  @override
  String get todayCredits => "आज का श्रेय";

  @override
  String get notifications => "सूचनाएं";

  @override
  String get voice => "आवाज़";

  @override
  String get systemVoices => "सिस्टम आवाज़ें";

  @override
  String get congratulations => "बधाई हो!";

  @override
  String get youAreNowChatSYPro =>
      "अब आप चैटएसवाई प्रो सदस्य हैं और सभी प्रो सुविधाओं का आनंद लें।";

  @override
  String get doYouWantToKeepSeeing =>
      "क्या आप अनुवर्ती प्रश्न देखना जारी रखना चाहते हैं?";

  @override
  String get noHideThem => "नहीं, उन्हें छिपाओ";

  @override
  String get yesKeepThem => "हाँ, उन्हें रखो";

  @override
  String get managingFollowUpQuestions => "अनुवर्ती प्रश्नों का प्रबंधन";

  @override
  String get youCanEnableOrDisable =>
      "आप चैटसी सेटिंग में प्रश्नों को सक्षम या अक्षम कर सकते हैं।";

  @override
  String get followUpQuestions => "अनुवर्ती प्रश्न";

  @override
  String get wait => "इंतज़ार!";

  @override
  String get justOneLastThing => "बस एक आखिरी बात...";

  @override
  String get beforeWeShowYouAround =>
      "इससे पहले कि हम आपको दिखाएं, हमारे पास आपके लिए उपहार है";

  @override
  String get openGift => "खुला उपहार";

  @override
  String get noThanks => "जी नहीं, धन्यवाद!";

  @override
  String get feelThe => "लगता है";

  @override
  String get love => "प्यार!";

  @override
  String get lowestPriceOfTheYear => "साल की सबसे कम कीमत";

  @override
  String get unlimitedCredits => "असीमित क्रेडिट";

  @override
  String get proFeatures => "प्रो सुविधाएँ";

  @override
  String get closeThisBannerAndTtGone =>
      "⚠ इस बैनर को बंद करें, और यह हमेशा के लिए चला जाएगा!";

  @override
  String get weSavedTheBestForLast =>
      "हमने आखिरी के लिए सर्वश्रेष्ठ बचाकर रखा, ";

  @override
  String get offPro => "प्रो पर 35% की छूट";

  @override
  String get defaultVoice => "डिफ़ॉल्ट आवाज";

  @override
  String get yourGift => "आपका उपहार";

  @override
  String get activated => "सक्रिय";

  @override
  String get justForYou => "सिर्फ आपके लिए";

  @override
  String get here => "यहाँ एक है";

  @override
  String get save115 => "45% बचाएं";

  @override
  String get discount => "छूट";

  @override
  String get lowestPriceEver => "अब तक की सबसे कम कीमत";

  @override
  String get claimYourLimitedOffer => "अभी अपने सीमित ऑफर का दावा करें!";

  @override
  String get only => "केवल";

  @override
  String get week => "सप्ताह";

  @override
  String get enterEmail => "ईमेल दर्ज करें";

  @override
  String get enterSubject => "विषय दर्ज करें";

  @override
  String get writeHere => "यहाँ लिखें";

  @override
  String get yourCreditsRefilled => "आपके क्रेडिट फिर से भर गए";

  @override
  String get doHaveAnAccount => "कोई खाता नहीं है?";

  @override
  String get pleaseSignInToContinue => "कृपया जारी रखने के लिए साइन इन करें";

  @override
  String get enterPassword => "पास वर्ड दर्ज करें";

  @override
  String get forgotPassword => "पासवर्ड भूल गए?";

  @override
  String get signUp => "साइन अप करें";

  @override
  String get noWorriesHelpYou =>
      "कोई चिंता नहीं, हम आपका पासवर्ड रीसेट करने में आपकी सहायता करेंगे";

  @override
  String get send => "Sendभेजना";

  @override
  String get authentication => "प्रमाणीकरण";

  @override
  String get enterTheVerificationCodeSent =>
      "आपके ईमेल पर भेजा गया सत्यापन कोड दर्ज करें";

  @override
  String get verify => "सत्यापित करें";

  @override
  String get resetPassword => "पासवर्ड रीसेट";

  @override
  String get yourNewPasswordMustBe =>
      "आपका नया पासवर्ड आपके पिछले पासवर्ड से अलग होना चाहिए";

  @override
  String get enterNewPassword => "नया पासवर्ड दर्ज करें";

  @override
  String get enterConfirmNewPassword => "नए पासवर्ड की पुष्टि करें दर्ज करें";

  @override
  String get updatePassword => "पासवर्ड अपडेट करें";

  @override
  String get successful => "सफल!";

  @override
  String get yourPasswordHasBeen => "आपका पासवर्ड बदला जा चुका है";

  @override
  String get successfully => "सफलतापूर्वक";

  @override
  String get createNewAccount => "नया खाता बनाएँ";

  @override
  String get enterYourDetailsBelowTo =>
      "जारी रखने के लिए नीचे अपना विवरण दर्ज करें";

  @override
  String get enterFullName => "पूरा नाम दर्ज करें";

  @override
  String get enterConfirmPassword => "पुष्टिकरण पासवर्ड दर्ज करें";

  @override
  String get iAgreeToThe => "मैं करने के लिए सहमत हूं";

  @override
  String get alreadyHaveAnAccount => "क्या आपके पास पहले से एक खाता मौजूद है?";

  @override
  String get yourProfileHasBeenCreated => "आपकी प्रोफ़ाइल सफलतापूर्वक बन गई है";

  @override
  String get didReceiveTheCode => "कोड प्राप्त नहीं हुआ?";

  @override
  String get resend => "पुन: भेजें";

  @override
  String get fullName => "पूरा नाम";

  @override
  String get confirmPassword => "पासवर्ड की पुष्टि कीजिये";

  @override
  String get newPassword => "नया पासवर्ड";

  @override
  String get newConfirmPassword => "नया पुष्टि पासवर्ड";

  @override
  String get continueWithEmail => "ईमेल जारी रखें";

  @override
  String passwordMustBeMoreThan8Characters({String? title}) {
    if (title == null) {
      return "पासवर्ड लोअर केस, अपर केस, नंबर और एक विशेष कैरेक्टर सहित 8 अक्षरों से अधिक लंबा होना चाहिए";
    }
    return "$title पासवर्ड लोअर केस, अपर केस, नंबर और एक विशेष कैरेक्टर सहित 8 अक्षरों से अधिक लंबा होना चाहिए";
  }

  @override
  String get passwordAndConfirmPassword =>
      "पासवर्ड और कन्फ़र्म पासवर्ड मेल नहीं खाता";

  @override
  String get errorMessagePrivacyAndTerms =>
      "कृपया हमारी गोपनीयता नीति और नियम एवं शर्तों से सहमत हों";

  @override
  String get errorMessageOtp => "कृपया ओटीपी दर्ज करें";

  @override
  String get errorMessageValidOTP => "कृपया वैध ओटीपी दर्ज करें";

  @override
  String get newName => "नया";

  @override
  String get pleaseEnterNewPassword => "कृपया नया पासवर्ड दर्ज करें";

  @override
  String get pleaseEnterNewConfirmPassword =>
      "कृपया नया पुष्टिकरण पासवर्ड दर्ज करें";

  @override
  String get newPasswordAndNewConfirmPassword =>
      "नया पासवर्ड और नया कन्फर्म पासवर्ड मेल नहीं खाता";

  @override
  String get oops => "उफ़!";

  @override
  String get looksLikeYouReNotLoggedIn =>
      "ऐसा लगता है कि आप लॉग इन नहीं हैं। ऐप की सभी शानदार सुविधाओं को अनलॉक करने के लिए, कृपया साइन इन करें या एक खाता बनाएं। अतिथि मोड की अपनी सीमाएँ हैं!";

  @override
  String get unlockMoreWith => "के साथ और अधिक अनलॉक करें";

  @override
  String get yourDayFreeTrialUnlockedClaim =>
      "आपका 3 दिवसीय निःशुल्क परीक्षण अनलॉक। अभी दावा करें 🎁";

  @override
  String get claimYourFreeTrial =>
      "अपने 3-दिवसीय निःशुल्क परीक्षण का दावा करें 🎁";

  @override
  String get microphone => "माइक्रोफ़ोन";

  @override
  String get joinHappyPROUsers => "10K+ से जुड़ें खुश";

  @override
  String get users => "उपयोगकर्ताओं";

  @override
  String get offFirstYear => "प्रथम वर्ष पर 45% की छूट";

  @override
  String get rating => "4.9/5 रेटिंग";

  @override
  String get by => "द्वारा";

  @override
  String get purchaseLifetimePlanAtNoCost =>
      'आजीवन पहुंच केवल सीमित समय के लिए';

  @override
  String get apiError => "एक त्रुटि हुई है। कृपया बाद में दोबारा प्रयास करें।";

  @override
  String get apiErrorDescription =>
      "ओह! कुछ ग़लत हो गया। कृपया बाद में पुनः प्रयास करें।";

  @override
  String get connectionTimeout => "रिश्तों का समय बाहर";

  @override
  String get connectionTimeoutDesc =>
      "ओह! ऐसा लगता है कि आपका कनेक्शन समय समाप्त हो गया है। कृपया अपना इंटरनेट कनेक्शन जांचें और पुनः प्रयास करें।";

  @override
  String get sendTimeout => "रिश्तों का समय बाहर";

  @override
  String get sendTimeoutDesc =>
      "ओह! ऐसा लगता है कि आपका कनेक्शन समय समाप्त हो गया है। कृपया अपना इंटरनेट कनेक्शन जांचें और पुनः प्रयास करें।";

  @override
  String get receiveTimeout => "डेटा प्राप्ति समस्या";

  @override
  String get receiveTimeoutDesc =>
      "ओह! हमें डेटा प्राप्त करने में समस्या आ रही है। कृपया बाद में पुनः प्रयास करें।";

  @override
  String get badCertificate => "सुरक्षा प्रमाणपत्र समस्या";

  @override
  String get badCertificateDesc =>
      "हमें खेद है, सुरक्षा प्रमाणपत्र में कोई समस्या है। सहायता के लिए कृपया समर्थन से संपर्क करें।";

  @override
  String get badResponse => "अप्रत्याशित सर्वर प्रतिक्रिया";

  @override
  String get badResponseDesc =>
      "अरे नहीं! हमें सर्वर से अप्रत्याशित प्रतिक्रिया मिली है। कृपया बाद में पुनः प्रयास करें।";

  @override
  String get reqCancel => "अनुरोध रद्द किया गया";

  @override
  String get reqCancelDesc =>
      "आपका अनुरोध रद्द कर दिया गया है। कृपया पुनः प्रयास करें।";

  @override
  String get connectionError => "कनेक्शन समस्या";

  @override
  String get connectionErrorDesc =>
      "हमें सर्वर से कनेक्ट करने में समस्या आ रही है। कृपया अपना इंटरनेट कनेक्शन जांचें और पुनः प्रयास करें।";

  @override
  String get unknown => "अज्ञात त्रुटि";

  @override
  String get unknownDesc =>
      "ओह! कुछ ग़लत हो गया। कृपया बाद में पुनः प्रयास करें।";

  @override
  String get code200 => "अनुरोध सफल रहा";

  @override
  String get code201 => "एक नया संसाधन सफलतापूर्वक बनाया गया.";

  @override
  String get code202 =>
      "आवेदन को प्रसंस्करण हेतु स्वीकार कर लिया गया था, परंतु प्रसंस्करण पूरा नहीं हुआ है।";

  @override
  String get code301 =>
      "संसाधन को स्थायी रूप से नए स्थान पर स्थानांतरित कर दिया गया है।";

  @override
  String get code302 =>
      "संसाधन को अस्थायी रूप से नए स्थान पर स्थानांतरित कर दिया गया है।";

  @override
  String get code304 =>
      "पिछले अनुरोध के बाद से संसाधन को संशोधित नहीं किया गया है।";

  @override
  String get code400 => "ग़लत सिंटैक्स के कारण सर्वर अनुरोध को समझ नहीं सका.";

  @override
  String get code401 => "अनुरोध के लिए उपयोगकर्ता प्रमाणीकरण आवश्यक है।";

  @override
  String get code403 =>
      "सर्वर ने अनुरोध को समझ लिया, लेकिन उसे पूरा करने से इंकार कर दिया।";

  @override
  String get code404 => "अनुरोधित संसाधन नहीं मिल सका.";

  @override
  String get code405 =>
      "अनुरोध में निर्दिष्ट विधि अनुरोधित संसाधन के लिए अनुमत नहीं है।";

  @override
  String get code409 =>
      "संसाधन की वर्तमान स्थिति के साथ टकराव के कारण अनुरोध पूरा नहीं किया जा सका।";

  @override
  String get code500 =>
      "सर्वर को एक अप्रत्याशित स्थिति का सामना करना पड़ा जिसके कारण वह अनुरोध पूरा नहीं कर सका।";

  @override
  String get code503 => "सर्वर इस समय अनुरोध संसाधित नहीं कर सकता.";

  @override
  String get aiAssistantPrompt =>
      'उदाहरण: “आप एक लेखन सहायक हैं और आपका काम मेरे द्वारा उपलब्ध कराई गई सामग्री के आधार पर स्वचालित रूप से बेहतरीन लेख तैयार करना है।”';

  @override
  String get aiModels => 'एआई सहायक सूचना';

  @override
  String get backendPromptInputEx => 'एआई मॉडल';

  @override
  String get create => 'जीपीटी 4o';

  @override
  String get deleteAssistant => 'सबसे शक्तिशाली एआई मॉडल';

  @override
  String get deleteAssistantDesc => 'अधिक मानवीय प्रतिक्रियाएँ';

  @override
  @override
  String get moreHumanlyResponses => 'कृपया संदेश दर्ज करें';

  @override
  String get mostPowerfulAiModel => 'कृपया छवि का चयन करें';

  @override
  String get pleaseEnterPrompt => 'पुनः प्रयास करें';

  @override
  String get pleaseSelectImage => 'निष्कासन विज़ार्ड';

  @override
  String get retry => 'क्या आप वाकई इस विज़ार्ड को हटाना चाहते हैं?';
}
