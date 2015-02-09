Template.body.helpers
  polls: ->
    Polls.find {}

Template.poll.helpers
  title: ->
    @title
  options: ->
    Options.find {pollId: @_id}
    
Template.poll.events
  'keydown .title': (event) ->
    if event.keyCode is 13
      event.target.blur()
      false
  'blur .title': (event) ->
    Polls.update @_id, $set: title: event.target.innerHTML
  'submit .new-option': (event) ->
    text = event.target.text.value
    Options.insert
      value: text
      pollId: @_id
      score: 0
      createdAt: new Date
    event.target.text.value = ''
    false
    
