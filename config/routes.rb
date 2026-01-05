Rails.application.routes.draw do
  # HOME
  root "home#index"
  get "chi_sono", to: "pages#chi_sono"

  # AUTH
  get    "/login",  to: "sessions#new"
  post   "/login",  to: "sessions#create"
  delete "/logout", to: "sessions#destroy"

  get  "/signup", to: "users#new"
  post "/signup", to: "users#create"

  # PAGINE PUBBLICHE
  get "piani_alimentari", to: "pages#piani_alimentari"
  get "gestione-peso",   to: "pages#gestione_peso", as: :gestione_peso
  get "gravidanza",      to: "pages#gravidanza",    as: :gravidanza
  get "patologie",       to: "pages#patologie",     as: :patologie
  get "sport",           to: "pages#sport",         as: :sport

  # PRENOTAZIONE CONSULENZA GRATUITA
  get  "prenota-consulenza-gratuita",
       to: "free_consultations#new",
       as: :prenota_consulenza

  post "prenota-consulenza-gratuita",
       to: "free_consultations#create"

  resources :free_consultations, only: [:new, :create]

  # OAUTH (GOOGLE / ZOOM ECC.)
  get "/oauth2callback", to: "oauth#callback"

  # =========================
# ====== AREA ADMIN =======
# =========================
namespace :admin do

  # DASHBOARD CONSULENZE GRATUITE
  resources :free_consultations, only: [:index, :destroy] do
    member do
      post :send_reminder
    end
  end

  # GESTIONE SLOT CONSULENZE
  resources :availability_slots, only: [:index, :create, :destroy] do
    member do
      patch :toggle
      post  :send_reminder
    end
  end

  # 👤 CLIENTI + NOTE CLINICHE (CORRETTO)
  resources :clients, only: [:show] do
    resources :client_notes, only: [:create, :destroy]
  end

end

end
