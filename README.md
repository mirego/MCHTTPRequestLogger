
# MCHTTPRequestLogger

`MCHTTPRequestLogger` is an extension to [AFNetworking](http://github.com/AFNetworking/AFNetworking/) that logs every requests and responses as they are sent and received. It is a lot more verbose than [AFHTTPRequestOperationLogger](http://github.com/AFNetworking/AFHTTPRequestOperationLogger/), by design.

## Example Usage

Just add the following code to your `UIApplicationDelegate`, in the method `-application:didFinishLaunchingWithOptions:` and you should see extensive information for each requests/responses in your Xcode console.
```objc
[[MCHTTPRequestLogger sharedLogger] startLogging];
```


## Important Notes

- This code has been known to work on iOS 5.x+.
- This code uses **Automatic Reference Counting**, if your project does not use ARC, you must add the `-fobjc-arc` compiler flag to each implementation files in `Target Settings > Build Phases > Compile Source`.
- This code also uses the **literals syntax**, so at least Xcode 4.5 is required.



## License

MCHTTPRequestLogger is © 2012 [Mirego, Inc.](http://www.mirego.com) and may be freely distributed under the [New BSD license](http://opensource.org/licenses/BSD-3-Clause). See the `LICENSE` file.
