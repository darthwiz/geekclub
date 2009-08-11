# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_geekclub_session',
  :secret      => 'bb8e14fffad1e4d2fba8319c1adce9d21c22cc7bf6cb6b9bce74dba9b63eba927c94b41c2d0ac804d31f5a5585ba7c7a7d8c93a9f416d55232bae4c6a731c07b'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
