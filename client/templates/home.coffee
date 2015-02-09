Template.home.helpers
  polls: ->
    Polls.find {}

Template.home.events
  'click .create-poll': (event) ->
    random = Random.id 8
    Polls.insert
      title: 'Click to edit'
      createdAt: new Date
      url: random
    Router.go 'poll.view', id: random