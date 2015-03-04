Meteor.methods
  createPoll: (title = 'Click to edit') ->
    random = Random.id 8
    Polls.insert
      title: title
      createdAt: new Date
      url: random
    random
  deletePoll: (pollId) ->
    Polls.remove pollId
  updatePollTitle: (pollId, newTitle) ->
    Polls.update pollId, $set: title: newTitle
  addOption: (pollId, text) ->
    numOptions = Options.find(pollId: pollId).count()
    Options.insert
      value: text
      pollId: pollId
      score: 0
      createdAt: new Date
      prevPosition: numOptions
  removeOption: (optionId) ->
    Options.remove optionId
  increaseScoreBy: (optionId, increaseBy) ->
    previousScore = (Options.findOne optionId).score
    Options.update optionId, $set: score: previousScore + increaseBy
