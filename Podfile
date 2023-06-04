# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'IOCL' do
  # Comment the next line if you don't want to use dynamic frameworks
  
  use_frameworks!
  # Pods for IOCL

  pod 'SwiftyGif'
  pod 'IBAnimatable'
  pod 'IQKeyboardManagerSwift'
  pod 'SDWebImage'
  pod 'KRProgressHUD'
  pod 'SwiftyJSON'
  pod 'FTPopOverMenu'
  pod 'SideMenu'
  pod 'iOSDropDown'
  pod 'OTPFieldView'
  pod 'iOSEasyList'
  pod 'DropDown'
  pod 'SwiftyGif'
  pod 'FirebaseCore'
  pod 'FirebaseFirestore'
  pod 'FirebaseMessaging'
  pod 'Firebase/Auth'
  pod 'Cosmos', '~> 23.0'
  pod 'Charts', '~> 4.1.0'
  pod 'Alamofire'
    
  post_install do |installer|
     installer.generated_projects.each do |project|
        project.targets.each do |target|
          target.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
           end
        end
     end
   end
  target 'IOCLTests' do
    inherit! :search_paths
    # Pods for testing
  end
  
  target 'IOCLUITests' do
    # Pods for testing
  end
  
end
