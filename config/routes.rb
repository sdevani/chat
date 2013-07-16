Chat::Application.routes.draw do
  match '/logout' => 'session#destroy', via: [:get, :post]
  match '/auth/:provider/callback' => 'session#create', via: [:get, :post]
  match '/auth/failure' => 'session#failure', via: [:get, :post]
  resources :messages
  root :to => "messages#index"
  get '/stream' => 'messages#stream'
  post '/comment' => 'messages#comment'
  get '/chat_history' => 'messages#history'
end
