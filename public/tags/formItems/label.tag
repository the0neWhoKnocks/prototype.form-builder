<label-item>
  <label class="pos-{ layout }">{ label }</label>
  
  <style scoped>
    label.pos-top,
    label.pos-bottom {
      display: block;
    }
    label.pos-top {
      margin-bottom: 0.5em;
    }
    label.pos-left {
      margin-right: 0.5em;
    }
    label.pos-bottom {
      margin-top: 0.5em;
    }
    label.pos-right {
      margin-left: 0.5em;
    }
  </style>
  
  <script>
    var _self = this;
    
    this.layouts = {
      TOP: 'top',
      LEFT: 'left',
      BOTTOM: 'bottom',
      RIGHT: 'right'
    };
    this.label = opts.label || 'Default:';
    this.layout = opts.layout || this.layouts.LEFT;
    
    this.setLabel = function(data){
      if( data ){
        _self.label = data.label;
        _self.update();
      }
    };
    
    this.getLabel = function(){
      return _self.label;
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
      }
    };
  </script>
</label-item>