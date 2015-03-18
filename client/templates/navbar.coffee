Template.navbar.helpers
  pageIsHome: ->
    data = Template.currentData()
    data.page is 'home' if data
  pageIsPoll: ->
    data = Template.currentData()
    data.page is 'poll' if data
