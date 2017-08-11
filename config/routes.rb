Rails.application.routes.draw do
  resources :teams do
    resources :events, constraints: lambda { |r| Team.find_by_id(r.params[:team_id]).present? }
  end

  get 'welcome/index'

  root 'welcome#index'
end
