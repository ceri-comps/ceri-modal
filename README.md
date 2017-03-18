# ceri-modal

the best modal you can get.

Features:
- plain JS
- 25kB unzipped with animations - even smaller when using multiple ceri components
- themeable
- use in your markup - easy to reason about


### [Demo](https://ceri-comps.github.io/ceri-modal)

# Install

```sh
npm install --save-dev ceri-modal
```

## Usage
- [general ceri component usage instructions](https://github.com/cerijs/ceri#i-want-to-use-a-component-built-with-ceri)
- in your project
```coffee
window.customElements.define("ceri-modal", require("ceri-modal"))
```
```html
<!-- as sibling (preferred) -->
<button> Open Modal </button>
<ceri-modal attach>
    Content
</ceri-modal>
<!-- as child -->
<button> Open Modal 
  <ceri-modal attach>
      Content
  </ceri-modal>
</button>
```

For examples see [`dev/`](dev/).

Note, that the modal will be appended to `document.body` on first opening.

#### Props
Name | type | default | description
---:| --- | ---| ---
attach | Boolean | false | will set a click listener on sibling or parent to toggle the modal
opacity | Number | 0.5 | opacity of the overlay
keep-open | Boolean | false | will be not close on click on overlay or ESC
open | Boolean | false | set to open / close
z-index | Number | 1500 | minimum zIndex of the overlay
bottom-sheet | Boolean | false | will appear from below


#### Events
Name |  description
---:| ---
toggled(isOpened:Boolean) | emitted before open and after close

#### Themes
- [ceri-materialize](https://github.com/ceri-comps/ceri-materialize)
```html
<button class=btn>Click me!</button>
<!-- 
add fixed-footer class for fixed-footer 
and/or bottom-sheet attribute for bottom-sheet
-->
<ceri-modal class=materialize attach> 
  <div class=modal-content>
    someContent
  </div>
  <div class=modal-footer>
    footer content
  </div>
</ceri-modal>
```

#### Custom animation
- read the documentation of the [animate mixin](https://github.com/cerijs/ceri#animate).
- read and understand the default animation in [src/modal.coffee](src/modal.coffee)
- you can provide a custom animation like this:
```coffee
# application wide
CEModal = require("ceri-modal")
CEModal.prototype.enter = (o) -> # your new enter animation
CEModal.prototype.leave = (o) -> # your new leave animation
window.customElements.define("ceri-modal", CEModal)
# single instance
# get a ref to your instance of ceri-modal somehow
# then overwrite the animations directly
ceModal.enter = (o) -> # your new enter animation
ceModal.leave = (o) -> # your new leave animation
```

# Development
Clone repository.
```sh
npm install
npm run dev
```
Browse to `http://localhost:8080/`.

## License
Copyright (c) 2016 Paul Pflugradt
Licensed under the MIT license.
