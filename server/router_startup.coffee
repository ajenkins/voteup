Meteor.startup ->
  WebApp.connectHandlers.use '/', (req, res, next) ->
    if req.headers.host is 'voteup-io.herokuapp.com'
      res.writeHead(301, Location: 'https://www.voteup.io' + req.url)
      res.end()
    else if req.url.split('?').shift() in ['/', '/privacy', '/terms'] or req.url.match /^\/polls\/.{8}$/
      next() # Route exists, let iron router render it
    else
      res.writeHead(404)
      res.end("404: Page not found.")
