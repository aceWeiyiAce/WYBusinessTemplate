#
# Be sure to run `pod lib lint PROJECT.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'PROJECT'
  s.version          = '0.1.0'
  s.summary          = 'A short description of PROJECT.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'HOMEPAGE_URL'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'CREATEDBYAUTHOR' => 'CREATEDBYAUTHOR@CUSTOMORGANIZATIONNAME.com' }
  s.source           = { :git => 'REPO_URL', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'PROJECT/Classes/**/*'
  
  s.resources       = ['PROJECT/Assets.xcassets', 'PROJECT/Resoures/**/*']
  # s.resource_bundles = {
  #   'PROJECT' => ['PROJECT/Assets/*.png']
  # }

  s.prefix_header_contents = '#import "PROJECT.h"'
  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
