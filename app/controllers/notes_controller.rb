class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]
  require 'pry'
  # POST /notes
  def create
    binding.pry
    @order = Order.find(params[:current_order])

    if @order.note != params[:note]
      @order.note = params[:note]
      @order.save
    end
    if @order.commentary != params[:commentary]
      @order.commentary = params[:commentary]
      @order.save
    end

    redirect_to :back
  end

  # PATCH/PUT /notes/1
  def update
    if @note.update(note_params)
      redirect_to @note, notice: 'Note was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /notes/1
  def destroy
    @note.destroy
    redirect_to notes_url, notice: 'Note was successfully destroyed.'
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = Note.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def note_params
    params[:note]
  end
end
