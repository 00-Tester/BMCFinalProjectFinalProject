import java.io.FileInputStream
import java.util.Properties

fun getProperty(key: String, defaultValue: String = ""): String {
    val propFile = project.rootProject.file("key.properties")
    if (propFile.exists()) {
        val properties = Properties()
        properties.load(FileInputStream(propFile))
        return properties.getProperty(key) ?: defaultValue
    }
    return defaultValue
}

plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
    kotlin("android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

android {
    namespace = "com.example.ecommerce_app"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.example.ecommerce_app"
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

    // --- START: RELEASE SIGNING CONFIGURATION ---
    signingConfigs {
        create("release") {
            // Load credentials from the key.properties file using the helper function
            keyAlias = getProperty("keyAlias")
            keyPassword = getProperty("keyPassword")
            storeFile = file(getProperty("storeFile"))
            storePassword = getProperty("storePassword")
        }
    }
    // --- END: RELEASE SIGNING CONFIGURATION ---

    buildTypes {
        release {
            // Assign the new release signing configuration instead of the debug one
            signingConfig = signingConfigs.getByName("release")
            isMinifyEnabled = true
            proguardFiles(getDefaultProguardFile("proguard-android-optimize.txt"), "proguard-rules.pro")
        }
    }
}

flutter {
    source = "../.."
}