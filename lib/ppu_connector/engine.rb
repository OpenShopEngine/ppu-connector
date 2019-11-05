module PpuConnector
  class Engine < ::Rails::Engine
    isolate_namespace PpuConnector
    config.generators.api_only = true
  end
end
