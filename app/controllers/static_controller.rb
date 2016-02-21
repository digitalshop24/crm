class StaticController < ApplicationController
layout 'welcome'
	def conditions
		@worktypes = Worktype.all
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
	end
	def guarantees
		@worktypes = Worktype.all
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
	end
	def advantages
		@worktypes = Worktype.all
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
	end
	def payment
		@worktypes = Worktype.all
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
	end
	def pedit
		@worktypes = Worktype.all
 		text = params['content']
    File.write(File.join(Rails.root, 'app','views','static', '_content.html.erb'), text) if text
	end
	def vacancy
	  @worktypes = Worktype.all
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
	end
	def vedit
	  @worktypes = Worktype.all
 	  text = params['content']
    File.write(File.join(Rails.root, 'app','views','static', '_vacancycontent.html.erb'), text) if text
	end
	def partners
		@worktypes = Worktype.all
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
	end
	def paedit
	  @worktypes = Worktype.all
 	  text = params['content']
    File.write(File.join(Rails.root, 'app','views','static', '_partnercontent.html.erb'), text) if text
	end
	def oedit
 		@worktypes = Worktype.all
 	  text = params['content']
    File.write(File.join(Rails.root, 'app','views','static', '_offercontent.html.erb'), text) if text
	end
	def offer
		@worktypes = Worktype.all
  	@news = News.last
    @question = Question.last
    @feedback = Feedback.last
	end
	def contacts
		@worktypes = Worktype.all
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
    @text = Static.where(:title => 'contacts').first
	end
	def cedit
	  @worktypes = Worktype.all
	  @text = Static.where(:title => 'contacts').first
 	  text = params['content']
    if text
    	record = Static.where(:title => 'contacts').first
    	if record
    		record.update_attribute(:text, text)
    	else
    		Static.create(:title => 'contacts', :text => text)
    	end
    end
  end
	def event
	end
end
