
Template.eventsStartBt.events
  "click .startEventBt": (e,t)->
    eventId = $(e.target).attr "eventId"
    Meteor.call "startEvent", eventId, (err, res)->
      if not err
        console.log "res = "
        console.log res


Template.eventsStartBt.helpers
  isScheduled: ->
    @status is "scheduled"



Template.admin.helpers
  events: ->
    Events.find()

Template.eventInAgenda.helpers
  isLive: ->
    @status is "LIVE"

  isFinished: ->
    @status is "FINISHED"

Template.eventsScheduleBt.helpers
  isScheduled: ->
    @status in ["scheduled","LIVE","FINISHED"]


Template.eventsScheduleBt.events
  "click .scheduleEventBt": (e,t)->
    eventId = $(e.target).attr "eventId"
    Meteor.call "scheduleEvent", eventId, (err, res)->
      if not err
        console.log "res = "
        console.log res


Template.eventsTable.helpers
  settings: ->
    scheduleBtField =
      key: "_id"
      label: "Schedule!"
      tmpl: Template.eventsScheduleBt

    res=
      collection:Events
      rowsPerPage:20
      showFilter: true
      fields:["challange","unit","hitTH","duration","speaker","status", scheduleBtField]



Template.eventEditorForm.helpers
  eventEditSchema: ->
    resSchema = new SimpleSchema
      challange:
        label: "Challange Title"
        type: String

      unit:
        label: "Challange Unit"
        type: String

      hitTH:
        label: "Time to Hit Threshld (minutes)"
        type: Number
        min: 1

      duration:
        label: "Talk Duration (minutes)"
        type: Number
        min: 1





Template.audience.events
  "click .voteBt": (e,t) ->
    eventId = $(e.target).attr("eventId")
    Meteor.call "voteEvent", eventId, Cookies.get "uuid"