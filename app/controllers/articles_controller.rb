class ArticlesController < ApplicationController
  def index
    # @articles = Article.all
    @articles = Article.order(created_at: :desc)
  end

  def show
    @article = Article.find(params[:id])
    @comment_count = @article.comments.count
  end

  def new
    @article = Article.new
  end

  def create
    @article = Article.new(article_params)
    puts "Current username", session[:current_username]
    @article.user = User.find_by(username: session[:current_username])
    if @article.user.nil?
      # TODO: Do something here.
      @article.user = User.create(username: session[:current_username])
    else
      @article.user.username = session[:current_username]
    end
    puts ""
    if @article.save
      redirect_to @article
    else
      puts @article.errors.full_messages
      render :new, status: :unprocessable_entity
    end
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])
    if @article.update(article_params)
      redirect_to @article
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy
    redirect_to root_path, status: :see_other
  end

  private
  def article_params
    params.require(:article).permit(:title, :body, :status)
  end
end
