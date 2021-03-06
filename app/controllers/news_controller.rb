class NewsController < ApplicationController
  layout 'welcome'
  before_action :set_news, only: [:show, :edit, :update, :destroy]
  load_and_authorize_resource
  # GET /news
  def index
    @newss = News.all.order(date: :desc).paginate(:page => params[:page], :per_page => 4)
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
  end

  # GET /news/1
  def show
  end

  # GET /news/new
  def new
    @news = News.new
  end

  # GET /news/1/edit
  def edit
  end

  # POST /news
  def create
    @news = News.new(news_params)

    if @news.save
      redirect_to @news, notice: 'News was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /news/1
  def update
    if @news.update(news_params)
      redirect_to @news, notice: 'News was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /news/1
  def destroy
    @news.destroy
    redirect_to news_index_url, notice: 'News was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_news
      @news = News.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def news_params
      permitted_arr = [:title, :text, :image, :date]
    params.require(:news).permit(permitted_arr)
    end
end
