project 'DakkenApp.xcodeproj'

# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DakkenApp' do
  # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DakkenApp
  pod 'Alamofire'
  pod 'ScrollableSegmentedControl', '~> 1.3.0'
  pod 'TextFieldEffects'
  pod 'JSSAlertView', '~> 4.0.0'
end
# Workaround for @IBDesignable (https://github.com/CocoaPods/CocoaPods/issues/5334)
post_install do |installer|
  installer.pods_project.targets.each do |target|
    next if target.product_type == "com.apple.product-type.bundle"
    target.build_configurations.each do |config|
      config.build_settings['CONFIGURATION_BUILD_DIR'] = '$PODS_CONFIGURATION_BUILD_DIR'
    end
  end
end
