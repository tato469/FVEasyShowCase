Pod::Spec.new do |s|
  s.name             = "FVEasyShowCase"
  s.version          = "1.0"
  s.summary          = "Highlight parts of your app iShowcase."
  s.homepage         = "https://github.com/tato469/FVEasyShowCase"
  s.screenshots      = "https://github.com/tato469/FVEasyShowCase/raw/master/screenshots/screenshot.png"
  s.license          = 'MIT'
  s.author           = { "tato469" => "fernandovalle.developer@gmail.com" }
  s.source           = { :git => "https://github.com/tato469/FVEasyShowCase.git", :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/tato469'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Classes/*.{m,h}'
  s.frameworks = 'UIKit'
end
