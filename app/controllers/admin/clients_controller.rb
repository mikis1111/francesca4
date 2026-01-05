class Admin::ClientsController < ApplicationController
  before_action :set_client, only: [:show]

  def show
    @consultations = @client.free_consultation_bookings.order(scheduled_at: :desc)
    @notes = @client.client_notes.order(created_at: :desc)
    @new_note = @client.client_notes.build
  end

  private

  def set_client
    @client = User.find(params[:id])
  end
end


