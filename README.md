# iOS SDK for Whereby Embedded

This repository contains the distribution files of the Whereby SDK framework and its dependencies. You will find the complete running examples using the SDK in our [demo app repository](https://github.com/whereby/ios-sdk-demo).

*Be informed that this is a beta version of the framework. For any comments, suggestions or questions, please reach out to our customer support: embedded@whereby.com*.

Other platforms: 
- [Android SDK](https://github.com/whereby/android-sdk)
- [Browser SDK](https://github.com/whereby/browser-sdk)

## Prerequisites
- The latest stable version of [Xcode](https://apps.apple.com/us/app/xcode/id497799835)
- The latest stable version of [CocoaPods](https://cocoapods.org/)
- Sign up to [Whereby Embedded](https://whereby.com/information/embedded/) account
- [Create a room](https://docs.whereby.com/creating-and-deleting-rooms) in your Whereby Embedded account

Whereby SDK supports iOS 14.0 as minimum deployment target.

## Installation
### Using CocoaPods

1. Add the following line to your project's Podfile:
```
pod 'WherebySDK'
```

Your Podfile should look like this:
```
platform :ios, '14.0'

target 'TargetName' do
  use_frameworks!
  pod 'WherebySDK'
end
```

2. In the Terminal, navigate to the directory containing your Podfile and run:
```
pod install
```
### Manual installation

We recommend using CocoaPods dependency manager to install Whereby SDK. Alternatively, it's also possible to add the SDK to your project manually:
1. Clone this repository:
```
git clone https://github.com/whereby/ios-sdk.git
```

2. Copy `WherebySDK.xcframework`, `WebRTC.xcframework`, `mediasoup_client_ios.xcframework` from the repository to your project directory next to your `.xcodeproj` file

3. In Xcode select your project file and then your app's target. In the target settings select the General tab. Drag the newly copied `WherebySDK.xcframework`, `WebRTC.xcframework`, `mediasoup_client_ios.xcframework` frameworks into the Frameworks, Libraries, and Embedded Content section of your target.
## Project setup

After adding the Whereby SDK follow the next steps to set up your project:

1. Add the camera and microphone usage descriptions. Both descriptions are user-facing messages that will be displayed in the standard system permission prompt in your app. You can provide your own messages that better describe the purpose for your app. In your app's `Info.plist` add the following keys and values:

   **Privacy - Camera Usage Description** (`NSCameraUsageDescription`): _Allow camera access so that other people can see you during meetings._

   **Privacy - Microphone Usage Description** (`NSMicrophoneUsageDescription`): _Allow microphone access so that other people can hear you during meetings._

   For more details see [Requesting Authorization for Media Capture on iOS](https://developer.apple.com/documentation/avfoundation/capture_setup/requesting_authorization_for_media_capture_on_ios) (note that you don't need to use `AVCaptureDevice` API in your code, this is done by Whereby SDK).

2. Add the audio and voice over IP background execution modes. In Xcode select your project file and then your app's target. In the target settings select the Signing & Capabilities tab. Add the Background Modes capability by clicking the "+" button in the top left corner. After adding the capability select the following values in the Background Modes section using the corresponding checkboxes:
   - Audio, AirPlay, and Picture in Picture
   - Voice over IP

   For more details see [Configuring background execution modes](https://developer.apple.com/documentation/xcode/configuring-background-execution-modes).

3. Disable Bitcode for your app's target. In Xcode select your project file and then your app's target. In the target settings select the Build Settings tab. Search for **Enable Bitcode** setting (`ENABLE_BITCODE`) and set its value to **No**.