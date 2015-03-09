Tracker.autorun ->
  if Meteor.userId()
    pollId = Session.get 'poll'
    Meteor.call 'addParticipant', pollId, Meteor.userId()
