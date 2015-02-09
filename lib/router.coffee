Router.route '/', (->
  @render 'home'
), name: 'home'
  
Router.route '/polls/:id', (->
  poll = Polls.findOne {url: @params.id}
  @render 'poll', {data: poll}
), name: 'poll.view'