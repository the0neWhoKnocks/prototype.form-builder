<formBuilder>
  <nav
    class="top-nav"
  >
    <button 
      disabled={ !items.length }
      onclick={ clearFormItems }
    >Clear</button>
    <button disabled>Load</button>
    <button disabled>Save</button>
  </nav>
  <!-- TODO - possibly allow dropping a json file here to load. -->
  <div 
    class="dropzone { items.length ? 'has--items' : '' }"
    ondragenter={ handleDragEnter }
    ondragover={ handleDragOver }
    ondragleave={ handleDragLeave }
    ondrop={ handleDrop }
  >
    <form-item
      each={ item in items }
      ctx="{ item }"
    />
  </div>
  
  <style scoped>
    :scope {
      width: calc(99% - 300px);
      height: 100%;
      display: inline-block;
      box-sizing: border-box;
      vertical-align: top;
    }
    
    button {
      cursor: pointer;
    }
    button:disabled {
      cursor: default;
      opacity: 0.5;
    }
    
    .top-nav {
      width: 100%;
      height: 2.3em;
      text-align: right;
      padding: 0.5em;
      background: #333;
    }
    
    .dropzone {
      height: calc(99% - 2.75em);
      padding: 0.5em;
      border: dashed 1px #aaa;
      margin-top: 0.5em;
      background: #eee;
      position: relative;
    }
    
    .dropzone::after {
      content: 'Drop Items Here';
      font-size: 1.3em;
      padding: 0.5em;
      background: #fff;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
    }
    
    .dropzone.drop-it {
      background-color: #c2f3f7;
    }
    
    .dropzone.has--items::after {
      content: none;
    }
    
    form-item {
      display: inline-block;
    }
    
    [data-is="container-item"] {
      display: block;
    }
  </style>
  
  <script>
    var _self = this;
    
    /*
     * As a note, `items` doesn't keep track of item order after
     * sorting has occurred. For now it's just a mechanism to update
     * the DOM.
     */
    this.items = [];
    this.itemCount = 0;
    
    this.handleDragEnter = function(ev){
      var el = ev.target;
      
      // only highlight when adding an item
      if( ev.dataTransfer.effectAllowed != 'move' ){
        el.classList.add('drop-it');
      }
      
      return true;
    };
    
    this.handleDragOver = function(ev){
      ev.dataTransfer.dropEffect = 'move';  // See the section on the DataTransfer object.
    };

    this.handleDragLeave = function(ev){
      var el = ev.target;
      
      el.classList.remove('drop-it');  // this / e.target is previous target element.
      
      return true;
    };
    
    this.handleDrop = function(ev){
      var el = ev.target;
      var itemData = ev.dataTransfer.getData('text/plain');
      
      el.classList.remove('drop-it');
      
      // Sorting triggers this, so verify the data is JSON
      // before trying to parse.
      if( /^\{/.test(itemData) ){
        itemData = JSON.parse(itemData);
        itemData.tag = itemData.itemType +'-item';
        this.items.push(itemData);
      }
    };
    
    this.clearFormItems = function(ev){
      this.items = [];
    };
    
    this.on('updated', function(ev){
      if( 
        _self.items.length 
        && _self.itemCount != _self.items.length
      ){
        RiotControl.trigger('formItemAdded', _self.items[_self.itemCount]);
        _self.itemCount = _self.items.length;
      }
    });
  </script>
</formBuilder>