doneCallback = undefined

Accounts.onResetPasswordLink (token, done) ->
  Session.set 'resetPasswordToken', token
  Session.set 'accountsUI', 'resetPassword'
  doneCallback = done

Template.resetPassword.helpers
  errorMessage: ->
    Session.get 'accountsErrorMessage'

Template.resetPassword.events
  'submit #reset-passwd-form': (event) ->
    Session.clear 'accountsErrorMessage'
    Session.clear 'accountsSuccessMessage'
    token = Session.get 'resetPasswordToken'
    newPassword = event.target.elements.password.value
    Accounts.resetPassword(token, newPassword,
      (error) ->
        if error
          Session.set 'accountsErrorMessage', error.reason
        else
          Session.clear 'resetPasswordToken'
          Session.set 'accountsUI', 'signIn'
          doneCallback() if doneCallback
        return
    )
    false
  'click #sign-in-link': (event) ->
    Session.clear 'resetPasswordToken'
    Session.set 'accountsUI', 'signIn'
