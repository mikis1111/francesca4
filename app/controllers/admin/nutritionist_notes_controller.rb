class Admin::NutritionistNotesController < ApplicationController
    def create
      @note = NutritionistNote.new(note_params)
      if @note.save
        redirect_back fallback_location: admin_client_path(@note.user), notice: "Nota salvata."
      else
        redirect_back fallback_location: admin_client_path(@note.user), alert: "Errore: nota vuota."
      end
    end
  
    def destroy
      @note = NutritionistNote.find(params[:id])
      user = @note.user
      @note.destroy
      redirect_back fallback_location: admin_client_path(user), notice: "Nota eliminata."
    end
  
    private
  
    def note_params
      params.require(:nutritionist_note).permit(:content, :user_id)
    end
  end
  