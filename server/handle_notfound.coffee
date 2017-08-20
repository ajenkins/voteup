Meteor.startup ->
  WebApp.connectHandlers.use '/', (req, res, next) ->
    if req.url is '/' or _.contains(_.keys(Router.routes), req.url.substr(1))
      next() # Route exists, let iron router render it
    else
      res.writeHead(404)
      res.end("404: Page not found.")
