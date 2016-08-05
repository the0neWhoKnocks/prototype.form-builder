<button-item>
  <button class="btn" type="{ type }">{ label }</button>
  
  <style scoped>
    .btn {
      font-weight: bold;
      padding: 0.5em 1em;
      cursor: pointer;
    }
  </style>
  
  <script>
    var _self = this;
    
    this.types = {
      BUTTON: 'button',
      SUBMIT: 'submit'
    };
    this.type = opts.type || this.types.BUTTON;
    this.label = opts.label || 'CTA';
    
    this.setBtnText = function(data){
      if( data ){
        _self.label = data.label;
        _self.update();
      }
    };
    
    this.getBtnText = function(){
      return _self.label;
    };
    
    this.configurable = {
      "Change Text": {
        type: 'text',
        name: 'label',
        val: this.getBtnText,
        onSave: this.setBtnText.bind(this)
      }
    };
  </script>
</button-item>