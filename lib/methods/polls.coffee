Meteor.methods
  createPoll: (title = 'Click to edit') ->
    random = Random.id 8
    Polls.insert
      title: title
      createdAt: new Date
      url: random
      creator: Meteor.userId()
      participants: [Meteor.userId()]
    random

  deletePoll: (pollId) ->
    Polls.remove pollId

  updatePollTitle: (pollId, newTitle) ->
    Polls.update pollId, $set: title: newTitle

  addParticipant: (pollId, userId) ->
    Polls.update pollId, $addToSet: participants: userId
