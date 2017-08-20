# Homepage
HOME = 'home'
Router.route '/', (->
  @render 'home'
), name: HOME

Router.onAfterAction (->
  document.title = 'VoteUp - Create real-time, dynamic surveys'
), only: HOME

# View polls
POLL = 'poll.view'
Router.route '/polls/:id', (->
  poll = Polls.findOne {url: @params.id}
  Session.set 'poll', poll._id if poll
  @render 'poll', {data: poll}
), name: POLL

Router.onAfterAction ((req, res, next) ->
  document.title = 'my poll title'
), only: POLL

# Privacy page
PRIVACY = 'privacyPolicy'
Router.route '/privacy', (->
  @render 'privacyPolicy'
), name: PRIVACY

Router.onAfterAction (->
  document.title = 'VoteUp - Privacy Policy'
), only: PRIVACY

# Terms page
TERMS = 'termsAndConditions'
Router.route '/terms', (->
  @render 'termsAndConditions'
), name: TERMS

Router.onAfterAction (->
  document.title = 'VoteUp - Terms and Conditions'
), only: TERMS
