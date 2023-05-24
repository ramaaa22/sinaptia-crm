class ClientsController < ApplicationController
  before_action :set_client, only: %i[edit update destroy]
  before_action :authorize_client, only: %i[edit update destroy]
  before_action :set_company
  after_action :verify_authorized
  after_action :verify_policy_scoped, only: :index

  # GET /clients
  def index
    authorize Client
    @clients = policy_scope(Client).where(company: @company).page(params[:page])
    if params[:search].present?
      @clients = @clients.search(params[:search])
    end
  end

  # GET /clients/new
  def new
    @client = Client.new
    authorize_client
  end

  # POST /clients
  def create
    @client = Client.new(client_params.merge(company: current_user.company))
    authorize_client

    if @client.save
      redirect_to clients_path, notice: "Client was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1
  def update
    if @client.update(client_params)
      redirect_to clients_path, notice: "Client was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1
  def destroy
    @client.destroy
    redirect_to clients_path, notice: "Client was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = policy_scope(Client).find(params[:id])
  rescue ActiveRecord::RecordNotFound => e
    redirect_to clients_path
  end

  # Only allow a list of trusted parameters through.
  def client_params
    params.require(:client).permit(:name, :email, :location, tag_ids: [])
  end

  def authorize_client
    authorize(@client)
  end
end
