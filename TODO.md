# To do

## Server

- [X] Spin up a server to house the GUI & handle the service that'll return the
rendered markup.
- [ ] Look into BrowserSync for live reload https://www.browsersync.io/docs/gulp/.


## GUI

- [X] Loads form components from a folder.
- [ ] Set up a 2 column shell. Left column holds the components, right column is
the drop-zone.
   - [ ] When components are dragged from the left to right, it'll start 
   building out the JSON config Object.
   - [ ] Configs will either be saved locally or to a Database.


## Service

- [ ] When passed a config, it'll return the rendered markup.