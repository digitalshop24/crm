class ServiceController < ApplicationController
layout 'welcome'
  def index
  	@worktypes = Worktype.all
  	@news = News.last
   	@question = Question.last
   	@feedback = Feedback.last
  end
end
