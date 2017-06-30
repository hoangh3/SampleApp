ChatEngine::Engine.routes.draw do
  mount ActionCable.server => '/cable'

  resources :chat_rooms, only: [:show]
end
