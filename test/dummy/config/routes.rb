Rails.application.routes.draw do

  mount Pyr::Gem::Engine => "/pyr_gem"
end
