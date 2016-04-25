<form-item oncontextmenu={ handleRightClick }>
  <script>
    var _self = this;
    
    this.handleRightClick = function(ev){
      var tag = this.root._tag;
      
      if( tag.configurable ){
        RiotControl.trigger('openContextMenu', {
          items: tag.configurable,
          mouseEvent: ev
        });
      }
    };
    
    RiotControl.on('contextItemSelected', function(data){
      RiotControl.trigger('openConfigModal', data);
    });
    
    riot.mount(this.root, opts.ctx.tag, opts.ctx);
  </script>
</form-item>