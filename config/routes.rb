Rails.application.routes.draw do
  resources :bookmarks

  root to: redirect('/bookmarks')
end
