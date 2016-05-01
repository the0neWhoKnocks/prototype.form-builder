<select-item>
  <label-item 
    if={ labelPos == labelPositions.TOP || labelPos == labelPositions.LEFT } 
    label={ label }
    layout={ labelPos }
  />
  <select name={ name }>
    <!-- 
      account for optgroup
      <optgroup label="">
        <option value="{{value}}">{{label}}</option>
      </optgroup>
    --> 
    <option
      each={ opt in options } 
      value="{ opt.value }"
    >{ opt.label }</option>
  </select>
  <label-item 
    if={ labelPos == labelPositions.BOTTOM || labelPos == labelPositions.RIGHT } 
    label={ label }
    layout={ labelPos }
  />
  
  <script>
    var _self = this;
    
    this.labelPositions = {
      TOP: 'top',
      LEFT: 'left',
      BOTTOM: 'bottom',
      RIGHT: 'right'
    };
    this.label = opts.label || 'Label :';
    this.labelPos = opts.labelPos || this.labelPositions.LEFT;
    this.name = opts.name || 'default';
    this.options = opts.options || [
      {
        'label': 'Label',
        'value': '_temp_'
      }
    ];
    
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
    
    this.setOptions = function(data){
      if( data ){
        _self.options = data;
        _self.update();
      }
    };
    
    this.getOptions = function(){
      return _self.options;
    };
    
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
      },
      "Change Options": {
        type: 'keyValue',
        name: 'options',
        val: this.getOptions,
        fn: this.setOptions.bind(_self)
      }
    };
  </script>
</select-item>