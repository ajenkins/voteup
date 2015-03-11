Template.body.helpers
  polls: ->
    Polls.find {}

Template.poll.helpers
  title: ->
    @title
  options: ->
    Options.find pollId: @_id, {sort: score: -1, prevPosition: 1}
  getURL: ->
    id: @url
  canEditTitle: ->
    @creator is Meteor.userId()

Template.poll.events
  'keydown #title-text': (event) ->
    if event.keyCode is 13
      event.target.blur()
      false
  'blur #title-text': (event) ->
    text = event.target.innerHTML
    if text isnt @title
      event.target.innerHTML = ''
    Meteor.call 'updatePollTitle', @_id, text
    false
  'submit #new-option-form': (event) ->
    text = event.target.text.value
    Meteor.call 'addOption', @_id, text
    event.target.text.value = ''
    false
