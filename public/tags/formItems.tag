<formItems>
  <div 
    each={ item in opts.formItems }
    class="item" 
    data-item-type="{ item.type }" 
    draggable="true"
    ondragstart={ handleDragStart }
    ondragend={ handleDragEnd }
  >{ item.label }</div>
  
  <style scoped>
    :scope {
      width: 300px;
      display: inline-block;
      vertical-align: top;
      box-sizing: border-box;
    }
    
    .item {
      width: 100%;
      font-size: inherit;
      font-weight: bold;
      text-transform: uppercase;
      padding: 1em;
      border: solid 1px #aaa;
      border-radius: 0.25em;
      display: block;
      background: #eee;
      cursor: -webkit-grab;
      cursor: grab;
      box-sizing: border-box;
      
      // Prevent the text contents of draggable elements from being selectable.
      -moz-user-select: none;
      -khtml-user-select: none;
      -webkit-user-select: none;
      user-select: none;
      // Required to make elements draggable in old WebKit
      -khtml-user-drag: element;
      -webkit-user-drag: element;
    }
    
    .item.is--current {
      background-color: #c2f3f7;
      //cursor: -webkit-grabbing;
      //cursor: grabbing;
    }
  </style>
  
  <script>
    this.handleDragStart = function(ev){
      var el = ev.target;
      
      el.classList.add('is--current');
      ev.dataTransfer.setData('text/plain', JSON.stringify(el.dataset));
      
      return true;
    }
    
    this.handleDragEnd = function(ev){
      var el = ev.target;
      
      el.classList.remove('is--current');
    }

  </script>
</formItems>