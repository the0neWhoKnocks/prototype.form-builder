<container-item>
  <div class="container" type="{ type }"></div>
  
  <style>
    .container {
      padding: 1em;
      border: dashed 1px #333;
      position: relative;
    }
    .container::before {
      content: attr(type);
      opacity: 0.5;
      position: absolute;
      top: 0.5em;
      right: 0.5em;
    }
  </style>
  
  <script>
    this.type = opts.type || 'default';
  </script>
</container-item>