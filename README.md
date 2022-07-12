# iOS SDK for Whereby Embedded

This repository contains the distribution files of the Whereby SDK framework and its dependencies.

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

3. Disable bitcode. Whereby SDK does not support bitcode and in general it is being deprecated in Xcode 14 (currently in beta, see Apple Clang Compiler, Deprecations section in [Xcode 14 release notes](https://developer.apple.com/documentation/xcode-release-notes/xcode-14-release-notes)). If your app's target enables bitcode then it needs to be disabled. In Xcode select your project file and then your app's target. In the target settings select the Build Settings tab. Search for **Enable Bitcode** setting (`ENABLE_BITCODE`) and set its value to **No**.

## Usage

For the complete example of the SDK usage try our [demo app](https://github.com/whereby/ios-sdk-demo).

`WherebyRoomViewController` is the main element of the SDK. It's a subclass of `UIViewController` that provides the user interface of a Whereby room as well as the API to interact with the room programmatically. Follow these steps to add a Whereby room to your app:

1. Import `WherebySDK` at the top of your file (typically this would be in your `UIViewController` subclass):
    ```swift
    import WherebySDK
    ```

2. Provide the room URL. The room URL would usually be created by your own backend using Whereby API. For more details see [Creating and deleting rooms](https://docs.whereby.com/creating-and-deleting-rooms).
    ```swift
    let roomUrl = URL(string: "https://...")!
    ```

3. Create a `WherebyRoomConfig`:
    ```swift
    let roomConfig = WherebyRoomConfig(url: roomUrl)
    ```

    Optionally, set configuration parameters to customize the room:
    ```swift
    roomConfig.mediaMode = .audioOnly
    ```

4. Create a `WherebyRoomViewController`. If you intend to push the room view controller in the existing `UINavigationController` in your app, pass `isPushedInNavigationController: true`. Otherwise, pass `isPushedInNavigationController: false`.
    ```swift
    let roomViewController = WherebyRoomViewController(config: roomConfig, isPushedInNavigationController: false)
    // Set the delegate to be able to receive the room callback events: 
    roomViewController.delegate = self
    ```

5. Show the room view controller in your app using one of the methods:

   - Embed the room view controller as a portion of your app's UI by adding it as a child view controller. For more details see [Creating a Custom Container View Controller](https://developer.apple.com/documentation/uikit/view_controllers/creating_a_custom_container_view_controller).
        ```swift
        // Add the room view controller as a child of this view controller
        addChild(roomViewController)
        view.addSubview(roomViewController.view)

        // Set up the auto layout constraints for the room view controller’s view.
        roomViewController.view.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            roomViewController.view.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 8),
            roomViewController.view.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -8),
            roomViewController.view.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor, constant: 16),
            roomViewController.view.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor, constant: -16)
        ])

        // Notify the room view controller that the move is complete.
        roomViewController.didMove(toParent: self)
        ```

   - Another option is to push the room view controller in the app's existing navigation stack:
       ```swift
       navigationController!.pushViewController(roomViewController, animated: true)
       ```

6. Join the room:
    ```swift
    roomViewController.join()
    ```

7.  Implement `WherebyRoomViewControllerDelegate` to handle the room callbacks:
    ```swift
    func roomViewControllerDidLeave(_ roomViewController: WherebyRoomViewController) {
        // Handle room leave, for example, remove WherebyRoomViewController 
        // from parent view controller if it was previously added as a child
        roomViewController.willMove(toParent: nil)
        roomViewController.view.removeFromSuperview()
        roomViewController.removeFromParent()

        // Or pop it from the navigation stack if it was pushed
        // navigationController!.popViewController(animated: true)
    }
    ```

## Notes
- iOS simulator does not have camera support. We recommend testing the room integration on a real device. However, it is possible to run the app using Whereby SDK on a simulator as well.
- When running on a simulator on a Mac computer with Apple Silicon CPU the SDK may crash when rendering more than one remote video view in a room. This issue is only present for simulator. As a workaround, run the app on a real device or alternatively, open Xcode using Rosetta and then run your app on a simulator.
-  Whereby SDK uses [CallKit](https://developer.apple.com/documentation/callkit) framework. When submitting your app to the App Store, Apple may require to disable CallKit for users in China. This is already handled by the SDK and does not require any additional configuration in your app. You may need to provide a note in the App Review Information section in App Store Connect when submitting your app, e.g. _CallKit functionality is disabled for users in China._ Whereby rooms will still work for users in China but without the deeper system integration that is provided by CallKit.

## Disclaimer
Whereby publishes these packages to help the developer community understand how the Whereby Embedded product can be implemented.

Whereby does not recommend using such examples in a production environment without a prior assessment and appropriate testing relevant to the production setup targeted which can be of operational, technical, security or legal (e.g. library licenses assessment) nature. You expressly agree that the use of these packages is at your sole risk.

Whereby, its affiliates, suppliers, or licensors, whether express or implied, do not make any representation, warranties, contractual commitments, conditions, or assurances by the operation of these examples, or the information, content, materials, therein.