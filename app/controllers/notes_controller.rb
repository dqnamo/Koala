class NotesController < ApplicationController
  before_action :set_note, only: %i[ show edit update destroy ]
  before_action :init_session, :set_tag, :set_notes

  # GET /notes or /notes.json
  def index
    if current_user.present?
      @note = Note.new
    else
      @note = Note.new(session_id: session[:session_id])
    end
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
    @note = current_user.present? ? current_user.notes.new(note_params) : Note.new(note_params)

    respond_to do |format|
      if @note.save
        format.js
        # format.html { redirect_to note_url(@note), notice: "Note was successfully created." }
        # format.json { render json: @note.to_json, status: :created, location: @note }
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
        @note.update_column(:tags, params[:tags].split(',')) if params[:tags].present?

        @tags = @notes.pluck(:tags).flatten.uniq

        format.js
        # format.html { redirect_to note_url(@note), notice: "Note was successfully updated." }
        # format.json { render :show, status: :ok, location: @note }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @note.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    return if @note.nil?
    
    @note.destroy

    @tags = @notes.pluck(:tags).flatten.uniq
    respond_to do |format|
      format.js
      format.html { redirect_to notes_url, notice: "Note was successfully destroyed." }
      # format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_note
      @note = Note.find_by(slug: params[:id])
    end

    def init_session
      session["init"] = true if !current_user.present?
    end

    def set_tag
      @tag = params[:tag]
    end

    def set_notes
      if current_user.present?
        @notes = current_user.notes.order(created_at: :desc)
      else
        @notes = Note.where(session_id: session[:session_id]).order(created_at: :desc)
      end

      # @tags = Note.connection.select_rows('select distinct unnest(tags) from notes').flatten
      # TODO make this query below more effiecent
      @tags = @notes.pluck(:tags).flatten.uniq
      @notes = @notes.where(":tags = ANY (tags)", tags: @tag) if @tag.present?
    end

    # Only allow a list of trusted parameters through.
    def note_params
      params.require(:note).permit(:content, :tags, :session_id)
    end
end
