Momentum.registerPlugin 'slide-nice', (options) ->
  options or= {}
  options.duration = 200
  options.easing = 'ease-in-out'
  {
    insertElement: (node, next, done) ->
      $node = $(node)
      $node.insertBefore(next).css('height', $node.height()).velocity 'slideDown',
        easing: options.easing
        duration: options.duration
        queue: false
        complete: ->
          # $node.css 'height', ''
          # remove explicit height
          done()
    removeElement: (node, done) ->
      $node = $(node)
      $node.velocity 'slideUp',
        easing: options.easing
        duration: options.duration
        complete: ->
          $node.remove()
          done()
  }
