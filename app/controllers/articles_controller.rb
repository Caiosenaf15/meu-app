class ArticlesController < ApplicationController
  include Paginable

  before_action :authenticate_user!, except: %i[index show]
  before_action :set_article, only: %i[ edit update destroy ]
  before_action :set_categories, only: %i[new create edit update]

  # GET /articles or /articles.json
  def index
    @categories = Category.sorted
    category = @categories.select { |c| c.name == params[:category] }[0] if params[:category].present?

    @highlights = Article.includes(:category, :user)
                         .filter_by_category(category)
                         .filter_by_archive(params[:month_year])
                         .desc_order
                         .first(3)
    
    highlight_ids = @highlights.pluck(:id).join(',')

    

    @articles = Article.includes(:category,:user)
                       .without_highlights(highlight_ids)
                       .filter_by_category(category)
                       .filter_by_archive(params[:month_year])
                       .desc_order
                       .page(current_page)

    @archives = Article.group_by_month(:created_at, format: "%B %Y").count

  end

  # GET /articles/1 or /articles/1.json
  def show
    @article = Article.includes(comments: :user).find(params[:id])
    
    authorize @article
  end

  # GET /articles/new
  def new
    @article = current_user.articles.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = current_user.articles.new(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to @article, notice: "Article was successfully created." }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to @article, notice: "Article was successfully updated." }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy!

    respond_to do |format|
      format.html { redirect_to articles_path, status: :see_other, notice: "Article was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
      authorize @article
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :body, :category_id)
    end

    def set_categories
      @categories = Category.sorted
    end
end
