require("./materialize.config.scss")
require "./basic.css"
window.customElements.define "ceri-modal", require "../src/modal.coffee"
createView = require "ceri-dev-server/lib/createView"
module.exports = createView
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
