unless Rails.env.production?
	ENV['MY_KEY'] = 'my_key'
	ENV['MY_TOKEN'] = 'my_token'
end
