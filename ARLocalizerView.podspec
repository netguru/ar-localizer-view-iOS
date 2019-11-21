Pod::Spec.new do |s|

s.platform = :ios
s.ios.deployment_target = '12.0'
s.name = "ARLocalizerView"
s.summary = "ARLocalizerView is a simple and lightweight AR view displaying POIs."
s.requires_arc = true
s.version = "1.0.0"
s.license = { :type => "MIT", :file => "LICENSE" }
s.author = { "Netguru" => "jedrzej.gronek@netguru.com" }
s.homepage = "https://github.com/netguru/ar-localizer-view-iOS"
s.source = { :git => "https://github.com/netguru/ar-localizer-view-iOS.git", 
             :tag => "#{s.version}" }
s.framework = "UIKit"
s.source_files = "ARLocalizerView/**/*.{swift}"
s.resources = "ARLocalizerView/**/*.{png,jpeg,jpg,storyboard,xib,xcassets}"
s.swift_version = "5.1"

end