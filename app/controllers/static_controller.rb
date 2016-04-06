class StaticController < ApplicationController
layout 'welcome'

  def about
     @text = Static.where(:title => 'about').first
  end

  def aboutedit
   text = params['content']
    @text = Static.where(:title => 'about').first
    @c= @text.text if @text
    if text
      record = Static.where(:title => 'about').first
      if record
        record.update_attribute(:text, text)
      else
        Static.create(:title => 'about', :text => text)
      end
    end
  end
  
  def conditions
    @text = Static.where(:title => 'condition').first
	end

	def guarantees
    @text = Static.where(:title => 'guarantees').first
  end

  def guaredit
    text = params['content']
    @text = Static.where(:title => 'guarantees').first
    @c= @text.text if @text
    if text
      record = Static.where(:title => 'guarantees').first
      if record
        record.update_attribute(:text, text)
      else
        Static.create(:title => 'guarantees', :text => text)
      end
    end
  end


	def advantages
    @text = Static.where(:title => 'advantages').first
	end

  def advedit
    text = params['content']
    @text = Static.where(:title => 'advantages').first
    @c= @text.text if @text
    if text
      record = Static.where(:title => 'advantages').first
      if record
        record.update_attribute(:text, text)
      else
        Static.create(:title => 'advantages', :text => text)
      end
    end
  end

	def payment
		@text = Static.where(:title => 'payment').first
	end

	def pedit
 		text = params['content']
	  @text = Static.where(:title => 'payment').first
    @c= @text.text
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
 	  text = params['text']
	  @text = Static.where(:title => 'vacancy').first
       @c= @text.text
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
       @c= @text.text
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
       @c= @text.text
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
       @c= @text.text
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
    event_params = { :content => "оставлена заявка с номером #{params[:tel]} и типом работы #{params[:type]}", :event_type => "стоимость" }
    event = Event.new(event_params)
    event.save
    redirect_to(:back)
	end

  def condedit
    @text = Static.where(:title => 'condition').first
    @c= @text.text
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
