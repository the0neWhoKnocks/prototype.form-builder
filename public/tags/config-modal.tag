<config-modal if={ showModal }>
  <div class="config-modal-bg" onclick={ handleModalClose }></div>
  <div class="config-modal">
    <form 
      name="configModalForm" 
      autocomplete="off" 
      onsubmit={ handleSubmit }
    >
      <input if={ opts.type == 'text' } name={ opts.name } type="text" value={ opts.val } />
      <div if={ opts.type == 'keyValue' }>
        <nav class="config-modal__key-val-nav">
          <input 
            type="number" 
            class="config-modal__add-count js-addCount" 
            value="1" 
          />
          <button 
            type="button"
            class="config-modal__add-btn"
            onclick={ handleAddNodeClick }
          >Add</button>
        </nav>
        <div 
          each={ opt, nodeCount in opts.val }
          class="js-keyValueNode"
          data-node={ nodeCount }
        >
          <input 
            each={ key, val in opt }
            type="text" 
            name="node[{ nodeCount }][{ key }]" 
            value={ val }
            placeholder={ key }
          />
          <button 
            type="button"
            class="config-modal__delete-btn"
            onclick={ handleDeleteNodeClick }
          >Delete</button>
        </div>
      </div>
      <button class="config-modal__update-btn">Update</button>
    </form>
  </div>
  
  <style scoped>
    :scope {
      font-size: 1.25rem;
      position: fixed;
      top: 0;
      right: 0;
      bottom: 0;
      left: 0;
      /* 
        needed for centering. using this technique since the transform technique
        was causing blurred text.
      */
      display: -webkit-box;
      display: -webkit-flex;
      display: -ms-flexbox;
      display: flex;
      -webkit-box-pack: center;
      -webkit-justify-content: center;
      -ms-flex-pack: center;
      justify-content: center;
      -webkit-box-align: center;
      -webkit-align-items: center;
      -ms-flex-align: center;
      align-items: center;
    }
    
    .config-modal-bg {
      background: rgba(0, 0, 0, 0.5);
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      z-index: -1;
    }
    
    .config-modal {
      padding: 1em;
      border: solid 1px #333;
      border-radius: 0.25em;
      background: #eee;
    }
    
    .config-modal button,
    .config-modal input {
      font-size: inherit;
      padding: 0.5em;
    }
    
    .config-modal button {
      cursor: pointer;
    }
    
    .config-modal__key-val-nav {
      text-align: right;
      padding: 0.5em;
      margin: 0 -8px 0.5em;
      background: #333;
    }
    
    .config-modal__add-count {
      width: 80px;
    }
    
    .config-modal__add-btn,
    .config-modal__delete-btn {
      width: 82px;
    }
    
    .config-modal__update-btn {
      width: 100%;
      margin-top: 0.5em;
      display: block;
    }
  </style>
  
  <script>
    var _self = this;
    
    this.showModal = false;
    this.opts = {};
    this.cache = undefined;
    
    function hasClass(cl, el){
      return (el.className) ? el.className.split(' ').indexOf( cl.replace('.', '') ) > -1 : false;
    };
    
    function closest(cl, el){
      cl = cl.replace('.', '');

      while( el.parentNode ){
        el = el.parentNode;
        
        if( hasClass(cl, el) ){
          return el;
          break;
        }
      }
      
      return;
    };
    
    function simpleClone(obj){
      return JSON.parse( JSON.stringify( obj ) );
    };
    
    this.formToData = function(form){
      var field, data = {};
      
      if( typeof form == 'object' && form.nodeName == 'FORM' ){
        for (i=0; i<form.elements.length; i++) {
          field = form.elements[i];
          
          if (field.name && !field.disabled && field.type != 'file' && field.type != 'reset' && field.type != 'submit' && field.type != 'button') {
            if (field.type == 'select-multiple') {
              for (j=form.elements[i].options.length-1; j>=0; j--) {
                if(field.options[j].selected) data[field.name] = field.options[j].value;
              }
            } else if ((field.type != 'checkbox' && field.type != 'radio') || field.checked) {
              var node = field.name.match(/^node\[(\d+)\]\[([\w-]+)\]/i);
              
              if( node ){
                if( field.value != '' ){ 
                  if( !Array.isArray(data) ) data = [];
                  if( !data[node[1]] ) data[node[1]] = {};
                  
                  data[node[1]][node[2]] = field.value;
                }
              }else{
                data[field.name] = field.value;
              }
            }
          }
        }
      }
      
      // remove empty items
      if( Array.isArray(data) ){
        for(var i=data.length-1; i>=0; i--){
          if( !data[i] ){
            data.splice(i, 1);
          }
        }
      }
      
      return data;
    };
    
    this.handleModalClose = function(ev){
      _self.showModal = false;
      _self.opts = {};
    };
    
    this.handleSubmit = function(ev){
      _self.opts.fn( _self.formToData(_self.configModalForm) );
      _self.handleModalClose();
    };
    
    this.handleAddNodeClick = function(ev){
      var count = parseInt(_self.root.querySelector('.js-addCount').value, 10);
      // copy the structure of the last item and use it as a template.
      var obj = simpleClone( _self.opts.val[_self.opts.val.length-1] );
      for(var i in obj){ obj[i] = ''; }
      
      // add the base items
      for( var i=0; i<count; i++ ){
        // if Object isn't unique, it dirties the scope when used in an each.
        var ob = simpleClone( obj );
        _self.opts.val.push( ob );
      }
      
      _self.update();
    };
    
    this.handleDeleteNodeClick = function(ev){
      var el = closest('.js-keyValueNode', ev.target);
      
      _self.opts.val.splice(el.dataset.node, 1);
      _self.update();
    };
    
    RiotControl.on('openConfigModal', function(data){
      _self.opts = data;
      if( typeof data.val == 'function' ) _self.opts.val = data.val();
      _self.showModal = true;
      _self.update();
      _self.configModalForm.querySelector('input').focus();
    });
  </script>
</config-modal>