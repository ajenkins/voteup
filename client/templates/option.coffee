Template.option.events
  'click .delete': (event) ->
    Meteor.call 'removeOption', @_id
  'click .upvote': (event) ->
    Meteor.call 'increaseScoreBy', @_id, 1
  'click .downvote': (event) ->
    Meteor.call 'increaseScoreBy', @_id, -1