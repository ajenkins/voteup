Meteor.publish 'polls', ->
  Polls.find {}
Meteor.publish 'options', ->
  Options.find {}