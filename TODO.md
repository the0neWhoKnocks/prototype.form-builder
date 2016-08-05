# To do

## Server

- [X] Spin up a server to house the GUI & handle the service that'll return the
rendered markup.
- [X] Look into BrowserSync for live reload https://www.browsersync.io/docs/gulp/.

---

## GUI

- [X] Loads form components from a folder.
- [X] Set up a 2 column shell. Left column holds the components, right column is
the drop-zone.
   - [ ] When components are dragged from the left to right, it'll start 
   building out the JSON config Object.
   - [ ] Configs will either be saved locally or to a Database.

---

## Service

- [ ] When passed a config, it'll return the rendered markup.

---

## Bugs

- [X] When options are added for a select, they don't persist when you open the
config modal again.
- [X] When adding multiple options at once the index is the same causing previous
values to be blank since only the last one is written.