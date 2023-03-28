class TagsController < ApplicationController
  before_action :set_tag, only: %i[edit update destroy]
  before_action :authorize_tag, only: %i[edit update destroy]
  after_action :verify_authorized, except: :index
  after_action :verify_policy_scoped, only: :index

  # GET /tags
  def index
    @tags = policy_scope(Tag).page(params[:page])
    if params[:search].present?
      @tags = @tags.search(params[:search])
    end
  end

  # GET /tags/new
  def new
    @tag = Tag.new
    authorize_tag
  end

  # POST /tags
  def create
    @tag = Tag.new(tag_params)
    authorize_tag
    if @tag.save
      redirect_to tags_url, notice: "Tag was successfully created."
    else
      render :new, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tags/1
  def update
    if @tag.update(tag_params)
      redirect_to tags_url, notice: "Tag was successfully updated."
    else
      render :edit, status: :unprocessable_entity
    end
  end

  # DELETE /tags/1
  def destroy
    @tag.destroy
    redirect_to tags_url, notice: "Tag was successfully destroyed."
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_tag
    @tag = policy_scope(Tag).find(params[:id])
  end

  # Only allow a list of trusted parameters through.
  def tag_params
    params.require(:tag).permit(:name)
  end

  def authorize_tag
    authorize(@tag)
  end
end
