class FeedbacksController < ApplicationController
  layout 'welcome'
  load_and_authorize_resource
  before_action :set_feedback, only: [:show, :edit, :update, :destroy]

  # GET /feedbacks
  def index
    @worktypes = Worktype.all
    @feedbacks = Feedback.all.order(date: :desc).paginate(:page => params[:page], :per_page => 5)
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
  end

  # GET /feedbacks/1
  def show
  end

  # GET /feedbacks/new
  def new
    @feedback = Feedback.new
  end

  # GET /feedbacks/1/edit
  def edit
  end

  # POST /feedbacks
  def create
    @feedback = Feedback.new(feedback_params)

    if @feedback.save
      redirect_to @feedback, notice: 'Feedback was successfully created.'
    else
      render :new
    end
  end

  # PATCH/PUT /feedbacks/1
  def update
    if @feedback.update(feedback_params)
      redirect_to @feedback, notice: 'Feedback was successfully updated.'
    else
      render :edit
    end
  end

  # DELETE /feedbacks/1
  def destroy
    @feedback.destroy
    redirect_to feedbacks_url, notice: 'Feedback was successfully destroyed.'
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_feedback
      @feedback = Feedback.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def feedback_params
        permitted_arr = [:name, :feedback]
        params.require(:feedback).permit(permitted_arr)
    end
end
