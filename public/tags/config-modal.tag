<config-modal if={ showModal }>
  <div class="config-modal-bg" onclick={ handleModalClose }></div>
  <div class="config-modal">
    <form name="configModalForm" onsubmit={ handleSubmit }>
      <input if={ opts.type == 'text' } name={ opts.name } type="text" value={ opts.val } />
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
    
    .config-modal__update-btn {
      width: 100%;
      margin-top: 0.5em;
      display: block;
      cursor: pointer;
    }
  </style>
  
  <script>
    var _self = this;
    
    this.showModal = false;
    this.opts = {};
    
    this.formToObject = function(form){
      var field, obj = {};
      
      if( typeof form == 'object' && form.nodeName == 'FORM' ){
        for (i=0; i<form.elements.length; i++) {
          field = form.elements[i];
          
          if (field.name && !field.disabled && field.type != 'file' && field.type != 'reset' && field.type != 'submit' && field.type != 'button') {
            if (field.type == 'select-multiple') {
              for (j=form.elements[i].options.length-1; j>=0; j--) {
                if(field.options[j].selected) obj[field.name] = field.options[j].value;
                //obj.push( encodeURIComponent(field.name) + "=" + encodeURIComponent(field.options[j].value) );
              }
            } else if ((field.type != 'checkbox' && field.type != 'radio') || field.checked) {
              obj[field.name] = field.value;
              //obj.push( encodeURIComponent(field.name) + "=" + encodeURIComponent(field.value) );
            }
          }
        }
      }
      
      //return s.join('&').replace(/%20/g, '+');
      return obj;
    };
    
    this.handleModalClose = function(ev){
      _self.showModal = false;
      _self.update();
    };
    
    this.handleSubmit = function(ev){
      _self.opts.fn( _self.formToObject(_self.configModalForm) );
      _self.handleModalClose();
    };
    
    RiotControl.on('openConfigModal', function(data){
      _self.opts = data;
      _self.showModal = true;
      _self.update();
      _self.configModalForm.querySelector('input').focus();
    });
  </script>
</config-modal>