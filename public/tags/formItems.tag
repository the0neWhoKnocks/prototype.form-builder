<formItems>
  <button 
    each={ item in opts.formItems }
    class="item"
    type="{ item.type }" 
    onmousedown={ startDrag }
  >{ item.label }</button>
  
  <style scoped>
    :scope {
      width: 300px;
      display: inline-block;
    }
    
    .item {
      width: 100%;
      font-size: inherit;
      font-weight: bold;
      text-transform: uppercase;
      padding: 1em;
      display: block;
      cursor: -webkit-grab;
      cursor: grab;
    }
    
    .item:active {
      cursor: -webkit-grabbing;
      cursor: grabbing;
    }
  </style>
  
  <script>
    startDrag(ev){
      console.log('Start dragging item', ev.item.item.type);
    }
  </script>
</formItems>