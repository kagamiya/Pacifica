set :stage, :production
set :rails_env, "production"
set :unicorn_rack_env, "production"

# この設定がないと、デプロイ先でdb:migrateされない
set :migration_role, 'db'

role :app, %w{kagamiya@54.248.167.186}
role :web, %w{kagamiya@54.248.167.186}
role :db,  %w{kagamiya@54.248.167.186}, :primary => true
#role :db,  %w{USER_NAME@IP_ADDRESS}

server '54.248.167.186', user: 'kagamiya', roles: %w{web app db}

set :ssh_options, {
  keys: [File.expand_path('/Users/Diamond/.ssh/pacifica_key_rsa)],
  forward_agent: true,
  auth_methods: %w{publickey}
}
