class OauthController < ApplicationController
    def callback
      render plain: "Autorizzazione Google completata. Puoi chiudere questa finestra."
    end
  end
  