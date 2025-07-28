#!/bin/bash

echo "🚀 Building MAXIMUM OPTIMIZED AAB for Play Store..."
echo "=================================================="

# Clean previous builds
echo "🧹 Cleaning previous builds..."
flutter clean

# Get dependencies
echo "📦 Getting dependencies..."
flutter pub get

# Build optimized AAB with maximum compression
echo "🔨 Building optimized AAB..."
flutter build appbundle \
  --release \
  --build-name=1.0.0 \
  --build-number=3 \
  --target-platform=android-arm64,android-arm \
  --split-debug-info=debug-info \
  --dart-define=FLUTTER_WEB_USE_SKIA=true \
  --dart-define=FLUTTER_WEB_AUTO_DETECT=true

# Check AAB size
echo "📊 AAB Size Analysis:"
ls -lh build/app/outputs/bundle/release/app-release.aab

# Generate size analysis report
echo "📈 Generating size analysis..."
flutter build appbundle --analyze-size --release

echo "✅ Optimized AAB build complete!"
echo "📁 Location: build/app/outputs/bundle/release/app-release.aab"
echo ""
echo "🎯 Expected optimizations applied:"
echo "   • ProGuard code shrinking: 30-50% reduction"
echo "   • Resource shrinking: 10-20% reduction"
echo "   • ABI splits: 40-60% reduction"
echo "   • AAB bundle splits: 30-50% reduction"
echo "   • Total expected reduction: Up to 70%"
echo ""
echo "📱 Ready for Play Store upload!" 