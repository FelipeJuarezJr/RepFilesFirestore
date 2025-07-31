#!/bin/bash

# RepFiles Flutter Build Script
# This script helps build the app for different platforms

echo "🐉 RepFiles Flutter Build Script"
echo "=================================="

# Function to build for web
build_web() {
    echo "🌐 Building for Web..."
    flutter build web --release
    echo "✅ Web build completed!"
    echo "📁 Output: build/web/"
}

# Function to build for Android
build_android() {
    echo "🤖 Building for Android..."
    flutter build apk --release
    echo "✅ Android build completed!"
    echo "📁 Output: build/app/outputs/flutter-apk/app-release.apk"
}

# Function to build for iOS
build_ios() {
    echo "🍎 Building for iOS..."
    flutter build ios --release
    echo "✅ iOS build completed!"
    echo "📁 Output: build/ios/archive/"
}

# Function to build for all platforms
build_all() {
    echo "🚀 Building for all platforms..."
    build_web
    build_android
    build_ios
    echo "🎉 All builds completed!"
}

# Function to clean builds
clean() {
    echo "🧹 Cleaning build files..."
    flutter clean
    flutter pub get
    echo "✅ Clean completed!"
}

# Function to show help
show_help() {
    echo "Usage: $0 [OPTION]"
    echo ""
    echo "Options:"
    echo "  web     - Build for web"
    echo "  android - Build for Android"
    echo "  ios     - Build for iOS"
    echo "  all     - Build for all platforms"
    echo "  clean   - Clean build files"
    echo "  help    - Show this help message"
    echo ""
    echo "Examples:"
    echo "  $0 web     # Build for web only"
    echo "  $0 android # Build for Android only"
    echo "  $0 all     # Build for all platforms"
}

# Check if Flutter is installed
if ! command -v flutter &> /dev/null; then
    echo "❌ Flutter is not installed or not in PATH"
    echo "Please install Flutter from: https://flutter.dev/docs/get-started/install"
    exit 1
fi

# Check Flutter version
echo "📱 Flutter version: $(flutter --version | head -n 1)"
echo ""

# Parse command line arguments
case "${1:-help}" in
    "web")
        build_web
        ;;
    "android")
        build_android
        ;;
    "ios")
        build_ios
        ;;
    "all")
        build_all
        ;;
    "clean")
        clean
        ;;
    "help"|*)
        show_help
        ;;
esac 