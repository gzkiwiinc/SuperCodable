Pod::Spec.new do |s|
  
  s.name         = 'SuperCodable'
  s.version      = '0.0.1'
  s.summary      = 'give Codable super power'

  s.description  = 'give Codable super power.'
  
  s.homepage     = 'https://github.com/gzkiwiinc/SuperCodable'
  s.license      = { :type => 'MIT' }
  s.author       = { 'lacklock' => 'lacklock@gmail.com' }  
  
  s.source       = { :git => 'https://github.com/gzkiwiinc/SuperCodable.git', :tag => "#{s.version}" }
  s.source_files = 'SuperCodable/*.swift'
  
  s.platform     = :ios, '8.0'
  s.requires_arc = true

end
