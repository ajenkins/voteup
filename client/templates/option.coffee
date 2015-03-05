Template.option.helpers
  upvoted: ->
    if Session.equals @_id, 'up'
      'active'
  downvoted: ->
    if Session.equals @_id, 'down'
      'active'

Template.option.events
  'click .delete': (event) ->
    Meteor.call 'removeOption', @_id
    
  'click .upvote': (event) ->
    if Session.equals @_id, 'up'
      Session.clear @_id
      Meteor.call 'increaseScoreBy', @_id, -1
    else if Session.equals @_id, 'down'
      Session.setPersistent @_id, 'up'
      Meteor.call 'increaseScoreBy', @_id, 2
    else
      Session.setPersistent @_id, 'up'
      Meteor.call 'increaseScoreBy', @_id, 1
      
  'click .downvote': (event) ->
    if Session.equals @_id, 'down'
      Session.clear @_id
      Meteor.call 'increaseScoreBy', @_id, 1
    else if Session.equals @_id, 'up'
      Session.setPersistent @_id, 'down'
      Meteor.call 'increaseScoreBy', @_id, -2
    else
      Session.setPersistent @_id, 'down'
      Meteor.call 'increaseScoreBy', @_id, -1