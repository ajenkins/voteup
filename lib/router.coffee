Router.route '/', (->
  DocHead.setTitle 'VoteUp - Create real-time, dynamic surveys'
  metaDescription =
    name: 'description'
    content: 'Ask a question and share with others to crowdsource ideas. Vote on ideas in real-time to reach a consensus quickly.'
  DocHead.addMeta(metaDescription)
  @render 'home'
), name: 'home'

Router.route '/polls/:id', (->
  poll = Polls.findOne {url: @params.id}
  Session.set 'poll', poll._id if poll
  DocHead.setTitle "VoteUp - #{poll.title}"
  @render 'poll', {data: poll}
), name: 'poll.view'

Router.route '/privacy', (->
  DocHead.setTitle 'VoteUp - Privacy Policy'
  @render 'privacyPolicy'
), name: 'privacyPolicy'

Router.route '/terms', (->
  DocHead.setTitle 'VoteUp - Terms and Conditions'
  @render 'termsAndConditions'
), name: 'termsAndConditions'

Router.onBeforeAction (->
  DocHead.removeDocHeadAddedTags()
  @next()
)
