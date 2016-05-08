<form-item-config>
  <input if={ opts.type == 'text' } name={ opts.name } type="text" value={ confVal }>
  <div if={ opts.type == 'keyValue' }>
    <nav class="form-item-config__key-val-nav">
      <input 
        type="number" 
        class="form-item-config__add-count js-addCount" 
        value="1" 
      >
      <button 
        type="button"
        class="form-item-config__add-btn"
        onclick={ handleAddNodeClick }
      >Add</button>
    </nav>
    <div 
      each={ opt, nodeCount in confVal }
      class="js-keyValueNode"
      data-node={ nodeCount }
    >
      <input 
        each={ key, val in opt }
        type="text" 
        name="node[{ nodeCount }][{ key }]" 
        value={ val }
        placeholder={ key }
      >
      <button 
        type="button"
        class="form-item-config__delete-btn"
        onclick={ handleDeleteNodeClick }
      >Delete</button>
    </div>
  </div>
  <div if={ opts.type == 'radio' }>
    <div each={ rad, key in confVal }>
      <label class="form-item-config__radio-label">
        <input 
          type="radio" 
          name={ parent.opts.name }
          value={ rad.value }
          checked={ rad.checked }
        >{ rad.text }
      </label>
    </div>
  </div>
  
  <style scoped>
    .form-item-config__key-val-nav {
      text-align: right;
      padding: 0.5em;
      margin: 0 -8px 0.5em;
      background: #333;
    }
    
    .form-item-config__add-count {
      width: 80px;
    }
    
    .form-item-config__add-btn,
    .form-item-config__delete-btn {
      width: 82px;
    }
    
    .form-item-config__radio-label {
      text-transform: capitalize;
      margin-bottom: 0.5em;
      display: block;
    }
    
    .form-item-config__radio-label > input {
      width: 1em;
      height: 1em;
      margin-right: 0.5em;
      vertical-align: top;
    }
  </style>
  
  <script>
    var _self = this;
    
    this.confVal = getVal(opts.val);
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
    
    function getVal(val){
      return ( typeof val === 'function' )
        ? val()
        : val;
    };
    
    this.handleAddNodeClick = function(ev){
      var count = parseInt(_self.root.querySelector('.js-addCount').value, 10);
      // copy the structure of the last item and use it as a template.
      var obj = simpleClone( _self.confVal[_self.confVal.length-1] );
      for(var i in obj){ obj[i] = ''; }
      
      // add the base items
      for( var i=0; i<count; i++ ){
        // if Object isn't unique, it dirties the scope when used in an each.
        var ob = simpleClone( obj );
        _self.confVal.push( ob );
      }
      
      _self.update();
    };
    
    this.handleDeleteNodeClick = function(ev){
      var el = closest('.js-keyValueNode', ev.target);
      
      _self.confVal.splice(el.dataset.node, 1);
      _self.update();
    };
  </script>
</form-item-config>