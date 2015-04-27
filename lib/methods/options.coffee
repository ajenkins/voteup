Meteor.methods
  addOption: (pollId, text) ->
    numOptions = Options.find(pollId: pollId).count()
    Options.insert
      value: text
      pollId: pollId
      score: 0
      createdAt: new Date
      prevPosition: numOptions
      newPosition: false
      votes: {}

  removeOption: (optionId) ->
    Options.remove optionId

  increaseScoreBy: (optionId, increaseBy) ->
    # Update the option's score
    option = Options.findOne optionId
    previousPosition = option.prevPosition
    previousScore = option.score
    Options.update optionId, $set: score: previousScore + increaseBy

    # Save the option's new position as the previous position
    poll = Polls.findOne option.pollId
    pollOptions = Options.find pollId: poll._id, {sort: score: -1, prevPosition: 1}
    pollOptions.forEach (pollOption, index) ->
      Options.update pollOption._id, $set: prevPosition: index

    # Mark the option if its position has changed
    option = Options.findOne optionId
    newPosition = option.prevPosition
    if previousPosition isnt newPosition
      Options.update optionId, $set: newPosition: true

  addVotesforUser: (pollId, userId, votes) ->
    pollOptions = Options.find pollId: pollId
    pollOptions.forEach (pollOption) ->
      vote = votes[pollOption._id]
      if vote?
        pollOption.votes or= {}
        pollOption.votes[userId] = vote
        Options.update pollOption._id, $set: votes: pollOption.votes

  deleteVoteforUser: (optionId, userId) ->
    option = Options.findOne optionId
    delete option.votes[userId]
    Options.update optionId, $set: votes: option.votes

  updateVoteforUser: (optionId, userId, vote) ->
    option = Options.findOne optionId
    option.votes[userId] = vote
    Options.update optionId, $set: votes: option.votes
