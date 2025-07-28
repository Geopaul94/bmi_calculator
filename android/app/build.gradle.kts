plugins {
    id("com.android.application")
    id("kotlin-android")
    // The Flutter Gradle Plugin must be applied after the Android and Kotlin Gradle plugins.
    id("dev.flutter.flutter-gradle-plugin")
}

import java.util.Properties
import java.io.FileInputStream

val keystoreProperties = Properties()
val keystorePropertiesFile = rootProject.file("key.properties")
if (keystorePropertiesFile.exists()) {
    keystoreProperties.load(FileInputStream(keystorePropertiesFile))
}

android {
    namespace = "com.geo.bmi_calculator"
    compileSdk = flutter.compileSdkVersion
    ndkVersion = flutter.ndkVersion

    compileOptions {
        sourceCompatibility = JavaVersion.VERSION_11
        targetCompatibility = JavaVersion.VERSION_11
        isCoreLibraryDesugaringEnabled = true
    }

    kotlinOptions {
        jvmTarget = JavaVersion.VERSION_11.toString()
    }

    defaultConfig {
        applicationId = "com.geo.bmi_calculator"
        minSdk = 21 // Optimized for modern devices
        targetSdk = flutter.targetSdkVersion
        versionCode = flutter.versionCode
        versionName = flutter.versionName
        
        // Enable multidex if needed
        multiDexEnabled = true
        
        // Disable unnecessary build features
        vectorDrawables.useSupportLibrary = true
    }

    signingConfigs {
        create("release") {
            if (keystorePropertiesFile.exists()) {
                keyAlias = keystoreProperties["keyAlias"] as String
                keyPassword = keystoreProperties["keyPassword"] as String
                storeFile = file(keystoreProperties["storeFile"] as String)
                storePassword = keystoreProperties["storePassword"] as String
            }
        }
    }

    buildTypes {
        release {
            // MAXIMUM OPTIMIZATION FOR PLAY STORE
            isMinifyEnabled = true                    // Enable ProGuard code shrinking
            isShrinkResources = true                 // Remove unused resources (CRITICAL)
            
            // Use maximum optimization ProGuard rules
            proguardFiles(
                getDefaultProguardFile("proguard-android-optimize.txt"),
                "proguard-rules.pro"
            )
            
            // Disable all debugging features for maximum performance
            isDebuggable = false
            isJniDebuggable = false
            isPseudoLocalesEnabled = false
            
            // Optimize resources for maximum compression
            isCrunchPngs = true                      // Compress PNG files
            
            // Use release signing config
            signingConfig = signingConfigs.getByName("release")
        }
        
        debug {
            isMinifyEnabled = false
            isShrinkResources = false
            isDebuggable = true
            applicationIdSuffix = ".debug"
            versionNameSuffix = "-debug"
        }
    }

    // Enable ABI splits for much smaller individual APKs
    splits {
        abi {
            isEnable = true
            reset()
            include("arm64-v8a", "armeabi-v7a")
            isUniversalApk = false
        }
    }



    // Optimize build features
    buildFeatures {
        buildConfig = true
        aidl = false
        renderScript = false
        shaders = false
        compose = false
        mlModelBinding = false
        prefab = false
        viewBinding = false
        dataBinding = false
    }

    // Lint optimizations
    lint {
        checkReleaseBuilds = false
        abortOnError = false
        disable.addAll(listOf("VectorPath", "UnusedResources"))
    }

    // MAXIMUM PACKAGING OPTIMIZATIONS FOR SMALLEST AAB
    packaging {
        resources {
            excludes += listOf(
                "META-INF/DEPENDENCIES",
                "META-INF/LICENSE*",
                "META-INF/NOTICE*",
                "META-INF/*.kotlin_module",
                "META-INF/*.version",
                "META-INF/maven/**",
                "META-INF/services/**",
                "kotlin/**",
                "**/*.txt",
                "**/*.xml",
                "**/*.properties",
                "**/*.version",
                "**/*.git*",
                "**/LICENSE*",
                "**/NOTICE*",
                "**/README*",
                "**/CHANGELOG*",
                "**/COPYING*",
                "**/COPYRIGHT*",
                "**/AUTHORS*",
                "**/CONTRIBUTORS*",
                "**/DEPENDENCIES*"
            )
        }
        jniLibs {
            useLegacyPackaging = false
            excludes += listOf(
                "**/libc++_shared.so",
                "**/libjsc.so",
                "**/libfbjni.so",
                "**/libfolly_runtime.so",
                "**/libreactnativejni.so",
                "**/libturbomodulejsijni.so",
                "**/libyoga.so"
            )
        }
        dex {
            useLegacyPackaging = false
        }
    }

    // MAXIMUM AAB OPTIMIZATIONS FOR PLAY STORE
    bundle {
        language {
            enableSplit = true
        }
        density {
            enableSplit = true
        }
        abi {
            enableSplit = true
        }
        // Enable all possible splits for maximum size reduction
        texture {
            enableSplit = true
        }
    }


}

dependencies {
    // Required for Java 8+ features on older Android versions
    coreLibraryDesugaring("com.android.tools:desugar_jdk_libs:2.1.2")
}

flutter {
    source = "../.."
}