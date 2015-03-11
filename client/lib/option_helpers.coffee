@voteStatus = (optionId) ->
  if Meteor.userId()
    option = Options.findOne optionId
    option.votes[Meteor.userId()]
  else
    Session.get optionId

@upVote = (optionId) ->
  if Meteor.userId()
    option = Options.findOne optionId
    if option.votes[Meteor.userId()] is 'up'
      Meteor.call 'deleteVoteforUser', optionId, Meteor.userId()
    else
      Meteor.call 'updateVoteforUser', optionId, Meteor.userId(), 'up'
  if Session.equals optionId, 'up'
    Session.clear optionId
    Meteor.call 'increaseScoreBy', optionId, -1
  else if Session.equals optionId, 'down'
    Session.setPersistent optionId, 'up'
    Meteor.call 'increaseScoreBy', optionId, 2
  else
    Session.setPersistent optionId, 'up'
    Meteor.call 'increaseScoreBy', optionId, 1

@downVote = (optionId) ->
  if Meteor.userId()
    option = Options.findOne optionId
    if option.votes[Meteor.userId()] is 'down'
      Meteor.call 'deleteVoteforUser', optionId, Meteor.userId()
    else
      Meteor.call 'updateVoteforUser', optionId, Meteor.userId(), 'down'
  if Session.equals @_id, 'down'
    Session.clear @_id
    Meteor.call 'increaseScoreBy', @_id, 1
  else if Session.equals @_id, 'up'
    Session.setPersistent @_id, 'down'
    Meteor.call 'increaseScoreBy', @_id, -2
  else
    Session.setPersistent @_id, 'down'
    Meteor.call 'increaseScoreBy', @_id, -1
