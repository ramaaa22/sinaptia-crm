class NotesController < ApplicationController
  before_action :set_client
  before_action :set_note, only: %i[edit update destroy]
  before_action :authorize_note, only: %i[edit update destroy]
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  # GET /notes or /notes.json
  def index
    @notes = policy_scope(@client.notes).order("created_at DESC").page(params[:page])
    authorize(@client)
  end

  # GET /notes/new
  def new
    @note = @client.notes.build
    authorize_note
  end

  # POST /notes or /notes.json
  def create
    @note = @client.notes.build(note_params.merge(user: current_user))
    authorize_note
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
    @note = policy_scope(@client.notes).find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to client_notes_path
  end

  # Only allow a list of trusted parameters through.
  def note_params
    params.require(:note).permit(:body, :client_id, :user_id)
  end

  def set_client
    @client = Client.find(params[:client_id])
  end

  def authorize_note
    authorize(@note)
  end
end
