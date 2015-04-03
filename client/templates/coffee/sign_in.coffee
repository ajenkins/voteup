doneCallback = undefined

Accounts.onResetPasswordLink (token, done) ->
  Session.set 'resetPasswordToken', token
  Session.set 'accountsUI', 'resetPassword'
  doneCallback = done

Template.signIn.helpers
  signInUI: ->
    Session.setDefault 'accountsUI', 'signIn'
    Session.equals 'accountsUI', 'signIn'
  createAccountUI: ->
    Session.equals 'accountsUI', 'createAccount'
  forgotPasswordUI: ->
    Session.equals 'accountsUI', 'forgotPassword'
  resetPasswordUI: ->
    Session.equals 'accountsUI', 'resetPassword'
  errorMessage: ->
    Session.get 'accountsErrorMessage'
  successMessage: ->
    Session.get 'accountsSuccessMessage'

Template.signIn.events
  'click #sign-in-link': (event) ->
    Session.set 'accountsUI', 'signIn'
    Session.clear 'accountsErrorMessage'
    Session.clear 'accountsSuccessMessage'
    false
  'click #create-account-link': (event) ->
    Session.set 'accountsUI', 'createAccount'
    Session.clear 'accountsErrorMessage'
    Session.clear 'accountsSuccessMessage'
    false
  'click #forgot-passwd-link': (event) ->
    Session.set 'accountsUI', 'forgotPassword'
    Session.clear 'accountsErrorMessage'
    Session.clear 'accountsSuccessMessage'
    false
  'submit #accounts-form': (event) ->
    Session.clear 'accountsErrorMessage'
    Session.clear 'accountsSuccessMessage'
    email = event.target.elements.email.value
    switch Session.get 'accountsUI'
      when 'signIn'
        password = event.target.elements.password.value
        Meteor.loginWithPassword(email, password,
          (error) -> Session.set 'accountsErrorMessage', error.reason if error)
        false
      when 'createAccount'
        password = event.target.elements.password.value
        Accounts.createUser({email: email, password: password},
          (error) -> Session.set 'accountsErrorMessage', error.reason if error)
        false
      when 'forgotPassword'
        Accounts.forgotPassword({email: email},
          (error) ->
            if error
              Session.set 'accountsErrorMessage', error.reason
            else
              Session.set 'accountsSuccessMessage', 'Email sent'
        )
        false
