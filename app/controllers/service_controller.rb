class ServiceController < ApplicationController
layout 'welcome'
  def index
  	@news = News.last
   	@question = Question.last
   	@feedback = Feedback.last
  end
end
