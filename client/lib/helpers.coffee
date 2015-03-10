@getVotesforPoll = (pollId) ->
  votes = {}
  pollOptions = Options.find pollId: pollId
  pollOptions.forEach (pollOption) ->
    vote = Session.get pollOption._id
    votes[pollOption._id] = vote
  votes
