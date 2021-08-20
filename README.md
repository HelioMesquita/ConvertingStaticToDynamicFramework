# StaticToDynamicFramework  

Using static libraries can be a problem when you are creating awesome products that depends on it. This steps and articles can help if you are having the same issues about encapsulation/using static libraries to distribute them dynamically.  

Steps  

1. Open iOSKruxLibUniversal.framework 
2. Copy Binary
3. Copy Headers and let them public
4. Add other link flags “-all_load”
    1. This with fail to compile, because it is missing libraries when compile, then add:
        1. AdSupport
        2. Foundation
        3. SystemConfiguration
        4. AppTrackingTransparenci
        5. UIKit
5. I used this simple approach to generate the fat binary (https://medium.com/@hassanahmedkhan/a-noobs-guide-to-creating-a-fat-library-for-ios-bafe8452b84b)
6. Add Framework inside a test project
    1. This will compile, but when run will be missing a library because it came as static
    2. Change the framework to embed
7. Enjoy :) 

Observation: I opened the binary because I cannot let a public header from static framework 

Articles used to learn about this theme
https://medium.com/@hassanahmedkhan/a-noobs-guide-to-creating-a-fat-library-for-ios-bafe8452b84b

https://konsole.zendesk.com/hc/en-us/articles/219986988-iOS-SDK-Implementation-Guide

https://pewpewthespells.com/blog/convert_static_to_dynamic.html

https://developer.apple.com/library/archive/qa/qa1490/_index.html

https://medium.com/5-minute-break-while-coding/creating-swift-framework-with-private-objective-c-members-the-good-the-bad-and-the-ugly-4d726386644b

https://web.archive.org/web/20200213075206/http:/nsomar.com/modular-framework-creating-and-using-them/
