Momentum.registerPlugin 'slide-nice', (options) ->
  options or= {}
  options.duration = 1000
  options.easing = 'easeOutQuint'
  {
    insertElement: (node, next, done) ->
      $node = $(node)
      $node.insertBefore(next).css('height', '44px').velocity 'slideDown',
        easing: options.easing
        duration: options.duration
        queue: false
        complete: ->
          $node.css 'height', ''
          done()
    removeElement: (node, done) ->
      $node = $(node)
      $node.velocity 'slideUp',
        height: 0
        easing: options.easing
        duration: options.duration
        complete: ->
          $node.remove()
          done()
  }
