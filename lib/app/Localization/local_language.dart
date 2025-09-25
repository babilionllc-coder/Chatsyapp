import 'package:flutter/material.dart';

abstract class Languages {
  static Languages? of(BuildContext context) {
    return Localizations.of<Languages>(context, Languages);
  }

  String get appName;

  String get dashboard;

  String get eliteTools;

  String get tools;

  String get uploadAndAsk;

  String get doYouLikeUsAsMuchAsW;

  String get weDetailedReview;

  String get helpAiChatSy;

  String get hiHowCanIHelpYou;

  String get suggestions;

  String get linkAndAsk;

  String get exitAlertMessage;

  String get doYouLike;

  String get searchOrAsk;

  String get searchOrWebPage;

  String get myHistory;

  String get getText;

  String get templates;

  String get newChat;

  String get startNewChat;

  String get chatHistory;

  String get chat;

  String get promptChat;

  String get deleteAll;

  String get sendAMessage;

  String get takePicture;

  String get chooseFromLibrary;

  String get uploadFile;

  String get analyzeWebsite;

  String get generateImage;

  String get scanText;

  String get deleteThisChat;

  String get deleteThisChatSub;

  String get cancel;

  String get delete;

  String get deleteAllChat;

  String get deleteAllChatSub;

  String get settings;

  String get followUs;

  String get language;

  String get rateUs;

  String get selectAIModel;

  String get darkMode;

  String get lightMode;

  String get userID;

  String get aboutUs;

  String get contactUs;

  String get privacyPolicy;

  String get legal;

  String get termsOfUse;

  String get aboutUsSub;

  String get name;

  String get url;

  String get subject;

  String get poweredBy;

  String get message;

  String get submit;

  String get errorMessageValidYourName;

  String get errorMessageEmail;

  String get errorMessageValidEmail;

  String get errorMessageSubject;

  String get errorMessagePassword;

  String get errorMessageMessage;

  String get email;

  String get letAiChtSyUnlockYourInnerGenius;

  String get bestSeller;

  String get off;

  String get byContinuingYouAccept;

  String get tosPrivacyPolicy;

  String get and;

  String get billingTeam;

  String get purchase;

  String get restore;

  String get aiChatSy;

  String get chatGPT4;

  String get joinMillionsOf;

  String get happyUsers;

  String get unlockThePotential;

  String get aICamera;

  String get technology;

  String get elevateYourExperienceWith;

  String get eliteFeatures;

  String get aiChatSyMsg;

  String get imageGeneration;

  String get effortlesslyCraftYourSearch;

  String get textToImage;

  String get photoIdentification;

  String get camera;

  String get gallery;

  String get uploadYourImage;

  String get uploadAndIdentify;

  String get weLoveToGetADetailed;

  String get askSomething;

  String get uploadAndAskSubTitle;

  String get typeYourQuestionHere;

  String get typeYourTextHere;

  String get pleaseUploadFile;

  String get pleaseUploadPDF;

  String pleaseEnterValid({String title});

  String get pleaseEnterValidQuestion;

  String get pleaseEnterImage;

  String get done;

  String get linkAndAskSubTitle;

  String get pasteYourLink;

  String get pleaseEnterValidUrl;

  String get pleaseEnterUrl;

  String get summarizeArticle;

  String get summarizeArticleMsg;

  String get summarizeWeb;

  String get summarizeWebMsg;

  String get summarizeArticleTitle;

  String get summarizeArticleWeb;

  String get summarizeIn;

  String get summarize;

  String get chatGPT;

  String get chatGPTMsg;

  String get GPT4;

  String get paLM2;

  String get aCreativeAndHelpfulCollaborator;

  String get convertTextBasedDescriptions;

  String get GPT4Msg;

  String get copy;

  String get selectText;

  String get regenerateResponse;

  String get ok;

  String get appUpdate;

  String get update;

  String get english;

  String get spanish;

  String get hindi;

  String get french;

  String get portuguese;

  String get pleaseFillThe;

  String get inTheFormForBetterResults;

  String get aiAssistants;

  String get examples;

  String get aiChatSyCanGenerateUnique;

  String get freeTrialEnabled;

  String get explore;

  String get yourListIsEmpty;

  String get seeAll;

  String get hide;

  String get download;

  String get share;

  String get chooseYourLanguage;

  String get home;

  String get assistants;

  String get fullAccessTo;

  String get pro;

  String get aICHATSYUnlimited;

  String get poweredByGPT4GeminiPaLM;

  String get premiumAiTools;

  String get fasterConversation;

  String get unlimitedChatImages;

  String get pDFURLSummary;

  String get unlimitedYearly;

  String get save80;

  String get save25;

  String get mostPopular;

  String get unlimitedMonthly;

  String get unlimitedWeekly;

  String get lifetimeAccess;

  String get limitedOffer;

  String get oneTimeBuy;

  String get anyTimeCancel;

  String get unlockLifetimeAccess;

  String get subscribe;

  String get autoRenewable;

  String get unlimitedUsage;

  String get noCommitment;

  String get cancelAnytime;

  String get imageScan;

  String get textScan;

  String get summarizePDF;

  String get textsFromImages;

  String get whatNew;

  String get news;

  String get aIModules;

  String get yourDailyFreeCredits;

  String get youHave;

  String get creditLeft;

  String get upgradeToPremium;

  String get getUnlimitedAccessToAllFeatures;

  String get unlimitedAccess;

  String get yearly;

  String get monthly;

  String get threeDaysFreeTrial;

  String get startFreeTrial;

  String get uploadAndAAsk;

  String get unlockTheFullPotentialOfAichatsy;

  String get uploadYourDocument;

  String get clickTheUploadButtonAndSelectYourFile;

  String get askQuestion;

  String get typeInYourQueryBboutTheDocument;

  String get getAnswer;

  String get receiveInstantAIGeneratedResponses;

  String get receiveInstantAIGeneratedAnswers;

  String get letsGo;

  String get visionScan;

  String get experienceThePowerOfAichatsy;

  String get transformYourVisionIntoArt;

  String get scanDocumentsImages;

  String get scanDocument;

  String get captureYourDocumentOrImage;

  String get enterYourQuestion;

  String get getInsights;

  String get transformYourIdeasIntoVisualsWithAichatsy;

  String get describeImage;

  String get enterBriefDescriptionOfTheImageYouWant;

  String get selectStyle;

  String get pickStyleOrTemplateThatSuitsYourVision;

  String get generate;

  String get clickToCreateYourImage;

  String get enterALink;

  String get enterTheURLToSummarize;

  String get pasteALink;

  String get pasteALinkEG;

  String get continues;

  String get uploadYourPDF;

  String get itMustBe10MBMax;

  String get uploadPDF;

  String get uploadImage;

  String get uploadImageToScan;

  String get oopsYouReachedYourDailyMessaging;

  String get upgradeToPRO;

  String get premium;

  String get length;

  String get auto;

  String get short;

  String get medium;

  String get long;

  String get defaults;

  String get professional;

  String get friendly;

  String get inspirational;

  String get joyful;

  String get persuasive;

  String get empathetic;

  String get surprised;

  String get optimistic;

  String get worried;

  String get curious;

  String get assertive;

  String get cooperative;

  String get romantic;

  String get passionate;

  String get critical;

  String get responseTone;

  String get save;

  String get selectImageSizeStyle;

  String get selectSize;

  String get chooseAvatar;

  String get chooseImage;

  String get pleaseEnterName;

  String get summarizeIt;

  String get rewriteIt;

  String get welcomeToAICHATSY;

  String get wereDelightedToHaveYouHere;

  String get howShouldWeCallYou;

  String get optional;

  String get enterName;

  String get theme;

  String get chatGPTIsYourAIAssistant;

  String get knowledgeBase;

  String get deliversAccurateInformativeResponses;

  String get creativity;

  String get helpsGenerateIdeasAndWriteContent;

  String get efficiency;

  String get providesQuickReliableAnswers;

  String get chatGPT4IsYourAdvancedAIAssistant;

  String get enhancedUnderstanding;

  String get deliversMoreAccurateResponses;

  String get creativeAssistance;

  String get generatesIdeasAndContentEffortlessly;

  String get realTimeUpdates;

  String get accessesLiveInfoForRealTimeResponses;

  String get paLMIsAnAILanguageModelDevelopedByGoogleAI;

  String get advancedPatternRecognition;

  String get enhancesPatternRecognitionCapabilities;

  String get contextualUnderstanding;

  String get improvesModelsComprehensionOfContext;

  String get enhancedPerformance;

  String get boostOverallModelCapabilitiesEffectively;

  String get palm;

  String get geminiIsAnInnovativeAITechnology;

  String get smoothInteractions;

  String get enablesIntuitiveUserEngagement;

  String get efficientTasks;

  String get enhancesProductivity;

  String get advancedIntegration;

  String get cuttingEdgeAIOptimization;

  String get letTry;

  String get websiteInsightsWithAIChatSY;

  String get addWebsiteURL;

  String get pasteTheWebsiteLink;

  String get summarizeAnyPDF;

  String get clickSummarize;

  String get hitTheSummarizeButtonStart;

  String get uploadAnyDocumentOrPdf;

  String get readSummary;

  String get getConciseSummaryWebpage;

  String get askAnything;

  String get askAICHATSYWhatDocument;

  String get getResponses;

  String get getQuickResponsesInSeconds;

  String get cancellationCancelAnytimeDuring;

  String get summarizeDocument;

  String get youtubeSummary;

  String get realTimeWeb;

  String get scanAnyText;

  String get uploadOrCapture;

  String get uploadAnyDocumentOrPicture;

  String get askWhatToDoWithDocument;

  String get getRespondOnScan;

  String get sendFeedback;

  String get useCamera;

  String get addWebsite;

  String get searchAndAskAboutYouTubeVideoContent;

  String get takeOrChoosePhoto;

  String get recognize;

  String get addWebsiteDesc;

  String get pasteLink;

  String get enterYoutubeLink;

  String get documentUpload;

  String get summarizeYourDocument;

  String get summarizeYourDocumentDesc;

  String get imageUpload;

  String get edit;

  String get readLoud;

  String get recentImages;

  String get clearAll;

  String get areYouSureYouWantToClearAllImage;

  String get wouldYouLikeToDeleteAll;

  String get yes;

  String get allHistory;

  String get favorites;

  String get today;

  String get yesterday;

  String get thisWeek;

  String get noDataFound;

  String get upgradeToAICHATSY;

  String get creditsLeftToday;

  String get setLanguages;

  String get search;

  String get languagesNotFound;

  String grantPermission({String title});

  String permissionFromTheAppAppSettings({String title});

  String get hiAiChatsyPoweredByChatGPT;

  String get imHereToAssistYouWithGuidance;

  String get startAskingQuestions;

  String get youAre;

  String get user;

  String get allAIModules;

  String get aIImageRecognition;

  String get freeTrial;

  String get startWithFreeTrial;

  String get pleasePurchasePlanForAccess;

  String get login;

  String get welcomeBack;

  String get continueWithApple;

  String get continueWithGoogle;

  String get docIos;

  String get docAndroid;

  String get logOut;

  String get password;

  String get createYourFreeAccount;

  String get skip;

  String get signIn;

  String get free;

  String get profile;

  String get clickToChangeAvatar;

  String get logInSuccessful;

  String get syncYourHistoryAcross;

  String get creatingCustomizedAnd;

  String get syncingYourChatHistoryFor;

  String get restoringYourPurchasesSoThat;

  String get areYouSureTo;

  String get youWillNotLooseYourDataIf;

  String get gotIt;

  String get realTimeWebSearch;

  String get upgradeTo;

  String get forFullAccess;

  String get saveTimeDoMoreAnd;

  String get bestOffer;

  String get unlimited;

  String get deleteAccount;

  String get itSpam;

  String get falseInformation;

  String get privacyConcerns;

  String get violenceThreats;

  String get other;

  String get writeYourReason;

  String get hateSpeechSymbols;

  String get bullyingOrHarassment;

  String get scamOrFraud;

  String get areYouSureYouWantTo;

  String get youWilLoseAllYourData;

  String get chooseAReason;

  String get pleaseEnterReason;

  String get report;

  String get more;

  String get no;

  String get doYouLikeTheApp;

  String get maybeLater;

  String get specialOffer;

  String get offAnnualPlan;

  String get pROAITools;

  String get aIAssistantsTemplates;

  String get aIImageGenerations;

  String get accessAllAIModels;

  String get accessHumanLikeChat;

  String get onlyForYou;

  String get thisOfferExpiresIn;

  String get just;

  String get perFirstYear;

  String get lessThan;

  String get perWeek;

  String get grabThisDeal;

  String get tryTodayFor;

  String get freeAccount;

  String get proAccount;

  String get subscribeForJust;

  String get purchaseLifetimePlanAtNoCost;

  String get offForYearlyPlan;

  String get powerfulAIModelsGPTGemini;

  String get weekly;

  String get unlockAccessTo;

  String get forUnlimitedCredits;

  String get redeemYourFreeTrial;

  String dayFreeTrialWeekCancelAnytime({String price});

  String get tapToSignIn;

  String get todayCredits;

  String get notifications;

  String get voice;

  String get systemVoices;

  String get congratulations;

  String get youAreNowChatSYPro;

  String get doYouWantToKeepSeeing;

  String get noHideThem;

  String get yesKeepThem;

  String get managingFollowUpQuestions;

  String get youCanEnableOrDisable;

  String get followUpQuestions;

  String get wait;

  String get justOneLastThing;

  String get beforeWeShowYouAround;

  String get openGift;

  String get noThanks;

  String get feelThe;

  String get love;

  String get lowestPriceOfTheYear;

  String get unlimitedCredits;

  String get proFeatures;

  String get closeThisBannerAndTtGone;

  String get weSavedTheBestForLast;

  String get offPro;

  String get defaultVoice;

  String get yourGift;

  String get activated;

  String get justForYou;

  String get here;

  String get save115;

  String get discount;

  String get lowestPriceEver;

  String get claimYourLimitedOffer;

  String get only;

  String get week;

  String get enterEmail;

  String get enterSubject;

  String get writeHere;

  String get yourCreditsRefilled;

  String get doHaveAnAccount;

  String get pleaseSignInToContinue;

  String get enterPassword;

  String get forgotPassword;

  String get signUp;

  String get noWorriesHelpYou;

  String get send;

  String get authentication;

  String get enterTheVerificationCodeSent;

  String get verify;

  String get resetPassword;

  String get yourNewPasswordMustBe;

  String get enterNewPassword;

  String get enterConfirmNewPassword;

  String get updatePassword;

  String get successful;

  String get yourPasswordHasBeen;

  String get successfully;

  String get createNewAccount;

  String get enterYourDetailsBelowTo;

  String get enterFullName;

  String get enterConfirmPassword;

  String get iAgreeToThe;

  String get alreadyHaveAnAccount;

  String get yourProfileHasBeenCreated;

  String get didReceiveTheCode;

  String get resend;

  String get fullName;

  String get confirmPassword;

  String get newPassword;

  String get newConfirmPassword;

  String get continueWithEmail;

  String passwordMustBeMoreThan8Characters({String title});

  String get passwordAndConfirmPassword;

  String get errorMessagePrivacyAndTerms;

  String get errorMessageOtp;

  String get errorMessageValidOTP;

  String get newName;

  String get pleaseEnterNewPassword;

  String get pleaseEnterNewConfirmPassword;

  String get newPasswordAndNewConfirmPassword;

  String get oops;

  String get looksLikeYouReNotLoggedIn;

  String get unlockMoreWith;

  String get yourDayFreeTrialUnlockedClaim;

  String get claimYourFreeTrial;

  String get microphone;

  String get joinHappyPROUsers;

  String get users;

  String get offFirstYear;

  String get rating;

  String get by;

  String get apiError;

  String get apiErrorDescription;

  String get connectionTimeout;

  String get connectionTimeoutDesc;

  String get sendTimeout;

  String get sendTimeoutDesc;

  String get receiveTimeout;

  String get receiveTimeoutDesc;

  String get badCertificate;

  String get badCertificateDesc;

  String get badResponse;

  String get badResponseDesc;

  String get reqCancel;

  String get reqCancelDesc;

  String get connectionError;

  String get connectionErrorDesc;

  String get unknown;

  String get unknownDesc;

  String get code200;

  String get code201;

  String get code202;

  String get code301;

  String get code302;

  String get code304;

  String get code400;

  String get code401;

  String get code403;

  String get code404;

  String get code405;

  String get code409;

  String get code500;

  String get code503;

  String get backendPromptInputEx;

  String get aiAssistantPrompt;

  String get aiModels;

  String get mostPowerfulAiModel;

  String get moreHumanlyResponses;

  String get create;

  String get pleaseEnterPrompt;

  String get pleaseSelectImage;

  String get retry;

  String get deleteAssistant;

  String get deleteAssistantDesc;

  String deepseek = 'Deepseek';

  String deepseekIsAnInnovativeAITechnology =
      'Deepseek is an innovative AI technology known for enabling seamless interactions and enhancing task efficiency with advanced capabilities.';

  String GPT4o = "GPT 4o";

  String gemini = 'Gemini';
}
