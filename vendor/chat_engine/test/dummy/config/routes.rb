Rails.application.routes.draw do
  mount ChatEngine::Engine => "/chat_engine"
end
