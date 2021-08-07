class Account {
  check() {
    const fs = require('fs');
    const path = './../log'; //Location of recorded audio files

    fs.readdir(path, function(err, files) {
      if (err) { throw err; }
      console.log(files);
      const test = /^[0-9]+/g;
      let newFiles = [];
      files.forEach(file => {
        if (test.test(file)) {
          newFiles.push(file);
        }
      })
      console.log(newFiles);

      const currentLogFile = getNewestFile(newFiles, path);
      console.log(currentLogFile);

      const currentLogs = fs.readFileSync(`${path}/${currentLogFile}`, {
        encoding: "utf8"
      });
      console.log(currentLogs);
      const currentLogsLines = currentLogs.split("\n");
      const addressTest = /0x[0-9a-fA-F]{40}/;
      const keyTest = /0x[0-9a-fA-F]{64}/;
      let address, key;
      let searching = [true, true];

      for (let i = 0; i < currentLogsLines.length; i++) {

        const line = currentLogsLines[i];
        address = (searching[0]) ? line.match(addressTest) : address;
        key = (searching[1]) ? line.match(keyTest) : key;
        if (address) {
          console.log(address)
          searching[0] = false;
          
        }
        if (key) {
          console.log(key);
          break;
        }
      }
      const outString = `${address[0]}\n${key[0]}`
      console.log(outString);
      const outFileName = "./../.account";
      fs.writeFileSync(outFileName, outString);
    });

    function getNewestFile(files, path) {
        var out = [];
        files.forEach(function(file) {
            var stats = fs.statSync(path + "/" +file);
            if(stats.isFile()) {
                out.push({"file":file, "mtime": stats.mtime.getTime()});
            }
        });
        out.sort(function(a,b) {
            return b.mtime - a.mtime;
        })
        return (out.length>0) ? out[0].file : "";
    }

  }

};

module.exports = Account;