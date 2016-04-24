var path = require('path');
var fs = require('fs-extra');
var express = require('express');
var expHbs = require('express-handlebars');
var riot = require('riot');
var color = require('cli-color');
var exec = require('child_process').exec;
var opn = require('opn');
var conf = {
  PORT: 8080,
  paths: {
    PUBLIC: path.resolve(__dirname +'/public'),
    NODE_MODULES: path.resolve(__dirname +'/node_modules')
  }
};
conf.paths.VIEWS = conf.paths.PUBLIC+'/views';
conf.paths.TAGS = conf.paths.PUBLIC+'/tags';
conf.paths.JS = conf.paths.PUBLIC+'/js';
conf.paths.FORM_ITEMS = conf.paths.TAGS+'/formItems';
var OS = function(){
  var platform = process.platform;
  
  if( /^win/.test(platform) ) return 'WINDOWS';
  else if( /^darwin/.test(platform) ) return 'OSX';
  else if( /^linux/.test(platform) ) return 'LINUX';
  else return platform;
}();
var CHROME = function(){
  switch(OS){
    case 'WINDOWS': return 'chrome';
    case 'OSX': return 'google chrome';
    case 'LINUX': return 'google-chrome';
  }
}();
var formItems = require(conf.paths.TAGS+'/formItems.tag');
var formBuilder = require(conf.paths.TAGS+'/formBuilder.tag');

var app = {
  init: function(callback){
    this.server = express();
    // set up server templating engine
    this.server.engine('.hbs', expHbs({
      extname: '.hbs',
      defaultLayout: 'shell',
      layoutsDir: conf.paths.VIEWS +'/layouts'
    }));
    this.server.set('view engine', '.hbs');
    // set path to templates
    this.server.set('views', conf.paths.VIEWS);
    // doc root is `public`
    this.server.use(express.static(conf.paths.PUBLIC));
    // bind server routes
    this.setupRoutes();
    this.addServerListeners(callback);
  },
  
  util: {
    copyFiles: function(files, callback){
      var ndx = 0;
  
      console.log("\n");
      
      function copy(file){
        var output = path.resolve(conf.paths.JS +'/'+ path.basename(file));
        file = path.resolve(file);
        
        fs.copy(file, output, function(err){
          if(err){
            console.log("\n "+ color.red.bold('[ERROR]'), err);
          }else{
            console.log('', color.green.bold('[COPIED]'), path.basename(output));
            ndx++;
            
            if( ndx === files.length ) callback();
            else copy(files[ndx]);
          }
        });
      }
      
      copy(files[ndx]);
    },
    
    compileRiotTags: function(callback){
      // compile tags for client-side viewing
      // TODO - It may be better to just load the `riot+compiler.min.js` file and not pre-compile.
      console.log("\n "+ color.green.bold('[COMPILING]') +" Riot tags for client-side rendering.\n");
      
      var cmd = 'riot '+ conf.paths.TAGS +'/ '+ conf.paths.JS +'/tags.js';
      
      exec(cmd, function(error, stdout, stderr){
        var i;
        var lines = stdout.split(/\r\n|\n/);
        lines.pop(); // last item is just a new line.
        
        for(i=0; i<lines.length; i++){
          var line = lines[i].split(' -> ');
          lines[i] = '  '+ path.basename(line[0]).replace('.tag', '') +' '+ color.cyan('➜') +' '+ path.basename(line[1]);
        }
        
        console.log(lines.join("\n"));
        
        callback();
      });
    }
  },
  
  setupRoutes: function(){
    this.server.get('/', function(req, res){
      var model = {
        formItems: []
      };
      
      fs.readdirSync(conf.paths.FORM_ITEMS).forEach(function(item){
        var name = item.replace(/\.tag$/, '');
        var itemData = {
          type: name,
          label: name
        };
        
        model.formItems.push(itemData);
      });
      
      // Have to double up here to achieve server-side renders & client-side bindings.
      res.render('admin', {
        formItems: riot.render(formItems, model),
        formBuilder: riot.render(formBuilder, model),
        model: JSON.stringify(model)
      });
    });
  },
  
  addServerListeners: function(callback){
    var _self = this;
    
    this.server.listen(conf.PORT, function(){
      _self.util.compileRiotTags(function(){
        // copy over any assets needed by the frontend
        _self.util.copyFiles.call(_self, [
          conf.paths.NODE_MODULES +'/riot/riot.min.js',
          conf.paths.NODE_MODULES +'/riot/riot+compiler.min.js'
        ], function(){
          var url = 'http://localhost:'+ conf.PORT +'/';
          
          // let the user know the server is up and ready
          console.log("\n "+ color.green.bold('[SERVER]') +" Running at "+ url +"\n");
          
          /* BrowserSync handles opening now
          opn(url, {
            app: [CHROME]
          });
          */
          
          callback({
            url: url,
            port: conf.PORT,
            browser: CHROME
          });
        });
      });
    });
  }
};


module.exports = app;
var args = process.argv;
if( 
  // CLI won't have parent
  !module.parent
  // First arg is node executable, second arg is the .js file, the rest are user args
  && args.length >= 3
){
  if( app[args[2]] ) app[args[2]]();
}