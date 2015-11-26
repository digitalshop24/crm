class NotesController < ApplicationController
  before_action :set_note, only: [:show, :edit, :update, :destroy]

  # GET /notes
  def index
    @notes = Note.all
  end

  # GET /notes/1
  def show
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes
  def create
    if params[:employee_id].nil?
      commentary_params= {:employee_id => "N/A", :manager_id => current_user[:id], :content => params[:commentary], :order_id => params[:current_order].to_i}
      note_params= {:manager_id => current_user[:id], :content => params[:note], :order_id => params[:current_order].to_i}
    else
      commentary_params= {:employee_id => params[:employee_id], :manager_id => current_user[:id], :content => params[:commentary], :order_id => params[:current_order].to_i}
      note_params= {:manager_id => current_user[:id], :content => params[:note], :order_id => params[:current_order].to_i}
    end

    @db_note = Note.find_by_order_id(params[:current_order])
    @db_commentary = Commentary.find_by_order_id(params[:current_order])
    if @db_note.nil?
      @note = Note.new(note_params)
      @note.save
    elsif @db_note.content != note_params[:content]
      @db_note.update(note_params)
    end
    if @db_commentary.nil?
      @commentary = Commentary.new(commentary_params)
      @commentary.save
    elsif @db_commentary.content != commentary_params[:content]
      @db_commentary.update(commentary_params)
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
