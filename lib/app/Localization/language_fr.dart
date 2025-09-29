import 'dart:io';

import '../helper/constants.dart';
import 'local_language.dart';

class LanguageFr extends Languages {
  @override
  String get appName => Constants.appName;

  @override
  String get dashboard => "Tableau de bord";

  @override
  String get eliteTools => "Outils d'élite";

  @override
  String get tools => "Outils";

  @override
  String get legal => "Légal";

  @override
  String get uploadAndAsk => "Téléverser & Demander";

  @override
  String get doYouLikeUsAsMuchAsW =>
      "Nous appréciez-vous autant que nous vous apprécions?";

  @override
  String get weDetailedReview =>
      (Platform.isAndroid)
          ? "Répandre l'amour! Nous serions reconnaissants si vous pouviez laisser un avis détaillé sur le Google Play Store. Vos commentaires comptent pour nous! ❤️"
          : "Répandre l'amour! Nous serions reconnaissants si vous pouviez laisser un avis détaillé sur l’App Store. Vos commentaires comptent pour nous! ❤️";

  @override
  String get helpAiChatSy => "Aidez ${Constants.appName}";

  @override
  String get chooseImage => "Choisissez l'image";

  @override
  String get scanDocumentsImages => "Numériser des documents ou des images";

  @override
  String get transformYourVisionIntoArt => "Transformez votre vision en art";

  @override
  String get hiHowCanIHelpYou => "Bonjour! Comment puis-je vous aider?";

  @override
  String get suggestions => "Suggestions";

  @override
  String get linkAndAsk => "Lien & Demander";

  @override
  String get exitAlertMessage =>
      "Appuyez une nouvelle fois sur le bouton retour pour \nquitter l'application";

  @override
  String get doYouLike =>
      "Nous appréciez-vous autant que nous vous apprécions?";

  @override
  String get searchOrAsk =>
      "Cherchez ou demandez quoi que ce soit dans un document";

  @override
  String get searchOrWebPage =>
      "Cherchez ou demandez quoi que ce soit sur une page web";

  @override
  String get myHistory => "Mon Historique";

  @override
  String get getText => "Obtenir le texte";

  @override
  String get templates => "Modèles";

  @override
  String get newChat => "Nouveau Chat";

  @override
  String get startNewChat => "Commencer un nouveau chat";

  @override
  String get chatHistory => "Historique du chat";

  @override
  String get chat => "CHAT";

  @override
  String get promptChat => "CHAT SUR INVITATION";

  @override
  String get deleteAll => "Tout supprimer";

  @override
  String get sendAMessage => "Envoyer un message";

  @override
  String get takePicture => "Prendre une photo";

  @override
  String get chooseFromLibrary => "Choisir depuis la bibliothèque";

  @override
  String get uploadFile => "Téléverser un fichier";

  @override
  String get analyzeWebsite => "Analyser le site web";

  @override
  String get generateImage => "Générer une image";

  @override
  String get scanText => "Scanner le texte";

  @override
  String get viewTemplates => "Voir les modèles";

  @override
  String get deleteThisChat => "Supprimer ce Chat?";

  @override
  String get deleteThisChatSub =>
      "Êtes-vous sûr de vouloir supprimer\ncette conversation ?";

  @override
  String get cancel => "Annuler";

  @override
  String get delete => "supprimer";

  @override
  String get deleteAllChat => "Supprimer tout l'historique des conversations ?";

  @override
  String get deleteAllChatSub =>
      "Êtes-vous sûr de vouloir supprimer\ntoute votre historique de conversation ?";

  @override
  String get settings => "Paramètres";

  @override
  String get followUs => "Suivez-nous";

  @override
  String get language => "Langue";

  @override
  String get rateUs => "Notez-nous";

  @override
  String get selectAIModel => "Sélectionnez le modèle d'IA";

  @override
  String get darkMode => "Mode Sombre";

  @override
  String get lightMode => "Mode lumière";

  @override
  String get userID => "Identifiant d'utilisateur";

  @override
  String get aboutUs => "À propos de nous";

  @override
  String get contactUs => "Contactez-nous";

  @override
  String get privacyPolicy => "Politique de confidentialité";

  @override
  String get termsOfUse => "Conditions d'utilisation";

  @override
  String get aboutUsSub =>
      "${Constants.appName} est un assistant de chatbot d'IA alimenté par la technologie ChatGPT-4 qui vous aidera à résoudre n'importe quelle tâche et répondre à toutes les questions. En écrivant des prompts pour ce dont vous avez besoin, vous pouvez demander n'importe quoi et obtenir une réponse pour toute question ou solution pour tout problème / tâche!\n\nNotre assistant chatbot AI conçu pour répondre à tous vos besoins - Toutes les fonctionnalités d'IA dans une seule application!Modules \n\nAI disponibles:\n - ChatGPT\n - GPT-4\n - PaLM 2\n\n \nVous pouvez facilement vérifier l'historique de votre chat & prompt, et localiser l'application pour la langue préférée (English, Spanish, Hindi, French, Portuguese).\n\nNotre application combine le meilleur de l'intelligence artificielle chatbot brillance et des fonctionnalités d'assistant virtuel, alimenté par la technologie avancée Chat GPT-4.\n\nPrincipales caractéristiques :\n- Rédacteur d'essai\n- Générateur de photos et de reconnaissance\n- Text-to-Audio\n- Éditeur d'e-mail \n- Téléchargement de texte \n- Vérification grammaticale\n- Traduction\n- Résumé des articles et des sites Web\n- Vérificateur du plagiat\n- Génération de mots de passe\n- Résummé de la réunion \n- Outil de paraphrasage\n- Generateur de plaisanterie\n- Problème de résolution\n- Interaction vocale / Commande \n- Analyse du site Web \n- Analyse des fichiers\n- Interprète de rêve\n- Analyses des concurrents\n- Contenu social\n- Ressources de codage \n- et bien d'autres!\n\nNous sommes déterminés à innover en permanence, en explorant toujours de nouvelles façons d'améliorer votre interaction avec la technologie.\n\nVotre expérience est au cœur de notre processus de développement. Nous écoutons vos commentaires et adaptons nos services à votre vie.\n\nEnjoy les avantages que notre AI Chatbot Assistant offre - ${Constants.appName} est là pour vous 24/7! N'hésitez pas à nous contacter pour tout via mail@aichatsy.com.";

  @override
  String get name => "Nom";

  @override
  String get url => "Veuillez entrer l'URL";

  @override
  String get subject => "Sujet";

  @override
  String get poweredBy => "Propulsé par";

  @override
  String get message => "Message";

  @override
  String get submit => "SOUMETTRE";

  @override
  String get errorMessageValidYourName => "Veuillez entrer votre nom";

  @override
  String get errorMessageEmail => "Veuillez entrer votre email";

  @override
  String get errorMessageValidEmail => "Veuillez entrer un email valide";

  @override
  String get errorMessageSubject => "Veuillez entrer le sujet";

  @override
  String get errorMessageMessage => "Veuillez entrer le message";

  @override
  String get email => "Email";

  @override
  String get letAiChtSyUnlockYourInnerGenius =>
      "Laissez ${Constants.appName} libérer votre génie intérieur !";

  @override
  String get bestSeller => "Meilleure vente";

  @override
  String get off => "55% de réduction";

  @override
  String get byContinuingYouAccept => "En continuant, vous acceptez ";

  @override
  String get tosPrivacyPolicy =>
      "Conditions générales, Politique de confidentialité";

  @override
  String get and => "et ";

  @override
  String get billingTeam => "Équipe de facturation";

  @override
  String get purchase => "Acheter";

  @override
  String get restore => "Restaurer";

  @override
  String get aiChatSy => Constants.appName;

  @override
  String get chatGPT4 => "ChatGPT & GPT-4";

  @override
  String get joinMillionsOf => "Rejoignez des millions de ";

  @override
  String get happyUsers => "utilisateurs heureux ";

  @override
  String get unlockThePotential =>
      "Débloquez le potentiel des technologies avancées ";

  @override
  String get aICamera => "de l'IA Caméra  ";

  @override
  String get technology => "Technologie";

  @override
  String get elevateYourExperienceWith => "Améliorez votre expérience avec ";

  @override
  String get eliteFeatures => " des fonctionnalités d'élite. ";

  @override
  String get aiChatSyMsg =>
      "Tapez ci-dessous pour obtenir des réponses\nPosez n'importe quelle question ouverte";

  @override
  String get imageGeneration => "Génération d'images";

  @override
  String get effortlesslyCraftYourSearch =>
      "Formulez facilement votre recherche avec notre outil pratique";

  @override
  String get textToImage => "Texte en image";

  @override
  String get photoIdentification => "Identification de photo";

  @override
  String get camera => "Caméra";

  @override
  String get gallery => "Galerie";

  @override
  String get uploadYourImage => "Téléchargez votre image";

  @override
  String get uploadAndIdentify => "Téléchargez et identifiez";

  @override
  String get weLoveToGetADetailed =>
      "Nous aimerions beaucoup recevoir un avis détaillé de votre part sur l'App Store, expliquant au monde entier pourquoi vous aimez ${Constants.appName} !";

  @override
  String get askSomething => "Posez une question";

  @override
  String get uploadAndAskSubTitle =>
      "Vous pouvez poser des questions ou rechercher n'importe quoi dans un document. Pour la summarization, veuillez utiliser la section de résumé sur la page d'accueil.\n\nVeuillez vous assurer que le fichier est au format .pdf, .docx ou .txt";

  @override
  String get typeYourQuestionHere => "Tapez votre question ici";

  @override
  String get typeYourTextHere => "Tapez votre texte ici";

  @override
  String get pleaseUploadFile =>
      "Le fichier n'est pas pris en charge. Veuillez insérer uniquement des fichiers .pdf, .docx ou .txt";

  @override
  String pleaseEnterValid({String? title}) {
    return "Veuillez entrer valide  $title";
  }

  @override
  String get pleaseEnterValidQuestion => "Veuillez entrer une question valide";

  @override
  String get pleaseEnterImage => "Veuillez saisir l'image";

  @override
  String get done => "Terminé";

  @override
  String get linkAndAskSubTitle =>
      "Vous pouvez poser des questions ou rechercher n'importe quoi sur une page web. Pour la summarization, veuillez utiliser la section de résumé sur la page d'accueil.";

  @override
  String get pasteYourLink => "Collez votre lien";

  @override
  String get pleaseEnterValidUrl => "Veuillez entrer un lien URL valide";

  @override
  String get pleaseEnterUrl => "Veuillez entrer le lien URL";

  @override
  String get summarizeArticle => "Résumer l'article";

  @override
  String get summarizeArticleMsg => "Obtenez un résumé détaillé de l'article";

  @override
  String get summarizeWeb => "Résumer le Website";

  @override
  String get summarizeWebMsg => "Obtenez un résumé détaillé de la page web";

  @override
  String get summarizeArticleTitle =>
      "Vous pouvez ajouter votre document et ${Constants.appName} pour le résumer.\n\nVeuillez vous assurer que le fichier est au format .pdf, .docx ou .txt";

  @override
  String get summarizeArticleWeb =>
      "Vous pouvez ajouter votre document et ${Constants.appName} pour le résumer.";

  @override
  String get summarizeIn => "Résumer en";

  @override
  String get summarize => "Résumer";

  @override
  String get chatGPT => "ChatGPT";

  @override
  String get chatGPTMsg => "Modèle de chatbot par défaut fourni\npar OpenAI";

  @override
  String get GPT4 => "GPT-4";

  @override
  String get paLM2 => "PaLM 2";

  @override
  String get aCreativeAndHelpfulCollaborator =>
      "Un collaborateur créatif et utile,\ndéveloppé par Google AI";

  @override
  String get convertTextBasedDescriptions =>
      "Convertissez les descriptions textuelles en données visuelles";

  @override
  String get GPT4Msg =>
      "Un système plus avancé, produisant\ndes réponses plus sûres et plus utiles";

  @override
  String get copy => "Copier";

  @override
  String get selectText => "Sélectionner le texte";

  @override
  String get regenerateResponse => "Régénérer la réponse";

  @override
  String get ok => "Ok";

  @override
  String get appUpdate => "Mise à jour de l'application requise !";

  @override
  String get update => "Mettre à jour";

  @override
  String get english => "Anglais";

  @override
  String get spanish => "Espagnol";

  @override
  String get hindi => "Hindi";

  @override
  String get french => "Français";

  @override
  String get portuguese => "Portugais";

  @override
  String get pleaseFillThe => "Veuillez remplir le";

  @override
  String get inTheFormForBetterResults =>
      "Veuillez remplir le formulaire pour de meilleurs résultats";

  @override
  String get aiAssistants => "Assistants IA";

  @override
  String get examples => "Exemples";

  @override
  String get aiChatSyCanGenerateUnique =>
      "visuels basés sur votre description. Pour créer une image, vous pouvez envoyer un message pour la décrire ou utiliser une invite pré-faite!";

  @override
  String get freeTrialEnabled => "Essai gratuit activé";

  @override
  String get explore => "Explorer";

  @override
  String get yourListIsEmpty => "Votre liste est vide";

  @override
  String get seeAll => "Voir tout";

  @override
  String get hide => "Cacher";

  @override
  String get download => "Télécharger";

  @override
  String get share => "Partager";

  @override
  String get chooseYourLanguage => "Choisissez votre langue";

  @override
  String get assistants => "Assistants";

  @override
  String get home => "Maison";

  @override
  String get pro => " PRO ";

  @override
  String get fullAccessTo => "Accès complet à";

  @override
  String get aICHATSYUnlimited => "${Constants.appName} Illimité";

  @override
  String get poweredByGPT4GeminiPaLM => "Propulsé par GPT 4o, Gemini";

  @override
  String get premiumAiTools => "Outils d'IA haut de gamme";

  @override
  String get fasterConversation => "Conversation plus rapide";

  @override
  String get unlimitedChatImages => "Chat et images illimités";

  @override
  String get pDFURLSummary => "Résumé PDF et URL";

  @override
  String get unlimitedYearly => "Illimité Annuel";

  @override
  String get save80 => "Économisez 80%";

  @override
  String get save25 => "Économisez 25%";

  @override
  String get mostPopular => "Le plus populaire";

  @override
  String get lowestPrice => "Prix le plus bas";

  @override
  String get unlimitedMonthly => "Mensuel illimité";

  @override
  String get unlimitedWeekly => "Illimité Hebdomadaire";

  @override
  String get lifetimeAccess => "Accès à vie";

  @override
  String get limitedOffer => "OFFRE LIMITÉE";

  @override
  String get oneTimeBuy => "ACHAT UNIQUE";

  @override
  String get unlockLifetimeAccess => "Débloquez l'accès à vie";

  @override
  String get subscribe => "S'abonner";

  @override
  String get autoRenewable => "Auto-renouvelable";

  @override
  String get unlimitedUsage => "Utilisation illimitée";

  @override
  String get noCommitment => "Aucun engagement";

  @override
  String get cancelAnytime => "Annuler à tout moment";

  @override
  String get whatNew => "Quoi de neuf?";

  @override
  String get news => "Nouveau";

  @override
  String get imageScan => "Numérisation d'images";

  @override
  String get textScan => "Numérisation de texte";

  @override
  String get summarizePDF => "Résumer le PDF";

  @override
  String get textsFromImages => "Textes à partir d'images";

  @override
  @override
  @override
  String get aIModules => "Modules IA";

  @override
  String get yourDailyFreeCredits => "Vos crédits gratuits quotidiens";

  @override
  String get youHave => "Tu as";

  @override
  String get creditLeft => "Crédit restant";

  @override
  String get upgradeToPremium => "Passer à la version premium";

  @override
  String get getUnlimitedAccessToAllFeatures =>
      "Obtenez un accès illimité à toutes les fonctionnalités";

  @override
  String get unlimitedAccess => "Accès illimité";

  @override
  String get yearly => "Annuel";

  @override
  String get monthly => "Mensuel";

  @override
  String get threeDaysFreeTrial => "Essai gratuit de 3 jours";

  @override
  String get startFreeTrial => "Commencer l'essai gratuit";

  @override
  String get uploadAndAAsk => "Télécharger et demander";

  @override
  String get unlockTheFullPotentialOfAichatsy =>
      "Libérez tout le potentiel de l'IA d'${Constants.appName} en utilisant la fonctionnalité Télécharger et demander. Téléchargez facilement n'importe quel document et obtenez des réponses rapides et précises.";

  @override
  String get uploadYourDocument => "Téléchargez votre document";

  @override
  String get clickTheUploadButtonAndSelectYourFile =>
      "Cliquez sur le bouton de téléchargement et sélectionnez votre fichier.";

  @override
  String get askQuestion => "Poser une question";

  @override
  String get typeInYourQueryBboutTheDocument =>
      "Tapez votre requête sur le document.";

  @override
  String get getAnswer => "Obtenir une réponse";

  @override
  String get receiveInstantAIGeneratedResponses =>
      "Recevez des réponses instantanées générées par l’IA.";

  @override
  String get letsGo => "Allons-y";

  @override
  String get visionScan => "Numérisation visuelle";

  @override
  String get experienceThePowerOfAichatsy =>
      "Découvrez la puissance de la fonction Vision Scan d'${Constants.appName}. Numérisez facilement des documents ou des images et obtenez instantanément des informations générées par l'IA.";

  @override
  String get scanDocument => "Numériser un document";

  @override
  String get captureYourDocumentOrImage =>
      "Capturez votre document ou votre image.";

  @override
  String get enterYourQuestion => "Entrez votre question.";

  @override
  String get getInsights => "Obtenez des informations";

  @override
  String get transformYourIdeasIntoVisualsWithAichatsy =>
      "Transformez vos idées en visuels avec la fonctionnalité de génération d'images d'${Constants.appName}. Parfait pour créer des images personnalisées sans effort.";

  @override
  String get describeImage => "Décrire l'image";

  @override
  String get enterBriefDescriptionOfTheImageYouWant =>
      "Entrez une brève description de l'image souhaitée.";

  @override
  String get selectStyle => "Sélectionnez le style";

  @override
  String get pickStyleOrTemplateThatSuitsYourVision =>
      "Choisissez le style ou le modèle qui correspond à votre vision.";

  @override
  String get generate => "Générer";

  @override
  String get clickToCreateYourImage => "Cliquez pour créer votre image.";

  @override
  String get receiveInstantAIGeneratedAnswers =>
      "Recevez des réponses instantanées générées par l’IA.";

  @override
  String get enterALink => "Entrez un lien";

  @override
  String get enterTheURLToSummarize =>
      "Saisissez l'URL pour résumer, réécrire, traduire ou analyser son contenu.";

  @override
  String get pasteALink => "Coller un lien";

  @override
  String get pasteALinkEG => "Collez un lien (e:g www.aichatsy.com)";

  @override
  String get continues => "Continuer";

  @override
  String get uploadYourPDF => "Téléchargez votre PDF";

  @override
  String get itMustBe10MBMax => "Sa taille doit être de 10,0 Mo maximum.";

  @override
  String get uploadPDF => "Télécharger le PDF";

  @override
  String get uploadImage => "Télécharger une image";

  @override
  String get uploadImageToScan => "Télécharger l'image à numériser";

  @override
  String get oopsYouReachedYourDailyMessaging =>
      "Oups, vous avez atteint votre limite quotidienne de messages! Vous pouvez envoyer 4 messages par jour avec le forfait gratuit. Mettez à niveau pour débloquer des messages illimités.";

  @override
  String get upgradeToPRO => "Passer à";

  @override
  String get premium => "Prime";

  @override
  String get length => "Longueur";

  @override
  String get auto => "Auto";

  @override
  String get short => "Court";

  @override
  String get medium => "Moyen";

  @override
  String get long => "Long";

  @override
  String get defaults => "🤖 Par défaut";

  @override
  String get professional => "🧐 Professionnel";

  @override
  String get friendly => "😃 Amicalement";

  @override
  String get inspirational => "😇 Inspirant";

  @override
  String get joyful => "😂 Joyeux";

  @override
  String get persuasive => "😉 Persuasif";

  @override
  String get empathetic => "️️🙂 Empathique";

  @override
  String get surprised => "😯 Surpris";

  @override
  String get optimistic => "😋 Optimiste";

  @override
  String get worried => "😟 Inquiet";

  @override
  String get curious => "😏 Curieux";

  @override
  String get assertive => "😎 Assertif";

  @override
  String get cooperative => "😌 Coopérative";

  @override
  String get romantic => "🥰 Romantique";

  @override
  String get passionate => "😍 Passionné";

  @override
  String get critical => "🤬 Critique";

  @override
  String get responseTone => "Tonalité de réponse";

  @override
  String get save => "Sauvegarder";

  @override
  String get selectImageSizeStyle =>
      "Sélectionnez la taille et le style de l'image";

  @override
  String get selectSize => "Sélectionnez la taille";

  @override
  String get pleaseUploadPDF =>
      "Le fichier n'est pas pris en charge. veuillez insérer uniquement des fichiers .pdf";

  @override
  String get chooseAvatar => "Choisissez Avatar";

  @override
  String get pleaseEnterName => "Veuillez entrer le nom";

  @override
  String get anyTimeCancel => "Annuler à tout moment";

  @override
  String get summarizeIt => "Résumez-le";

  @override
  String get rewriteIt => "Réécrivez-le";

  @override
  String get welcomeToAICHATSY => "Bienvenue chez ${Constants.appName}";

  @override
  String get wereDelightedToHaveYouHere =>
      "Nous sommes ravis de vous accueillir ici.";

  @override
  String get howShouldWeCallYou => "Comment devrions-nous vous appeler ?";

  @override
  String get optional => "Facultatif";

  @override
  String get enterName => "Entrez le nom";

  @override
  String get theme => "Thème";

  @override
  String get chatGPTIsYourAIAssistant =>
      "ChatGPT est votre assistant IA pour des réponses rapides et une aide créative, offrant des réponses personnalisées pour améliorer votre expérienc.";

  @override
  String get knowledgeBase => "Base de connaissances:";

  @override
  String get deliversAccurateInformativeResponses =>
      "Fournit des réponses précises et informative.";

  @override
  String get creativity => "La créativit:";

  @override
  String get helpsGenerateIdeasAndWriteContent =>
      "Aide à générer des idées et à rédiger du conten.";

  @override
  String get efficiency => "Efficacit:";

  @override
  String get providesQuickReliableAnswers =>
      "Fournit des réponses rapides et fiable.";

  @override
  String get chatGPT4IsYourAdvancedAIAssistant =>
      "ChatGPT-4 est votre assistant IA avancé, conçu pour fournir des réponses précises, vous aider dans les tâches créatives et offrir une assistance personnalisée.";

  @override
  String get enhancedUnderstanding => "Compréhension améliorée :";

  @override
  String get deliversMoreAccurateResponses =>
      "Fournit des réponses plus précises.";

  @override
  String get creativeAssistance => "Aide à la création :";

  @override
  String get generatesIdeasAndContentEffortlessly =>
      "Génère des idées et du contenu sans effort.";

  @override
  String get realTimeUpdates => "Mises à jour en temps réel :";

  @override
  String get accessesLiveInfoForRealTimeResponses =>
      "Accède aux informations en direct pour des réponses en temps réel.";

  @override
  String get paLMIsAnAILanguageModelDevelopedByGoogleAI =>
      "PaLM est un modèle de langage d'IA développé par GOOGLE AI, connu pour ses capacités avancées de traitement et de génération du langage naturel.";

  @override
  String get advancedPatternRecognition =>
      "Reconnaissance avancée des formes :";

  @override
  String get enhancesPatternRecognitionCapabilities =>
      "Améliore les capacités de reconnaissance de formes.";

  @override
  String get contextualUnderstanding => "Compréhension contextuelle :";

  @override
  String get improvesModelsComprehensionOfContext =>
      "Améliore la compréhension du contexte par les modèles.";

  @override
  String get enhancedPerformance => "Performance améliorée:";

  @override
  String get boostOverallModelCapabilitiesEffectively =>
      "Augmente efficacement les capacités globales du modèle.";

  @override
  String get palm => "Palmier";

  @override
  String get geminiIsAnInnovativeAITechnology =>
      "Gemini est une technologie d'IA innovante connue pour permettre des interactions transparentes et améliorer l'efficacité des tâches grâce à des capacités avancées.";

  @override
  String get smoothInteractions => "Interactions fluides :";

  @override
  String get enablesIntuitiveUserEngagement =>
      "Permet un engagement intuitif des utilisateurs.";

  @override
  String get efficientTasks => "Tâches efficaces :";

  @override
  String get enhancesProductivity => "Améliore la productivité.";

  @override
  String get advancedIntegration => "Intégration avancée :";

  @override
  String get cuttingEdgeAIOptimization => "Optimisation de l’IA de pointe.";

  @override
  String get letTry => "Essayons";

  @override
  String get websiteInsightsWithAIChatSY =>
      "Aperçus du site Web avec ${Constants.appName}";

  @override
  String get addWebsiteURL => "Ajouter l'URL du site Web";

  @override
  String get pasteTheWebsiteLink => "Collez le lien du site Web";

  @override
  String get summarizeAnyPDF => "Résumez n’importe quel PDF";

  @override
  String get clickSummarize => "Cliquez sur Résumer";

  @override
  String get hitTheSummarizeButtonStart =>
      "Appuyez sur le bouton Résumer pour commencer";

  @override
  String get uploadAnyDocumentOrPdf =>
      "Téléchargez n’importe quel document ou pdf";

  @override
  String get readSummary => "Lire le résumé";

  @override
  String get getConciseSummaryWebpage =>
      "Obtenez un résumé concis de la page Web";

  @override
  String get askAnything => "Demandez n'importe quoi";

  @override
  String get askAICHATSYWhatDocument =>
      "Demandez à ${Constants.appName} quoi faire avec le document";

  @override
  String get getResponses => "Obtenir des réponses";

  @override
  String get getQuickResponsesInSeconds =>
      "Obtenez des réponses rapides en quelques secondes";

  @override
  String get cancellationCancelAnytimeDuring =>
      "Annulation : Annulez à tout moment pendant les 3 premiers jours";

  @override
  String get summarizeDocument => "Résumer Document";

  @override
  String get youtubeSummary => "Youtube Résumé";

  @override
  String get realTimeWeb => "Temps réel Web";

  @override
  String get scanAnyText => "Numérisez n'importe quel texte";

  @override
  String get uploadOrCapture => "Télécharger ou capturer";

  @override
  String get uploadAnyDocumentOrPicture =>
      "Téléchargez n'importe quel document ou image";

  @override
  String get askWhatToDoWithDocument =>
      "Demandez à ${Constants.appName} quoi faire avec le document";

  @override
  String get getRespondOnScan => "Obtenez une réponse lors de l'analyse";

  @override
  String get sendFeedback => "Envoyer des commentaires";

  @override
  String get useCamera => "Utiliser l'appareil photo";

  @override
  String get addWebsite => "Ajouter un site Web";

  @override
  String get searchAndAskAboutYouTubeVideoContent =>
      "Rechercher et poser des questions sur le contenu vidéo YouTube";

  @override
  String get takeOrChoosePhoto => "Prendre ou choisir une photo";

  @override
  String get recognize => "Reconnaître";

  @override
  String get addWebsiteDesc =>
      "Saisissez l'URL pour résumer, réécrire, traduire ou analyser son contenu.";

  @override
  String get pasteLink => "Collez un lien (e:g www.aichatsy.com)";

  @override
  String get enterYoutubeLink => "Entrez le lien YouTube";

  @override
  String get documentUpload => "Téléchargement de documents";

  @override
  String get summarizeYourDocument => "Résumez votre document";

  @override
  String get summarizeYourDocumentDesc =>
      "Veuillez vous assurer que le fichier est soit un fichier .pdf, soit un fichier .docx ou .txt.";

  @override
  String get imageUpload => "Téléchargement d'images";

  @override
  String get edit => "Modifier";

  @override
  String get readLoud => "Lire à haute voix";

  @override
  String get recentImages => "Images récentes";

  @override
  String get clearAll => "Tout effacer";

  @override
  String get areYouSureYouWantToClearAllImage =>
      "Etes-vous sûr de vouloir effacer \ntoutes les images ?";

  @override
  String get yes => "Oui";

  @override
  String get allHistory => "Toute l'histoire";

  @override
  String get favorites => "Favoris";

  @override
  String get today => "Aujourd'hui";

  @override
  String get yesterday => "Hier";

  @override
  String get thisWeek => "Cette semaine";

  @override
  String get noDataFound => "Aucune donnée trouvée";

  @override
  String get upgradeToAICHATSY => "Mise à niveau vers ${Constants.appName}";

  @override
  String get wouldYouLikeToDeleteAll =>
      "Souhaitez-vous supprimer toutes les discussions?";

  @override
  String get creditsLeftToday => "Crédits restants aujourd'hui";

  @override
  String get languagesNotFound => "Langues introuvables";

  @override
  String get setLanguages => "Définir les langues";

  @override
  String get search => "Recherche";

  @override
  String grantPermission({String? title}) {
    return "accorder l'autorisation du $title";
  }

  @override
  String permissionFromTheAppAppSettings({String? title}) {
    return "Veuillez accorder l'autorisation au $title à partir des paramètres de l'application";
  }

  @override
  String get hiAiChatsyPoweredByChatGPT =>
      "Salut, je m'appelle ${Constants.appName}! Propulsé par ChatGPT.";

  @override
  String get imHereToAssistYouWithGuidance =>
      "Je suis là pour vous aider à rédiger un CV impressionnant, à rédiger des e-mails efficaces, à augmenter votre productivité, à obtenir des suggestions de cadeaux réfléchies ou à découvrir des lieux uniques pour un premier rendez-vous.";

  @override
  String get startAskingQuestions => "Commencez à poser des questions!";

  @override
  String get youAre => "Tu es";

  @override
  String get user => "utilisateur";

  @override
  String get allAIModules => "Tous les modules IA";

  @override
  String get aIImageRecognition => "Reconnaissance d'images IA";

  @override
  String get freeTrial => "Essai gratuit";

  @override
  String get startWithFreeTrial => "Commencez par un essai gratuit";

  @override
  String get pleasePurchasePlanForAccess =>
      "Veuillez acheter un plan pour accéder à ce modèle";

  @override
  String get login => "se connecter";

  @override
  String get welcomeBack => "Content de te revoir!";

  @override
  String get continueWithApple => "Continuer avec Apple";

  @override
  String get continueWithGoogle => "Continuer avec Google";

  @override
  String get docIos =>
      "En cliquant sur Connectez-vous avec Apple ou Connectez-vous avec Google, vous acceptez nos";

  @override
  String get docAndroid =>
      "En cliquant sur Connectez-vous avec Google, vous acceptez nos";

  @override
  String get logOut => "Déconnexion";

  @override
  String get password => "Mot de passe";

  @override
  String get errorMessagePassword => "Veuillez entrer le mot de passe";

  @override
  String get createYourFreeAccount => "Créez votre compte gratuit";

  @override
  String get skip => "Sauter";

  @override
  String get signIn => "Se connecter";

  @override
  String get free => "Gratuit";

  @override
  String get profile => "Profil";

  @override
  String get clickToChangeAvatar => "Cliquez pour changer d'avatar";

  @override
  String get logInSuccessful => "Connexion réussie";

  @override
  String get syncYourHistoryAcross =>
      "Synchronisez votre historique sur vos appareils.";

  @override
  String get creatingCustomizedAnd =>
      "Créer une expérience personnalisée et améliorée.";

  @override
  String get syncingYourChatHistoryFor =>
      "Synchroniser votre historique de discussion pour une meilleure expérience";

  @override
  String get restoringYourPurchasesSoThat =>
      "Restaurer vos achats pour ne rien manquer";

  @override
  String get areYouSureTo => "Êtes-vous sûr de vous déconnecter ?";

  @override
  String get youWillNotLooseYourDataIf =>
      "Vous ne perdrez pas vos données si vous vous déconnectez. Vous pouvez toujours vous connecter à ce compte.";

  @override
  String get gotIt => "J'ai compris";

  @override
  String get realTimeWebSearch => "Recherche Web en temps réel";

  @override
  String get upgradeTo => "Mettre à niveau vers";

  @override
  String get forFullAccess => "pour un accès complet!";

  @override
  String get saveTimeDoMoreAnd =>
      "Gagnez du temps, faites plus et réalisez plus rapidement";

  @override
  String get bestOffer => "Meilleure offre";

  @override
  String get unlimited => "Illimité";

  @override
  String get deleteAccount => "Supprimer le compte";

  @override
  String get itSpam => "C'est un spam";

  @override
  String get falseInformation => "Fausses informations";

  @override
  String get privacyConcerns => "Problèmes de confidentialité";

  @override
  String get violenceThreats => "Menaces de violence";

  @override
  String get other => "Autre";

  @override
  String get writeYourReason => "Écrivez votre raison";

  @override
  String get hateSpeechSymbols => "Discours ou symboles de haine";

  @override
  String get bullyingOrHarassment => "Intimidation ou harcèlement";

  @override
  String get scamOrFraud => "Arnaque ou fraude";

  @override
  String get areYouSureYouWantTo =>
      "Êtes-vous sûr de vouloir supprimer votre compte?";

  @override
  String get youWilLoseAllYourData =>
      "Vous perdrez toutes vos données et votre compte ne sera pas récupéré.";

  @override
  String get chooseAReason => "Choisissez une raison";

  @override
  String get pleaseEnterReason => "Veuillez entrer la raison";

  @override
  String get report => "Rapport";

  @override
  String get more => "Plus";

  @override
  String get no => "Non";

  @override
  String get doYouLikeTheApp => "Aimez-vous l'application?";

  @override
  String get maybeLater => "Peut-être plus tard";

  @override
  String get specialOffer => "Offre spéciale";

  @override
  String get offAnnualPlan => "25% de réduction sur le forfait annuel";

  @override
  String get pROAITools => "Outils PRO IA";

  @override
  String get aIAssistantsTemplates => "Assistants et modèles d'IA";

  @override
  String get aIImageGenerations => "Générations d'images IA";

  @override
  String get accessAllAIModels => "Accédez à tous les modèles d'IA";

  @override
  String get accessHumanLikeChat => "Accédez à un chat de type humain";

  @override
  String get onlyForYou => "UNIQUEMENT POUR VOUS";

  @override
  String get thisOfferExpiresIn => "Cette offre expire dans";

  @override
  String get just => "Juste";

  @override
  String get perFirstYear => "par première année";

  @override
  String get lessThan => "(moins que";

  @override
  String get perWeek => "par semaine)";

  @override
  String get grabThisDeal => "Saisissez cette offre";

  @override
  String get tryTodayFor => "Essayez aujourd'hui pour 0 \$";

  @override
  String get freeAccount => "Compte gratuit";

  @override
  String get proAccount => "Compte Pro";

  @override
  String get subscribeForJust => "Abonnez-vous pour seulement";

  @override
  String get offForYearlyPlan => "15 % de réduction pour le forfait annuel";

  @override
  String get powerfulAIModelsGPTGemini =>
      "De puissants modèles d'IA GPT, Gemini et Claude dans une seule application";

  @override
  String get weekly => "Hebdomadaire";

  @override
  String get unlockAccessTo => "Débloquer l'accès à";

  @override
  String get forUnlimitedCredits => "pour des crédits illimités.";

  @override
  String get redeemYourFreeTrial => "Échangez votre essai gratuit";

  @override
  String dayFreeTrialWeekCancelAnytime({String? price}) {
    return "Essai gratuit de 3 jours, $price/semaine. Annuler à tout moment";
  }

  @override
  String get tapToSignIn => "Appuyez pour vous connecter";

  @override
  String get todayCredits => "Les crédits du jour";

  @override
  String get notifications => "Notifications";

  @override
  String get voice => "Voix";

  @override
  String get systemVoices => "Voix du système";

  @override
  String get congratulations => "Félicitations!";

  @override
  String get youAreNowChatSYPro =>
      "Vous êtes maintenant membre ChatSY Pro. Profitez de toutes les fonctionnalités Pro.";

  @override
  String get doYouWantToKeepSeeing =>
      "Voulez-vous continuer à voir la question de suivi ?";

  @override
  String get noHideThem => "Non, cache-les";

  @override
  String get yesKeepThem => "Oui, gardez-les";

  @override
  String get managingFollowUpQuestions => "Gestion des questions de suivi";

  @override
  String get youCanEnableOrDisable =>
      "Vous pouvez activer ou désactiver les questions dans les paramètres Chatsy.";

  @override
  String get followUpQuestions => "Questions de suivi";

  @override
  String get wait => "Attendez!";

  @override
  String get justOneLastThing => "Juste une dernière chose...";

  @override
  String get beforeWeShowYouAround =>
      "Avant de vous faire visiter, nous avons un cadeau pour vous";

  @override
  String get openGift => "Cadeau ouvert";

  @override
  String get noThanks => "Non merci!";

  @override
  String get feelThe => "Ressentez le";

  @override
  String get love => "AMOUR!";

  @override
  String get lowestPriceOfTheYear => "Prix le plus bas de l'année";

  @override
  String get unlimitedCredits => "Crédits illimités";

  @override
  String get proFeatures => "Fonctionnalités professionnelles";

  @override
  String get closeThisBannerAndTtGone =>
      "⚠ Fermez cette bannière, et c'est parti pour de bon !";

  @override
  String get weSavedTheBestForLast =>
      "Nous avons gardé le meilleur pour la fin, ";

  @override
  String get offPro => "35 % de réduction sur les Pro";

  @override
  String get defaultVoice => "Voix par défaut";

  @override
  String get yourGift => "Votre cadeau";

  @override
  String get activated => "Activé";

  @override
  String get justForYou => "Juste pour toi";

  @override
  String get here => "Voici un";

  @override
  String get save115 => "Économisez 45 %";

  @override
  String get discount => "Rabais";

  @override
  String get lowestPriceEver => "Prix ​​le plus bas jamais vu";

  @override
  String get claimYourLimitedOffer =>
      "Réclamez votre offre limitée maintenant !";

  @override
  String get only => "Seulement";

  @override
  String get week => "Semaine";

  @override
  String get enterEmail => "Entrez l'e-mail";

  @override
  String get enterSubject => "Entrez le sujet";

  @override
  String get writeHere => "Écrivez ici";

  @override
  String get yourCreditsRefilled => "Vos crédits rechargés";

  @override
  String get doHaveAnAccount => "Vous n'avez pas de compte ?";

  @override
  String get pleaseSignInToContinue => "Veuillez vous connecter pour continuer";

  @override
  String get enterPassword => "Entrez le mot de passe";

  @override
  String get forgotPassword => "Mot de passe oublié ?";

  @override
  String get signUp => "S'inscrire";

  @override
  String get noWorriesHelpYou =>
      "Pas de soucis, nous vous aiderons à réinitialiser votre mot de passe";

  @override
  String get send => "Envoyer";

  @override
  String get authentication => "Authentification";

  @override
  String get enterTheVerificationCodeSent =>
      "Entrez le code de vérification envoyé à votre email";

  @override
  String get verify => "Vérifier";

  @override
  String get resetPassword => "Réinitialiser le mot de passe";

  @override
  String get yourNewPasswordMustBe =>
      "Votre nouveau mot de passe doit être différent de votre précédent";

  @override
  String get enterNewPassword => "Entrez le nouveau mot de passe";

  @override
  String get enterConfirmNewPassword =>
      "Entrez confirmer le nouveau mot de passe";

  @override
  String get updatePassword => "Mettre à jour le mot de passe";

  @override
  String get successful => "Réussi!";

  @override
  String get yourPasswordHasBeen => "Votre mot de passe a été réinitialisé";

  @override
  String get successfully => "avec succès";

  @override
  String get createNewAccount => "Créer un nouveau compte";

  @override
  String get enterYourDetailsBelowTo =>
      "Entrez vos coordonnées ci-dessous pour continuer";

  @override
  String get enterFullName => "Entrez le nom complet";

  @override
  String get enterConfirmPassword => "Entrez le mot de passe de confirmation";

  @override
  String get iAgreeToThe => "J'accepte le";

  @override
  String get alreadyHaveAnAccount => "Vous avez déjà un compte ?";

  @override
  String get yourProfileHasBeenCreated => "Votre profil a été créé avec succès";

  @override
  String get didReceiveTheCode => "Vous n'avez pas reçu le code ?";

  @override
  String get resend => "Renvoyer";

  @override
  String get fullName => "Nom et prénom";

  @override
  String get confirmPassword => "Confirmez le mot de passe";

  @override
  String get newPassword => "Nouveau mot de passe";

  @override
  String get newConfirmPassword => "Nouveau mot de passe de confirmation";

  @override
  String get continueWithEmail => "Continuer avec l'e-mail";

  @override
  String passwordMustBeMoreThan8Characters({String? title}) {
    if (title == null) {
      return "Le mot de passe doit comporter plus de 8 caractères, dont des minuscules, des majuscules, un chiffre et un caractère spécial.";
    }
    return "Le mot de $title passe doit comporter plus de 8 caractères, dont des minuscules, des majuscules, un chiffre et un caractère spécial.";
  }

  @override
  String get passwordAndConfirmPassword =>
      "Le mot de passe et le mot de passe de confirmation ne correspondent pas";

  @override
  String get errorMessagePrivacyAndTerms =>
      "Veuillez accepter notre politique de confidentialité et nos conditions générales";

  @override
  String get errorMessageOtp => "Veuillez entrer OTP";

  @override
  String get errorMessageValidOTP => "Veuillez saisir un OTP valide";

  @override
  String get newName => "Nouveau";

  @override
  String get pleaseEnterNewPassword =>
      "Veuillez entrer un nouveau mot de passe";

  @override
  String get pleaseEnterNewConfirmPassword =>
      "Veuillez entrer un nouveau mot de passe de confirmation";

  @override
  String get newPasswordAndNewConfirmPassword =>
      "Le nouveau mot de passe et le nouveau mot de passe de confirmation ne correspondent pas";

  @override
  String get oops => "Oups!";

  @override
  String get looksLikeYouReNotLoggedIn =>
      "On dirait que vous n'êtes pas connecté. Pour débloquer toutes les fonctionnalités géniales de l'application, veuillez vous connecter ou créer un compte. Le mode Invité a ses limites !";

  @override
  String get unlockMoreWith => "Débloquez davantage avec";

  @override
  String get yourDayFreeTrialUnlockedClaim =>
      "Votre essai gratuit de 3 jours débloqué. Réclamez maintenant 🎁";

  @override
  String get claimYourFreeTrial => "Réclamez votre essai gratuit de 3 jours 🎁";

  @override
  String get microphone => "microphone";

  @override
  String get joinHappyPROUsers => "Rejoignez 10 000 + heureux";

  @override
  String get users => "Utilisateurs";

  @override
  String get offFirstYear => "45 % de réduction sur la première année";

  @override
  String get rating => "Note 4,9/5";

  @override
  String get by => "Par";

  @override
  String get purchaseLifetimePlanAtNoCost =>
      "Accès à vie limité dans le temps seulement";

  @override
  String get apiError =>
      "Une erreur s'est produite. Veuillez réessayer ultérieurement.";

  @override
  String get apiErrorDescription =>
      "Oups ! Un problème est survenu. Veuillez réessayer plus tard.";

  @override
  String get connectionTimeout => "délai de connexion expiré";

  @override
  String get connectionTimeoutDesc =>
      "Oups ! Il semble que votre connexion ait expiré. Veuillez vérifier votre connexion Internet et réessayer.";

  @override
  String get sendTimeout => "délai de connexion expiré";

  @override
  String get sendTimeoutDesc =>
      "Oups ! Il semble que votre connexion ait expiré. Veuillez vérifier votre connexion Internet et réessayer.";

  @override
  String get receiveTimeout => "problème d'acquisition de données";

  @override
  String get receiveTimeoutDesc =>
      "Oups ! Nous rencontrons des difficultés pour obtenir des données. Veuillez réessayer plus tard.";

  @override
  String get badCertificate => "Problèmes de certificat de sécurité";

  @override
  String get badCertificateDesc =>
      "Désolé, il y a un problème avec le certificat de sécurité. Veuillez contacter l'assistance pour obtenir de l'aide.";

  @override
  String get badResponse => "Réponse inattendue du serveur";

  @override
  String get badResponseDesc =>
      "Oh non ! Nous avons reçu une réponse inattendue du serveur. Veuillez réessayer plus tard.";

  @override
  String get reqCancel => "demande d'annulation";

  @override
  String get reqCancelDesc =>
      "Votre demande a été annulée. Veuillez réessayer.";

  @override
  String get connectionError => "problème de connexion";

  @override
  String get connectionErrorDesc =>
      "Nous rencontrons des difficultés de connexion au serveur. Veuillez vérifier votre connexion Internet et réessayer.";

  @override
  String get unknown => "erreur inconnue";

  @override
  String get unknownDesc =>
      "Oups ! Un problème est survenu. Veuillez réessayer plus tard.";

  @override
  String get code200 => "La demande a été acceptée";

  @override
  String get code201 => "Une nouvelle ressource a été créée avec succès.";

  @override
  String get code202 =>
      "La demande a été acceptée pour traitement, mais le traitement n'est pas terminé.";

  @override
  String get code301 =>
      "La ressource a été déplacée définitivement vers le nouvel emplacement.";

  @override
  String get code302 =>
      "La ressource a été temporairement déplacée vers un nouvel emplacement.";

  @override
  String get code304 =>
      "La ressource n'a pas été modifiée depuis la dernière demande.";

  @override
  String get code400 =>
      "Le serveur n'a pas pu comprendre la requête en raison d'une syntaxe incorrecte.";

  @override
  String get code401 =>
      "La demande nécessite une authentification de l'utilisateur.";

  @override
  String get code403 =>
      "Le serveur a compris la demande, mais a refusé de la satisfaire.";

  @override
  String get code404 => "La ressource demandée n'a pas pu être trouvée.";

  @override
  String get code405 =>
      "La méthode spécifiée dans la demande n'est pas autorisée pour la ressource demandée.";

  @override
  String get code409 =>
      "La demande n'a pas pu être complétée en raison d'un conflit avec l'état actuel de la ressource.";

  @override
  String get code500 =>
      "Le serveur a rencontré une condition inattendue qui l'a empêché de terminer la demande.";

  @override
  String get code503 =>
      "Le serveur ne peut pas traiter la demande pour le moment.";

  @override
  String get aiAssistantPrompt =>
      "Exemple : « Vous êtes assistant de rédaction et votre travail consiste à créer automatiquement d’excellents articles à partir du contenu que je fournis. »";

  @override
  String get aiModels => "Informations complémentaires sur l'IA";

  @override
  String get backendPromptInputEx => "Modèles d'IA";

  @override
  String get create => "gpt 4o";

  @override
  String get deleteAssistant => "Les modèles d'IA les plus puissants";

  @override
  String get deleteAssistantDesc => "Des réponses plus humaines";

  @override
  @override
  String get moreHumanlyResponses => "Veuillez entrer un message";

  @override
  String get mostPowerfulAiModel => "Veuillez sélectionner une image";

  @override
  String get pleaseEnterPrompt => "essayer à nouveau";

  @override
  String get pleaseSelectImage => "Assistant de suppression";

  @override
  String get retry => "Êtes-vous sûr de vouloir supprimer cet assistant ?";

  @override
  String get deepseek => throw UnimplementedError();

  @override
  String get deepseekIsAnInnovativeAITechnology => 'throw UnimplementedError()';
}
