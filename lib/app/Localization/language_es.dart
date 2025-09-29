import 'dart:io';

import '../helper/constants.dart';
import 'local_language.dart';

class LanguageEs extends Languages {
  @override
  String get appName => Constants.appName;

  @override
  String get dashboard => "Panel de Control";

  @override
  String get eliteTools => "Herramientas Élite";

  @override
  String get tools => "Herramientas";

  @override
  String get uploadAndAsk => "Subir y Preguntar";

  @override
  String get doYouLikeUsAsMuchAsW => "¿Te gustamos tanto como a ti?";

  @override
  String get weDetailedReview =>
      (Platform.isAndroid)
          ? "¡Difunde el amor! Le agradeceríamos que dejara una reseña detallada en Google Play Store. ¡Sus comentarios significan mucho para nosotros! ❤️"
          : "¡Difunde el amor! Le agradeceríamos que dejara una reseña detallada en la App Store. ¡Sus comentarios significan mucho para nosotros! ❤️";

  @override
  String get helpAiChatSy => "Ayuda a ${Constants.appName}";

  @override
  String get hiHowCanIHelpYou => "¡Hola! ¿Cómo puedo ayudarte?";

  @override
  String get suggestions => "Sugerencias";

  @override
  String get linkAndAsk => "Enlazar y Preguntar";

  @override
  String get exitAlertMessage =>
      "Toca el botón de atrás una vez más para \nsalir de la aplicación";

  @override
  String get doYouLike => "¿Te gustamos tanto como a ti?";

  @override
  String get searchOrAsk => "Buscar o preguntar cualquier cosa en un documento";

  @override
  String get searchOrWebPage =>
      "Buscar o preguntar cualquier cosa en una página web";

  @override
  String get myHistory => "Mi Historia";

  @override
  String get getText => "Obtener texto";

  @override
  String get templates => "Plantillas";

  @override
  String get newChat => "Chat Nuevo";

  @override
  String get startNewChat => "Iniciar un nuevo chat";

  @override
  String get chatHistory => "Historial de Chat";

  @override
  String get chat => "CHAT";

  @override
  String get promptChat => "CHAT RÁPIDO";

  @override
  String get deleteAll => "Eliminar Todo";

  @override
  String get sendAMessage => "Enviar un mensaje";

  @override
  String get takePicture => "Tomar foto";

  @override
  String get chooseFromLibrary => "Elegir de la biblioteca";

  @override
  String get uploadFile => "Subir archivo";

  @override
  String get analyzeWebsite => "Analizar sitio web";

  @override
  String get generateImage => "Generar imagen";

  @override
  String get scanText => "Escanear texto";

  @override
  String get viewTemplates => "Ver plantillas";

  @override
  String get deleteThisChat => "¿Eliminar este chat?";

  @override
  String get deleteThisChatSub =>
      "¿Estás seguro de que quieres eliminar\neste chat?";

  @override
  String get cancel => "Cancelar";

  @override
  String get delete => "Eliminar";

  @override
  String get deleteAllChat => "¿Eliminar todo el historial de chat?";

  @override
  String get deleteAllChatSub =>
      "¿Estás seguro de que quieres eliminar\ntodo tu historial de chat?";

  @override
  String get settings => "Ajustes";

  @override
  String get followUs => "Síguenos";

  @override
  String get language => "Idioma";

  @override
  String get rateUs => "Califícanos";

  @override
  String get selectAIModel => "Seleccionar Modelo de IA";

  @override
  String get darkMode => "Modo Oscuro";

  @override
  String get lightMode => "Modo de luz";

  @override
  String get userID => "ID de Usuario";

  @override
  String get aboutUs => "Sobre Nosotros";

  @override
  String get contactUs => "Contáctanos";

  @override
  String get privacyPolicy => "Política de Privacidad";

  @override
  String get termsOfUse => "Términos de Uso";

  @override
  String get aboutUsSub =>
      "${Constants.appName} es un asistente de chatbot de inteligencia artificial impulsado por la tecnología ChatGPT-4, que le ayudará a resolver cualquier tarea y responder a cualquier pregunta. Al escribir prompts para lo que necesita, usted puede preguntar cualquier cosa y obtener la respuesta para cualquier pregunta o solución para cualquier problema / tarea!\n\nNuestro asistente de chatbot de IA diseñado para atender a todas tus necesidades - Todas las funciones de AI en una sola aplicación!\n\n módulos de AI disponibles:\n - ChatGPT\n - GPT-4\n - PaLM 2\n\nPuede comprobar fácilmente su historial de chat y prompt, y localizar la aplicación para el idioma preferido (English, Spanish, Hindi, French, Portuguese).\n\nNuestra aplicación combina lo mejor de la inteligencia artificial chatbot brillo y las funciones de asistente virtual, impulsado por la avanzada tecnología de Chat GPT-4.\n\nCaracterísticas principales:\n- Escritor de ensayos\n- Generador de fotos y reconocimiento\n- Text-to-Audio\n- Escritora de correos electrónicos\n- Escaneo de texto\n- Comprobación gramatical\n- Traducción\n- Resumen de artículos y sitios web\n- Verificador de plagiarismo\n- Generador De contraseñas\n- Resumen De Reunión\n- Herramienta de parafraseo\n- Generadora de bromas \n- Solucionador de problemas\n- Interacción de voz/Comando\n- Analizar el sitio web \n- Analizar archivos\n‐ Interpretación de sueños\n- Análisis de competidores\n- Contenido Social\n- Recursos de codificación\n- y muchos otros!\n\nEstamos comprometidos con la innovación continua, siempre explorando nuevas formas de mejorar su interacción con la tecnología.\n\nSu experiencia está en el centro de nuestro proceso de desarrollo. Escuchamos tu opinión y adaptamos nuestros servicios a tu vida.\n\nDisfrute de los beneficios que ofrece nuestro AI Chatbot Assistant - ${Constants.appName} está aquí para usted 24/7! No dude en ponerse en contacto con nosotros para cualquier cosa a través de mail@aichatsy.com.";

  @override
  String get name => "Nombre";

  @override
  String get url => "Por favor, introduce la URL";

  @override
  String get subject => "Asunto";

  @override
  String get poweredBy => "Con tecnología de";

  @override
  String get message => "Mensaje";

  @override
  String get submit => "ENVIAR";

  @override
  String get errorMessageValidYourName => "Por favor, introduce tu nombre";

  @override
  String get errorMessageEmail => "Por favor, introduce tu correo electrónico";

  @override
  String get errorMessageValidEmail =>
      "Por favor, introduce un correo electrónico válido";

  @override
  String get errorMessageSubject => "Por favor, introduce el asunto";

  @override
  String get errorMessageMessage => "Por favor, introduce el mensaje";

  @override
  String get email => "Correo electrónico";

  @override
  String get letAiChtSyUnlockYourInnerGenius =>
      "¡Deja que ${Constants.appName} desbloquee tu genio interior!";

  @override
  String get bestSeller => "Más vendido";

  @override
  String get off => "55% de descuento";

  @override
  String get byContinuingYouAccept => "Al continuar aceptas ";

  @override
  String get tosPrivacyPolicy =>
      "Términos y condiciones, Política de privacidad";

  @override
  String get and => "y ";

  @override
  String get billingTeam => "Equipo de facturación";

  @override
  String get purchase => "Comprar";

  @override
  String get restore => "Restaurar";

  @override
  String get aiChatSy => Constants.appName;

  @override
  String get chatGPT4 => "ChatGPT & GPT-4";

  @override
  String get joinMillionsOf => "Únete a millones de ";

  @override
  String get happyUsers => "usuarios felices ";

  @override
  String get unlockThePotential => "Desbloquea el potencial de avanzada ";

  @override
  String get aICamera => "cámara AI  ";

  @override
  String get technology => "Tecnología";

  @override
  String get elevateYourExperienceWith => "Eleva tu experiencia con ";

  @override
  String get eliteFeatures => "características élite. ";

  @override
  String get aiChatSyMsg =>
      "Escribe abajo para obtener respuestas\nHaz cualquier pregunta abierta";

  @override
  String get imageGeneration => "Generación de imágenes";

  @override
  String get effortlesslyCraftYourSearch =>
      "Elabora tu búsqueda sin esfuerzo con nuestro práctico";

  @override
  String get textToImage => "Texto a imagen";

  @override
  String get photoIdentification => "Identificación fotográfica";

  @override
  String get camera => "Cámara";

  @override
  String get gallery => "Galería";

  @override
  String get uploadYourImage => "Sube tu imagen";

  @override
  String get uploadAndIdentify => "Subir e identificar";

  @override
  String get weLoveToGetADetailed =>
      "Nos encantaría recibir una reseña detallada de ti en la App Store, ¡contando al mundo por qué disfrutas de ${Constants.appName}!";

  @override
  String get askSomething => "Pregunta algo";

  @override
  String get uploadAndAskSubTitle =>
      "Puedes preguntar o buscar cualquier cosa en un documento. Para resumir, por favor usa la sección de resumen en la página principal.\n\nAsegúrate de que el archivo sea .pdf, .docx o .txt";

  @override
  String get typeYourQuestionHere => "Escribe tu pregunta aquí";

  @override
  String get typeYourTextHere => "Escribe tu texto aquí";

  @override
  String get pleaseUploadFile =>
      "Archivo no compatible. por favor inserta solo archivos .pdf, .docx o .txt";

  @override
  String get pleaseUploadPDF =>
      "El archivo no es compatible. por favor inserte solo archivos .pdf";

  @override
  String pleaseEnterValid({String? title}) {
    return "Por favor ingresa válido  $title";
  }

  @override
  String get pleaseEnterValidQuestion =>
      "Por favor, introduce una pregunta válida";

  @override
  String get pleaseEnterImage => "Por favor ingresa Imagen";

  @override
  String get done => "Hecho";

  @override
  String get linkAndAskSubTitle =>
      "Puedes preguntar o buscar cualquier cosa en una página web. Para resumir, por favor usa la sección de resumen en la página principal.";

  @override
  String get pasteYourLink => "Pega tu enlace";

  @override
  String get pleaseEnterValidUrl => "Por favor, introduce un enlace URL válido";

  @override
  String get pleaseEnterUrl => "Por favor, introduce el enlace URL";

  @override
  String get summarizeArticle => "Resumir artículo";

  @override
  String get summarizeArticleMsg => "Obtener un resumen detallado del artículo";

  @override
  String get summarizeWeb => "Resumir website";

  @override
  String get summarizeWebMsg => "Obtener un resumen detallado de la página web";

  @override
  String get summarizeArticleTitle =>
      "Puedes agregar tu documento y ${Constants.appName} para resumirlo.\n\nAsegúrate de que el archivo sea .pdf, .docx o .txt";

  @override
  String get summarizeArticleWeb =>
      "Puedes agregar tu documento y ${Constants.appName} para resumirlo.";

  @override
  String get summarizeIn => "Resumir en";

  @override
  String get summarize => "Resumir";

  @override
  String get chatGPT => "ChatGPT";

  @override
  String get chatGPTMsg =>
      "Modelo de chatbot predeterminado proporcionado\npor OpenAI";

  @override
  String get GPT4 => "GPT-4";

  @override
  String get paLM2 => "PaLM 2";

  @override
  String get aCreativeAndHelpfulCollaborator =>
      "Un colaborador creativo y útil,\ndesarrollado por Google AI";

  @override
  String get convertTextBasedDescriptions =>
      "Convertir descripciones basadas en texto en datos visuales";

  @override
  String get GPT4Msg =>
      "Un sistema más avanzado, que produce\nrespuestas más seguras y útiles";

  @override
  String get copy => "Copiar";

  @override
  String get selectText => "Seleccionar texto";

  @override
  String get regenerateResponse => "Regenerar respuesta";

  @override
  String get ok => "Ok";

  @override
  String get appUpdate => "¡Actualización de la app requerida!";

  @override
  String get update => "Actualizar";

  @override
  String get english => "Inglés";

  @override
  String get spanish => "Español";

  @override
  String get hindi => "Hindi";

  @override
  String get french => "Francés";

  @override
  String get portuguese => "Portugués";

  @override
  String get pleaseFillThe => "Por favor, rellene el";

  @override
  String get inTheFormForBetterResults =>
      "Por favor, rellene el formulario para obtener mejores resultados";

  @override
  String get aiAssistants => "Asistentes de IA";

  @override
  String get examples => "Ejemplos";

  @override
  String get aiChatSyCanGenerateUnique =>
      "visuals based on your description. To create an image, you can send a message to describe it or use a pre- made prompt!";

  @override
  String get freeTrialEnabled => "Prueba gratuita activada";

  @override
  String get explore => "Explorar";

  @override
  String get yourListIsEmpty => "Tu lista está vacía";

  @override
  String get seeAll => "Ver todo";

  @override
  String get hide => "Ocultar";

  @override
  String get download => "Descargar";

  @override
  String get share => "Compartir";

  @override
  String get chooseYourLanguage => "Elige tu idioma";

  @override
  String get assistants => "Asistentes";

  @override
  String get home => "Hogar";

  @override
  String get fullAccessTo => "Acceso completo a";

  @override
  String get pro => " PRO ";

  @override
  String get aICHATSYUnlimited => "${Constants.appName} Ilimitado";

  @override
  String get poweredByGPT4GeminiPaLM => "Desarrollado por GPT 4o, Gemini";

  @override
  String get premiumAiTools => "Herramientas de IA premium";

  @override
  String get fasterConversation => "Conversación más rápida";

  @override
  String get unlimitedChatImages => "Chat e imágenes ilimitados";

  @override
  String get pDFURLSummary => "Resumen de PDF y URL";

  @override
  String get unlimitedYearly => "Ilimitado Anual";

  @override
  String get save80 => "Ahorra 80%";

  @override
  String get save25 => "Ahorra 25%";

  @override
  String get mostPopular => "Más popular";

  @override
  String get chooseImage => "Elige la imagen";

  @override
  String get scanDocumentsImages => "Escanear documentos o imágenes";

  @override
  String get transformYourVisionIntoArt => "Transforma tu visión en arte";

  @override
  String get unlimitedMonthly => "Mensual Ilimitado";

  @override
  String get unlimitedWeekly => "Ilimitado Semanal";

  @override
  String get lifetimeAccess => "Acceso de por vida";

  @override
  String get limitedOffer => "OFERTA LIMITADA";

  @override
  String get oneTimeBuy => "COMPRA ÚNICA";

  @override
  String get unlockLifetimeAccess => "Desbloquear acceso de por vida";

  @override
  String get subscribe => "Suscribir";

  @override
  String get autoRenewable => "Auto renovable";

  @override
  String get unlimitedUsage => "Uso ilimitado";

  @override
  String get noCommitment => "Sin compromiso";

  @override
  String get cancelAnytime => "Cancelar en cualquier momento";

  @override
  String get imageScan => "Escaneo de imágenes";

  @override
  String get textScan => "Escaneo de texto";

  @override
  String get summarizePDF => "Resumir PDF";

  @override
  String get textsFromImages => "Textos a partir de imágenes";

  @override
  String get whatNew => "Qué hay de nuevo?";

  @override
  String get news => "Nuevo";

  @override
  @override
  @override
  String get aIModules => "Módulos de IA";

  @override
  String get yourDailyFreeCredits => "Tus créditos diarios gratuitos";

  @override
  String get youHave => "Tienes";

  @override
  String get creditLeft => "Crédito restante";

  @override
  String get upgradeToPremium => "Mejorado a Premium";

  @override
  String get getUnlimitedAccessToAllFeatures =>
      "Obtenga acceso ilimitado a todas las funciones";

  @override
  String get unlimitedAccess => "Acceso ilimitado";

  @override
  String get yearly => "Anual";

  @override
  String get monthly => "Mensual";

  @override
  String get threeDaysFreeTrial => "Prueba gratuita de 3 días";

  @override
  String get startFreeTrial => "Empiza la prueba gratuita";

  @override
  String get uploadAndAAsk => "Subir y preguntar";

  @override
  String get unlockTheFullPotentialOfAichatsy =>
      "Desbloquee todo el potencial de la IA de ${Constants.appName} utilizando la función Cargar y Preguntar. Cargue fácilmente cualquier documento y obtenga respuestas rápidas y precisas.";

  @override
  String get uploadYourDocument => "Sube tu documento";

  @override
  String get clickTheUploadButtonAndSelectYourFile =>
      "Haga clic en el botón cargar y seleccione su archivo.";

  @override
  String get askQuestion => "Pregunta";

  @override
  String get typeInYourQueryBboutTheDocument =>
      "Escriba su consulta sobre el documento.";

  @override
  String get getAnswer => "Obtener respuesta";

  @override
  String get receiveInstantAIGeneratedResponses =>
      "Reciba respuestas instantáneas generadas por IA.";

  @override
  String get letsGo => "Vamos";

  @override
  String get visionScan => "Escaneo de visión";

  @override
  String get experienceThePowerOfAichatsy =>
      "Experimente el poder de la función Vision Scan de ${Constants.appName}. Escanee fácilmente documentos o imágenes y obtenga información instantánea generada por IA.";

  @override
  String get scanDocument => "Escanear documento";

  @override
  String get captureYourDocumentOrImage => "Capture su documento o imagen.";

  @override
  String get enterYourQuestion => "Ingrese su pregunta.";

  @override
  String get getInsights => "Obtenga información";

  @override
  String get transformYourIdeasIntoVisualsWithAichatsy =>
      "Transforme sus ideas en imágenes con la función Generación de imágenes de ${Constants.appName}. Perfecto para crear imágenes personalizadas sin esfuerzo.";

  @override
  String get describeImage => "Describir imagen";

  @override
  String get enterBriefDescriptionOfTheImageYouWant =>
      "Introduce una breve descripción de la imagen que deseas.";

  @override
  String get selectStyle => "Seleccionar estilo";

  @override
  String get pickStyleOrTemplateThatSuitsYourVision =>
      "Elija el estilo o plantilla que se adapte a su visión.";

  @override
  String get generate => "Generar";

  @override
  String get clickToCreateYourImage => "Haz clic para crear tu imagen.";

  @override
  String get receiveInstantAIGeneratedAnswers =>
      "Reciba respuestas instantáneas generadas por IA.";

  @override
  String get enterALink => "Ingrese un enlace";

  @override
  String get enterTheURLToSummarize =>
      "Ingrese la URL para resumir, reescribir, traducir o analizar su contenido.";

  @override
  String get pasteALink => "Pegar un enlace";

  @override
  String get pasteALinkEG => "Pegue un enlace (por ejemplo, www.aichatsy.com)";

  @override
  String get continues => "Continuar";

  @override
  String get uploadYourPDF => "Sube tu PDF";

  @override
  String get itMustBe10MBMax => "Debe tener un tamaño máximo de 10,0 MB.";

  @override
  String get uploadPDF => "Subir PDF";

  @override
  String get uploadImage => "Cargar imagen";

  @override
  String get uploadImageToScan => "Subir imagen para escanear";

  @override
  String get oopsYouReachedYourDailyMessaging =>
      "¡Vaya, has alcanzado tu límite de mensajes diarios! Puedes enviar 4 mensajes por día en el plan gratuito. Actualice para desbloquear mensajes ilimitados.";

  @override
  String get upgradeToPRO => "Actualízate a";

  @override
  String get premium => "De primera calidad";

  @override
  String get length => "Longitud";

  @override
  String get auto => "Auto";

  @override
  String get short => "Corto";

  @override
  String get medium => "Medio";

  @override
  String get long => "Largo";

  @override
  String get defaults => "🤖 Predeterminado";

  @override
  String get professional => "🧐 Profesional";

  @override
  String get friendly => "😃 Amistoso";

  @override
  String get inspirational => "😇 Inspirador";

  @override
  String get joyful => "😂 alegre";

  @override
  String get persuasive => "😉 Persuasivo";

  @override
  String get empathetic => "️️🙂 Empático";

  @override
  String get surprised => "😯 Sorprendido";

  @override
  String get optimistic => "😋 Optimista";

  @override
  String get worried => "😟 Preocupado";

  @override
  String get curious => "😏 Curioso";

  @override
  String get assertive => "😎 Asertivo";

  @override
  String get cooperative => "😌 Cooperativa";

  @override
  String get romantic => "🥰 Romántico";

  @override
  String get passionate => "😍 Apasionado";

  @override
  String get critical => "🤬 Crítico";

  @override
  String get responseTone => "Tono de respuesta";

  @override
  String get save => "Ahorrar";

  @override
  String get selectImageSizeStyle => "Seleccionar tamaño y estilo de imagen";

  @override
  String get selectSize => "Selecciona el tamaño";

  @override
  String get chooseAvatar => "Elija Avatar";

  @override
  String get anyTimeCancel => "Cancelar en cualquier momento";

  @override
  String get pleaseEnterName => "Por favor ingrese el nombre";

  @override
  String get summarizeIt => "Resúmelo";

  @override
  String get rewriteIt => "Reescríbelo";

  @override
  String get welcomeToAICHATSY => "Bienvenido a ${Constants.appName}";

  @override
  String get wereDelightedToHaveYouHere =>
      "Estamos encantados de tenerte aquí.";

  @override
  String get howShouldWeCallYou => "¿Cómo deberíamos llamarte?";

  @override
  String get optional => "Opcional";

  @override
  String get enterName => "Ingrese su nombre";

  @override
  String get theme => "Tema";

  @override
  String get chatGPTIsYourAIAssistant =>
      "ChatGPT es su asistente de inteligencia artificial para obtener respuestas rápidas y ayuda creativa, y ofrece respuestas personalizadas para mejorar su experiencia.";

  @override
  String get knowledgeBase => "Base de conocimientos:";

  @override
  String get deliversAccurateInformativeResponses =>
      "Ofrece respuestas precisas e informativas.";

  @override
  String get creativity => "Creatividad:";

  @override
  String get helpsGenerateIdeasAndWriteContent =>
      "Ayuda a generar ideas y escribir contenido.";

  @override
  String get efficiency => "Eficiencia:";

  @override
  String get providesQuickReliableAnswers =>
      "Proporciona respuestas rápidas y confiables.";

  @override
  String get chatGPT4IsYourAdvancedAIAssistant =>
      "ChatGPT-4 es su asistente avanzado de IA, diseñado para brindar respuestas precisas, ayudar con tareas creativas y ofrecer soporte personalizado.";

  @override
  String get enhancedUnderstanding => "Comprensión mejorada:";

  @override
  String get deliversMoreAccurateResponses => "Ofrece respuestas más precisas.";

  @override
  String get creativeAssistance => "Asistencia creativa:";

  @override
  String get generatesIdeasAndContentEffortlessly =>
      "Genera ideas y contenidos sin esfuerzo.";

  @override
  String get realTimeUpdates => "Actualizaciones en tiempo real:";

  @override
  String get accessesLiveInfoForRealTimeResponses =>
      "Accede a información en vivo para obtener respuestas en tiempo real.";

  @override
  String get paLMIsAnAILanguageModelDevelopedByGoogleAI =>
      "PaLM es un modelo de lenguaje de IA desarrollado por GOOGLE AI, conocido por sus capacidades avanzadas en el procesamiento y generación de lenguaje natural.";

  @override
  String get advancedPatternRecognition =>
      "Reconocimiento de patrones avanzado:";

  @override
  String get enhancesPatternRecognitionCapabilities =>
      "Mejora las capacidades de reconocimiento de patrones.";

  @override
  String get contextualUnderstanding => "Comprensión contextual:";

  @override
  String get improvesModelsComprehensionOfContext =>
      "Mejora la comprensión del contexto de los modelos.";

  @override
  String get enhancedPerformance => "Rendimiento mejorado:";

  @override
  String get boostOverallModelCapabilitiesEffectively =>
      "Aumenta las capacidades generales del modelo de manera efectiva.";

  @override
  String get palm => "Palmera";

  @override
  String get geminiIsAnInnovativeAITechnology =>
      "Gemini es una innovadora tecnología de inteligencia artificial conocida por permitir interacciones fluidas y mejorar la eficiencia de las tareas con capacidades avanzadas.";

  @override
  String get smoothInteractions => "Interacciones fluidas:";

  @override
  String get enablesIntuitiveUserEngagement =>
      "Permite la participación intuitiva del usuario.";

  @override
  String get efficientTasks => "Tareas eficientes:";

  @override
  String get enhancesProductivity => "Mejora la productividad.";

  @override
  String get advancedIntegration => "Integración avanzada:";

  @override
  String get cuttingEdgeAIOptimization => "Optimización de IA de vanguardia.";

  @override
  String get letTry => "Intentemos";

  @override
  String get websiteInsightsWithAIChatSY =>
      "Información del sitio web con ${Constants.appName}";

  @override
  String get addWebsiteURL => "Agregar URL del sitio web";

  @override
  String get pasteTheWebsiteLink => "Pegue el enlace del sitio web";

  @override
  String get summarizeAnyPDF => "Resumir cualquier PDF";

  @override
  String get clickSummarize => "Haga clic en Resumir";

  @override
  String get hitTheSummarizeButtonStart =>
      "Presione el botón Resumir para comenzar";

  @override
  String get uploadAnyDocumentOrPdf => "Sube cualquier documento o pdf";

  @override
  String get readSummary => "Leer resumen";

  @override
  String get getConciseSummaryWebpage =>
      "Obtenga un resumen conciso de la página web";

  @override
  String get askAnything => "Pregunta cualquier cosa";

  @override
  String get askAICHATSYWhatDocument =>
      "Pregúntele a ${Constants.appName} qué hacer con el documento";

  @override
  String get getResponses => "Obtener respuestas";

  @override
  String get getQuickResponsesInSeconds =>
      "Obtenga respuestas rápidas en segundos";

  @override
  String get cancellationCancelAnytimeDuring =>
      "Cancelación: Cancela en cualquier momento durante los primeros 3 días.";

  @override
  String get summarizeDocument => "Resumir Documento";

  @override
  String get youtubeSummary => "YouTube Resumen";

  @override
  String get realTimeWeb => "Tiempo real Web";

  @override
  String get scanAnyText => "Escanea cualquier texto";

  @override
  String get uploadOrCapture => "Cargar o capturar";

  @override
  String get uploadAnyDocumentOrPicture => "SSube cualquier documento o imagen";

  @override
  String get askWhatToDoWithDocument =>
      "Pregúntele a ${Constants.appName} qué hacer con el documento";

  @override
  String get getRespondOnScan => "Obtenga Responder al escanear";

  @override
  String get sendFeedback => "Enviar comentarios";

  @override
  String get useCamera => "Usar cámara";

  @override
  String get addWebsite => "Agregar sitio web";

  @override
  String get searchAndAskAboutYouTubeVideoContent =>
      "Busque y pregunte sobre el contenido de vídeo de YouTube";

  @override
  String get takeOrChoosePhoto => "Toma o elige una foto";

  @override
  String get recognize => "Reconocer";

  @override
  String get addWebsiteDesc =>
      "Ingrese la URL para resumir, reescribir, traducir o analizar su contenido.";

  @override
  String get pasteLink => "Pegue un enlace (por ejemplo, www.aichatsy.com)";

  @override
  String get enterYoutubeLink => "Ingrese al enlace de youtube";

  @override
  String get documentUpload => "Carga de documentos";

  @override
  String get summarizeYourDocument => "Resuma su documento";

  @override
  String get summarizeYourDocumentDesc =>
      "Asegúrese de que el archivo sea .pdf, .docx o .txt.";

  @override
  String get imageUpload => "Subir imagen";

  @override
  String get edit => "Editar";

  @override
  String get readLoud => "Leer en voz alta";

  @override
  String get recentImages => "Imágenes recientes";

  @override
  String get clearAll => "Borrar todo";

  @override
  String get areYouSureYouWantToClearAllImage =>
      "¿Está seguro de que desea borrar \ntoda la imagen?";

  @override
  String get yes => "Sí";

  @override
  String get allHistory => "Toda la historia";

  @override
  String get favorites => "Favoritos";

  @override
  String get today => "Hoy";

  @override
  String get yesterday => "Ayer";

  @override
  String get thisWeek => "Esta semana";

  @override
  String get legal => "Legal";

  @override
  String get noDataFound => "No se encontraron datos";

  @override
  String get upgradeToAICHATSY => "Actualízate a ${Constants.appName}";

  @override
  String get wouldYouLikeToDeleteAll => "Quieres eliminar todos los chats?";

  @override
  String get creditsLeftToday => "Créditos restantes hoy";

  @override
  String get setLanguages => "Establecer idiomas";

  @override
  String get languagesNotFound => "Idiomas no encontrados";

  @override
  String get search => "Buscar";

  @override
  String grantPermission({String? title}) {
    return "conceder permiso al $title̱";
  }

  @override
  String permissionFromTheAppAppSettings({String? title}) {
    return "Otorgue permiso al $title desde la configuración de la aplicacióṉ";
  }

  @override
  String get hiAiChatsyPoweredByChatGPT =>
      "Hola, soy ${Constants.appName}! Desarrollado por ChatGPT.";

  @override
  String get imHereToAssistYouWithGuidance =>
      "Estoy aquí para ayudarte con orientación sobre cómo elaborar un CV impresionante, escribir correos electrónicos efectivos, aumentar la productividad, recibir sugerencias de regalos bien pensadas o descubrir lugares únicos para la primera cita.";

  @override
  String get startAskingQuestions => "¡Empiece a hacer preguntas!";

  @override
  String get youAre => "Eres";

  @override
  String get user => "usuario";

  @override
  String get allAIModules => "Todos los módulos de IA";

  @override
  String get aIImageRecognition => "Reconocimiento de imágenes por IA";

  @override
  String get freeTrial => "Prueba gratuita";

  @override
  String get startWithFreeTrial => "Comience con la prueba gratuita";

  @override
  String get pleasePurchasePlanForAccess =>
      "Por favor compre el plan para acceder a este modelo.";

  @override
  String get login => "acceso";

  @override
  String get welcomeBack => "¡Bienvenido de nuevo!";

  @override
  String get continueWithApple => "Continuar con Apple";

  @override
  String get continueWithGoogle => "Continuar con Google";

  @override
  String get docIos =>
      "Al hacer clic en Iniciar sesión con Apple o Iniciar sesión con Google, acepta nuestras";

  @override
  String get docAndroid =>
      "Al hacer clic en Iniciar sesión con Google, aceptas nuestras";

  @override
  String get logOut => "Finalizar la sesión";

  @override
  String get password => "Contraseña";

  @override
  String get errorMessagePassword => "Por favor ingrese la contraseña";

  @override
  String get createYourFreeAccount => "Crea tu cuenta gratuita";

  @override
  String get skip => "Saltar";

  @override
  String get signIn => "Iniciar sesión";

  @override
  String get free => "Gratis";

  @override
  String get profile => "Perfil";

  @override
  String get clickToChangeAvatar => "Haz clic para cambiar de avatar";

  @override
  String get logInSuccessful => "Iniciar sesión exitosamente";

  @override
  String get syncYourHistoryAcross =>
      "Sincroniza tu historial en tus dispositivos.";

  @override
  String get creatingCustomizedAnd =>
      "Creando una experiencia personalizada y mejorada.";

  @override
  String get syncingYourChatHistoryFor =>
      "Sincronizar su historial de chat para una mejor experiencia";

  @override
  String get restoringYourPurchasesSoThat =>
      "Restaurar tus compras para no perderte nada";

  @override
  String get areYouSureTo => "¿Estás seguro de cerrar sesión?";

  @override
  String get youWillNotLooseYourDataIf =>
      "No perderás tus datos si cierras sesión. Aún puedes iniciar sesión en esta cuenta.";

  @override
  String get gotIt => "Entiendo";

  @override
  String get realTimeWebSearch => "Búsqueda web en tiempo real";

  @override
  String get upgradeTo => "Actualizar a";

  @override
  String get forFullAccess => "¡para acceso completo!";

  @override
  String get saveTimeDoMoreAnd =>
      "Ahorre tiempo, haga más y consiga resultados más rápido";

  @override
  String get bestOffer => "Mejor oferta";

  @override
  String get unlimited => "Ilimitado";

  @override
  String get deleteAccount => "Eliminar cuenta";

  @override
  String get itSpam => "es un spam";

  @override
  String get falseInformation => "Información falsa";

  @override
  String get privacyConcerns => "Preocupaciones de privacidad";

  @override
  String get violenceThreats => "Amenazas de violencia";

  @override
  String get other => "Otro";

  @override
  String get writeYourReason => "Escribe tu razón";

  @override
  String get hateSpeechSymbols => "Discurso o símbolos de odio";

  @override
  String get bullyingOrHarassment => "Intimidación o acoso";

  @override
  String get scamOrFraud => "Estafa o fraude";

  @override
  String get areYouSureYouWantTo =>
      "¿Estás seguro de que quieres eliminar tu cuenta?";

  @override
  String get youWilLoseAllYourData =>
      "Perderás todos tus datos y tu cuenta no será recuperada.";

  @override
  String get chooseAReason => "Elige una razón";

  @override
  String get pleaseEnterReason => "Por favor ingresa el motivo";

  @override
  String get report => "Informe";

  @override
  String get more => "Más";

  @override
  String get no => "No";

  @override
  String get doYouLikeTheApp => "¿Te gusta la aplicación?";

  @override
  String get maybeLater => "Quizás más tarde";

  @override
  String get specialOffer => "Oferta especial";

  @override
  String get offAnnualPlan => "25% de descuento en el plan anual";

  @override
  String get pROAITools => "Herramientas profesionales de IA";

  @override
  String get aIAssistantsTemplates => "Asistentes y plantillas de IA";

  @override
  String get aIImageGenerations => "Generaciones de imágenes de IA";

  @override
  String get accessAllAIModels => "Accede a todos los modelos de IA";

  @override
  String get accessHumanLikeChat => "Accede al chat humanoide";

  @override
  String get onlyForYou => "SOLO PARA TI";

  @override
  String get thisOfferExpiresIn => "Esta oferta vence en";

  @override
  String get just => "Justo";

  @override
  String get perFirstYear => "por primer año";

  @override
  String get lessThan => "(menos que";

  @override
  String get perWeek => "por semana)";

  @override
  String get grabThisDeal => "Aprovecha esta oferta";

  @override
  String get tryTodayFor => "Pruébalo hoy por \$0";

  @override
  String get freeAccount => "Cuenta gratuita";

  @override
  String get proAccount => "Cuenta Pro";

  @override
  String get subscribeForJust => "Suscríbete por solo";

  @override
  String get offForYearlyPlan => "15% de descuento para plan anual";

  @override
  String get powerfulAIModelsGPTGemini =>
      "Potentes modelos de IA GPT, Gemini y Claude en una sola aplicación";

  @override
  String get weekly => "Semanalmente";

  @override
  String get unlockAccessTo => "Desbloquear el acceso a";

  @override
  String get forUnlimitedCredits => "para créditos ilimitados.";

  @override
  String get redeemYourFreeTrial => "Canjee su prueba gratuita";

  @override
  String dayFreeTrialWeekCancelAnytime({String? price}) {
    return "Prueba gratuita de 3 días, $price/semana. Cancelar en cualquier momento";
  }

  @override
  String get tapToSignIn => "Toca para iniciar sesión";

  @override
  String get todayCredits => "Créditos de hoy";

  @override
  String get notifications => "Notificaciones";

  @override
  String get voice => "Voz";

  @override
  String get systemVoices => "Voces del sistema";

  @override
  String get congratulations => "¡Felicitaciones!";

  @override
  String get youAreNowChatSYPro =>
      "Ahora eres miembro de ChatSY Pro. Disfruta de todas las funciones Pro.";

  @override
  String get doYouWantToKeepSeeing =>
      "¿Quieres seguir viendo la pregunta de seguimiento?";

  @override
  String get noHideThem => "No, escóndelos";

  @override
  String get yesKeepThem => "Sí, guárdalos";

  @override
  String get managingFollowUpQuestions => "Gestión de preguntas de seguimiento";

  @override
  String get youCanEnableOrDisable =>
      "Puede habilitar o deshabilitar las preguntas en la configuración de Chatsy.";

  @override
  String get followUpQuestions => "Preguntas de seguimiento";

  @override
  String get wait => "¡Esperar!";

  @override
  String get justOneLastThing => "Sólo una última cosa...";

  @override
  String get beforeWeShowYouAround =>
      "Antes de mostrarte el lugar, tenemos un regalo para ti.";

  @override
  String get openGift => "Regalo abierto";

  @override
  String get noThanks => "¡No, gracias!";

  @override
  String get feelThe => "Siente el";

  @override
  String get love => "¡AMAR!";

  @override
  String get lowestPriceOfTheYear => "Precio más bajo del año.";

  @override
  String get unlimitedCredits => "Créditos ilimitados";

  @override
  String get proFeatures => "Funciones profesionales";

  @override
  String get closeThisBannerAndTtGone =>
      "⚠ ¡Cierra este banner y desaparecerá para siempre!";

  @override
  String get weSavedTheBestForLast => "Guardamos lo mejor para el final, ";

  @override
  String get offPro => "35 % de descuento profesional";

  @override
  String get defaultVoice => "Voz predeterminada";

  @override
  String get yourGift => "Tu regalo";

  @override
  String get activated => "Activado";

  @override
  String get justForYou => "solo para ti";

  @override
  String get here => "Aquí hay un";

  @override
  String get save115 => "Ahorra 45%";

  @override
  String get discount => "Descuento";

  @override
  String get lowestPriceEver => "El precio más bajo jamás visto";

  @override
  String get claimYourLimitedOffer => "¡Reclama tu oferta limitada ahora!";

  @override
  String get only => "Solo";

  @override
  String get week => "Semana";

  @override
  String get enterEmail => "Ingrese el correo electrónico";

  @override
  String get enterSubject => "Ingrese el asunto";

  @override
  String get writeHere => "Escribe aquí";

  @override
  String get yourCreditsRefilled => "Tus créditos recargados";

  @override
  String get doHaveAnAccount => "¿No tienes una cuenta?";

  @override
  String get pleaseSignInToContinue => "Por favor inicia sesión para continuar";

  @override
  String get enterPassword => "Introduce la contraseña";

  @override
  String get forgotPassword => "¿Has olvidado tu contraseña?";

  @override
  String get signUp => "Inscribirse";

  @override
  String get noWorriesHelpYou =>
      "No te preocupes, te ayudaremos a restablecer tu contraseña.";

  @override
  String get send => "Enviar";

  @override
  String get authentication => "Autenticación";

  @override
  String get enterTheVerificationCodeSent =>
      "Ingresa el código de verificación enviado a tu correo electrónico";

  @override
  String get verify => "Verificar";

  @override
  String get resetPassword => "Restablecer contraseña";

  @override
  String get yourNewPasswordMustBe =>
      "Tu nueva contraseña debe ser diferente a la anterior";

  @override
  String get enterNewPassword => "Ingrese una nueva contraseña";

  @override
  String get enterConfirmNewPassword => "Ingrese confirmar nueva contraseña";

  @override
  String get updatePassword => "Actualizar contraseña";

  @override
  String get successful => "¡Exitoso!";

  @override
  String get yourPasswordHasBeen => "Tu contraseña ha sido restablecida";

  @override
  String get successfully => "exitosamente";

  @override
  String get createNewAccount => "Crear nueva cuenta";

  @override
  String get enterYourDetailsBelowTo =>
      "Ingresa tus datos a continuación para continuar";

  @override
  String get enterFullName => "Introduce el nombre completo";

  @override
  String get enterConfirmPassword => "Ingrese confirmar contraseña";

  @override
  String get iAgreeToThe => "Estoy de acuerdo con el";

  @override
  String get alreadyHaveAnAccount => "¿Ya tienes una cuenta?";

  @override
  String get yourProfileHasBeenCreated =>
      "Tu perfil ha sido creado exitosamente";

  @override
  String get didReceiveTheCode => "¿No recibiste el código?";

  @override
  String get resend => "Reenviar";

  @override
  String get fullName => "nombre completo";

  @override
  String get confirmPassword => "Confirmar Contraseña";

  @override
  String get newPassword => "Nueva contraseña";

  @override
  String get newConfirmPassword => "Nueva contraseña de confirmación";

  @override
  String get continueWithEmail => "Continuar con el correo electrónico";

  @override
  String passwordMustBeMoreThan8Characters({String? title}) {
    if (title == null) {
      return "La contraseña debe tener más de 8 caracteres, incluyendo minúsculas, mayúsculas, números y un carácter especial.";
    }
    return "La contraseña debe tener más de 8 caracteres, incluyendo minúsculas, mayúsculas, números y un $title carácter especial.";
  }

  @override
  String get passwordAndConfirmPassword =>
      "La contraseña y la contraseña de confirmación no coinciden";

  @override
  String get errorMessagePrivacyAndTerms =>
      "Por favor acepte nuestra Política de Privacidad y Términos y Condiciones";

  @override
  String get errorMessageOtp => "Por favor ingresa otp";

  @override
  String get errorMessageValidOTP => "Por favor ingresa una OTP válida";

  @override
  String get newName => "Nuevo";

  @override
  String get pleaseEnterNewPassword => "Por favor ingrese una nueva contraseña";

  @override
  String get pleaseEnterNewConfirmPassword =>
      "Por favor ingrese una nueva contraseña de confirmación";

  @override
  String get newPasswordAndNewConfirmPassword =>
      "La nueva contraseña y la nueva contraseña de confirmación no coinciden";

  @override
  String get oops => "¡Ups!";

  @override
  String get looksLikeYouReNotLoggedIn =>
      "Parece que no has iniciado sesión. Para desbloquear todas las increíbles funciones de la aplicación, inicia sesión o crea una cuenta. ¡El modo invitado tiene sus límites!";

  @override
  String get unlockMoreWith => "Desbloquea más con";

  @override
  String get yourDayFreeTrialUnlockedClaim =>
      "Su prueba gratuita de 3 días desbloqueada. Reclama ahora 🎁";

  @override
  String get claimYourFreeTrial => "Solicite su prueba gratuita de 3 días 🎁";

  @override
  String get microphone => "micrófono";

  @override
  String get joinHappyPROUsers => "Únete a 10K+ feliz";

  @override
  String get users => "Usuarios";

  @override
  String get offFirstYear => "45% de descuento en el primer año";

  @override
  String get rating => "Calificación 4.9/5";

  @override
  String get by => "Por";

  @override
  String get purchaseLifetimePlanAtNoCost =>
      "Acceso de por vida por tiempo limitado únicamente";

  @override
  String get apiError =>
      "Se ha producido un error. Inténtalo de nuevo más tarde.";

  @override
  String get apiErrorDescription =>
      "¡Uy! Algo salió mal. Inténtalo de nuevo más tarde.";

  @override
  String get connectionTimeout => "Tiempo de espera de conexión";

  @override
  String get connectionTimeoutDesc =>
      "¡Uy! Parece que se agotó el tiempo de conexión. Por favor, revisa tu conexión a internet y vuelve a intentarlo.";

  @override
  String get sendTimeout => "Tiempo de espera de conexión";

  @override
  String get sendTimeoutDesc =>
      "¡Uy! Parece que se agotó el tiempo de conexión. Por favor, revisa tu conexión a internet y vuelve a intentarlo.";

  @override
  String get receiveTimeout => "Problema de recepción de datos";

  @override
  String get receiveTimeoutDesc =>
      "¡Uy! Tenemos problemas para recibir datos. Inténtalo de nuevo más tarde.";

  @override
  String get badCertificate => "Problema del certificado de seguridad";

  @override
  String get badCertificateDesc =>
      "Lo sentimos, hay un problema con el certificado de seguridad. Contacta con el servicio de asistencia para obtener ayuda.";

  @override
  String get badResponse => "Respuesta inesperada del servidor";

  @override
  String get badResponseDesc =>
      "¡Oh, no! Recibimos una respuesta inesperada del servidor. Inténtalo de nuevo más tarde.";

  @override
  String get reqCancel => "Solicitud cancelada";

  @override
  String get reqCancelDesc =>
      "Su solicitud ha sido cancelada. Inténtelo de nuevo.";

  @override
  String get connectionError => "Problema de conexión";

  @override
  String get connectionErrorDesc =>
      "Tenemos problemas para conectarnos al servidor. Por favor, revisa tu conexión a internet y vuelve a intentarlo.";

  @override
  String get unknown => "Error desconocido";

  @override
  String get unknownDesc =>
      "¡Uy! Algo salió mal. Inténtalo de nuevo más tarde.";

  @override
  String get code200 => "La solicitud fue exitosa";

  @override
  String get code201 => "Se creó un nuevo recurso exitosamente.";

  @override
  String get code202 =>
      "La solicitud fue aceptada para su procesamiento, pero el procesamiento no se ha completado.";

  @override
  String get code301 =>
      "El recurso se ha trasladado permanentemente a una nueva ubicación.";

  @override
  String get code302 =>
      "El recurso se ha trasladado temporalmente a una nueva ubicación.";

  @override
  String get code304 =>
      "El recurso no se ha modificado desde la última solicitud.";

  @override
  String get code400 =>
      "El servidor no pudo entender la solicitud debido a una sintaxis incorrecta.";

  @override
  String get code401 => "La solicitud requiere autenticación del usuario.";

  @override
  String get code403 =>
      "El servidor entendió la solicitud, pero se niega a cumplirla.";

  @override
  String get code404 => "No se pudo encontrar el recurso solicitado.";

  @override
  String get code405 =>
      "El método especificado en la solicitud no está permitido para el recurso solicitado.";

  @override
  String get code409 =>
      "La solicitud no se pudo completar debido a un conflicto con el estado actual del recurso.";

  @override
  String get code500 =>
      "El servidor encontró una condición inesperada que le impidió cumplir con la solicitud.";

  @override
  String get code503 =>
      "El servidor no puede procesar la solicitud en estos momentos.";

  @override
  String get backendPromptInputEx =>
      'Ejemplo: «Eres asistente de redacción y tu tarea es generar automáticamente artículos excelentes basados ​​en el contenido que te proporciono».';
  @override
  String get aiAssistantPrompt => 'Aviso del asistente de IA';
  @override
  String get aiModels => 'Modelos de IA';
  @override
  @override
  String get mostPowerfulAiModel => 'El modelo de IA más potente';
  @override
  String get moreHumanlyResponses => 'Respuestas más humanas';
  @override
  String get create => 'Crear';
  @override
  String get pleaseEnterPrompt => 'Por favor, introduzca el mensaje';
  @override
  String get pleaseSelectImage => 'Por favor seleccione imagen';
  @override
  String get retry => 'Intentar otra vez';
  @override
  String get deleteAssistant => 'Asistente de eliminación';
  @override
  String get deleteAssistantDesc =>
      '¿Estás seguro de que deseas eliminar este asistente?';

  @override
  String get deepseek => throw UnimplementedError();

  @override
  String get deepseekIsAnInnovativeAITechnology => throw UnimplementedError();
}
