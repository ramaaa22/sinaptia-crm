class CompaniesController < ApplicationController
  before_action :set_company
  before_action :authorize_company, only: %i[edit update destroy]

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
      current_user.update(company_id: @company.id, role: "admin")
      redirect_to root_path, notice: "Company was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  def join
    if current_user.update(company: @company)
      redirect_to root_path, notice: "You've joined the company successfully!"
    else
      puts "User save failed with errors: #{current_user.errors.full_messages.join(', ')}"
      redirect_to companies_path, alert: "Joining the company failed!"
    end
  end

  # Only allow a list of trusted parameters through.
  def company_params
    params.require(:company).permit(:name, :description)
  end
end
