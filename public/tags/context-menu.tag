<context-menu if={ contextItems }>
  <nav 
    class="context-menu"
    style="top:{ yPos }px; left:{ xPos }px;"
    name="contextMenuNav"
  >
    <button 
      class="context-menu__btn" 
      each={ item, i in contextItems } 
      onclick={ handleContextItemClick } 
      data-ndx="{ i }"
    >{ item.label }</button>
  </nav>
  
  <style scoped>
    :scope {
      position: absolute;
      top: 0;
      left: 0;
      bottom: 0;
      right: 0;
      pointer-events: none;
    }
    
    .context-menu {
      border: solid 1px #aaa;
      background: #fff;
      position: absolute;
      z-index: 1000;
      box-shadow: 3px 3px 2px 0 rgba(0,0,0,0.4);
      pointer-events: all;
    }
    
    .context-menu__btn {
      width: 100%;
      text-align: left;
      white-space: nowrap;
      padding: 0.5em 1em;
      border: none;
      background: transparent;
      cursor: default;
    }
    .context-menu__btn:hover {
      color: #fff;
      background: #007CFF;
    }
  </style>
  
  <script>
    var _self = this;
    
    this.contextItems = undefined;
    this.xPos = 0;
    this.yPos = 0;
    
    function cloneObject(obj) {
      if (obj === null || typeof obj !== 'object') return obj;
   
      var temp = obj.constructor();
      
      for (var key in obj) {
        temp[key] = cloneObject(obj[key]);
      }
   
      return temp;
    }
    
    this.handleContextItemClick = function(ev){
      var opts = _self.contextItems[ev.target.dataset.ndx].opts;
      
      _self.handleContextMenuClose();
      RiotControl.trigger('contextItemSelected', opts);
    };
    
    this.handleContextMenuClose = function(ev){
      if( !ev || _self.currTarget != ev.target ){
        // don't remove menu if a menu item was clicked
        if( ev ){
          if( _self.contextMenuNav == ev.target.parentNode ) return true;
        }
        
        document.removeEventListener('mousedown', _self.handleContextMenuClose.bind(_self));
        document.removeEventListener('contextmenu', _self.handleContextMenuClose.bind(_self));
        
        _self.contextItems = undefined;
        _self.update();
      }
    };
    
    this.handleContextMenuOpen = function(data){
      var menu = [];
      
      Object.keys(data.items).forEach(function(label){
        menu.push({
          label: label,
          opts: cloneObject(data.items[label])
        });
      });
      
      if( !_self.contextItems ){
        // add global listeners so the menu can be closed when a user clicks outside of the menu.
        document.addEventListener('mousedown', _self.handleContextMenuClose.bind(_self), false);
        document.addEventListener('contextmenu', _self.handleContextMenuClose.bind(_self), false);
      }
      
      _self.contextItems = menu;
      _self.currTarget = data.mouseEvent.target;
      _self.xPos = data.mouseEvent.pageX;
      _self.yPos = data.mouseEvent.pageY;
      _self.update();
    };
    
    RiotControl.on('openContextMenu', this.handleContextMenuOpen.bind(_self));
  </script>
</context-menu>