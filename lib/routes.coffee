Router.configure
  layoutTemplate: 'layout'


Router.map ->
  @route "index",
    path: "/"
    template: "index"
    data: ->
      resData =
        loginUser: ->
          Meteor.userId()

        isAdmin: ->
          Meteor.userId() in ["6HHcA47iuCyFdpfpt"]

        liveEvent: ->
          Events.findOne status:"LIVE"

    waitOn: ->
      unless Cookies.get "uuid"
        chance = new Chance
        uuid = chance.guid()
        Cookies.set "uuid", uuid

      Tracker.autorun ->
        liveEvent = Events.findOne status:"LIVE"
        if liveEvent
          Meteor.call "uuidJoinEvent", liveEvent._id, Cookies.get "uuid"

      unless Cookies.get "uuid"
        chance = new Chance
        uuid = chance.guid()
        Cookies.set "uuid", uuid


  @route "audience",
    path: "/audience"
    template: "audience"
    data: ->
      resData =
        liveEvent: ->
          Events.findOne status:"LIVE"
        liveAudiences: ->
          Events.findOne({status:"LIVE"}).jointUuid?.length
        votedAudiences: ->
          Events.findOne({status:"LIVE"}).votedUuid?.length

    waitOn: ->

      unless Cookies.get "uuid"
        chance = new Chance
        uuid = chance.guid()
        Cookies.set "uuid", uuid

      Tracker.autorun ->
        liveEvent = Events.findOne status:"LIVE"
        if liveEvent
          Meteor.call "uuidJoinEvent", liveEvent._id, Cookies.get "uuid"

      unless Cookies.get "uuid"
        chance = new Chance
        uuid = chance.guid()
        Cookies.set "uuid", uuid



  @route "speaker",
    path: "/speaker"
    template: "speaker"
    data: ->
      resData =
        myEvents: ->
          Events.find()

    waitOn: ->
      unless Cookies.get "uuid"
        chance = new Chance
        uuid = chance.guid()
        Cookies.set "uuid", uuid


  @route "admin",
    path: "/admin"
    template: "admin"
    waitOn: ->
      unless Cookies.get "uuid"
        chance = new Chance
        uuid = chance.guid()
        Cookies.set "uuid", uuid
