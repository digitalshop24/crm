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
	def statistic
		response = HTTParty.get('http://www.redbullcanyoumakeit.com/applications/list.json?region_id=2&order=votes_desc')
		json = JSON.parse(response.body)
		hash = {}
		res = response["data"]["applications"].map{|s| hash[s['id']] = s['fblikes']}
		place = hash.to_a.map(&:first).index(6766)+1
		fblikes = hash[6766]
		str=''
		5.times do |i|
  		a = hash.to_a[i][1]
  		str += "#{a-fblikes} "
		end
		render text: str
	end
end
