Pod::Spec.new do |s|

  s.name         = "JJCSwiftTools"
  s.version      = "1.0.0"
  s.summary      = "Some methods to get result fasterly with swift!"

  s.homepage     = "https://github.com/jijiucheng/JJCSwiftTools"
  s.license      = { :type => "MIT", :file => "LICENSE" }
  s.authors      = { "苜蓿鬼仙" => "302926124@qq.com" }

  s.swift_versions = ['5.0']
  s.ios.deployment_target = "13.0"
  s.requires_arc = true

  s.source       = { :git => "https://github.com/jijiucheng/JJCSwiftTools.git", :tag => s.version }
  s.source_files = [ "Sources/**/*.swift" ]
  s.resource     = [ "Sources/Resources/JJCSwiftTools.bundle" ]
  
end
