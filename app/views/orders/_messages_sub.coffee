window.client = new Faye.Client('http://localhost:9292/faye')

sub_url = '<%= can?(:manage, Message) ? "/order/#{@order.id}/messages" : "/order/#{@order.id}/messages/user/#{current_user.id}" %>'

jQuery ->
  client.subscribe sub_url, (payload) ->
    $('#messages.panel-scroll').append(payload.message) if payload.message
    $('#messages.panel-scroll').stop().animate({scrollTop: $('#messages.panel-scroll')[0].scrollHeight}, 1000);
