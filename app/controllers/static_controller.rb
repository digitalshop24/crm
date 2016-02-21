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
		@text = Static.where(:title => 'payment').first
		@worktypes = Worktype.all
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
	end
	def pedit
		@worktypes = Worktype.all
 		text = params['content']
	  @text = Static.where(:title => 'payment').first
    if text
    	record = Static.where(:title => 'payment').first
    	if record
    		record.update_attribute(:text, text)
    	else
    		Static.create(:title => 'payment', :text => text)
    	end
    end
 	end
	def vacancy
		@text = Static.where(:title => 'vacancy').first
	  @worktypes = Worktype.all
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
	end
	def vedit
	  @worktypes = Worktype.all
 	  text = params['content']
	  @text = Static.where(:title => 'vacancy').first
    if text
    	record = Static.where(:title => 'vacancy').first
    	if record
    		record.update_attribute(:text, text)
    	else
    		Static.create(:title => 'vacancy', :text => text)
    	end
    end
	end
	def partners
		@text = Static.where(:title => 'partners').first
		@worktypes = Worktype.all
    @news = News.last
    @question = Question.last
    @feedback = Feedback.last
	end
	def paedit
	  @worktypes = Worktype.all
 	  text = params['content']
	  @text = Static.where(:title => 'partners').first
 	  text = params['content']
    if text
    	record = Static.where(:title => 'partners').first
    	if record
    		record.update_attribute(:text, text)
    	else
    		Static.create(:title => 'partners', :text => text)
    	end
    end
	end
	def oedit
 	 	@worktypes = Worktype.all
	  @text = Static.where(:title => 'offer').first
 	  text = params['content']
    if text
    	record = Static.where(:title => 'offer').first
    	if record
    		record.update_attribute(:text, text)
    	else
    		Static.create(:title => 'offer', :text => text)
    	end
    end
	end
	def offer
		@worktypes = Worktype.all
  	@news = News.last
    @text = Static.where(:title => 'offer').first
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
