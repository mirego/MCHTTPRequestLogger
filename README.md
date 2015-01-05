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

## Disabling the logging service for a specific HTTP request

Add the `MCHTTPRequestLoggerDefaultHeaderIgnore` HTTP header to the NSMutableURLRequest like this:
```objc
[request addValue:@"YES" forHTTPHeaderField:MCHTTPRequestLoggerDefaultHeaderIgnore];
```
The value for the header is not important. To disable the logging, MCHTTPRequestLogger search only the presence of the header.

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

MCHTTPRequestLogger is © 2013-2015 [Mirego](http://www.mirego.com) and may be freely
distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause).
See the [`LICENSE.md`](https://github.com/mirego/MCHTTPRequestLogger/blob/master/LICENSE.md) file.

## About Mirego

[Mirego](http://mirego.com) is a team of passionate people who believe that work is a place where you can innovate and have fun. We're a team of [talented people](http://life.mirego.com) who imagine and build beautiful Web and mobile applications. We come together to share ideas and [change the world](http://mirego.org).

We also [love open-source software](http://open.mirego.com) and we try to give back to the community as much as we can.
