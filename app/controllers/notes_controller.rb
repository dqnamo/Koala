class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]
  before_action :set_notes

  # GET /notes or /notes.json
  def index
    @note = Note.new
  end

  # GET /notes/1 or /notes/1.json
  def show
    redirect_to notes_path if @note.nil?
  end

  # GET /notes/new
  def new
    @note = Note.new
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.js { render json: @note.to_json, status: :created, location: @note }
        format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
        format.json { render json: @note.to_json, status: :created, location: @note }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    respond_to do |format|
      if @note.update(note_params)
        format.html { redirect_to note_url(@note), notice: "Note was successfully updated." }
        format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy

    respond_to do |format|
      format.js
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find_by(id: params[:id])
    end

    def set_notes
      @notes = Note.all.order(created_at: :desc)
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:content)
    end
end
