class StaticController < ApplicationController
layout 'welcome'
	def conditions
  
    @text = Static.where(:title => 'condition').first
	end
  def 
	def guarantees
	end
	def advantages
	end
	def payment
		@text = Static.where(:title => 'payment').first
	end
	def pedit
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
	end
	def vedit
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
	end
	def paedit
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
    @text = Static.where(:title => 'offer').first
	end
	def contacts
    @text = Static.where(:title => 'contacts').first
	end
	def cedit
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
  def authors
  end
	def event
        redirect_to(:back)
	end
  def condedit
    @text = Static.where(:title => 'condition').first
    text = params['content']
    if text
      record = Static.where(:title => 'condition').first
      if record
        record.update_attribute(:text, text)
      else
        Static.create(:title => 'condition', :text => text)
      end
    end
  end
end
