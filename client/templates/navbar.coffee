Template.navbar.helpers
  pageIsHome: ->
    data = Template.currentData()
    data.page is 'home' if data
  pageIsPoll: ->
    data = Template.currentData()
    data.page is 'poll' if data
  showMenuIcon: ->
    data = Template.currentData()
    pageIsPoll = if data then data.page is 'poll' else false
    Meteor.user() or pageIsPoll

Template.navbar.events
  'click #sign-out': (event) ->
    Meteor.logout()
