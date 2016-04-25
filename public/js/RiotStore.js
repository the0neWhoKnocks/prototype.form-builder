function RiotStore(){
  riot.observable(this);
  
  var _self = this;
  var events = [];
  
  _self.add = function(evName){
    if( events.indexOf(evName) > 0 ){
      events.push(evName);
      
      _self.on(evName, function(){
        _self.trigger.apply(arguments);
      });
    }    
  };
};