Meteor.methods
  submitEvent: (data)->
    userId = Meteor.userId()
    if not userId
      throw new Meteor.Error(401, "You need to login")

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


