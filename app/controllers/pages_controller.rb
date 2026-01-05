class PagesController < ApplicationController
  skip_before_action :require_login, only: [
    :chi_sono,
    :piani_alimentari,
    :gestione_peso,
    :gravidanza,
    :patologie,
    :sport
  ]

  def chi_sono; end
  def piani_alimentari; end
  def gestione_peso; end
  def gravidanza; end
  def patologie; end
  def sport; end
end
