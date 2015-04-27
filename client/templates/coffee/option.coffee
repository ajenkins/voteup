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

  beginHidden: ->
    @newPosition

Template.option.events
  'click .delete': (event) ->
    Meteor.call 'removeOption', @_id

  'click .upvote': (event) ->
    upVote @_id

  'click .downvote': (event) ->
    downVote @_id

Tracker.autorun ->
  movedOptions = Options.find(newPosition: true).fetch()
  for option in movedOptions
    $option = $("div[data-option-id='#{option._id}']")
    $option.velocity 'slideDown',
      duration: 1000
      easing: 'easeOutQuint'
      complete: (elements) ->
        Meteor.call 'optionFinishedMoving', option._id
