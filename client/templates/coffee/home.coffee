Template.home.helpers
  polls: ->
    Polls.find participants: Meteor.userId(), {sort: createdAt: -1}
  isPollCreator: (pollData) ->
    poll = Polls.findOne pollData.hash.pollId
    Meteor.userId() is poll.creator


Template.home.events
  'click #create-poll-btn': (event) ->
    Meteor.call 'createPoll', (error, result) ->
      if error
        console.log error
      Router.go 'poll.view', id: result
  'click .delete': (event) ->
    pollId = event.target.parentElement.dataset.pollId
    $('#delete-poll-modal').data('pollId', pollId)


Template.home.onRendered ->
  $(document).foundation()
