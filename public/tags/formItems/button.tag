<button-item>
  <button type="{ type }">{ label }</button>
  
  <style scoped>
    button {
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
  </script>
</button-item>