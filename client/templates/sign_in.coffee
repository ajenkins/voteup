Template.signIn.helpers
  signInUI: ->
    Session.setDefault 'accountsUI', 'signIn'
    Session.equals 'accountsUI', 'signIn'
  createAccountUI: ->
    Session.equals 'accountsUI', 'createAccount'
  forgotPasswordUI: ->
    Session.equals 'accountsUI', 'forgotPassword'

Template.signIn.events
  'click #forgot-passwd-link': (event) ->
    Session.set 'accountsUI', 'forgotPassword'
    false
  'click #create-account-link': (event) ->
    Session.set 'accountsUI', 'createAccount'
    false
  'click #sign-in-link': (event) ->
    Session.set 'accountsUI', 'signIn'
    false
