Meteor.methods
  addOption: (pollId, text) ->
    numOptions = Options.find(pollId: pollId).count()
    Options.insert
      value: text
      pollId: pollId
      score: 0
      createdAt: new Date
      prevPosition: numOptions
      votes: {}

  removeOption: (optionId) ->
    Options.remove optionId

  increaseScoreBy: (optionId, increaseBy) ->
    option = Options.findOne optionId
    previousScore = option.score
    Options.update optionId, $set: score: previousScore + increaseBy

    poll = Polls.findOne option.pollId
    pollOptions = Options.find pollId: poll._id, {sort: score: -1, prevPosition: 1}
    pollOptions.forEach (pollOption, index) ->
      Options.update pollOption._id, $set: prevPosition: index

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
