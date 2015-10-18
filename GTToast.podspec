#
# Be sure to run `pod lib lint GTToast.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GTToast"
  s.version          = "0.1.0"
  s.summary          = "GTToast is a library written in Swift which allows toast notifcations to be displayed. You can create toasts with text and/or images."
  s.description      = "GTToast is a library written in Swift which allows toast notifcations to be displayed. You can create toasts with text and/or images. There are many options available to allow you to adapt look and feel of the toast messages to your app."

  s.homepage         = "https://github.com/gregttn/GTToast"
  s.license          = 'MIT'
  s.author           = { "gregttn" => "gregttn@gmail.com" }
  s.source           = { :git => "https://github.com/gregttn/GTToast.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/gregttn'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'GTToast' => ['Pod/Assets/*.png']
  }

  s.frameworks = 'UIKit'
end
