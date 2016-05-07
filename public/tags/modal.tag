<modal if={ showModal }>
  <div class="modal-bg" onclick={ handleModalClose }></div>
  <div class="modal">
    <form 
      id="modalForm" 
      autocomplete={ autocomplete } 
      onsubmit={ handleSubmit }
    >
      <div id="modalFormBody"></div>
      <nav>
        <button 
          class="modal__cancel-btn"
          onclick={ handleModalClose }
        >{ cancelBtnText }</button>
        <button 
          id="modalFormSubmitBtn"
          class="modal__submit-btn"
        >{ submitBtnText }</button>
      </nav>
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
    
    .modal-bg {
      background: rgba(0, 0, 0, 0.5);
      position: fixed;
      top: 0;
      left: 0;
      right: 0;
      bottom: 0;
      z-index: -1;
    }
    
    .modal {
      padding: 1em;
      border: solid 1px #333;
      border-radius: 0.25em;
      background: #eee;
    }
    
    .modal button,
    .modal input {
      font-size: inherit;
      padding: 0.5em;
    }
    
    .modal button {
      cursor: pointer;
    }
    
    .modal__cancel-btn,
    .modal__submit-btn {
      width: 49%;
      margin-top: 0.5em;
      display: inline-block;
    }
  </style>
  
  <script>
    var _self = this;
    
    this.autocomplete = opts.autocomplete || 'on';
    this.modalBody = opts.modalBody || '';
    this.cancelBtnText = opts.cancelBtnText || 'Cancel';
    this.submitBtnText = opts.submitBtnText || 'Submit';
    this.showModal = false;
    this.modalOpts = {};
    this.mountedTags = [];
    
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
      // unmount internal tags
      if( _self.mountedTags.length ){
        for(var i in _self.mountedTags){
          _self.mountedTags[i].unmount();
        }
        
        _self.mountedTags = [];
      }
      
      _self.showModal = false;
      _self.modalOpts = {};
    };
    
    this.handleSubmit = function(ev){
      if( _self.modalOpts.onSave ){
        _self.modalOpts.onSave( _self.formToData(_self.modalForm) );
      }
      
      _self.handleModalClose();
    };
    
    /**
     * @param {object} data - The data for the modal.
     * @example
     * {
     *   modalBody: '<tag-name id="fu" prop="val" /><input type="text" value="fu">',
     *   tags: ['#fu'],
     *   onSave: function(ev){...}
     * }
     */
    RiotControl.on('openModal', function(data){
      // set props from data
      for(var i in data){
        if( _self[i] !== undefined ) _self[i] = data[i];
      }
      
      _self.modalOpts = data;
      _self.showModal = true;
      _self.modalFormBody.innerHTML = _self.modalBody;
      
      // render the modal
      _self.update();
      
      // mount any tags (by Id) within the `modalBody`
      if( data.tags ){
        for(var i in data.tags){
          _self.mountedTags.push(riot.mount(data.tags[i])[0]);
        }
      }
      
      // focus an element within the modal for accessibilty.
      var firstInput = _self.modalForm.querySelector('input');
      
      if( firstInput ) firstInput.focus();
      else _self.modalFormSubmitBtn.focus();
    });
  </script>
</modal>