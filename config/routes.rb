Chat::Application.routes.draw do
	resources :messages
  root :to => "messages#index"
  get '/stream' => 'messages#stream'
  post '/comment' => 'messages#comment'
end
