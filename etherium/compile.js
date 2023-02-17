// Import different modules:
const path = require('path');
 const fs = require('fs-extra');
 const solc= require('solc');
 const { url } = require('inspector');

 // Delete the entire 'build' folder if exists.
 const buildPath = path.resolve(__dirname, 'build');
 fs.removeSync(buildPath);

// Read 'Post.sol' from the 'contracts' folder
 const lifePath= path.resolve(__dirname,'contracts',   'Life.sol');
 const source = fs.readFileSync(lifePath,'utf-8');
 var input = {
    language: 'Solidity',
    sources: {
             'Life.sol': {
              content: source
   }
},
    settings: {
              outputSelection: {
              '*': {
                 '*': ['*']
                  }
               }
      }
};
var output = JSON.parse(solc.compile(JSON.stringify(input)));