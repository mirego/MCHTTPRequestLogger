# MCHTTPRequestLogger - Output HTTP requests made with AFNetworking in the debug console.
[![Badge w/ Version](https://cocoapod-badges.herokuapp.com/v/MCHTTPRequestLogger/badge.png)](https://cocoadocs.org/docsets/MCHTTPRequestLogger)
[![Badge w/ Platform](https://cocoapod-badges.herokuapp.com/p/MCHTTPRequestLogger/badge.png)](https://cocoadocs.org/docsets/MCHTTPRequestLogger)

`MCHTTPRequestLogger` is an extension to [AFNetworking](http://github.com/AFNetworking/AFNetworking/) that logs every requests and responses as they are sent and received. It is a lot more verbose than [AFHTTPRequestOperationLogger](http://github.com/AFNetworking/AFHTTPRequestOperationLogger/), by design.

## Example Usage

Just add the following code to your `UIApplicationDelegate`, in the method `-application:didFinishLaunchingWithOptions:` and you should see extensive information for each requests/responses in your Xcode console.
```objc
[[MCHTTPRequestLogger sharedLogger] startLogging];
// Set the JSONOutputStyle property to have pretty printed JSON output
[[MCHTTPRequestLogger sharedLogger] setJSONOutputStyle:MCHTTPRequestLoggerJSONOutputStylePrettyPrinted];
```

## Important Notes

- This code has been known to work on iOS 5.x+.
- This code uses **Automatic Reference Counting**, if your project does not use ARC, you must add the `-fobjc-arc` compiler flag to each implementation files in `Target Settings > Build Phases > Compile Source`.
- This code also uses the **literals syntax**, so at least Xcode 4.5 is required.

## Adding to your project

If you're using [`CocoaPods`](http://cocoapods.org/), there's nothing simpler.
Add the following to your [`Podfile`](http://docs.cocoapods.org/podfile.html)
and run `pod install`

```
pod 'MCHTTPRequestLogger'
```

Don't forget to `#import "MCHTTPRequestLogger.h"` where it's needed.

## License

MCHTTPRequestLogger is © 2013 [Mirego](http://www.mirego.com) and may be freely
distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause).
See the [`LICENSE.md`](https://github.com/mirego/MCHTTPRequestLogger/blob/master/LICENSE.md) file.

## About Mirego

Mirego is a team of passionate people who believe that work is a place where you can innovate and have fun. We proudly build mobile applications for [iPhone](http://mirego.com/en/iphone-app-development/ "iPhone application development"), [iPad](http://mirego.com/en/ipad-app-development/ "iPad application development"), [Android](http://mirego.com/en/android-app-development/ "Android application development"), [Blackberry](http://mirego.com/en/blackberry-app-development/ "Blackberry application development"), [Windows Phone](http://mirego.com/en/windows-phone-app-development/ "Windows Phone application development") and [Windows 8](http://mirego.com/en/windows-8-app-development/ "Windows 8 application development") in beautiful Quebec City.

We also love [open-source software](http://open.mirego.com/) and we try to extract as much code as possible from our projects to give back to the community.
