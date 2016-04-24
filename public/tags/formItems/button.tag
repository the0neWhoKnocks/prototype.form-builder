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
    this.types = {
      BUTTON: 'button',
      SUBMIT: 'submit'
    };
    this.type = opts.type || this.types.BUTTON;
    this.label = opts.label || 'CTA';
    
    this.setBtnText = function(){
      var text = prompt("Enter button text", this.label);

      if( text ){
        this.label = text;
        this.update();
      }
    };
    
    this.configurable = {
      "Change Text": this.setBtnText.bind(this)
    };
  </script>
</button-item>