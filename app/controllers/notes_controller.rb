class NotesController < ApplicationController
  before_action :set_client
  before_action :set_note, only: %i[show edit update destroy]

  # GET /notes or /notes.json
  def index
    @notes = @client.notes.order("created_at DESC")
  end

  # GET /notes/1 or /notes/1.json
  def show
  end

  # GET /notes/new
  def new
    @note = @client.notes.build
  end

  # GET /notes/1/edit
  def edit
  end

  # POST /notes or /notes.json
  def create
    @note = @client.notes.build(note_params.merge(user: current_user))
    if @note.save
      redirect_to client_notes_path, notice: "Note was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /notes/1 or /notes/1.json
  def update
    if @note.update(note_params)
      redirect_to client_notes_path, notice: "Note was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /notes/1 or /notes/1.json
  def destroy
    @note.destroy
    redirect_to client_notes_path(@client), notice: "Note was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_note
    @note = @client.notes.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:body, :client_id, :user_id)
  end

  def set_client
    @client = Client.find(params[:client_id])
  end
end
