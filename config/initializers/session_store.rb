# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_cmdliner_session',
  :secret      => '60fc45b63fc323e06b4324a432ca1d92feb70f7e350f97f338584218e27209ba6a5bafc9252df0b895c3b78626a500b1d26db2018b5875347fbf04a1dfd06ae1'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
