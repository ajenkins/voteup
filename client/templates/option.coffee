Template.option.helpers
  upvoted: ->
    if voteState(@_id) is 'up'
      'active'
  downvoted: ->
    if voteState(@_id) is 'down'
      'active'
  canDelete: ->
    poll = Polls.findOne @pollId
    Meteor.userId() is poll.creator

Template.option.events
  'click .delete': (event) ->
    Meteor.call 'removeOption', @_id

  'click .upvote': (event) ->
    upVote @_id

  'click .downvote': (event) ->
    downVote @_id
