function ajax(params, callback) {
    var request = new XMLHttpRequest();
    params.async = params.async || true;
    request.open(params.method, params.url, params.async);
    var send = "";
    var data = params.data;
    for (var prop in data) {
        send += "&" + prop + "=" + data[prop];
    }
    
    console.log(data);

    send = send.substr(1);

    console.log(send);

    request.send(send);

    request.onreadystatechange = function () {
        if (this.readyState === 4 && this.status === 200) {
            callback(this.responseText);
        }
    };
}