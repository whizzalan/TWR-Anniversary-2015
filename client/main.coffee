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