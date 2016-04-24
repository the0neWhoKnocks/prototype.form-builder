<form-item oncontextmenu={ handleRightClick }>
  <nav class="context-menu" if={ contextItems }>
    <button 
      class="context-menu__btn" 
      each={ item, i in contextItems } 
      onclick={ handleContextItemClick } 
      data-ndx="{ i }"
    >{ item.label }</button>
  </nav>
  
  <style scoped>
    :scope {
      position: relative;
    }
    
    .context-menu {
      border: solid 1px #aaa;
      background: #fff;
      position: absolute;
      top: 0;
      right: 0;
      z-index: 1000;
      box-shadow: 3px 3px 2px 0 rgba(0,0,0,0.4);
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
    
    this.handleRightClick = function(ev){
      var tag = this.root._tag;
      
      if( tag.configurable ){
        var menu = [];
        
        Object.keys(tag.configurable).forEach(function(label){
          menu.push({
            label: label,
            callback: tag.configurable[label]
          });
        });
        
        _self.contextItems = menu;
      }
    };
    
    this.handleContextItemClick = function(ev){
      var callback = _self.contextItems[ev.target.dataset.ndx].callback;
      _self.contextItems = undefined;
      _self.update();
      callback();
    };
    
    riot.mount(this.root, opts.ctx.tag, opts.ctx);
  </script>
</form-item>