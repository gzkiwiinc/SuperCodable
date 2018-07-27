Pod::Spec.new do |s|
  
  s.name         = 'SuperCodable'
  s.version      = '0.1.7'
  s.summary      = 'give Codable super power'

  s.description  = 'give Codable super power.'
  
  s.homepage     = 'https://github.com/gzkiwiinc/SuperCodable'
  s.license      = { :type => 'MIT' }
  s.author       = { 'lacklock' => 'lacklock@gmail.com' }  
  s.swift_version = '4.1'

  s.source       = { :git => 'https://github.com/gzkiwiinc/SuperCodable.git', :tag => "#{s.version}" }
  s.source_files = 'SuperCodable/*.swift'
  s.ios.deployment_target = '8.0'
  s.requires_arc = true

end
