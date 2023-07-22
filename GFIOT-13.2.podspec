#
# Be sure to run `pod lib lint GFIOT.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'GFIOT'
  s.version          = '1.0.0'
  s.summary          = 'A short description of GFIOT.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'https://github.com/GoFun-Tech/GFIOT-iOS.git'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'qianquan' => 'qianquan@shouqiev.com' }
  s.source           = { :git => './' }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'
  s.requires_arc = true
  s.ios.deployment_target = '11.0'
  s.vendored_frameworks = 'GFIOTSDK-13.2/GFIOT.framework'
  
  #s.library = 'commonCrypto'

  s.frameworks = [
    'CoreBluetooth'
  ]
  #s.source_files = 'GFIOTSDK/GFIOT-Description.swift'
  
  #s.resources = [
  #  'GFIOTSDK.bundle'
  #]
  
  s.pod_target_xcconfig = { 'OTHER_LDFLAGS' => '-all_load' }
  
  s.swift_version = '5.0'
  
end
