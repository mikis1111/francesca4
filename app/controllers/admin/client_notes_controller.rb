class Admin::ClientNotesController < ApplicationController
  before_action :set_client

  def create
    note = @client.client_notes.build(note_params)
    note.author = "Admin Supporto"

    if note.save
      redirect_to admin_client_path(@client), notice: "Nota salvata."
    else
      redirect_to admin_client_path(@client), alert: "Nota non valida."
    end
  end

  def destroy
    note = @client.client_notes.find(params[:id])
    note.destroy
    redirect_to admin_client_path(@client), notice: "Nota eliminata."
  end

  private

  def set_client
    @client = User.find(params[:client_id])
  end

  def note_params
    params.require(:client_note).permit(:content)
  end
end

  