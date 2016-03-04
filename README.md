# GTToast

[![CI Status](http://img.shields.io/travis/gregttn/GTToast.svg?style=flat)](https://travis-ci.org/gregttn/GTToast)
[![Version](https://img.shields.io/cocoapods/v/GTToast.svg?style=flat)](http://cocoapods.org/pods/GTToast)
[![License](https://img.shields.io/cocoapods/l/GTToast.svg?style=flat)](http://cocoapods.org/pods/GTToast)
[![Platform](https://img.shields.io/cocoapods/p/GTToast.svg?style=flat)](http://cocoapods.org/pods/GTToast)

GTToast is a library written in Swift which allows toast notifcations to be displayed. You can create toasts with text and/or images.
There are many options available to allow you to adapt look and feel of the toast messages to your app.

![Preview](https://raw.githubusercontent.com/gregttn/GTToast/master/sample.gif)

## Usage

There are multiple ways you can display toast message:

* Simple toast

```swift
GTToast.create("your message").show()
```
This will create and show toast with default settings and your message

* Simple toast with image

```swift
GTToast.create("your message", image: yourImage).show()
```

This will create and show toast with your message and image displayed on the left.

* Custom toast

```swift
GTToast.create("your message", config: GTToastConfig(), image: yourImage).show()
```

This will create and show toast with message and custom config. You can find all properties of GTToastConfig below

* All toasts with the same configuration

You can specify global configuration for all of your toast.

```swift
let config: GTToastConfig = GTToastConfig()
let toastFactory: GTToast = GTToast(config: config)
toastFactory.create("your message").show()
toastFactory.create("your message", image: smallImage).show()
```

* Dismiss a toast

It is possible to force toast to disappear. In order to do that you will need to keep the reference to GTToastView

```swift
var toast: GTToastView = GTToast.create("foo bar")
toast.show()

// later when you are ready
toast.dismiss()
```

## Configuration

You can use GTToastConfig to configure the look of the toast. Here is a list of all possible configuration options that can be specified:

* contentInsets: UIEdgeInsets

Allows you to specify the padding of the toast. Default: *UIEdgeInsets(top: 3.0, left: 3.0, bottom: 3.0, right: 3.0)*

* cornerRadius: CGFloat

The corner radius of the toast. Default 3.0

* font: UIFont

Font used to render the text message. Default: *UIFont.systemFontOfSize(12.0)*

* textColor: UIColor

Text color of the message. Default: *UIColor.whiteColor()*

* textAlignment: NSTextAlignment

Alignment of the text. Default: *NSTextAlignment.Center*

* backgroundColor: UIColor

Background color of the toast. Default: *UIColor.blackColor().colorWithAlphaComponent(0.8)*

* animation: GTToastAnimation

The animation type to be used when displaying and hidding the toast. Default: *GTToastAnimation.BottomSlideIn* (see below for full list)

* displayInterval: NSTimeInterval

The amount of time the toast will be displayed for: Default: 4

* bottomMargin: CGFloat

Bottom margin of the toast. Default: 5

* imageMargins: UIEdgeInsets

The margins of the image displayed in the toast. Default: *UIEdgeInsets(top: 0, left: 0, bottom: 0, right: 0)*


* imageAlignment: GTToastAlignment

Allows you to specify where image should be displayed (Top, Bottom, Left or Right). Default: *GTToastAlignment.Left*

* maxImageSize: CGSize

Specifes the max image size. The width property is only into account when image is located on the Right or Left. Similarly, the height is only applied when image in Top or Bottom. Default: *CGSize(width: 100, height: 200)*

You can specify all of the above by creating GTToastConfig

```swift
GTToastConfig(
    contentInsets: UIEdgeInsets(top:10, left: 9, bottom: 8, right: 7),
    cornerRadius: 8.0,
    font: UIFont.systemFontOfSize(100),
    textColor: UIColor.redColor(),
    textAlignment: NSTextAlignment.Right,
    backgroundColor: UIColor.blueColor().colorWithAlphaComponent(0.8),
    animation: GTToastAnimation.Scale,
    displayInterval: 2,
    bottomMargin: 15.0,
    imageMargins: UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10),
    imageAlignment: GTToastAlignment.Top,
    maxImageSize: CGSizeMake(100,100)
)
```

Only the properties that you want to change can be provided. No need for all of them.

## GTToastAnimation options

GTToastAnimation hold predefined list of animations that can be used for displaying the toast

* Alpha
* Scale
* BottomSlideIn
* LeftSlideIn
* RightSlideIn
* LeftInRightOut
* RightInLeftOut

## Requirements

This control is written in Swift 2. You will need at least Xcode 7.
Also this project uses CocoaPods.

## Installation

Install GTToast by using [CocoaPods](http://cocoapods.org). Include the following in your Podfile:

```ruby
use_frameworks!
pod 'GTToast'
```

## Running the project

After cloning the project you will need to run 'pod update' in the Example directory.
To view in Xcode open the GTToast.xcworkspace which is located in the Example directory.

## Author

Grzegorz Tatarzyn, gregttn@gmail.com

## License

GTToast is available under the MIT license.
