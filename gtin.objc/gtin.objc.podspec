Pod::Spec.new do |s|
  s.name		= "gtin.objc"
  s.version		= "1.1.1"
  s.summary		= "An Objective C framework for validating and parsing GTIN-8, GTIN-12, GTIN-13 and GTIN-14 codes."
  s.homepage		= "https://github.com/powa/gtin"
  s.license		= 'Apache-2.0'
  s.author		= { 
                          "Joseph Earl" => "joseph@powa.com" 
                          }
  s.source		= { :git => "https://github.com/powa/gtin.git", :tag => s.version.to_s }
  s.social_media_url	= 'https://twitter.com/powatechltd'
  s.platform		= :ios, '7.0'
  s.requires_arc	= true
  s.compiler_flags	= '-fmodules'
  s.frameworks		= 'UIKit'

  s.source_files	= 'GTINObjc/*.{h,m}'
  
end
