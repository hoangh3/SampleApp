$:.push File.expand_path("../lib", __FILE__)

# Maintain your gem's version:
require "chat_engine/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |s|
  s.name        = "chat_engine"
  s.version     = ChatEngine::VERSION
  s.authors     = ["hoangh3"]
  s.email       = ["hoangh3@gmail.com"]
  # s.homepage    = "TODO"
  s.summary     = "Summary of ChatEngine."
  # s.summary     = "TODO: Summary of ChatEngine."
  # s.description = "TODO: Description of ChatEngine."
  s.license     = "MIT"

  s.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  s.add_dependency "rails", "~> 5.0.0"

  s.add_dependency "redis", "~> 3.0"

  s.add_dependency "jquery-rails"
end
