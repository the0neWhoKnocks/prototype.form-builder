# Form Builder [WIP]

A GUI that allows a normal user to build out HTML forms. A configuration of the
form will be saved in JSON format to allow for loading/editing/saving.


## Installation

```
npm i -dd -g riot gulp
npm i -dd
```

## Start App

```
// for prod
npm run app

// for dev
gulp app
```

## Riot JS Notes

- When events are set on markup, you can't `bind` `this`, so the handler won't
work as expected if it's trying to update internal properties. It's best to set
a top level var like `var _self = this;` and then reference `_self` inside of
the handler. Then if the markup is dependant on internal props, it'll update
automatically when the handler updates the props.

- If a function that's not added via a markup binding (like `onclick`), you'll
have to call `this.update()` to get markup to change after data is updated.