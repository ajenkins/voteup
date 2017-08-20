Router.route '/', (->
  document.title = 'VoteUp - Create real-time, dynamic surveys'
  @render 'home'
), name: 'home'

Router.route '/polls/:id', (->
  poll = Polls.findOne {url: @params.id}
  Session.set 'poll', poll._id if poll
  document.title = "VoteUp - #{poll.title}"
  @render 'poll', {data: poll}
), name: 'poll.view'

Router.route '/privacy', (->
  document.title = 'VoteUp - Privacy Policy'
  @render 'privacyPolicy'
), name: 'privacyPolicy'

Router.route '/terms', (->
  document.title = 'VoteUp - Terms and Conditions'
  @render 'termsAndConditions'
), name: 'termsAndConditions'
