# Be sure to restart your server when you modify this file.

# Your secret key is used for verifying the integrity of signed cookies.
# If you change this key, all old signed cookies will become invalid!

# Make sure the secret is at least 30 characters and all random,
# no regular words or you'll be exposed to dictionary attacks.
# You can use `rake secret` to generate a secure secret key.

# Make sure your secret_key_base is kept private
# if you're sharing your code publicly.
Chat::Application.config.secret_key_base = '31c6e1f3944fca891b801469c4621e8dbf0b476ff35b099c2b2e04a7fb85a304ca7fc21bb9fcfa6836025cfea7bda7be8f37011cf9369c1dd836045b735e5093'
