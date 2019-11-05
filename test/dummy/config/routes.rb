Rails.application.routes.draw do
  mount PpuConnector::Engine => "/ppu_connector"
end
