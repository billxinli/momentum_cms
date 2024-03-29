Rails.application.routes.draw do
  if MomentumCms.configuration.admin_panel_style == :html5
    namespace :momentum_cms, as: :cms, path: MomentumCms.configuration.admin_panel_mount_point do
      namespace :admin, as: :admin, except: :show, path: '' do
        root to: 'dashboards#selector'
        resources :sites do
          resources :dashboards, only: [:index]
          resources :templates
          resources :files
          resources :pages do
            get :blocks, on: :collection
          end
          resources :snippets
          resources :menus
        end
        get 'sites/:id', to: 'dashboards#selector'
      end
    end
  end

  namespace :momentum_cms, as: :cms, path: MomentumCms.configuration.mount_point do
    get 'momentum_cms/css/:id', to: 'pages#css', format: 'css'
    get 'momentum_cms/js/:id', to: 'pages#js', format: 'js'
    get '*id', to: 'pages#show'
    root to: 'pages#show'
  end
end