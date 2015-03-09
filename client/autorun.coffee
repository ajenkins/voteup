Tracker.autorun ->
  if Meteor.userId()
    pollId = Session.get 'poll'

    # When a user logs in, add them as a participant to the current poll
    Meteor.call 'addParticipant', pollId, Meteor.userId()

    # When a user logs in, add their existing votes to the options of the current poll
    Meteor.call 'addVotes', pollId, Meteor.userId()
