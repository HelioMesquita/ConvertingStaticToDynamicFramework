# Converting Static Framework to Dynamic Framework for iOS and Generate .framework or .xcframework

Using static libraries can be a problem when you are creating awesome products that depends on it. This steps and articles can help if you are having the same issues about encapsulation/using static libraries to distribute them dynamically.  

Steps to reproduce this example

1. Open iOSKruxLibUniversal.framework 
2. Copy Binary
3. Copy Headers and let them public
4. Add other link flags ```-all_load```
    1. This with fail to compile, because it is missing libraries when compile, then add:
        1. AdSupport
        2. Foundation
        3. SystemConfiguration
        4. AppTrackingTransparency
        5. UIKit
5. In build settings add ```"EXCLUDED_ARCHS[sdk=iphonesimulator14.2]" = arm64```
6. Create a Aggregate Target
    1. Inside Build Phase add Run Script
    2. Add this script
    ```swift
    SCHEME_NAME="SDKKruxEncapsulation"
    FRAMEWORK_NAME="SDKKruxEncapsulation"
    SIMULATOR_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-iphonesimulator.xcarchive"
    DEVICE_ARCHIVE_PATH="${BUILD_DIR}/${CONFIGURATION}/${FRAMEWORK_NAME}-iphoneos.xcarchive"
    OUTPUT_DIC="./xcframework/"
    # Simulator xcarchieve
    xcodebuild archive \
    -scheme ${SCHEME_NAME} \
    -archivePath ${SIMULATOR_ARCHIVE_PATH} \
    -sdk iphonesimulator \
    SKIP_INSTALL=NO
    # Device xcarchieve
    xcodebuild archive \
    -scheme ${SCHEME_NAME} \
    -archivePath ${DEVICE_ARCHIVE_PATH} \
    -sdk iphoneos \
    SKIP_INSTALL=NO
    # Clean up old output directory
    rm -rf "${OUTPUT_DIC}"
    # Create xcframwork combine of all frameworks
    xcodebuild -create-xcframework \
    -framework ${SIMULATOR_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
    -framework ${DEVICE_ARCHIVE_PATH}/Products/Library/Frameworks/${FRAMEWORK_NAME}.framework \
    -output ${OUTPUT_DIC}/${FRAMEWORK_NAME}.xcframework

    echo ${OUTPUT_DIC}/${FRAMEWORK_NAME}.xcframework
    mv ${OUTPUT_DIC}/${FRAMEWORK_NAME}.xcframework ../
    ```
    3. Remember to fix scheme name and framework name to fit your project
    4. When run, will generate a xcframework at same directory of framework project
6. Add Framework inside a test project
    1. This will compile, but when run will be missing a library because it came as static
    2. Change the framework to embed without signing
    3. There is a sample of Podspec to share your framework
7. Enjoy :) 

Observation: I opened the binary because I cannot let a public header from static framework.

Articles used to learn about this theme  
- https://medium.com/@hassanahmedkhan/a-noobs-guide-to-creating-a-fat-library-for-ios-bafe8452b84b
- https://konsole.zendesk.com/hc/en-us/articles/219986988-iOS-SDK-Implementation-Guide
- https://pewpewthespells.com/blog/convert_static_to_dynamic.html
- https://developer.apple.com/library/archive/qa/qa1490/_index.html
- https://medium.com/5-minute-break-while-coding/creating-swift-framework-with-private-objective-c-members-the-good-the-bad-and-the-ugly-4d726386644b
- https://web.archive.org/web/20200213075206/http:/nsomar.com/modular-framework-creating-and-using-them/
- https://medium.com/@er.mayursharma14/how-to-create-xcframework-855817f854cf

