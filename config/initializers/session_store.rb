# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_shop_session',
  :secret      => 'ce7ac4818c89c2c2b1ab9670451d26100cf5f213700542bc680f03c62cc0a9ceae00fd7b2b20f58bb6669d56a7368f6f9ff747a9fb34d710e42bb7d0c80f3ea3'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
