Template.option.helpers
  upvoted: ->
    if voteStatus(@_id) is 'up'
      'active'
  downvoted: ->
    if voteStatus(@_id) is 'down'
      'active'

Template.option.events
  'click .delete': (event) ->
    Meteor.call 'removeOption', @_id

  'click .upvote': (event) ->
    upVote @_id

  'click .downvote': (event) ->
    downVote @_id
