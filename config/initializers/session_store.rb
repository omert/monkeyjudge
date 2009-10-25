# Be sure to restart your server when you modify this file.

# Your secret key for verifying cookie session data integrity.
# If you change this key, all old sessions will become invalid!
# Make sure the secret is at least 30 characters and all random, 
# no regular words or you'll be exposed to dictionary attacks.
ActionController::Base.session = {
  :key         => '_monkeyjudge_session',
  :secret      => 'fc88925a8d76f84f486f249075e82680e8c3d0c80826c19e6c383452573b55dd160c7dcdc298ff5ea60b55ee028298e9065672b5bcfff630ac58a81ffb51e116'
}

# Use the database for sessions instead of the cookie-based default,
# which shouldn't be used to store highly confidential information
# (create the session table with "rake db:sessions:create")
# ActionController::Base.session_store = :active_record_store
