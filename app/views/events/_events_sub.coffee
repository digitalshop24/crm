window.client = new Faye.Client('http://localhost:9292/faye')

sub_url = '/events'

jQuery ->
  client.subscribe sub_url, (payload) ->
  	$(payload.message).hide().prependTo('#events tbody').show("slow") if payload.message
