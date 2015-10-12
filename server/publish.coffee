Meteor.publish null, ->
  if @userId
    if Meteor.users.findOne({_id:@userId}).profile.isAdmin
      eventsQuery = {}

    else
      eventsQuery =
        "$or": [{speaker:@userId}, {status: {$in: ["LIVE", "scheduled"]} }]
  else
    eventsQuery =
      status:
        $in: ["LIVE", "scheduled"]

  Events.find(eventsQuery)
