Meteor.publish null, ->
  if @userId
    query =
      "$or": [{speaker:@userId}, {status:"LIVE"}]
  else
    query =
      status:"LIVE"

  Events.find(query)
