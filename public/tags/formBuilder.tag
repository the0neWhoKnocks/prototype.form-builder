<formBuilder>
  <nav
    class="top-nav"
  >
    <button>Clear</button>
    <button>Load</button>
    <button>Save</button>
  </nav>
  <!-- TODO - possibly allow dropping a json file here to load. -->
  <div 
    class="dropzone { items.length ? 'has--items' : '' }"
    ondragenter={ handleDragEnter }
    ondragover={ handleDragOver }
    ondragleave={ handleDragLeave }
    ondrop={ handleDrop }
  >
    <ul class="list">
      <li each={ item in items }>
        <form-item ctx="{ item }" />
      </li>
    </ul>
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
    
    .list {
      list-style: none;
      padding: 0;
      margin: 0;
    }
  </style>
  
  <script>
    this.items = [];
    
    this.handleDragEnter = function(ev){
      var el = ev.target;
      
      el.classList.add('drop-it');
      
      return true;
    }
    
    this.handleDragOver = function(ev){
      ev.dataTransfer.dropEffect = 'move';  // See the section on the DataTransfer object.
    }

    this.handleDragLeave = function(ev){
      var el = ev.target;
      
      el.classList.remove('drop-it');  // this / e.target is previous target element.
      
      return true;
    }
    
    this.handleDrop = function(ev){
      var el = ev.target;
      var itemData = JSON.parse(ev.dataTransfer.getData('text/plain'));
      itemData.tag = itemData.itemType +'-item';
      
      el.classList.remove('drop-it');
      
      this.items.push(itemData);
    }
  </script>
</formBuilder>