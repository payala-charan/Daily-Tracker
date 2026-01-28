class NotesController < ApplicationController
  before_action :require_login
  before_action :set_note, only: [:edit, :update, :destroy]

  def index
    @note = Note.new
    @notes = current_user.notes.order(created_at: :desc)
  end

  def create
    @note = current_user.notes.new(note_params)

    if @note.save
      redirect_to notes_path, notice: "Note saved successfully"
    else
      @notes = current_user.notes.order(created_at: :desc)
      render :index
    end
  end

  def edit
    # @note is already loaded
  end

  def update
    if @note.update(note_params)
      redirect_to notes_path, notice: "Note updated successfully"
    else
      render :edit
    end
  end

  def destroy
    @note.destroy
    redirect_to notes_path, notice: "Note deleted successfully"
  end

  private

  def set_note
    @note = current_user.notes.find(params[:id])
  end

  def note_params
    params.require(:note).permit(:note)
  end
end
