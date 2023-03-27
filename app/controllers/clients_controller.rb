class ClientsController < ApplicationController
  before_action :set_client, only: %i[show edit update destroy]

  # GET /clients or /clients.json
  def index
      if params[:search]
        @clients = Client.page(params[:page]).search(params[:search])
      else
        @clients = Client.page(params[:page])
      end
  end

  # GET /clients/new
  def new
    @client = Client.new
  end

  # GET /clients/1/edit
  def edit
  end

  # POST /clients or /clients.json
  def create
    @client = Client.new(client_params)

    if @client.save
      redirect_to clients_path, notice: "Client was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /clients/1 or /clients/1.json
  def update
    if @client.update(client_params)
      redirect_to clients_path, notice: "Client was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /clients/1 or /clients/1.json
  def destroy
    @client.destroy
    redirect_to clients_path, notice: "Client was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_client
    @client = Client.find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def client_params
    params.require(:client).permit(:name, :email, :location, tag_ids: [])
  end
end
