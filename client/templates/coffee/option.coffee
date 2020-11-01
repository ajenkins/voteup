Template.option.helpers
  upvoted: ->
    if voteState(@_id) is 'up'
      'active'

  downvoted: ->
    if voteState(@_id) is 'down'
      'active'

  isCreator: ->
    poll = Polls.findOne @pollId
    if poll.creator
      Meteor.userId() is poll.creator
    else
      false

  beginHidden: ->
    @newPosition or @newOption

Template.option.events
  'click .delete': (event) ->
    optionId = @_id
    $option = $("div[data-option-id='#{optionId}']")
    $option.velocity 'slideUp',
      duration: 1000
      easing: 'easeOutQuint'
      queue: false
      complete: ->
        Meteor.call 'removeOption', optionId

  'click .upvote': (event) ->
    upVote @_id

  'click .downvote': (event) ->
    downVote @_id

  'keydown .option-value': (event) ->
    if event.keyCode is 13
      event.target.blur()
      false

  'blur .option-value': (event) ->
    text = event.target.innerHTML
    if text isnt @value
      event.target.innerHTML = ''
    Meteor.call 'updateOptionValue', @_id, text
    false

Template.option.rendered = ->
  option = @data
  if option.newOption
    $option = $("div[data-option-id='#{option._id}']")
    $option.velocity 'slideDown',
      duration: 1000
      easing: 'easeOutQuint'
      queue: false
      complete: ->
        Meteor.call 'optionFinishedMoving', option._id

Tracker.autorun ->
  movedOptions = Options.find(newPosition: true).fetch()
  for option in movedOptions
    if option.moveDirection is 'down'
      $ghostRow = $('<div class="ghost-row"></div>').prependTo('div#options-parent')
      $ghostRow.velocity 'slideUp',
        duration: 1000
        easing: 'easeOutQuint'
        queue: false
        complete: ->
          $ghostRow.remove()
    else if option.moveDirection is 'up'
      $ghostRow = $('<div class="ghost-row"></div>').appendTo('div#options-parent')
      $ghostRow.velocity 'slideUp',
        duration: 1000
        easing: 'easeOutQuint'
        queue: false
        complete: ->
          $ghostRow.remove()
    $option = $("div[data-option-id='#{option._id}']")
    $option.velocity 'slideDown',
      duration: 1000
      easing: 'easeOutQuint'
      queue: false
      complete: ->
        Meteor.call 'optionFinishedMoving', option._id
