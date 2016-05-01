<input-item>
  <label-item 
    if={ labelPos == labelPositions.TOP || labelPos == labelPositions.LEFT } 
    label="{ label }" 
    layout="{ labelPos }"
  />
  <input type={ type } name={ name }></input>
  <label-item 
    if={ labelPos == labelPositions.BOTTOM || labelPos == labelPositions.RIGHT } 
    label="{ label }" 
    layout="{ labelPos }"
  />
  
  <style scoped>
    input {
      padding: 0.5em 1em;
    }
  </style>
  
  <script>
    var _self = this;
    
    this.labelPositions = {
      TOP: 'top',
      LEFT: 'left',
      BOTTOM: 'bottom',
      RIGHT: 'right'
    };
    this.types = {
      TEXT: 'text',
      PASSWORD: 'password',
      RADIO: 'radio', 
      CHECKBOX: 'checkbox',
      // HTML5
      COLOR: 'color', 
      DATE: 'date', 
      DATETIME: 'datetime', 
      DATETIME_LOCAL: 'datetime-local', 
      EMAIL: 'email', 
      MONTH: 'month', 
      NUMBER: 'number', 
      RANGE: 'range', 
      SEARCH: 'search', 
      TEL: 'tel', 
      TIME: 'time', 
      URL: 'url', 
      WEEK: 'week'
    };
    this.type = opts.type || this.types.TEXT;
    this.label = opts.label || 'Label :';
    this.labelPos = opts.labelPos || this.labelPositions.LEFT;
    this.name = opts.name || 'default';
    
    this.setLabel = function(data){
      if( data ){
        _self.label = data.label;
        _self.update();
      }
    };
    
    this.getLabel = function(){
      return _self.label;
    };
    
    this.setName = function(data){
      if( data ){
        _self.name = data.name;
        _self.update();
      }
    };
    
    this.getName = function(){
      return _self.name;
    };
    
    // fires when the tag is nested & opts are changed
    this.on('update', function(ev){
      _self.update(opts);
    });
    
    this.configurable = {
      "Change Label": {
        type: 'text',
        name: 'label',
        val: this.getLabel,
        fn: this.setLabel.bind(_self)
      },
      "Change Name": {
        type: 'text',
        name: 'name',
        val: this.getName,
        fn: this.setName.bind(_self)
      }
    };
  </script>
</input-item>