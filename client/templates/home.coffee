Template.home.helpers
  polls: ->
    Polls.find {}

Template.home.events
  'click .create-poll': (event) ->
    Meteor.call 'createPoll', (error, result) ->
      if error
        console.log error
      Router.go 'poll.view', id: result

Template.home.rendered = ->
  Accounts._loginButtonsSession.set 'dropdownVisible', true

# Template.login.rendered = ->
#   Accounts._loginButtonsSession.set 'dropdownVisible', true
