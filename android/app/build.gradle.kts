plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    id("com.google.firebase.crashlytics")
    // END: FlutterFire Configuration
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.aichatsy.app"
    compileSdk = 36
    ndkVersion = "27.0.12077973"

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_17
        targetCompatibility = JavaVersion.VERSION_17
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_17.toString()
    }

    defaultConfig {
        applicationId = "com.aichatsy.app"
        multiDexEnabled = true
        minSdk = 24
        targetSdk = 36
        versionCode = 108
        versionName = "1.3.7"
    }

    signingConfigs {
        create("release") {
            storeFile = file("../jks/aichatsy_jks.jks")
            keyAlias = "aichatsy"
            keyPassword = "Aichatsy@1234"
            storePassword = "Aichatsy@1234"
        }
    }

    buildTypes {
        release {
            isMinifyEnabled = false
            isShrinkResources = false
            signingConfig = signingConfigs.getByName("release")
        }
    }
}

flutter {
    source = "../.."
}

dependencies {
    // Core library desugaring
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.4")

    // Kotlin standard library
    implementation("org.jetbrains.kotlin:kotlin-stdlib-jdk7:2.0.20") // Updated to latest Kotlin version

    // Firebase BOM (Bill of Materials)
    implementation(platform("com.google.firebase:firebase-bom:33.12.0"))
    implementation("com.google.firebase:firebase-perf")
    implementation("com.google.firebase:firebase-analytics-ktx")
    implementation("com.google.firebase:firebase-crashlytics-ktx")

    // Facebook SDK
    implementation("com.facebook.android:facebook-android-sdk:18.0.0") // Latest as of 2025

    // AppsFlyer SDK
    implementation("com.appsflyer:af-android-sdk:6.15.2")
    // Commented out as in original
    // implementation("com.appsflyer:af-android-sdk:HERE_LATEST_VERSION")

    // Google Play In-App Review
    implementation("com.google.android.play:review:2.0.2")
    implementation("com.google.android.play:review-ktx:2.0.2")

    // Install Referrer
    implementation("com.android.installreferrer:installreferrer:2.2")

    // Multidex support
    implementation("androidx.multidex:multidex:2.0.1") // Updated to androidx

    // Appvestor dependencies
    val appvestorStatsVersion = "1.2.0.170"
    implementation("com.appvestor.android:stats:$appvestorStatsVersion")

    val appvestorBillingVersion = "1.2.0.170"
    implementation("com.appvestor.android:billing-stats:$appvestorBillingVersion")

    implementation("com.android.billingclient:billing:7.0.0")
}