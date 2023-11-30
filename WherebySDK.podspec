Pod::Spec.new do |spec|
  spec.name         = "WherebySDK"
  spec.version      = "0.11.0"
  spec.summary      = "iOS SDK for Whereby Embedded"
  spec.description  = <<-DESC
    Whereby Embedded is the easiest way to add video calls to your web page or mobile app.
                   DESC
  spec.homepage     = "https://whereby.com/"
  spec.license      = "MIT"
  spec.author       = { "Whereby AS" => "embedded@whereby.com" }
  spec.social_media_url = "https://twitter.com/whereby"
  spec.platform     = :ios, "14.0"
  spec.source       = { :git => "https://github.com/whereby/ios-sdk.git", :tag => "#{spec.version}" }
  spec.vendored_frameworks = "WherebySDK.xcframework", "WebRTC.xcframework", "mediasoup_client_ios.xcframework"
end
