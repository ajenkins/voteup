Tracker.autorun ->
  if Meteor.userId()
    pollId = Session.get 'poll'
    Polls.update pollId, $addToSet: participants: Meteor.userId()
