Template.option.events
  'click .delete': (event) ->
    Options.remove @_id
  'click .upvote': (event) ->
    Options.update @_id, $set: score: @score + 1
  'click .downvote': (event) ->
    if @score > 0
      Options.update @_id, $set: score: @score - 1