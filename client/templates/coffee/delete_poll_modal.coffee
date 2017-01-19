Template.deletePollModal.events
  'click .delete-confirmation': (event) ->
    pollId = $('#delete-poll-modal').data('pollId')
    Meteor.call 'deletePoll', pollId
    $('#delete-poll-modal').foundation('close');
