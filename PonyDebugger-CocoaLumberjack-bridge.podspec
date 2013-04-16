Pod::Spec.new do |s|
  s.name = 'PonyDebugger-CocoaLumberjack-bridge'
  s.version = '0.1.0'
  s.summary = 'Bridge CocoaLumberjack and PonyDebugger remote logging.'
  s.homepage = 'https://github.com/siuying/PonyDebugger-CocoaLumberjack-bridge'
  s.description = <<-DESC
Bridge PonyDebugger and CocoaLumberjack, use cocoalumberjack and output to Chrome Developer Tools console.
DESC
  s.author = 'Square'
  s.source = { :git => 'git://github.com/siuying/PonyDebugger-CocoaLumberjack-bridge.git', :commit => 'c4d44b29caade33f2bcc82ab039298174804a469' }
  s.license = 'Apache Licence, Version 2.0'

  # Platform setup
  s.requires_arc = true
  s.platform = :ios, '5.0'
  
  s.source_files = 'PonyDebugger-CocoaLumberjack-bridge/Logger/*.{h,m}'

  s.dependency 'SocketRocket'
  s.dependency 'CocoaLumberjack'
  s.dependency 'JRSwizzle', '~> 1.0'
  s.dependency 'PonyDebugger'

  # The readme says that it is needed but it lints without
  s.frameworks = 'CoreData'
end