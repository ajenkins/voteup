Template.home.helpers
  polls: ->
    Polls.find {}

Template.home.events
  'click #create-poll-btn': (event) ->
    Meteor.call 'createPoll', (error, result) ->
      if error
        console.log error
      Router.go 'poll.view', id: result

Template.home.rendered = ->
  Accounts._loginButtonsSession.set 'dropdownVisible', true
