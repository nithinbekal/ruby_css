
$LOAD_PATH.push File.expand_path("../lib", __FILE__)
require "ruby_css/version"

Gem::Specification.new do |s|
  s.name         = "ruby_css"
  s.version      = RubyCss::VERSION
  s.authors      = ["Nithin Bekal"]
  s.email        = ["nithinbekal@gmail.com"]
  
  s.summary      = "Generate CSS through Ruby code"
  s.description  = "Generate CSS through Ruby code."
  s.homepage     = "http://github.com/nithinbekal/ruby_css"
  
  s.files        = Dir.glob("lib/**/*.rb")
  s.require_path = "lib"
end
