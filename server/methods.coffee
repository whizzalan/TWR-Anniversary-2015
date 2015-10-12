Meteor.methods
  startEvent: (eventId)->
    userId = Meteor.userId()
    if not userId
      throw new Meteor.Error(401, "You need to login")

    if not Meteor.user().profile.isAdmin
      throw new Meteor.Error(405, "Has no Authencation to schedule!")

    Events.update {_id:eventId}, {$set:{status:"LIVE", startedAt: new Date}}


  scheduleEvent: (eventId)->
    userId = Meteor.userId()
    if not userId
      throw new Meteor.Error(401, "You need to login")

    if not Meteor.user().profile.isAdmin
      throw new Meteor.Error(405, "Has no Authencation to schedule!")

    Events.update {_id:eventId}, {$set:{status:"scheduled", scheduledAt: new Date}}


  submitEvent: (data)->
    userId = Meteor.userId()
    if not userId
      throw new Meteor.Error(401, "You need to login")

    if data.hitTH > data.duration
      throw new Meteor.Error(999, "ValueError: data.hitTH > data.duration")

    eventData =
      challange: data.challange
      unit: data.unit
      hitTH: data.hitTH
      duration: data.duration
      speaker: userId
      createdAt: new Date
      status: "waitingForSchedule"


    Events.insert eventData

  uuidJoinEvent: (eventId, uuid)->
    updateData =
      $addToSet:
        jointUuid: uuid

    console.log "updateData = ", updateData
    console.log "eventId = ", eventId
    Events.update {_id:eventId}, updateData

  voteEvent: (eventId, uuid)->
    updateData =
      $addToSet:
        jointUuid: uuid

    console.log "updateData = ", updateData
    console.log "eventId = ", eventId
    Events.update {_id:eventId}, updateData

    updateData =
      $addToSet:
        votedUuid: uuid

    Events.update {_id:eventId}, updateData


