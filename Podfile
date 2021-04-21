platform :ios, '12.0'

target 'GameSearcher_MVVM' do

  use_frameworks!

  # Pods for GameSearcher
  pod 'Alamofire'
  pod 'Kingfisher'
  pod 'SVPullToRefresh'
  pod 'RealmSwift'
  pod 'MMPlayerView'

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '12.0'
      end
    end
end
