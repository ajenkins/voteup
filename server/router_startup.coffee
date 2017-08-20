Meteor.startup ->
  WebApp.connectHandlers.use '/', (req, res, next) ->
    if req.url in ['/', '/privacy', '/terms'] or req.url.match /^\/polls\/.{8}$/
      next() # Route exists, let iron router render it
    else
      res.writeHead(404)
      res.end("404: Page not found.")
