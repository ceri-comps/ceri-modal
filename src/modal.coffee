
ceri = require "ceri/lib/wrapper"
module.exports = ceri

  mixins: [
    require "ceri/lib/props"
    require "ceri/lib/style"
    require "ceri/lib/open"
    require "ceri/lib/overlay"
  ]

  props:
    opacity:
      type: Number
      default: 0.5
    keepOpen:
      type: Boolean
    zIndex:
      type: Number
      default: 1500
    bottomSheet:
      type: Boolean
    attach:
      type: String
  

  events:
    click:
      target:
        active: -> @target and !@openingOrOpen
        notPrevented: true
        prevent: true
        cbs: "show"
        destroy: true

  computed:
    target: ->
      if @attach
        return document.querySelector(@attach)
      else if @attach?
        if @__placeholder.previousElementSibling
          return @__placeholder.previousElementSibling
        else
          return @__parentElement
      return null
  data: ->
    onBody: true
  overlay:
    zIndex: "zIndex"
    active: "openingOrOpen"
    animate: "toggleAnimate"
    keepOpen: "keepOpen"
    delay: true
    onClose: "hide"
    onOpen: (zIndex) -> @style.zIndex = zIndex+1
  initStyle:
    position: "fixed"
    left: 0
    right: 0
    display: "block"
  methods:
    enter: (o) ->
      if @bottomSheet
        o.style =
          bottom: [-100,0,"%"]
          opacity: [0,1]
      else
        o.style =
          top: [4,10,"%"]
          opacity: [0,1]
          scaleX: [0.7,1]
      return @$animate(o)
    leave: (o) ->
      o.duration = 200
      if @bottomSheet
        o.style =
          bottom: [0,-100,"%"]
          opacity: [1,0]
      else
        o.style =
          top: [10,4,"%"]
          opacity: [1,0]
          scaleX: [1,0.7]
      return @$animate(o)