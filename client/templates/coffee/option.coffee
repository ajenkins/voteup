Template.option.helpers
  upvoted: ->
    if voteState(@_id) is 'up'
      'active'
  downvoted: ->
    if voteState(@_id) is 'down'
      'active'
  isCreator: ->
    poll = Polls.findOne @pollId
    if poll.creator
      Meteor.userId() is poll.creator
    else
      false

Template.option.events
  'click .delete': (event) ->
    Meteor.call 'removeOption', @_id

  'click .upvote': (event) ->
    upVote @_id

  'click .downvote': (event) ->
    downVote @_id
