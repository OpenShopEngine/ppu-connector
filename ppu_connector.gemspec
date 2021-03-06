$:.push File.expand_path("lib", __dir__)

# Maintain your gem's version:
require "ppu_connector/version"

# Describe your gem and declare its dependencies:
Gem::Specification.new do |spec|
  spec.name        = "ppu_connector"
  spec.version     = PpuConnector::VERSION
  spec.authors     = ["Pavel Kosilo"]
  spec.email       = ["kodosgames@gmail.com"]
  spec.homepage    = "https://github.com/OpenShopEngine/ppu-connector.git"
  spec.summary     = "Template payment system connector for ppu-plugin"
  spec.description = "Template payment system connector for ppu-plugin"
  spec.license     = "MIT"

  # Prevent pushing this gem to RubyGems.org. To allow pushes either set the 'allowed_push_host'
  # to allow pushing to a single host or delete this section to allow pushing to any host.
  if spec.respond_to?(:metadata)
    spec.metadata["allowed_push_host"] = "http://mygemserver.com"
  else
    raise "RubyGems 2.0 or newer is required to protect against " \
      "public gem pushes."
  end

  spec.files = Dir["{app,config,db,lib}/**/*", "MIT-LICENSE", "Rakefile", "README.md"]

  spec.add_dependency "rails", "~> 6.0.0"

  spec.add_development_dependency "sqlite3"
end
