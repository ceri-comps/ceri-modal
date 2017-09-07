require("./materialize.config.styl")

window.customElements.define "ceri-modal", require "../src/modal.coffee"
createView = require "ceri-dev-server/lib/createView"
module.exports = createView
  mixins: [
    require "ceri/lib/watch"
  ]
  structure: template 1, """

    <button>click</button>
    <ceri-modal #ref=modal attach>
      <p>Close by hitting ESC or clicking outside of the modal.</p>
    </ceri-modal>

    <button @click.toggle="open">keep-open</button>
    <ceri-modal #ref=keepOpen keep-open :open=open>
      <p>can only be closed by button:</p>
      <button @click.toggle="open">close</button>
    </ceri-modal>
    

    <br/>

    <button class=btn>materialize</button>
    <ceri-modal class=materialize attach>
      <p class=modal-content>Close by hitting ESC or clicking outside of the modal.</p>
    </ceri-modal>
    <button class=btn>bottom-sheet</button>
    <ceri-modal class=materialize bottom-sheet attach>
      <p class=modal-content>Close by hitting ESC or clicking outside of the modal.</p>
    </ceri-modal>
    <button class=btn>fixed-footer</button>
    <ceri-modal class="materialize fixed-footer" bottom-sheet attach>
      <p class=modal-content>Close by hitting ESC or clicking outside of the modal.</p>
      <div class="modal-footer">
        <a href="#!" class="btn-flat">Agree</a>
      </div>
    </ceri-modal>
    <br/><br/><br/>

    <a href="https://github.com/ceri-comps/ceri-modal/blob/master/dev/basic.ceri">source</a>
    """
  data: ->
    open: false
  tests: ceriModal: ->
    mouseClick = ->
      evt = document.createEvent("MouseEvents")
      evt.initMouseEvent(
        "click",
        true,
        true,
        window,
        1,
        10,
        10,
        10,
        10,
        false,
        false,
        false,
        false,
        0,
        null
        )
      return evt
    it "should work", (done) =>
      @modal.open = true
      @modal.animation.toEnd()
      requestAnimationFrame => requestAnimationFrame =>
        len = document.body.children.length
        document.body.children[len-2].should.have.attr("style").match /z-index: 1501/
        document.body.children[len-1].should.have.attr("style").match /z-index: 1500/
        @keepOpen.open = true
        @keepOpen.animation.toEnd()
        requestAnimationFrame => requestAnimationFrame =>
          len = document.body.children.length
          document.body.children[len-1].should.have.attr("style").match /z-index: 1506/
          document.body.children[len-2].should.have.attr("style").match /z-index: 1505/
          document.dispatchEvent(mouseClick())
          @$nextTick => @$nextTick =>
            @keepOpen.open.should.be.true
            @keepOpen.open = false
            @keepOpen.animation.toEnd()
            requestAnimationFrame => requestAnimationFrame =>
              len = document.body.children.length
              document.body.children[len-1].should.have.attr("style").match /z-index: 1500/
              document.body.children[len-1].dispatchEvent(mouseClick())
              @modal.animation.toEnd()
              requestAnimationFrame => requestAnimationFrame =>
                @modal.open.should.be.false
                done()