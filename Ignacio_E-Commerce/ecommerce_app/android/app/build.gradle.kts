<<<<<<< HEAD
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

=======
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
plugins {
    id("com.android.application")
    // START: FlutterFire Configuration
    id("com.google.gms.google-services")
    // END: FlutterFire Configuration
<<<<<<< HEAD
    kotlin("android")
=======
    id("kotlin-android")
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
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
<<<<<<< HEAD
        applicationId = "com.example.ecommerce_app"
=======
        // TODO: Specify your own unique Application ID (https://developer.android.com/studio/build/application-id.html).
        applicationId = "com.example.ecommerce_app"
        // You can update the following values to match your application needs.
        // For more information, see: https://flutter.dev/to/review-gradle-config.
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
        minSdk = flutter.minSdkVersion
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
    }

<<<<<<< HEAD
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
=======
    buildTypes {
        release {
            // TODO: Add your own signing config for the release build.
            // Signing with the debug keys for now, so `flutter run --release` works.
            signingConfig = signingConfigs.getByName("debug")
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
        }
    }
}

flutter {
    source = "../.."
<<<<<<< HEAD
}
=======
}
>>>>>>> daaf3ff007918d1d46173cf43c1035b9099f5f42
