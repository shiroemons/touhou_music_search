Rails.application.routes.draw do
  root to: 'root#index'
  if Rails.env.development?
    mount GraphiQL::Rails::Engine, at: "/graphiql", graphql_path: "/graphql"
  end
  post "/graphql", to: "graphql#execute"
  get '/auth/spotify/callback', to: 'user/spotify#index'
end
