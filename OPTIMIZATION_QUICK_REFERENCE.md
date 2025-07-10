# Android App Optimization - Quick Reference

## 🚀 Essential Commands

### Build AAB (Recommended)
```bash
flutter build appbundle --release
```

### Build with Size Analysis
```bash
flutter build appbundle --analyze-size
```

### Test AAB Locally
```bash
# Download bundletool first
java -jar bundletool.jar build-apks --bundle=app-release.aab --output=app.apks
java -jar bundletool.jar install-apks --apks=app.apks
```

### Performance Testing
```bash
flutter run --profile  # For performance testing
flutter run --release  # For final testing
```

---

## ⚙️ Key build.gradle.kts Settings

```kotlin
buildTypes {
    release {
        isMinifyEnabled = true           // Enable ProGuard
        isShrinkResources = true        // Remove unused resources
        isCrunchPngs = true            // Optimize images
        
        proguardFiles(
            getDefaultProguardFile("proguard-android-optimize.txt"),
            "proguard-rules.pro"
        )
    }
}

// ABI splits for smaller downloads
splits {
    abi {
        isEnable = true
        include("arm64-v8a", "armeabi-v7a")
        isUniversalApk = false
    }
}

// AAB optimizations
bundle {
    language { enableSplit = true }
    density { enableSplit = true }
    abi { enableSplit = true }
}
```

---

## 🛡️ Essential ProGuard Rules

```proguard
# Flutter core
-keep class io.flutter.** { *; }
-keep class io.flutter.plugins.** { *; }

# Remove logging
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
}

# Your app (replace package name)
-keep class com.yourcompany.yourapp.MainActivity { *; }

# Aggressive optimization
-optimizationpasses 5
-allowaccessmodification
```

---

## 📦 Size Reduction Checklist

- [ ] ✅ Enable ProGuard (`isMinifyEnabled = true`)
- [ ] ✅ Enable resource shrinking (`isShrinkResources = true`)
- [ ] ✅ Use ABI splits
- [ ] ✅ Enable AAB bundle splits
- [ ] ✅ Remove unused dependencies
- [ ] ✅ Optimize images (WebP format)
- [ ] ✅ Remove debug logging
- [ ] ✅ Use specific asset paths
- [ ] ✅ Create signed release build

---

## 🎯 Expected Results

| Optimization | Size Reduction |
|--------------|----------------|
| ProGuard | 30-50% |
| Resource Shrinking | 10-20% |
| ABI Splits | 40-60% |
| AAB vs APK | 30-50% |
| **Total Possible** | **Up to 70%** |

---

## 🐛 Common Issues & Quick Fixes

**Build fails after ProGuard**
```proguard
-keep class com.yourpackage.** { *; }
```

**Plugin not found**
```proguard
-keep class io.flutter.plugins.** { *; }
```

**Missing classes at runtime**
```proguard
-keep class * extends java.lang.annotation.Annotation { *; }
-keepattributes *Annotation*
```

**Large AAB size**
- Check all bundle splits are enabled
- Remove unused dependencies with `flutter pub deps`
- Optimize images before adding to assets

---

## 📱 Testing Workflow

1. **Development**: `flutter run --debug`
2. **Performance**: `flutter run --profile`
3. **Release Test**: `flutter run --release`
4. **AAB Build**: `flutter build appbundle --release`
5. **Size Analysis**: `flutter build appbundle --analyze-size`
6. **Local Test**: Use bundletool to test AAB

---

## 🔧 Gradle Properties for Faster Builds

Add to `gradle.properties`:
```properties
org.gradle.daemon=true
org.gradle.parallel=true
org.gradle.caching=true
android.enableBuildCache=true
```

---

*Keep this reference handy while implementing optimizations!* 