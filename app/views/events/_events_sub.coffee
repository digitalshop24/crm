window.client = new Faye.Client('/faye')

sub_url = '/faye/events'

jQuery ->
  client.subscribe sub_url, (payload) ->
  	$(payload.message).hide().prependTo('#events tbody').show("slow") if payload.message
