class CompaniesController < ApplicationController
  before_action :set_client, only: %i[edit update destroy]
  before_action :authorize_client, only: %i[edit update destroy]

  # GET /companies
  def index
    @companies = Company.order("name ASC")
  end

  # GET /companies/new
  def new
    @company = Company.new
  end

  # POST /companies
  def create
    @company = Company.new(company_params)

    if @company.save
      redirect_to companies_path, notice: "Company was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

    # Only allow a list of trusted parameters through.
    def company_params
      params.require(:company).permit(:name, :description)
    end
end
