![](https://img.shields.io/badge/swift-5.1-orange.svg)
![](https://img.shields.io/github/release/netguru/ar-localizer-view-ios.svg)
![](https://img.shields.io/badge/carthage-compatible-green.svg)
![](https://img.shields.io/badge/cocoapods-compatible-green.svg)

# ARLocalizerView iOS

Welcome to the ARLocalizerView for iOS project. It's a lightweight and simple AR view made for displaying chosen locations distances on a camera preview.

## Features

- [x] Displays labels showing direction from user to POIs.
- [x] Lightweight and easy to use.
- [x] Uses basic data from device's sensors to work on as wide range of iDevices as possible.
- [x] Easily customizable labels and POI provider. Check out Sample app's custom implementations to learn how to customize them yourself :).
- [x] Built in data conversion method with `Command` wrapper.

##  Displaying AR view:

Here is the simplest way to show an AR view:

1. Instantiate the provider of you POIs. You can use example FilePOIProvider that fetches json files or implement your own using POIProvider protocol.
2. Instantiate AR view controller using the POI provider and label view type. You can use example SimplePOILabelView or implement your own using POILabelView protocol.
3. Present the AR view controller.

Here is example implementation in AppDelegate's applicationDidFinishLaunching method:

```swift
// 1:
let poiProvider = FilePOIProvider(fileURL: #url-to-your-json-file#)

// 2:
let arViewController = ARViewController(
		viewModel: ARViewModel(poiProvider: poiProvider),
    poiLabelViewType: SimplePOILabelView.self
)

// 3:
window = UIWindow(frame: UIScreen.main.bounds)
window?.rootViewController = arViewController
window?.makeKeyAndVisible()
```

## 🛠 Dependency management:

ARLocalizerView can be drag'n dropped to the project directory,<br/>
but what's more important it's supported by most common dependency management!

### ![](https://img.shields.io/badge/cocoapods-compatible-green.svg)

Just drop the line below to your Podfile:

`pod 'ARLocalizerView'`

(but probably you'd like to pin it to the nearest major release, so `pod 'ARLocalizerView' , '~> 1.0.0'`)

### ![](https://img.shields.io/badge/carthage-compatible-green.svg)

The same as with Cocoapods, insert the line below to your Cartfile:

`github 'netguru/ar-localizer-view-ios'`

, or including version - `github 'netguru/ar-localizer-view-ios' ~> 1.0.0`

## 📄 License

(As all cool open source software, it's...)<br/>
Licensed under MIT license.<br/>

## Related repositories

- [ar-localizer-view-android](https://github.com/netguru/ar-localizer-view-android)
