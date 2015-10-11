Template.eventEditorForm.helpers
  eventEditSchema: ->
    resSchema = new SimpleSchema
      challange:
        label: "Challange Title"
        type: String

      unit:
        label: "Challange Unit"
        type: String

      period:
        label: "Prediction Time (minutes) to hit threshold"
        type: Number
        min: 1


Template.audience.events
  "click .voteBt": (e,t) ->
    eventId = $(e.target).attr("eventId")
    Meteor.call "voteEvent", eventId, Cookies.get "uuid"