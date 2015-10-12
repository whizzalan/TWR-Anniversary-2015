Accounts.onCreateUser (options, user) ->

  if user.services.facebook?
    userFacebookId = user.services.facebook.id
    userFacebookToken = user.services.facebook.accessToken

    userProfileUrl = "https://graph.facebook.com/v2.3/#{userFacebookId}?fields=name,email,link,picture&access_token=#{userFacebookToken}"
    userData = HTTP.get(userProfileUrl).data

    user.services.facebook.apiData = {}
    _.extend user.services.facebook.apiData, userData

    user.profile =
      name: userData.name
      photo:
        thumb_link: userData.picture.data.url
      link: userData.link
      email: userData.email
      isAdmin: userData.email in Meteor.settings.adminEmails

  user