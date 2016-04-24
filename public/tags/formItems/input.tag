<input-item>
  <label-item 
    if={ labelPos == labelPositions.TOP || labelPos == labelPositions.LEFT } 
    label="{ label }" 
    layout="{ labelPos }"
  />
  <input type="{ type }"></input>
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
    this.label = opts.label || 'Input';
    this.labelPos = opts.labelPos || this.labelPositions.LEFT;
  </script>
</input-item>