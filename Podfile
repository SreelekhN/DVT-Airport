# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'DVT Airport App' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for DVT Airport App

  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'NVActivityIndicatorView'
  pod 'GoogleMaps'
  pod 'GooglePlaces'

  post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['DEBUG_INFORMATION_FORMAT'] = 'dwarf'
      end
    end
  end
  
end


