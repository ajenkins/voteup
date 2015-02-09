Template.body.helpers
  polls: ->
    Polls.find {}

Template.poll.helpers
  title: ->
    @title
  options: ->
    Options.find {pollId: @_id}, {sort: {score: -1}}
  getURL: ->
    id: @url
    
Template.poll.events
  'keydown .title': (event) ->
    if event.keyCode is 13
      event.target.blur()
      false
  'blur .title': (event) ->
    text = event.target.innerHTML
    if text isnt @title
      event.target.innerHTML = ''
    Meteor.call 'updatePollTitle', @_id, text
    false
  'submit .new-option': (event) ->
    text = event.target.text.value
    Meteor.call 'addOption', @_id, text
    event.target.text.value = ''
    false