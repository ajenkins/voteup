Router.route '/', (->
  @render 'home'
), name: 'home'

Router.route '/polls/:id', (->
  poll = Polls.findOne {url: @params.id}
  Session.set 'poll', poll._id if poll
  DocHead.setTitle "VoteUp - #{poll.title}"
  @render 'poll', {data: poll}
), name: 'poll.view'

Router.route '/privacy', (->
  @render 'privacyPolicy'
), name: 'privacyPolicy'

Router.route '/terms', (->
  @render 'termsAndConditions'
), name: 'termsAndConditions'

Router.onBeforeAction (->
  DocHead.removeDocHeadAddedTags()
  @next()
)
