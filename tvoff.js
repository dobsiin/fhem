var lgtv = require("lgtv2")({
    url: 'ws://192.168.1.12:3000'
});

lgtv.on('connect', function () {
    console.log('connected');
    lgtv.request('ssap://system/turnOff', function (err, res) {
        lgtv.disconnect();
    });

});