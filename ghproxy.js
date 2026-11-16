function gfd() {
    function checkProxy(proxy) {
        var fullTest = proxy + testUrl;
        var resp = fetch(fullTest, {
            onlyHeaders: true
        });
        if (resp&&fetch(fullTest)) {
            var obj = JSON.parse(resp);
            return obj.statusCode == 200;
        }
        return false;
    }
    let urls = [
        "https://ghproxy.net/", "http://138.2.54.229:12580/", "http://138.2.69.119:30001/", "http://152.67.215.57:8081/", "http://152.70.36.140:88/", "https://g.blfrp.cn/", "https://gh.catmak.name/", "https://gh.halonice.com/", "https://gh.nxnow.top/", "https://gh.slw.im/", "https://ghproxy.sakuramoe.dev/", "https://github.ednovas.xyz/", "https://cdn.akaere.online/"
    ];
    let path = 'hiker://files/rules/juyue/ghproxy.txt',
        testUrl = 'https://raw.githubusercontent.com/mistywater/hiker/main/f';
    let now = Date.now();
    let fileContent = fetch(path);
    let cachedProxy = null,
        cachedTime = 0;
    if (fileContent) {
        let parts = fileContent.split('|');
        if (parts.length == 2) {
            cachedProxy = parts[0];
            cachedTime = parseInt(parts[1]);
        }
    }
    if (cachedProxy && cachedTime && (now - cachedTime) < 2 * 3600 * 1000) return cachedProxy;
    if (cachedProxy) {
        if (checkProxy(cachedProxy)) {
            writeFile(path, cachedProxy + '|' + now);
            return cachedProxy;
        } else toast('缓存代理失效: ' + cachedProxy);
    }
    for (let i = 0; i < urls.length; i++) {
        let proxy = urls[i];
        if (checkProxy(proxy)) {
            toast('有效代理:' + proxy);
            writeFile(path, proxy + '|' + now);
            return proxy;
        }
    }
    let t = '';
    toast('全部代理失效，不使用代理');
    writeFile(path, t + '|' + now);
    return t;
}
