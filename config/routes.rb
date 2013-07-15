Chat::Application.routes.draw do
	resources :messages
  root :to => "messages#index"
  get '/stream' => 'messages#stream'
  post '/comment' => 'messages#comment'
  get '/chat_history' => 'messages#history'
end
