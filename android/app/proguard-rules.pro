# Flutter wrapper
-keep class io.flutter.app.** { *; }
-keep class io.flutter.plugin.**  { *; }
-keep class io.flutter.util.**  { *; }
-keep class io.flutter.view.**  { *; }
-keep class io.flutter.**  { *; }
-keep class io.flutter.plugins.**  { *; }

# Provider package
-keep class * extends com.google.android.material.** { *; }

# Keep native methods
-keepclassmembers class * {
    native <methods>;
}

# Preserve the line number information for debugging stack traces
-keepattributes SourceFile,LineNumberTable

# Hide the original source file name
-renamesourcefileattribute SourceFile

# Remove logging in release builds
-assumenosideeffects class android.util.Log {
    public static boolean isLoggable(java.lang.String, int);
    public static int v(...);
    public static int i(...);
    public static int w(...);
    public static int d(...);
    public static int e(...);
}

# Keep crash reporting
-keepattributes *Annotation*

# Keep generic signature of Call, Response (R8 full mode strips signatures from non-kept items)
-keep,allowobfuscation,allowshrinking interface retrofit2.Call
-keep,allowobfuscation,allowshrinking class retrofit2.Response

# With R8 full mode generic signatures are stripped for classes that are not kept
-keep,allowobfuscation,allowshrinking class kotlin.coroutines.Continuation

# MAXIMUM AGGRESSIVE OPTIMIZATION FOR SMALLEST AAB SIZE
-optimizations !code/simplification/arithmetic,!code/simplification/cast,!field/*,!class/merging/*
-optimizationpasses 8
-allowaccessmodification
-dontusemixedcaseclassnames
-dontskipnonpubliclibraryclasses
-verbose
-dontpreverify
-mergeinterfacesaggressively

# Remove unused resources and code
-keep class **.R$* { *; }

# Remove debug and logging code
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
}

# Remove unused reflection and serialization
-dontwarn java.lang.invoke.**
-dontwarn **$$serializer

# Keep only essential BMI Calculator classes
-keep class com.geo.bmi_calculator.MainActivity { *; }

# Keep essential Flutter classes
-keep class io.flutter.** { *; }
-keep class io.flutter.embedding.** { *; }

# Ignore missing Play Core classes (not used by simple apps)
-dontwarn com.google.android.play.core.**
-dontwarn io.flutter.embedding.engine.deferredcomponents.**

# Keep classes that might be referenced but not used
-keep class * extends io.flutter.embedding.android.FlutterActivity { *; }
-keep class * extends io.flutter.embedding.android.FlutterFragment { *; }

# MAXIMUM SIZE REDUCTION RULES FOR BMI CALCULATOR
# Remove all debug and development code
-assumenosideeffects class android.util.Log {
    public static *** d(...);
    public static *** v(...);
    public static *** i(...);
    public static *** w(...);
    public static *** e(...);
    public static *** wtf(...);
}

# Remove unused reflection and serialization completely
-dontwarn java.lang.invoke.**
-dontwarn **$$serializer
-dontwarn **$$serializerImpl
-dontwarn **$$serializerImpl$*

# Remove unused annotation processing
-dontwarn javax.annotation.**
-dontwarn org.jetbrains.annotations.**

# Aggressive code removal for unused features
-assumenosideeffects class java.io.PrintStream {
    public void println(...);
    public void print(...);
}

# Remove unused string constants
-assumenosideeffects class java.lang.String {
    public static java.lang.String valueOf(...);
}

# Keep only essential BMI Calculator classes - be very specific
-keep class com.geo.bmi_calculator.MainActivity { *; }
-keep class com.geo.bmi_calculator.** { *; }

# Remove all other classes aggressively
-keep class !com.geo.bmi_calculator.** { *; }
-keep class !io.flutter.** { *; } 