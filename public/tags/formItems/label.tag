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
        this.label = data.label;
        this.update();
      }
    };
    
    this.configurable = {
      "Change Label": {
        type: 'text',
        name: 'label',
        val: this.label,
        fn: this.setLabel.bind(this)
      }
    };
  </script>
</label-item>