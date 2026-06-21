js://2026062111
// -*- mode: js -*-
function getHtml(url, headers, mode, proxy, textError) {
    const proxyPrefixMap = {
        1: 'https://seep.eu.org/', 
        3: 'https://wdkj.eu.org/', 
        4: 'https://hiker.mistywater.deno.net/' 
    };
    let cleanUrl = url;
    for (let k in proxyPrefixMap) {
        if (cleanUrl.startsWith(proxyPrefixMap[k])) {
            cleanUrl = cleanUrl.replace(proxyPrefixMap[k], '');
            if (k == 4) cleanUrl = decodeURIComponent(cleanUrl);
            break;
        }
    }
    let hasHeaders = headers && headers.body && typeof(headers.body) == 'string';
    let bodyMD5 = hasHeaders ? headers.body : '';
    let _cachePath = `hiker://files/_cache/juyue/${safePath(cleanUrl + bodyMD5)}.txt`;
    let htmlT = fetch(_cachePath);
    let textsError = ["your-domain.deno.dev",">404<", '__cf_chl_tk', 'cf-browser-verification', 'cf-chl-out', 'cf_captcha_kind', 'Protected by cdndefend', 'Attention Required!', 'Checking your browser', 'DDOS-Guard', '502 Bad Gateway', '503 Service Unavailable', '504 Gateway Timeout', '500 Internal Server Error', '403 Forbidden', '404 Not Found', 'Access Denied', 'Access denied', 'Blocked by', 'You have been blocked', 'Your IP has been blocked', 'IP has been blocked', 'Access from your IP has been blocked', 'Request blocked', 'Request rejected', 'Web Application Firewall', 'This website is using a security service', 'Please verify you are human', 'Verification required', 'Click to verify', 'Please complete the captcha', 'Too Many Requests', 'Rate-limited', 'Welcome to nginx', 'Apache2 Default Page', 'It works!', 'Default Page', 'error code:', '无法访问目标地址', 'Please enable JavaScript', 'JavaScript is required'];
    if (textError) textsError.push(textError);
    function hasError(html) {
        if (!html) return false;
        for (let i = 0; i < textsError.length; i++) {
            if (html.indexOf(textsError[i]) !== -1) return true;
        }
        return false;
    }
    function doRequest(reqUrl, reqHeaders) {
        if (mode == 1) return request(reqUrl, reqHeaders || {});
        else if (mode == 2) return fetchCodeByWebView(reqUrl);
        else if (mode == 3) return post(reqUrl, reqHeaders || {});
        else return fetchPC(reqUrl, reqHeaders || {});
    }
    function fetchByFirecrawl(targetUrl) {
        try {
            let firecrawlResult = post('https://api.firecrawl.dev/v2/scrape',  {
                headers: {
                    'Content-Type': 'application/json',
                    'Authorization': 'Bearer fc-cb439722377a4eccbbc81520b4e78858'
                },
                body: JSON.stringify({
                    url: targetUrl,
                    formats: ['rawHtml']
                })
            });
            let parsed = JSON.parse(firecrawlResult);
            let resultHtml = (parsed.data && parsed.data.rawHtml) || '';
            if (resultHtml) log('firecrawl抓取数据成功~');
            else log('firecrawl抓取数据失败：未获取到 rawHtml~');
            return resultHtml;
        } catch (e) {
            log('firecrawl抓取数据异常: ' + (e.message || e));
            return '';
        }
    }
    if (!htmlT || hasError(htmlT)) {
        if (proxy == 2) htmlT = fetchByFirecrawl(cleanUrl);
        else if (proxy && proxyPrefixMap[proxy]) {
            let actualProxy = (headers && proxy != 2) ? 4 : proxy;
            let prefix = proxyPrefixMap[actualProxy];
            let urlTrue = prefix +  cleanUrl;
            htmlT=fetch(urlTrue,headers||{});
            if (!htmlT || hasError(htmlT)) htmlT = fetchByFirecrawl(cleanUrl);
        } else htmlT = doRequest(cleanUrl, headers || {});
    }
    if (htmlT && !hasError(htmlT)) writeFile(_cachePath, htmlT);
    return htmlT;
}
function pdfhx(html,str){
            try{return pdfh(html,str);}catch(e){return '';}
        }
function getMusicBg(){
    return ['http://www.htqyy.com/play/33',
    'http://www.htqyy.com/play/1668',
    'http://www.htqyy.com/play/58',
    'http://www.htqyy.com/play/55',
    'http://www.htqyy.com/play/261',
    'http://www.htqyy.com/play/62',
    'http://www.htqyy.com/play/57',
    'http://www.htqyy.com/play/187',
    'http://www.htqyy.com/play/1670',
    'http://www.htqyy.com/play/1685',
    'http://www.htqyy.com/play/1708',
    'http://www.htqyy.com/play/1719']
}
function refreshToken() {
    let filePath = 'hiker://files/rule/bdwp/refresh_token.txt';
    let refresh_token = fetch(filePath) || getItem('refresh_token', '');
    if (!refresh_token) {
        toast('refresh_token 缺失，请重新授权');
        return;
    }
    let res = JSON.parse(request(buildUrl("https://openapi.baidu.com/oauth/2.0/token", {
        "grant_type": "refresh_token",
        "refresh_token": refresh_token,
        "client_id": "iYCeC9g08h5vuP9UqvPHKKSVrKFXGa1v",
        "client_secret": "jXiFMOPVPCWlO2M5CwWQzffpNPaGTRBG"
    })));
    if (!res.access_token) {
        toast('错误！！!刷新access_token失败~~');
        toast('重新获取授权码~');
    } else {
        setItem("access_token", res.access_token);
        let vip_type = JSON.parse(fetch('https://pan.baidu.com/rest/2.0/xpan/nas?method=uinfo&access_token=' + getItem('access_token'))).vip_type;
        setItem("vip_type", vip_type + '');
        setItem("refresh_token", res.refresh_token);
        writeFile(filePath, res.refresh_token);
        toast('刷新access_token成功~~');
    }
}
function getExtra(index, ctype, extra){
    return !(index % (ctype.replace(/[a-z_]/g, '') || 10)) ? extra : {}
}
function clearM3u8(url) {
    function clearAd(strM3u8) {
        if (strM3u8.length < 200) {
            return strM3u8;
        } else if (/EXT-X-KEY:METHOD=NONE/.test(strM3u8)) {
            log('删除广告片段~~'); //803803
            strM3u8 = strM3u8.replace(/#EXT-X-KEY:METHOD=NONE[\s\S]*?#EXT-X-DISCONTINUITY\n/g, '')
                .replace(/#EXT-X-KEY:METHOD=NONE[\s\S]*?#EXT-X-ENDLIST/g, '#EXT-X-ENDLIST');
        } else if (/#EXT-X-KEY:METHOD=AES-128[\s\S]*/.test(strM3u8)) { //开元
            var arr = strM3u8.match(/#EXT-X-KEY:METHOD=AES-128[\s\S]*?(#EXT-X-DISCONTINUITY\n|#EXT-X-ENDLIST\n)/g);
            if (!arr || arr.length < 2) return strM3u8;
            strM3u8 = strM3u8.replace(/#EXT-X-KEY:METHOD=AES-128[\s\S]*/, '') + arr[1] + '#EXT-X-ENDLIST\n';
        }

        return strM3u8;
    }
    var pathCache = cacheM3u8(url);
    var path = pathCache.split("##")[0];
    var strM3u8 = readFile(path);
    if (!strM3u8) { //sex8sex866/vostrely
        strM3u8 = getHtml('https://wdkj.eu.org/' + url);
        if (strM3u8 && strM3u8.includes('index.m3u8')) {
            var host = url.match(/(https?:\/\/.*?)\//)[1];
            if (!strM3u8.match(/http.*?index\.m3u8/)) {
                var newUrl = 'https://wdkj.eu.org/' + host + strM3u8.match(/\/.*?index\.m3u8/)[0];
            } else {
                newUrl = 'https://wdkj.eu.org/' + strM3u8.match(/http.*?index\.m3u8/)[0]
            }
            strM3u8 = (newUrl);
        }
        if (strM3u8) {
            if (!strM3u8.match(/http.*?\.ts/)) {
                strM3u8 = strM3u8.replace(/(\/.*?\.ts)/g, 'https://wdkj.eu.org/' + host + '$1');
            } else {
                strM3u8 = strM3u8.replace(/(http.*?\.ts)/g, 'https://wdkj.eu.org/$1');
            }
            strM3u8 = clearAd(strM3u8) + url;
            let pathCacheTmp = 'hiker://files/_cache/video.m3u8';
            writeFile(pathCacheTmp, strM3u8);
            return getPath(pathCacheTmp);
        }
    }
    strM3u8 = clearAd(strM3u8);
    writeFile(path, strM3u8);
    return pathCache;
}
function p(html, rule, host) {
    if (!html) return '';
    let isText = rule.includes('Text');
    let pureRule = rule.replace('&&Text', '').replace('&&Html', '');
    if (!pureRule) return isText ? html.replace(/<[^>]+>/g, '').trim() : html.trim();
    let parts = pureRule.split('&&');
    let currentHtml = html;
    for (let i = 0; i < parts.length; i++) {
        let part = parts[i];
        let isLast = (i === parts.length - 1);
        let index = 0;
        let idxMatch = part.match(/,(-?\d+)$/);
        if (idxMatch) {
            index = parseInt(idxMatch[1]);
            part = part.replace(idxMatch[0], '');
        }
        let isAttr = isLast && !part.includes('.') && !part.includes('#') && part !== 'Text' && part !== 'Html';
        if (isAttr) {
            let m = currentHtml.match(new RegExp(part + '\\s*=\\s*["\']([^"\']+)["\']'));
            if (m) {
                let val = m[1];
                if (host && val) {
                    let c = val[0];
                    if (c === '/') val = (val[1] === '/') ? 'http:' + val : host + val;
                    else if (c !== 'h' && c !== 'd' && c !== 'j' && val.indexOf(':') === -1) val = host + '/' + val;
                }
                return val;
            }
            return '';
        } else {
            let reg;
            let firstChar = part[0];
            let nextPart = parts[i + 1];
            let nextIsAttr = false;
            if (nextPart) {
                let n = nextPart.replace(/,(-?\d+)$/, '');
                if (!n.includes('.') && !n.includes('#') && n !== 'Text' && n !== 'Html') nextIsAttr = true;
            }
            if (nextIsAttr) {
                if (firstChar === '.') reg = new RegExp('<\\w+[^>]*class=["\'][^"\']*\\b' + part.slice(1) + '\\b[^"\']*["\'][^>]*>', 'gi');
                else if (firstChar === '#') reg = new RegExp('<\\w+[^>]*id=["\']' + part.slice(1) + '["\'][^>]*>', 'gi');
                else reg = new RegExp('<' + part + '[^>]*>', 'gi');
                let m, matches = [];
                while ((m = reg.exec(currentHtml)) !== null) matches.push(m[0]);
                if (matches.length > 0) {
                    let targetIndex = index < 0 ? matches.length + index : index;
                    if (targetIndex >= 0 && targetIndex < matches.length) currentHtml = matches[targetIndex];
                    else return '';
                } else return '';
            } else {
                if (firstChar === '.') reg = new RegExp('<(\\w+)[^>]*class=["\'][^"\']*\\b' + part.slice(1) + '\\b[^"\']*["\'][^>]*>([\\s\\S]*?)<\\s*\\/\\s*\\1\\s*>', 'gi');
                else if (firstChar === '#') reg = new RegExp('<(\\w+)[^>]*id=["\']' + part.slice(1) + '["\'][^>]*>([\\s\\S]*?)<\\s*\\/\\s*\\1\\s*>', 'gi');
                else reg = new RegExp('<(' + part + ')[^>]*>([\\s\\S]*?)<\\s*\\/\\s*\\1\\s*>', 'gi');
                let m, matches = [];
                while ((m = reg.exec(currentHtml)) !== null) matches.push(m[2]);
                if (matches.length > 0) {
                    let targetIndex = index < 0 ? matches.length + index : index;
                    if (targetIndex >= 0 && targetIndex < matches.length) currentHtml = matches[targetIndex];
                    else return '';
                } else return '';
            }
            if (isLast) return isText ? currentHtml.replace(/<[^>]+>/g, '').trim() : currentHtml.trim();
        }
    }
    return '';
}
function bgccc(arr, colorObj) {
    rc((rc('https://gitee.com/mistywater/hiker_info/raw/master/ghproxy.js'), gfd()) + 'https://raw.githubusercontent.com/mistywater/hiker/main/f', 24);
    colorObj = colorObj ? colorObj : {
        fc: '#FFFFFF',
        bc: '#FF0000',
    };
    return arr.filter(x => x.trim() != '').map(h => ccc(h, colorObj)).join(' ');
}

function setFont(title, font) {
    font = font.match(/\d+(\.\d+)?/);
    font = font ? parseFloat(font[0]) : 0;
    if (isNaN(font) || font === 0) return title;
    if (font < 10) {
        return typeof ss === 'function' ? ss(title) : title;
    } else if (font < 13) {
        return '<h5>' + title + '</h5>';
    } else if (font < 16) {
        return '<h4>' + title + '</h4>';
    } else if (font < 19) {
        return '<h3>' + title + '</h3>';
    } else if (font < 22) {
        return '<h2>' + title + '</h2>';
    } else {
        return '<h1>' + title + '</h1>';
    }
}

function setCate(data, host, d, v, mode, c, f, needBg, bgcolor, bgcolorSelected, textcolor) {
    // mode: 数字/不传/空值不处理；只有非空字符串时才处理，支持 '|' 分隔清除多个子分类变量
    if(!data) return;
    let subCs = (typeof mode === 'string' && mode.trim() !== '') ? mode.split('|') : [];
    v = v != undefined ? v : '';
    c = c ? c + v : 'c' + v;
    f = f || 'scroll_button';
    needBg = needBg || false;
    bgcolor = bgcolor ? ('#' + bgcolor).replace('##', '') : '';
    bgcolorSelected = bgcolorSelected ? ('#' + bgcolorSelected).replace('##', '') : '';
    textcolor = textcolor || '#000000';
    let isDarkMode = getItem('darkMode', '深色模式') === '浅色白字模式';
    if (Array.isArray(data)) data = data[0] || {};
    let c_title = data.title ? data.title.split('&') : [];
    let c_id = !data.id ? c_title : data.id === '@@@' ? data.title.replace(/^.*?&/, '&').split('&') : data.id.split('&');
    let picsClass = storage0.getMyVar(host + 'picsClass', []);
    let c_img = picsClass.length != 0 ? picsClass : (data.img ? data.img.split('&') : []);
    let defaultId = (c_id && c_id.length > 0) ? c_id[0] + '' : '';
    let currentId = getMyVar(host + c, defaultId) + '';
    c_title.forEach((title, index_c) => {
        title = title.replace(/＆＆/g, '&');
        let id_val = (c_id[index_c] !== undefined ? c_id[index_c] : title) + '';
        let isSelected = (currentId == id_val);
        let titleStyled = isSelected ? strong(title, needBg ? 'FFFF00' : 'FF6699') : needBg ? color(title, 'FFFFFF') : color(title, textcolor);
        d.push({
            title: titleStyled,
            img: c_img.length > index_c ? c_img[index_c] : '',
            col_type: f,
            url: $('#noLoading#').lazyRule((host, c, currentId, newId, subCs) => {
                if (newId != currentId) {
                    putMyVar(host + c, newId);
                    clearMyVar(host + 'page');
                    subCs.forEach(sc => clearMyVar(host + sc));
                }
                refreshPage(false);
                return 'hiker://empty';
            }, host, c, currentId, id_val, subCs),
            extra: {
                backgroundColor: needBg ? ((isSelected ? bgcolorSelected : bgcolor) || getRandomColor(getItem('darkMode'))) : '',
                LongClick: needBg ? bcLongClick() : [],
            },
        });
    });
    d.push({
        col_type: 'blank_block'
    });
    return d;
}

function CodeA(url, str, checkStr, headers, host) {
    headers = headers || {
        'User-Agent': PC_UA
    };
    let ck = getVar(host + 'ck', '');
    if (ck) headers.Cookie = ck;
    let html = request(url, {
        headers
    });
    if (html.includes(str)) {
        html = fetchCodeByWebView(url, {
            headers: headers,
            checkJs: $.toString((host, checkStr) => {
                if (document.body.innerHTML.includes(checkStr)) {
                    fba.putVar(host + 'ck', document.cookie);
                    return 1;
                }
            }, host, checkStr),
        });
    }
    return html;
}

function getLogo(text, isSave) {
    text = String(text);
    let len = text.length;
    let size = 800;
    let fontSize = Math.max(100, 600 - (len - 1) * 120);
    let strokeWidth = 20;

    let mainColor = 'ffffff'; //grc(2);
    let bgcolor = grc(2);
    let svg = `<svg width="${size}" height="${size}" xmlns="http://www.w3.org/2000/svg">  
        <circle cx="${size/2}" cy="${size/2}" r="${size/2 - strokeWidth}" 
                fill="${bgcolor}" 
                stroke="${mainColor}" 
                stroke-width="${strokeWidth}"/>
        <text x="${size/2}" y="${size/2 + fontSize * 0.35}" 
              font-family="Arial" text-anchor="middle" 
              font-size="${fontSize}" font-weight="bold"
              fill="${mainColor}">
            ${text}
        </text>
    </svg>`;
    if (isSave) {
        let fileName = 'logo_' + text.replace(/[\\/:*?"<>|]/g, '') + '.svg';

        if (isSave === 2) {
            let url = 'hiker://files/rules/juyue/logo/' + fileName;
            if (!fileExist(url)) {
                writeFile(url, svg);
                log(url);
            }
            return url;
        } else {
            let path = 'hiker://files/_cache/' + fileName;
            writeFile(path, svg);
            return path;
        }
    }
    return 'data:image/svg+xml;base64,' + base64Encode(svg);
}

function highlight(str, keyword,t) {
    return str.replace(new RegExp(keyword, 'gi'), m =>(!t?colorR(m, 'FF0000'):color(m, 'FF0000')));
}

function getHtmls(urls) {
    let result = new Array(urls.length).fill('');
    let needFetch = [];
    let urlIndexMap = {};
    urls.forEach((url, index) => {
        let path = 'hiker://files/_cache/juyue/' + safePath(url) + '.txt';
        let html = fetch(path);
        if (html) {
            result[index] = html;
        } else {
            needFetch.push(url);
            urlIndexMap[url] = index;
        }
    });
    if (needFetch.length === 0) return result;
    let res = fetch('https://api.firecrawl.dev/v2/batch/scrape', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer fc-85d64a45c6f4493f80fb37a346ee845a'
        },
        body: JSON.stringify({
            urls: needFetch,
            formats: ['rawHtml']
        })
    });
    let job = JSON.parse(res);
    if (!job.url) toast("任务创建失败");
    let data = null;
    for (let i = 0; i < 30; i++) {
        log(i);
        java.lang.Thread.sleep(1000);
        let queryRes = fetch(job.url, {
            headers: {
                'Authorization': 'Bearer fc-85d64a45c6f4493f80fb37a346ee845a'
            }
        });
        let queryData = JSON.parse(queryRes);
        if (queryData.completed === queryData.total) {
            data = queryData.data;
            break;
        }
    }
    for (let item of data) {
        let url = item.metadata.url;
        let html = item.rawHtml || '';
        let index = urlIndexMap[url];
        if (html && index !== undefined) {
            let path = 'hiker://files/_cache/juyue/' + safePath(url) + '.txt';
            writeFile(path, html);
            result[index] = html;
        }
    }
    return result;
}

function formatPostTime(timestamp) {
    if (!timestamp) return '';

    var now = Date.now();
    var diff = now - (timestamp * 1000);

    if (diff < 60 * 1000) {
        return '刚刚';
    } else if (diff < 60 * 60 * 1000) {
        return Math.floor(diff / (60 * 1000)) + '分钟前';
    } else if (diff < 24 * 60 * 60 * 1000) {
        return Math.floor(diff / (60 * 60 * 1000)) + '小时前';
    } else if (diff < 30 * 24 * 60 * 60 * 1000) {
        return Math.floor(diff / (24 * 60 * 60 * 1000)) + '天前';
    } else {
        var date = new Date(timestamp * 1000);
        var year = date.getFullYear();
        var month = (date.getMonth() + 1).toString().padStart(2, '0');
        var day = date.getDate().toString().padStart(2, '0');
        return year + '-' + month + '-' + day;
    }
}

function lineBlank(depth) {
    return '‘‘’’' + '<small>'.repeat(depth || 4) + '<br><br>' + '</small>'.repeat(depth || 4);
}

function generatePageLinks(d, pages, str) {
    [Array.from({
        length: pages
    }, (_, i) => i + 1).join('&')].forEach((item, index, data) => {
        classTop(index, item, host, d, 0, 0, 'multiPage', 'scroll_button', '', 0, 0);
    });
}

function x5toerji(MY_RULE, jkdata, extra) {
    MY_RULE = MY_RULE || JSON.parse(fetch("hiker://home@\u805a\u9605"));
    jkdata = jkdata || storage0.getMyVar("\u4e00\u7ea7\u6e90\u63a5\u53e3\u4fe1\u606f");
    extra = extra || getVar("\u8f6e\u64ad\u6570\u636e") || {};
    extra.name = extra.title || extra.name || extra.pageTitle;
    clearVar("\u8f6e\u64ad\u6570\u636e");
    return $.toString((MY_RULE, jkdata, extra) => {
        if (!extra.url && typeof window.item == "object") {
            extra.name = window.item.title;
            extra.pageTitle = window.item.title;
            extra.img = window.item.img;
            extra.url = window.item.url;
        }
        extra.data = jkdata;
        let findRule = "js:" + $$$.toString((extra) => {
            storage0.putMyVar("\u4e8c\u7ea7\u9644\u52a0\u4e34\u65f6\u5bf9\u8c61", extra);
            require(config.聚阅);
            erji();
        }, extra);
        fba.open(JSON.stringify({
            rule: "\u805a\u9605",
            title: extra.name || "\u8be6\u60c5",
            url: "hiker://empty?type=" + jkdata.type + "&page=fypage" + (jkdata.erjisign || "#immersiveTheme#"),
            group: MY_RULE.group,
            findRule: findRule,
            params: JSON.stringify(extra),
            preRule: MY_RULE.preRule,
            pages: MY_RULE.pages
        }));
    }, MY_RULE, jkdata, extra);
}

function searchX5(d, str, url, jkdata, href, title) {
    if (typeof(str) == 'object') {
        str = str.toString();
        str = str.substring(1, str.length - 1);
    } else if (typeof(str) == 'string' && str.startsWith('/')) {
        str = str.substring(1, str.length - 1);
    }
    d.push({
        title: '🔍',
        url: $.toString((str, url, x5toerji, MY_RULE, jkdata, href, title) => {
            putVar('keyword', input);
            return $('hiker://empty').rule((str, url, x5toerji, MY_RULE, jkdata, href, title) => {
                var d = [];
                d.push({
                    url: url,
                    col_type: 'x5_webview_single',
                    desc: 'list&&screen',
                    extra: {
                        ua: MOBILE_UA,
                        showProgress: false,
                        canBack: true,
                        jsLoadingInject: true,
                        js: $.toString((href, title) => {
                            if (href && title) {
                                document.addEventListener('click', function(e) {
                                    const bookLink = e.target.closest(href);
                                    if (bookLink) {
                                        const name = bookLink.querySelector(title).textContent.trim();
                                        fba.putVar('name', name);

                                    }
                                });
                            } else {
                                fba.putVar('name', '');
                            }
                        }, href, title),
                        urlInterceptor: $.toString((str, x5toerji, MY_RULE, jkdata) => {
                            let regex = new RegExp(str);
                            if (input.match(regex)) {
                                log(getVar('name'));
                                return x5toerji(MY_RULE, jkdata, {
                                    url: input,
                                    name: getVar('name', '')
                                });
                            }
                        }, str, x5toerji, MY_RULE, jkdata),
                    }
                });
                setResult(d);
            }, str, url, x5toerji, MY_RULE, jkdata, href, title);
        }, str, url, x5toerji, MY_RULE, jkdata, href, title),
        desc: '',
        col_type: 'input',
        extra: {
            defaultValue: getVar('keyword', ''),
        }
    });
    return d;
}

function bgcolorArr(arr, bc) {
    return arr.map(h => ccc(/<\//.test(h) ? pdfh(h, 'body&&Text') : h, {
        fc: '#FFFFFF',
        bc: !bc ? getDarkColor() : '',
    })).join(' ');
}

function banner(start, arr, data, cfg) {
    if (!data || data.length == 0) {
        return;
    }
    let id = cfg.id || "juyue";
    let rnum = 0;
    let item = data[rnum];
    putMyVar("rnum" + id, rnum + '');
    cfg = cfg || {};
    let time = cfg.time || 4000;
    let col_type = cfg.col_type || "card_pic_1";
    let desc = cfg.desc || "0";
    let extra = item.extra || {};
    extra["id"] = cfg.id || "juyue";
    arr.push({
        title: item.title,
        url: item.url,
        img: item.img || item.pic_url,
        desc: desc,
        col_type: col_type,
        extra: extra
    });
    if (start == false || getMyVar("benstart", "true") == "false") {
        unRegisterTask(id);
        return;
    }
    let obj = {
        data: data,
        jkdata: cfg.jkdata || storage0.getMyVar("一级源接口信息"),
    };
    registerTask(id, time, $.toString((obj, toerji, id) => {
        let data = obj.data;
        let rum = getMyVar("rnum" + id);
        let i = Number(getMyVar("banneri" + id, "0"));
        if (rum != "") {
            i = Number(rum) + 1;
            clearMyVar("rnum" + id);
        } else {
            i = i + 1;
        }
        if (i > data.length - 1) {
            i = 0;
        }
        let item = data[i];
        try {
            updateItem(id, toerji(item, obj.jkdata));
        } catch (e) {
            unRegisterTask(id);
        }
        putMyVar("banneri" + id, i);
    }, obj, toerji, id));
}

function proxyPic(url, mode) {
    const picProxyMap = {
        1: 'https://images.weserv.nl/?url=', 
        2: 'https://seep.eu.org/', 
        3: 'https://wdkj.eu.org/', 
        default: 'https://i1.wp.com/' 
    };
    for (let k in picProxyMap)
        if (url.startsWith(picProxyMap[k])) return url;
    if (/blogspot/.test(url)) return picProxyMap[1] + url;
    if (/mrcong|misskon/.test(url) && !url.endsWith('/')) return picProxyMap['default'] + url.replace(/https?:\/\//, '');
    if (/meitu\.jrants\.com/.test(url)) return picProxyMap[2] + url;
    if (mode == 9) return decodeURIComponent(url).replace(picProxyMap[3], '');
    let prefix = picProxyMap[mode] || picProxyMap['default'];
    let finalUrl = (prefix === picProxyMap['default']) ? url.replace(/https?:\/\//, '') : url;
    return prefix + finalUrl;
}

function bfs(urls, maxRetry) {
    let retryLimit = maxRetry !== undefined ? maxRetry : 5;
    let cachePaths = urls.map(url => 'hiker://files/_cache/juyue/' + safePath(url.url) + '.txt');
    let resultHtmls = new Array(urls.length).fill(null);

    function isRequestFailed(html) {
        return !html || /HTTP Error 503|服务不可用|error code: 1015/.test(html);
    }
    let needFetchList = [];
    urls.forEach((urlObj, idx) => {
        try {
            let cache = readFile(cachePaths[idx]);
            if (!isRequestFailed(cache)) {
                resultHtmls[idx] = cache;
            } else {
                needFetchList.push({
                    urlObj: urlObj,
                    index: idx
                });
            }
        } catch (e) {
            needFetchList.push({
                urlObj: urlObj,
                index: idx
            });
        }
    });
    if (needFetchList.length === 0) {
        return resultHtmls.map(html => html || '');
    }
    let currentTasks = needFetchList;
    let retryCount = 0;
    while (retryCount < retryLimit && currentTasks.length > 0) {
        let fetchUrlObjs = currentTasks.map(item => item.urlObj);
        let fetchResults = bf(fetchUrlObjs);
        if (fetchResults && fetchResults.length === currentTasks.length) {
            currentTasks.forEach((task, idx) => {
                let html = fetchResults[idx];
                resultHtmls[task.index] = html;
                if (!isRequestFailed(html)) {
                    writeFile(cachePaths[task.index], html);
                }
            });
        }
        currentTasks = currentTasks.filter(task => isRequestFailed(resultHtmls[task.index]));
        retryCount++;

        if (currentTasks.length > 0 && retryCount < retryLimit) {
            java.lang.Thread.sleep(100);
        }
    }
    return resultHtmls.map(html => isRequestFailed(html) ? '' : html);
}

function bcRandom(darkMode) {
    if (typeof(darkMode) == 'undefined' || !darkMode) {
        darkMode = '深色模式';
    }
    // 确保生成的颜色值差异较大以提高对比度
    if (darkMode == '浅色模式') {
        for (var k = 1; k <= 999; k++) {
            var r = Math.floor(Math.random() * 256);
            if (r <= 180) {
                var g = 180 - r;
            } else {
                var g = Math.floor(Math.random() * 256);
            }

            for (var m = 1; m <= 999; m++) {
                var b = Math.floor(Math.random() * 256);
                if (g + r <= 128 && b >= 128 - Math.abs(r - g)) {
                    continue
                } else {
                    break;
                }
            }
        }
        return '#' + r.toString(16).padStart(2, '0') + g.toString(16).padStart(2, '0') + b.toString(16).padStart(2, '0');
    } else if (darkMode == '浅色白字模式') {
        const maxBrightness = 200;
        let r, g, b;
        do {
            r = Math.floor(Math.random() * 256);
            g = Math.floor(Math.random() * 256);
            b = Math.floor(Math.random() * 256);
            var brightness = 0.299 * r + 0.587 * g + 0.114 * b;
        } while (brightness > maxBrightness);

        const toHex = (value) => {
            const hex = value.toString(16);
            return hex.length === 1 ? '0' + hex : hex;
        };
        return `#${toHex(r)}${toHex(g)}${toHex(b)}`;
        /*var s = 40 + Math.floor(Math.random() * 61);
        var h = Math.floor(Math.random() * 360);
        for (var k = 1; k <= 999; k++) {
            var v = 20 + Math.floor(Math.random() * 71);
            if ((((h >= 40 && h <= 70) || (h >= 170 && h <= 210)) && v >= 60) || ((h >= 210 && h <= 280) && v <= 60)) {
                continue;
            } else {
                break;
            }
        }*/
    } else if (darkMode == '深色模式') {
        var str = '#' + (((Math.random() * 0x1000000 << 0).toString(16)).substr(-6)).padStart(6, ‌Math.ceil‌(Math.random() * 16).toString(16));
        return str;
    }
}

function getRandomColor(mode) {
    if (typeof(mode) == 'undefined') {
        darkMode = getVar('darkMode', '1') == 0 ? '浅色模式' : (getVar('darkMode') == 2 ? '浅色白字模式' : '深色模式');
    } else {
        darkMode = mode == 0 ? '浅色模式' : (mode == 2 ? '浅色白字模式' : ((mode == 3 ? '黑字淡彩色' : (mode == 4 ? '4' : '深色模式'))));
    }
    switch (darkMode) {
        case '浅色模式':
            return generateLightColor();
        case '浅色白字模式':
            return generateLightColorForWhiteText();
        case '黑字淡彩色':
            return getRandomTagColor();
        case '深色模式':
            return generateDarkColor();
        case '4':
            return generateArrayDarkColor();
        default:
            return generateDarkColor();
    }
}
var grc = getRandomColor;

function getRandomTagColor() {
    const colors = [
        '#fff5e6', '#f0f9ff', '#e6fffa', '#f3f0ff', '#fdf2f8',
        '#fefce8', '#ecfdf5', '#eff6ff', '#e0f7fa', '#e8f5e9',
        '#fff3e0', '#fce4ec', '#ede7f6', '#f9fbe7', '#e3f2fd',
        '#fbe9e7', '#f3e5f5', '#e1f5fe', '#f1f8e9', '#fffde7',
        '#eceff1', '#f0f4c3', '#e8eaf6', '#ede7f6', '#fff9c4',
        '#e1f5fe', '#fce4ec', '#f9fbe7', '#e0f2f1', '#fbe9e7',
        '#ede7f6', '#e3f2fd'
    ];
    const randomIndex = Math.floor(Math.random() * colors.length);
    return colors[randomIndex];
}

function generateArrayDarkColor() {
    const colors = ['#FFC107', '#FFF8E1', '#FFECB3', '#FFE082', '#FFD54F', '#FFCA28', '#FFC107', '#FFB300', '#FFA000', '#FF8F00', '#FF6F00', '#2196F3', '#E3F2FD', '#BBDEFB', '#90CAF9', '#64B5F6', '#42A5F5', '#2196F3', '#1E88E5', '#1976D2', '#1565C0', '#0D47A1', '#607D8B', '#ECEFF1', '#CFD8DC', '#B0BEC5', '#90A4AE', '#78909C', '#607D8B', '#546E7A', '#455A64', '#37474F', '#263238', '#795548', '#EFEBE9', '#D7CCC8', '#BCAAA4', '#A1887F', '#8D6E63', '#795548', '#6D4C41', '#5D4037', '#4E342E', '#3E2723', '#00BCD4', '#E0F7FA', '#B2EBF2', '#80DEEA', '#4DD0E1', '#26C6DA', '#00BCD4', '#00ACC1', '#0097A7', '#00838F', '#006064', '#FF5722', '#FBE9E7', '#FFCCBC', '#FFAB91', '#FF8A65', '#FF7043', '#FF5722', '#F4511E', '#E64A19', '#D84315', '#BF360C', '#673AB7', '#EDE7F6', '#D1C4E9', '#B39DDB', '#9575CD', '#7E57C2', '#673AB7', '#5E35B1', '#512DA8', '#4527A0', '#311B92', '#4CAF50', '#E8F5E9', '#C8E6C9', '#A5D6A7', '#81C784', '#66BB6A', '#4CAF50', '#43A047', '#388E3C', '#2E7D32', '#1B5E20', '#9E9E9E', '#FAFAFA', '#F5F5F5', '#EEEEEE', '#E0E0E0', '#BDBDBD', '#9E9E9E', '#757575', '#616161', '#424242', '#212121', '#3F51B5', '#E8EAF6', '#C5CAE9', '#9FA8DA', '#7986CB', '#5C6BC0', '#3F51B5', '#3949AB', '#303F9F', '#283593', '#1A237E', '#03A9F4', '#E1F5FE', '#B3E5FC', '#81D4FA', '#4FC3F7', '#29B6F6', '#03A9F4', '#039BE5', '#0288D1', '#0277BD', '#01579B', '#8BC34A', '#F1F8E9', '#DCEDC8', '#C5E1A5', '#AED581', '#9CCC65', '#8BC34A', '#7CB342', '#689F38', '#558B2F', '#33691E', '#CDDC39', '#F9FBE7', '#F0F4C3', '#E6EE9C', '#DCE775', '#D4E157', '#CDDC39', '#C0CA33', '#AFB42B', '#9E9D24', '#827717', '#FF9800', '#FFF3E0', '#FFE0B2', '#FFCC80', '#FFB74D', '#FFA726', '#FF9800', '#FB8C00', '#F57C00', '#EF6C00', '#E65100', '#E91E63', '#FCE4EC', '#F8BBD0', '#F48FB1', '#F06292', '#EC407A', '#E91E63', '#D81B60', '#C2185B', '#AD1457', '#880E4F', '#9C27B0', '#F3E5F5', '#E1BEE7', '#CE93D8', '#BA68C8', '#AB47BC', '#9C27B0', '#8E24AA', '#7B1FA2', '#6A1B9A', '#4A148C', '#F44336', '#FFEBEE', '#FFCDD2', '#EF9A9A', '#E57373', '#EF5350', '#F44336', '#E53935', '#D32F2F', '#C62828', '#B71C1C', '#009688', '#E0F2F1', '#B2DFDB', '#80CBC4', '#4DB6AC', '#26A69A', '#009688', '#00897B', '#00796B', '#00695C', '#004D40', '#FFEB3B', '#FFFDE7', '#FFF9C4', '#FFF59D', '#FFF176', '#FFEE58', '#FFEB3B', '#FDD835', '#FBC02D', '#F9A825', '#F57F17', '#FFD740', '#FFE57F', '#FFD740', '#FFC400', '#FFAB00', '#448AFF', '#82B1FF', '#448AFF', '#2979FF', '#2962FF', '#18FFFF', '#84FFFF', '#18FFFF', '#00E5FF', '#00B8D4', '#FF6E40', '#FF9E80', '#FF6E40', '#FF3D00', '#DD2C00', '#7C4DFF', '#B388FF', '#7C4DFF', '#651FFF', '#6200EA', '#69F0AE', '#B9F6CA', '#69F0AE', '#00E676', '#00C853', '#536DFE', '#8C9EFF', '#536DFE', '#3D5AFE', '#304FFE', '#40C4FF', '#80D8FF', '#40C4FF', '#00B0FF', '#0091EA', '#B2FF59', '#CCFF90', '#B2FF59', '#76FF03', '#64DD17', '#EEFF41', '#F4FF81', '#EEFF41', '#C6FF00', '#AEEA00', '#FFAB40', '#FFD180', '#FFAB40', '#FF9100', '#FF6D00', '#FF4081', '#FF80AB', '#FF4081', '#F50057', '#C51162', '#E040FB', '#EA80FC', '#E040FB', '#D500F9', '#AA00FF', '#FF5252', '#FF8A80', '#FF5252', '#FF1744', '#D50000', '#64FFDA', '#A7FFEB', '#64FFDA', '#1DE9B6', '#00BFA5', '#FFFF00', '#FFFF8D', '#FFFF00', '#FFEA00', '#FFD600', '#FFC107', '#FFF8E1', '#FFECB3', '#FFE082', '#FFD54F', '#FFCA28', '#FFC107', '#FFB300', '#FFA000', '#FF8F00', '#FF6F00', '#2196F3', '#E3F2FD', '#BBDEFB', '#90CAF9', '#64B5F6', '#42A5F5', '#2196F3', '#1E88E5', '#1976D2', '#1565C0', '#0D47A1', '#607D8B', '#ECEFF1', '#CFD8DC', '#B0BEC5', '#90A4AE', '#78909C', '#607D8B', '#546E7A', '#455A64', '#37474F', '#263238', '#795548', '#EFEBE9', '#D7CCC8', '#BCAAA4', '#A1887F', '#8D6E63', '#795548', '#6D4C41', '#5D4037', '#4E342E', '#3E2723', '#00BCD4', '#E0F7FA', '#B2EBF2', '#80DEEA', '#4DD0E1', '#26C6DA', '#00BCD4', '#00ACC1', '#0097A7', '#00838F', '#006064', '#FF5722', '#FBE9E7', '#FFCCBC', '#FFAB91', '#FF8A65', '#FF7043', '#FF5722', '#F4511E', '#E64A19', '#D84315', '#BF360C', '#673AB7', '#EDE7F6', '#D1C4E9', '#B39DDB', '#9575CD', '#7E57C2', '#673AB7', '#5E35B1', '#512DA8', '#4527A0', '#311B92', '#4CAF50', '#E8F5E9', '#C8E6C9', '#A5D6A7', '#81C784', '#66BB6A', '#4CAF50', '#43A047', '#388E3C', '#2E7D32', '#1B5E20', '#9E9E9E', '#FAFAFA', '#F5F5F5', '#EEEEEE', '#E0E0E0', '#BDBDBD', '#9E9E9E', '#757575', '#616161', '#424242', '#212121', '#3F51B5', '#E8EAF6', '#C5CAE9', '#9FA8DA', '#7986CB', '#5C6BC0', '#3F51B5', '#3949AB', '#303F9F', '#283593', '#1A237E', '#03A9F4', '#E1F5FE', '#B3E5FC', '#81D4FA', '#4FC3F7', '#29B6F6', '#03A9F4', '#039BE5', '#0288D1', '#0277BD', '#01579B', '#8BC34A', '#F1F8E9', '#DCEDC8', '#C5E1A5', '#AED581', '#9CCC65', '#8BC34A', '#7CB342', '#689F38', '#558B2F', '#33691E', '#CDDC39', '#F9FBE7', '#F0F4C3', '#E6EE9C', '#DCE775', '#D4E157', '#CDDC39', '#C0CA33', '#AFB42B', '#9E9D24', '#827717', '#FF9800', '#FFF3E0', '#FFE0B2', '#FFCC80', '#FFB74D', '#FFA726', '#FF9800', '#FB8C00', '#F57C00', '#EF6C00', '#E65100', '#E91E63', '#FCE4EC', '#F8BBD0', '#F48FB1', '#F06292', '#EC407A', '#E91E63', '#D81B60', '#C2185B', '#AD1457', '#880E4F', '#9C27B0', '#F3E5F5', '#E1BEE7', '#CE93D8', '#BA68C8', '#AB47BC', '#9C27B0', '#8E24AA', '#7B1FA2', '#6A1B9A', '#4A148C', '#F44336', '#FFEBEE', '#FFCDD2', '#EF9A9A', '#E57373', '#EF5350', '#F44336', '#E53935', '#D32F2F', '#C62828', '#B71C1C', '#009688', '#E0F2F1', '#B2DFDB', '#80CBC4', '#4DB6AC', '#26A69A', '#009688', '#00897B', '#00796B', '#00695C', '#004D40', '#FFEB3B', '#FFFDE7', '#FFF9C4', '#FFF59D', '#FFF176', '#FFEE58', '#FFEB3B', '#FDD835', '#FBC02D', '#F9A825', '#F57F17', '#FFD740', '#FFE57F', '#FFD740', '#FFC400', '#FFAB00', '#448AFF', '#82B1FF', '#448AFF', '#2979FF', '#2962FF', '#18FFFF', '#84FFFF', '#18FFFF', '#00E5FF', '#00B8D4', '#FF6E40', '#FF9E80', '#FF6E40', '#FF3D00', '#DD2C00', '#7C4DFF', '#B388FF', '#7C4DFF', '#651FFF', '#6200EA', '#69F0AE', '#B9F6CA', '#69F0AE', '#00E676', '#00C853', '#536DFE', '#8C9EFF', '#536DFE', '#3D5AFE', '#304FFE', '#40C4FF', '#80D8FF', '#40C4FF', '#00B0FF', '#0091EA', '#B2FF59', '#CCFF90', '#B2FF59', '#76FF03', '#64DD17', '#EEFF41', '#F4FF81', '#EEFF41', '#C6FF00', '#AEEA00', '#FFAB40', '#FFD180', '#FFAB40', '#FF9100', '#FF6D00', '#FF4081', '#FF80AB', '#FF4081', '#F50057', '#C51162', '#E040FB', '#EA80FC', '#E040FB', '#D500F9', '#AA00FF', '#FF5252', '#FF8A80', '#FF5252', '#FF1744', '#D50000', '#64FFDA', '#A7FFEB', '#64FFDA', '#1DE9B6', '#00BFA5', '#FFFF00', '#FFFF8D', '#FFFF00', '#FFEA00', '#FFD600'];
    const randomIndex = Math.floor(Math.random() * colors.length);
    return colors[randomIndex];
}
/*function generateLightColor() {
    let h, s, v;
    do {
        h = Math.floor(Math.random() * 360);
    } while (h >= 200 && h <= 300);
    if (Math.random() < 0.2) {
        s = 60 + Math.floor(Math.random() * 40); // 60-100%
        v = 75 + Math.floor(Math.random() * 20); // 75-95%
    } else {
        s = 20 + Math.floor(Math.random() * 30); // 20-50%
        v = 80 + Math.floor(Math.random() * 20); // 80-100%
    }
    return hsvToHex(h, s, v);
}*/


function generateLightColorForWhiteText() {
    const colorGroups = [{
            weight: 1,
            colors: [
                // 红色系 - 高饱和度红色
                '#FF0000', '#FF3333', '#FF4444', '#FF5555', '#FF6666',
                '#EE5566', '#FF33EE', '#993344', '#FF5588', '#FF0066'
            ]
        },
        {
            weight: 1,
            colors: [
                // 橙色系 - 高饱和度橙色
                '#FF4500', '#FF5733', '#FF6347', '#FF7F00', '#FF8C00',
                '#FFA500', '#FF8E53', '#FFB347', '#FFA07A',
            ]
        },
        {
            weight: 0.2,
            colors: [
                // 黄色系 - 中等饱和度黄色
                '#FFD700', '#DEBB00', '#DEA725',
            ]
        },
        {
            weight: 1,
            colors: [
                // 绿色系 - 高饱和度绿色
                '#00EE00', '#32CD32', '#00FF7F', '#00FA9A', '#06D6A0',
                '#8AC926', '#43AA70', '#4CAF50', '#00C853'
            ]
        },
        {
            weight: 1,
            colors: [
                // 蓝色系 - 中等饱和度蓝色
                '#4466EE', '#3355CC', '#44BBFF', '#2299FF', '#6699EE',
                '#4682B4', '#2222BB', '#88CCEE', '#99CCEE',
            ]
        },
        {
            weight: 1,
            colors: [
                // 紫色系 - 高饱和度紫色
                '#880088', '#8822EE', '#9900DD', '#9933CC', '#8833EE',
                '#7700BB', '#5500FF', '#664499', '#AA66CC', '#BB55DD'
            ]
        },
        {
            weight: 0.8,
            colors: [
                // 青色系 - 中等饱和度青色
                '#00BBFF', '#00FFDD', '#447799', '#44DDCC', '#33EEDD',
                '#00CCDD', '#22BBAA', '#88DDEE',
            ]
        },
        {
            weight: 0.5,
            colors: [
                // 中性色系 - 适中亮度的灰色（避免过暗或过亮）
                '#666666', '#777777', '#888888', '#999999', '#AAAAAA',
            ]
        }
    ];
    const totalWeight = colorGroups.reduce((sum, group) => sum + group.weight, 0);
    let random = Math.random() * totalWeight;
    let selectedGroup = null;

    for (let group of colorGroups) {
        random -= group.weight;
        if (random <= 0) {
            selectedGroup = group;
            break;
        }
    }
    const colors = selectedGroup.colors;
    return colors[Math.floor(Math.random() * colors.length)];
}

function generateDarkColor() {
    const h = Math.floor(Math.random() * 360);
    const s = Math.floor(Math.random() * 50) + 50; // 50-100% 饱和度（原来30+50=50-80%）
    const v = Math.floor(Math.random() * 60) + 40; // 40-100% 明度（原来30+20=20-50%）
    return hsvToHex(h, s, v);
}

function generateLightColor() {
    const colorGroups = [{
            weight: 1,
            colors: [
                // 红色系 - 包含较高饱和度的红色
                '#FFCCCC', '#FFB6C1', '#FF9999', '#FF6666', '#FF3333',
                '#FF5555', '#FF7777', '#FFAAAA', '#EE8888', '#FF0000'
            ]
        },
        {
            weight: 1,
            colors: [
                // 橙色系 - 高饱和度橙色
                '#FFE5B4', '#FFD580', '#FFCC99', '#FFB366', '#FF9933',
                '#FF8C00', '#FFA500', '#FF7F00', '#FF6347', '#FF4500'
            ]
        },
        {
            weight: 0.8,
            colors: [
                // 黄色系 - 高饱和度黄色
                '#FFFFCC', '#FFFF66', '#FFFF00', '#FFD700',
                '#FFEA00', '#FFD600', '#FFFF33', '#FFFACD', '#FFF8DC'
            ]
        },
        {
            weight: 1,
            colors: [
                // 绿色系 - 高饱和度绿色
                '#CCFFCC', '#99FF99', '#66FF66', '#33FF33', '#00FF00',
                '#32CD32', '#00FA9A', '#00FF7F', '#7CFC00', '#7FFF00'
            ]
        },
        {
            weight: 1,
            colors: [
                // 蓝色系 - 中等饱和度蓝色（避免深蓝）
                '#CCFFFF', '#99FFFF', '#66CCFF', '#3399FF', '#0099FF',
                '#64B5F6', '#42A5F5', '#90CAF9', '#81D4FA', '#4FC3F7'
            ]
        },
        {
            weight: 1,
            colors: [
                // 紫色系 - 高饱和度紫色
                '#E6CCFF', '#DDA0DD', '#DA70D6', '#BA55D3', '#9932CC',
                '#8A2BE2', '#9370DB', '#C8A2C8', '#D8BFD8', '#DDA0DD'
            ]
        },
        {
            weight: 0.7,
            colors: [
                // 中性色系 - 各种灰白色调
                '#EEEEEE', '#E0E0E0', '#D6D6D6', '#CCCCCC', '#DDDDDD',
                '#F5F5F5', '#FAFAFA', '#FFFFFF', '#F0F0F0', '#E8E8E8'
            ]
        }
    ];

    const totalWeight = colorGroups.reduce((sum, group) => sum + group.weight, 0);
    let random = Math.random() * totalWeight;
    let selectedGroup = null;

    for (let group of colorGroups) {
        random -= group.weight;
        if (random <= 0) {
            selectedGroup = group;
            break;
        }
    }

    const colors = selectedGroup.colors;
    return colors[Math.floor(Math.random() * colors.length)];
}

function calculateBrightness(r, g, b) {
    return 0.299 * r + 0.587 * g + 0.114 * b;
}

function rgbToHex(r, g, b) {
    const toHex = (n) => n.toString(16).padStart(2, '0');
    return `#${toHex(r)}${toHex(g)}${toHex(b)}`.toUpperCase();
}

function hsvToHex(h, s, v) {
    h = (h % 360 + 360) % 360;
    s = Math.max(0, Math.min(100, s)) / 100;
    v = Math.max(0, Math.min(100, v)) / 100;
    const c = v * s;
    const x = c * (1 - Math.abs((h / 60) % 2 - 1));
    const m = v - c;
    let r, g, b;
    if (h >= 0 && h < 60) {
        [r, g, b] = [c, x, 0];
    } else if (h >= 60 && h < 120) {
        [r, g, b] = [x, c, 0];
    } else if (h >= 120 && h < 180) {
        [r, g, b] = [0, c, x];
    } else if (h >= 180 && h < 240) {
        [r, g, b] = [0, x, c];
    } else if (h >= 240 && h < 300) {
        [r, g, b] = [x, 0, c];
    } else {
        [r, g, b] = [c, 0, x];
    }
    r = Math.round((r + m) * 255);
    g = Math.round((g + m) * 255);
    b = Math.round((b + m) * 255);
    return rgbToHex(r, g, b);
}

function jsExtraClick(e, n) {
    n = !n ? 0 : n;
    return $.toString((n) => {
        var buttons = document.querySelectorAll(e);
        var button = buttons.item(n);
        var targets = [button, button.querySelector('svg'), button.querySelector('div')];
        targets.forEach(function(target) {
            if (target) target.click();
        });
    }, n);
}

function getWeekdayColor(weekday) {
    const colors = {
        // 日曜日 - 星期日 - 周日
        "日曜日": "#FF6B6B",
        "星期日": "#FF6B6B",
        "周日": "#FF6B6B",
        "Sunday": "#FF6B6B",
        "Sun": "#FF6B6B",

        // 月曜日 - 星期一 - 周一
        "月曜日": "#A0A0A0",
        "星期一": "#A0A0A0",
        "周一": "#A0A0A0",
        "Monday": "#A0A0A0",
        "Mon": "#A0A0A0",

        // 火曜日 - 星期二 - 周二
        "火曜日": "#FF8C42",
        "星期二": "#FF8C42",
        "周二": "#FF8C42",
        "Tuesday": "#FF8C42",
        "Tue": "#FF8C42",

        // 水曜日 - 星期三 - 周三
        "水曜日": "#4FC3F7",
        "星期三": "#4FC3F7",
        "周三": "#4FC3F7",
        "Wednesday": "#4FC3F7",
        "Wed": "#4FC3F7",

        // 木曜日 - 星期四 - 周四
        "木曜日": "#66BB6A",
        "星期四": "#66BB6A",
        "周四": "#66BB6A",
        "Thursday": "#66BB6A",
        "Thu": "#66BB6A",

        // 金曜日 - 星期五 - 周五
        "金曜日": "#FFD54F",
        "星期五": "#FFD54F",
        "周五": "#FFD54F",
        "Friday": "#FFD54F",
        "Fri": "#FFD54F",

        // 土曜日 - 星期六 - 周六
        "土曜日": "#BA68C8",
        "星期六": "#BA68C8",
        "周六": "#BA68C8",
        "Saturday": "#BA68C8",
        "Sat": "#BA68C8"
    };
    return colors[weekday] || "#666666"; // 默认灰色
}

function toerji(item, jkdata) {
    if (!jkdata.url) {
        info = jkdata || storage0.getMyVar("\u4e00\u7ea7\u6e90\u63a5\u53e3\u4fe1\u606f");
        if (item.url && !/js:|select:|=>|@|toast:|hiker:\/\/page|video:/.test(item.url) && item.col_type != "x5_webview_single" && item.url != "hiker://empty") {
            let extra = item.extra || {};
            extra.name = extra.name || extra.pageTitle || (item.title ? item.title.replace(/‘|’|“|”|<[^>]+>/g, "") : "");
            extra.img = extra.img || item.pic_url || item.img;
            extra.stype = info.type;
            extra.pageTitle = extra.pageTitle || extra.name;
            extra.surl = item.url.replace(/hiker:\/\/empty|#immersiveTheme#|#autoCache#|#noRecordHistory#|#noHistory#|#noLoading#|#/g, "");
            extra.sname = info.name;
            item.url = $("hiker://empty?type=" + info.type + "#immersiveTheme##autoCache#").rule(() => {
                require(config.依赖);
                erji();
            });
            item.extra = extra;
        }
        return item;
    } else {
        try {
            if (item.url && item.url != 'hiker://empty') {
                jkdata = jkdata || storage0.getMyVar('一级源接口信息');
                if (!jkdata.url) {
                    jkdata = storage0.getMyVar('一级源接口信息');
                }
                let extra = item.extra || {};
                let extensions = ['.jpg', '.jpeg', '.png', '.gif', '.bmp', '.webp', '.svg', '.tiff', '.ico', '.m3u8', '.mp4'];
                let excludeurl = ['.m3u8?', '.mp4?']
                if (!extra.noDetail && !/select:|@|toast:|hiker:|video:|pics:/.test(item.url) && item.col_type != "x5_webview_single" && !extensions.some(ext => item.url.toString().toLowerCase().endsWith(ext)) && !excludeurl.some(ext => item.url.toString().includes(ext))) {
                    extra.name = extra.name || extra.pageTitle || (item.title ? item.title.replace(/‘|’|“|”|<[^>]+>/g, "") : "");
                    extra.img = extra.img || item.pic_url || item.img;
                    extra.pageTitle = extra.pageTitle || extra.name;
                    extra.url = item.url.toString().replace(/#immersiveTheme#|#autoCache#|#noRecordHistory#|#noHistory#|#noLoading#|#/g, "");
                    extra.data = jkdata;
                    item.url = $("hiker://empty?type=" + jkdata.type + "&page=fypage#autoCache#" + (jkdata.erjisign || "#immersiveTheme#")).rule(() => {
                        require(config.聚阅);
                        erji();
                    })
                    item.extra = extra;
                }

                if (/video:|pics:|\.m3u8|\.mp4|@rule=|@lazyRule=/.test(item.url) && (!/text_icon|rich_text|avatar|_button|icon_|text_/.test(item.col_type) || item.col_type == 'icon_1_left_pic')) {
                    let caseExtra = Object.assign({}, extra);
                    delete caseExtra.longClick;
                    caseExtra.data = caseExtra.data || {
                        name: jkdata.name,
                        type: jkdata.type
                    }
                    let caseData = {
                        type: item.url.includes('@rule=') ? '二级列表' : '一级列表',
                        title: extra.pageTitle || item.title,
                        picUrl: extra.img || item.img || item.pic_url,
                        params: {
                            url: item.url,
                            find_rule: '',
                            params: caseExtra
                        }
                    }

                    let longClick = extra.longClick || [];
                    longClick = longClick.filter(v => v.title != "加入收藏书架🗄")
                    longClick.push({
                        title: "加入收藏书架🗄",
                        js: $.toString((caseData) => {
                            return addBookCase(caseData);
                        }, caseData)
                    })
                    extra.longClick = longClick;
                    item.extra = extra;
                }
            }
        } catch (e) {
            log("toerji失败>" + e.message + " 错误行#" + e.lineNumber)
        }
        return item;
    }
}

function searchByPinyin(keyword, list) {
    //"https://cdn.jsdelivr.net/npm/pinyin-match@1.2.8/dist/main.min.js"
    let PinyinMatch = $.require("https://gitee.com/mistywater/hiker_info/raw/master/main.min.js")
    if (!list) {
        let jkfile = "hiker://files/rules/Src/juyue/jiekou.json";
        list = JSON.parse(readFile(jkfile));
    }
    if (!keyword || !Array.isArray(list) || list.length === 0) {
        return [];
    }
    return list.filter(item => {
        let title = String(item.name || item.title || item);
        return PinyinMatch.match(title, keyword) !== false;
    });
}

function getFastestDomain(input) {
    function pad(url) {
        return url.endsWith('/') ? url : url + '/';
    }
    var urls = [];
    if (typeof input === "string" && !/\.txt|\.json/.test(input)) {
        return pad(input);
    } else if (typeof input === "string") {
        var html = request(input, {
            timeout: 1000
        });
        if (html == "VxbsqiZ42C0OKBc6CG3cFMsmC4tAi2OpYyKXI81tYy5rTImObDRz3+ZyAZITstS+") {
            html = 'http://110.42.37.69:1866';
        } else if (html == "5nipIo1wUKXtmMvZeR3aqOJ6qcgeA0Mp5oxgfacApBI=") {
            html = 'http://www.zjcvod.com';
        } else if (html == "lDFYQlB9bihryBS7ggv8s4MYr/oEsaOkiExCPkMa3aEL/c0gjkO/3fqbyAK5tFqn") {
            html = 'http://shayu.sxtzg.com';
        }
        urls = html.match(/https?:\/\/[^\s'"]+/g) || [];
    } else if (Array.isArray(input)) {
        urls = input;
    }
    if (urls.length == 1) {
        return pad(urls[0]);
    } else if (urls.length == 0) {
        return '';
    } else {
        let urlsFind = urls.map(h => h.replace(/https?:\/\//, '').replace(/:\d+/, '').replace(/\/$/, ''));
        var reachableRaw = findReachableIP(urlsFind, 2000);
        var url = urls.find(item => item.includes(reachableRaw));
        return pad(url);
    }
}

function ssyz(img, type) {
    const MAP = {
        num: {
            'a': '4',
            'b': '6',
            'd': '0',
            'e': '9',
            'g': '9',
            'i': '1',
            'l': '1',
            'm': '3',
            's': '5',
            't': '7',
            'o': '0',
            'q': '9',
            'u': '4',
            'z': '2'
        },
        alpha: {
            '4': 'a',
            '6': 'b',
            '9': 'q',
            '1': 'l',
            '3': 'm',
            '5': 's',
            '7': 't',
            '0': 'o',
            '2': 'z'
        }
    };
    const currentMap = MAP[type] || {};
    const ocrResult = request('https://api.nn.ci/ocr/b64/text', {
        method: 'POST',
        headers: {
            'Content-Type': 'application/json'
        },
        body: convertBase64Image(img).split(',')[1]
    }).split('')
    const result = [];
    for (let i = 0; i < ocrResult.length; i++) {
        let char = ocrResult[i];
        result.push(currentMap[char] || char);
    }
    return result.join('')
}

function linkPages(d, pages, host) {
    [Array.from({
        length: pages
    }, (_, i) => i + 1).join('&')].forEach((item, index, data) => {
        classTop(index, item, host, d, 0, 0, 'multiPages', 'scroll_button', '', 0, 0);
    });
}

function getDarkColor() {
    let hue;
    do {
        hue = Math.floor(Math.random() * 360);
    } while (hue > 200 && hue < 260);
    const saturation = 80 + Math.floor(Math.random() * 20);
    const lightness = 25 + Math.floor(Math.random() * 35);
    const c = (1 - Math.abs(2 * lightness / 100 - 1)) * saturation / 100;
    const x = c * (1 - Math.abs(((hue / 60) % 2) - 1));
    const m = lightness / 100 - c / 2;
    let r, g, b;
    if (hue < 60)[r, g, b] = [c, x, 0];
    else if (hue < 120)[r, g, b] = [x, c, 0];
    else if (hue < 180)[r, g, b] = [0, c, x];
    else if (hue < 200)[r, g, b] = [0, x, c];
    else if (hue < 260)[r, g, b] = [x, 0, c];
    else [r, g, b] = [c, 0, x];
    const toHex = (n) => Math.round((n + m) * 255).toString(16).padStart(2, '0');
    return `#${toHex(r)}${toHex(g)}${toHex(b)}`;
}

function safePath(str) {
    return String(str).replace(/https?:\/\//g, '').replace(/[<>:"|?*\/\\]/g, '_');
}

function getdTemp(d, dTemp, _chchePath) {
    d = JSON.parse(fetch(_chchePath) || "[]");
    if (d.length != 0) {
        if (MY_RULE.title == "聚阅" && d[0].title == "🔍" && !/x5toerji|sarr|google|baidu|noDelete/.test(JSON.stringify(d[0]))) {
            d.splice(0, 1);
        }
        if (MY_RULE.title == "聚阅√" && d[0].title != "🔍" && !/multiPages/.test(JSON.stringify(d))) {
            d.unshift({
                "title": "🔍",
                "url": "(\n(r) => {\n    putVar(\"keyword\", input);\n    return \"hiker://search?rule=\" + r + \"&s=\" + input;\n}\n)(\"聚阅√\")",
                "desc": "搜索你想要的...",
                "col_type": "input",
                "extra": {
                    "defaultValue": ""
                }
            });
        }
        dTemp = d.concat(dTemp);
        if (MY_RULE.title == "聚阅√") {
            dTemp = JSON.parse(JSON.stringify(dTemp).replace(/config.聚阅/g, 'config.依赖'));
        } else if (MY_RULE.title == "聚阅") {
            dTemp = JSON.parse(JSON.stringify(dTemp).replace(/config.依赖/g, 'config.聚阅'));
        }
    }
    return dTemp.slice();
}

function getHtmlOld(url, headers, mode, proxy, textError) {
            let hasHeaders = headers && headers.body && typeof(headers.body) == 'string';
            if (hasHeaders) {
                var bodyMD5 = headers.body;
            } else bodyMD5 = '';
            let _cachePath =`hiker://files/_cache/juyue/${safePath(url + bodyMD5)}.txt`; 
            let htmlT=fetch(_cachePath);
            let textsError = [
                ">404<", '__cf_chl_tk', 'cf-browser-verification', 'cf-chl-out', 'cf_captcha_kind',
                'Protected by cdndefend', 'Attention Required!', 'Checking your browser',
                'DDOS-Guard', '502 Bad Gateway', '503 Service Unavailable', '504 Gateway Timeout',
                '500 Internal Server Error', '403 Forbidden', '404 Not Found', 'Access Denied',
                'Access denied', 'Blocked by', 'You have been blocked', 'Your IP has been blocked',
                'IP has been blocked', 'Access from your IP has been blocked', 'Request blocked',
                'Request rejected', 'Web Application Firewall', 'This website is using a security service',
                'Please verify you are human', 'Verification required', 'Click to verify',
                'Please complete the captcha', 'Too Many Requests', 'Rate-limited',
                'Welcome to nginx', 'Apache2 Default Page', 'It works!', 'Default Page',
                'error code:', '无法访问目标地址', 'Please enable JavaScript', 'JavaScript is required',
            ];
            if (textError) textsError.push(textError);

            function hasError(html) {
                if (!html) return false;
                for (let i = 0; i < textsError.length; i++) {
                    if (html.indexOf(textsError[i]) !== -1) return true;
                }
                return false;
            }
            if (!htmlT || hasError(htmlT)) {
                try {
                    var decodedUrl = decodeURIComponent(url);
                    var chinesePattern = /[\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF\u3400-\u4DBF\uF900-\uFAFF\uAC00-\uD7AF]/;
                    var hasChinese = chinesePattern.test(decodedUrl);
                } catch (e) {
                    var hasChinese = true;
                }
                let urlTrue;
                if (proxy && !hasChinese) {
                    urlTrue = url.startsWith('https://wdkj.eu.org/') ? url.replace('?', '%3f') : 'https://wdkj.eu.org/' + url.replace('?', '%3f');
                } else if (proxy && hasChinese) {
                    toast('中文网址需挂梯子~');
                    urlTrue = url;
                } else if (url.startsWith('https://wdkj.eu.org/') && hasChinese) {
                    urlTrue = decodeURIComponent(url.replace('https://wdkj.eu.org/', ''));
                } else {
                    urlTrue = url;
                }
                if (proxy == 2) {
                    let fireUrl = urlTrue;
                    if (fireUrl.startsWith('https://wdkj.eu.org/')) {
                        fireUrl = decodeURIComponent(fireUrl.replace('https://wdkj.eu.org/', ''));
                    }
                    try {
                        let firecrawlResult = fetch('https://api.firecrawl.dev/v2/scrape', {
                            method: 'POST',
                            headers: {
                                'Content-Type': 'application/json',
                                'Authorization': 'Bearer fc-cb439722377a4eccbbc81520b4e78858'
                            },
                            body: JSON.stringify({
                                url: fireUrl,
                                formats: ['rawHtml']
                            })
                        });
                        let parsed = JSON.parse(firecrawlResult);
                        htmlT = (parsed.data && parsed.data.rawHtml) || '';
                    } catch (e) {
                        htmlT = '';
                    }
                } else {
                    let needFirecrawl = false;
                    if (mode && mode == 1) {
                        htmlT = request(urlTrue, headers || {});
                    } else if (mode && mode == 2) {
                        htmlT = fetchCodeByWebView(urlTrue);
                    } else if (mode && mode == 3) {
                        htmlT = post(urlTrue, headers || {});
                    } else {
                        htmlT = fetchPC(urlTrue, headers || {});
                    }
                    if (!htmlT.includes('Firecrawl') && proxy && (needFirecrawl || !htmlT || hasError(htmlT))) {
                        let fireUrl = urlTrue;
                        if (fireUrl.startsWith('https://wdkj.eu.org/')) {
                            fireUrl = decodeURIComponent(fireUrl.replace('https://wdkj.eu.org/', ''));
                        }
                        try {
                            let firecrawlResult = fetch('https://api.firecrawl.dev/v2/scrape', {
                                method: 'POST',
                                headers: {
                                    'Content-Type': 'application/json',
                                    'Authorization': 'Bearer fc-cb439722377a4eccbbc81520b4e78858'
                                },
                                body: JSON.stringify({
                                    url: fireUrl,
                                    formats: ['rawHtml']
                                })
                            });
                            let parsed = JSON.parse(firecrawlResult);
                            htmlT = (parsed.data && parsed.data.rawHtml) || '';
                        } catch (e) {
                            htmlT = '';
                        }
                    }
                }
                if (htmlT && !hasError(htmlT)) {
                     writeFile(_cachePath, htmlT);
                }
            }
            return htmlT;
        }

function hanziToPinyin(hanzi, options) {
    var hanziMap = storage0.getMyVar('hanziMap');
    if (!hanziMap) {
        var html = fetchPC('https://tool.httpcn.com/Js/Convert_Pinyin.js');
        eval('var ' + html.match(/full_dict[\s\S]*?\}/)[0]);
        hanziMap = {};
        for (var pinyin in full_dict) {
            if (full_dict.hasOwnProperty(pinyin)) {
                var chars = full_dict[pinyin];
                for (var i = 0; i < chars.length; i++) {
                    hanziMap[chars[i]] = pinyin;
                }
            }
        }
    }
    var unknownChar = (options && options.unknownChar) ? options.unknownChar : 'original';
    var result = '';
    for (var j = 0; j < hanzi.length; j++) {
        var char = hanzi[j];
        if (hanziMap[char]) {
            result += hanziMap[char];
        } else {
            switch (unknownChar) {
                case 'original':
                    result += char;
                    break;
                case 'skip':
                    break;
                case 'placeholder':
                    result += '?';
                    break;
                default:
                    result += char;
            }
        }
        result += '';
    }
    return result.trim();
}

function searchBaidu(d, str, parse) {
    if (typeof(str) == 'object') {
        str = str.toString();
        str = str.substring(1, str.length - 1);
    } else if (typeof(str) == 'string' && str.startsWith('/')) {
        str = str.substring(1, str.length - 1);
    }
    d.push({
        title: '🔍',
        url: $.toString((str, parse) => {
            putVar('keyword', input);
            log('https://www.baidu.com/s?wd=' + getVar('keyword', '') + '%20site%3A' + parse.host.split('/').at(-1) + '&pn=0');
            return $('hiker://empty').rule((str, parse) => {
                var d = [];
                d.push({
                    url: 'https://www.baidu.com/s?wd=' + getVar('keyword', '').trim() + '%20site%3A' + parse.host.split('/').at(-1) + '&pn=0',
                    col_type: 'x5_webview_single',
                    desc: 'list&&screen',
                    extra: {
                        ua: PC_UA,
                        showProgress: false,
                        canBack: true,
                        jsLoadingInject: true,
                        urlInterceptor: $.toString((str, parse) => {
                            let regex = new RegExp(regex);
                            if (input.match(str)) {
                                input = fetchPC(input).match(/http.*?html/)[0];
                                input = input.replace(/_\d+\.html/, '.html');
                                return $.toString((url, parse) => {
                                    var js = 'js:host="' + parse.host + '";url=MY_URL;_c="";var parse={host: "' + parse.host + '",解析:function(){' + parse.解析.toString().replace(/^function.*?\{|\}$/g, '') + '}};' + parse.解析.toString().replace('return setResult(dTemp.concat(d))', 'setResult(dTemp.concat(d))').match(/addListener[\s\S]*setResult\((d|dTemp\.concat\(d\))\);/)[0];
                                    //fba.log(js);
                                    fba.open(JSON.stringify({
                                        title: '搜索',
                                        url: url,
                                        findRule: js,
                                    }));
                                }, input, parse)
                            }
                        }, str, parse),
                    }
                });
                setResult(d);
            }, str, parse);
        }, str, parse),
        desc: 'baidu站内搜索...',
        col_type: 'input',
        extra: {
            defaultValue: getVar('keyword', ''),
        }
    });
    return d;
}

function searchGoogle(d, str, parse) {
    if (typeof(str) == 'object') {
        str = str.toString();
        str = str.substring(1, str.length - 1);
    } else if (typeof(str) == 'string' && str.startsWith('/')) {
        str = str.substring(1, str.length - 1);
    }
    d.push({
        title: '🔍',
        url: $.toString((str, parse) => {
            putVar('keyword', input);
            log('https://www.google.com.hk/search?q=' + getVar('keyword', '').trim() + '+site:' + parse.host.replace(/https?:\/\//, '') + '&start=0');
            return $('hiker://empty').rule((str, parse) => {
                var d = [];
                d.push({
                    url: 'https://www.google.com.hk/search?q=' + getVar('keyword', '').trim() + '+site:' + parse.host.replace(/https?:\/\//, '') + '&start=0',
                    col_type: 'x5_webview_single',
                    desc: 'list&&screen',
                    extra: {
                        ua: MOBILE_UA,
                        showProgress: false,
                        canBack: true,
                        jsLoadingInject: true,
                        urlInterceptor: $.toString((str, parse) => {
                            log('___:::' + JSON.stringify(new Date()).split(':').at(-1));
                            let regex = new RegExp(str);
                            if (input.match(regex)) {
                                return $.toString((url, parse) => {
                                    var js = 'js:host="' + parse.host + '";url=MY_URL;_c="";var parse={host: "' + parse.host + '",解析:function(){' + parse.解析.toString().replace(/^function.*?\{|\}$/g, '') + '}};' + parse.解析.toString().replace('return setResult(dTemp.concat(d))', 'setResult(dTemp.concat(d))').match(/addListener[\s\S]*setResult\((d|dTemp\.concat\(d\))\);/)[0];
                                    fba.log('===:::' + JSON.stringify(new Date()).split(':').at(-1));
                                    fba.open(JSON.stringify({
                                        title: '搜索',
                                        url: url,
                                        findRule: js,
                                    }));
                                }, input, parse)
                            }
                        }, str, parse),
                    }
                });
                setResult(d);
            }, str, parse);
        }, str, parse),
        desc: 'google站内搜索,需挂梯子...',
        col_type: 'input',
        extra: {
            defaultValue: getVar('keyword', ''),
        }
    });
    return d;
}

function getLines() {
    return $.toString(() => {
        var arts = pdfa(html, 线路);
        var conts = pdfa(html, 选集);
        conts.forEach((cont, index) => {
            var list = pdfa(cont, 选集列表).map((item) => ({
                title: pdfh(item, 'a&&Text').replace(new RegExp('.+?(第\\d+季|第\\d+集)'), '$1'),
                url: pd(item, 'a&&href')
            }));
            lists.push(list);
            tabs.push(pdfh(arts[index], 线路名) + numberSub(list.length));
        });
    });
}

function parseUrlVideo(url, 依赖) {
    if (/baidu/.test(url)) {
        putVar('urlBaidu', url);
        return "hiker://page/list?rule=百度网盘&realurl=" + url;
    } else if (/aliyundrive|alipan/.test(url)) {
        return "hiker://page/aliyun?page=fypage&rule=云盘君.简&realurl=" + url;
        /*if (!依赖) 依赖 = 'https://codeberg.org/src48597962/hk/raw/branch/Ju/SrcJu.js';
        require(依赖.match(/http(s)?:\/\/.*\//)[0] + 'SrcParseS.js');
        return SrcParseS.聚阅(url);*/
    } else if (/quark|uc\./.test(url)) {
        return "hiker://page/quarkList?rule=Quark.简&realurl=" + url;
    } else if (/(thunder|xunlei|ed2k:|bt:|ftp:|\.torrent|magnet)/.test(url)) {
        if (url.includes('thunder')) url = base64Decode(url.split('//')[1]);
		if (url.includes('magnet')&&fetch('hiker://files/rules/bdwp/parseMagnet.txt')!='xunlei') return url;
        return "hiker://page/diaoyong?rule=迅雷&page=fypage#" + url;
    } else if (/cloud\.189\.cn|content\.21cn\.com/.test(url)) {
        return "hiker://page/diaoyong?rule=天翼网盘&realurl=" + encodeURIComponent(url)
    } else if (/lanzou/.test(url)) {
        return "hiker://page/diaoyong?rule=蓝奏云盘&page=fypage&realurl=" + encodeURIComponent(url);
    } else if (/123.*?(com|cn)/.test(url)) {
        return "hiker://page/diaoyong?rule=123云盘&page=fypage&realurl=" + encodeURIComponent(url);
    } else if (/yun\.139\.com/.test(url)) {
        return "hiker://page/diaoyong?rule=移动云盘&page=fypage&realurl=" + encodeURIComponent(url);
    } else {
        var html = fetchPC(url);
        if (/r Vurl/.test(html)) {
            var url_t = html.match(/r Vurl.*?['"](.*?)['"]/)[1];
            url = /\.m3u8|\.mp4|\.mkv/.test(url_t) ? url_t : 'video://' + url;
        } else if (/r player_/.test(html)) {
            var json = JSON.parse(html.match(/r player_.*?=(.*?)</)[1]);
            var url_t = json.url;
            if (json.encrypt == '1') {
                url_t = unescape(url_t);
            } else if (json.encrypt == '2') {
                url_t = unescape(base64Decode(url_t));
            }
            if (/\.m3u8|\.mp4/.test(url_t)) {
                url = url_t;
            } else {
                url = 'video://' + url;
            }
        } else {
            url = 'video://' + url;
        }
        return url;
    }
}

function updateJu(title, record) {
    if (MY_RULE.title == '聚阅') {
        var path = 'hiker://files/rules/juyue/updateTime_' + title + '_新.txt';
        let lastTime = fetch(path);
        log('lastTime:' + lastTime);
        let currentTime = Date.now();
        writeFile(path, currentTime + '');
        if (!lastTime || currentTime - lastTime >= 86400000) {
            let pathGitee = 'https://gitee.com/mistywater/hiker_info/raw/master/sourcefile/' + title + '_新.json';
            let html = fetch(pathGitee);
            if (html && !/Repository or file not found/.test(html)) {
                var codeNew = base64ToText(html);
                eval(codeNew);
                var verNew = parse.ver || parse.Ver || parse.VER || '';
                record = record ? record : parse['更新说明'];
                log('verNew:' + verNew);
                let pathJiekou = 'hiker://files/rules/Src/Juyue/jiekou.json';
                eval('let jsonJiekou =' + (fetchPC(pathJiekou)));
                for (let k in jsonJiekou) {
                    if (jsonJiekou[k].name.includes('🐹') && jsonJiekou[k].name.includes(title)) {
                        var verLocal = jsonJiekou[k].version || '';
                        log('verLocal:' + verLocal);
                        var url = jsonJiekou[k].url;
                        if (verNew > verLocal) {
                            jsonJiekou[k].version = verNew;
                            writeFile(pathJiekou, JSON.stringify(jsonJiekou));
                            writeFile(url, codeNew);
                            const hikerPop = $.require("https://gitee.com/mistywater/hiker_info/raw/master/Popup.js");
                            record ? hikerPop.updateRecordsBottom(record) : '';
                        }
                        break;
                    };
                }
            }
        }
    }
    if (MY_RULE.title == '聚阅√') {
        var path = 'hiker://files/rules/juyue/updateTime_' + title + '.txt';
        let lastTime = fetch(path);
        let currentTime = Date.now();
        writeFile(path, currentTime + '');
        if (!lastTime || currentTime - lastTime >= 86400000) {
            let pathGitee = 'https://gitee.com/mistywater/hiker_info/raw/master/sourcefile/' + title + '.json';
            let html = fetch(pathGitee);
            if (html && !/Repository or file not found/.test(html)) {
                let jsonGitee = JSON.parse(base64ToText(html));
                let jsonVer = JSON.parse(jsonGitee.parse.replace(/,.*\s+('|")页码[\s\S]*/, '}').replace(/'/g, '"'));
                let version = jsonVer.ver || jsonVer.Ver || '';
                log('versionNew:' + version);
                let sourcefile = 'hiker://files/rules/Src/Ju/jiekou.json';
                let datalist = JSON.parse(fetch(sourcefile));
                let index = datalist.findIndex(item => item.name == jsonGitee.name && item.type == jsonGitee.type);
                if (index != -1) {
                    let jsonVersionLast = JSON.parse(datalist[index].parse.replace(/,.*\s+('|")页码[\s\S]*/, '}').replace(/'/g, '"'));
                    var versionLast = jsonVersionLast.ver || jsonVersionLast.Ver || '';
                    log('versionLast:' + versionLast);
                }
                if (index == -1 || !versionLast || versionLast < version) {
                    confirm({
                        title: `聚阅接口:<${title}_${jsonGitee.type}>有新版本`,
                        content: jsonVer.更新说明 ? jsonVer.更新说明.replace(/,/g, '\n') : '导入新版本吗?',
                        confirm: $.toString((title, jsonGitee, index) => {
                            let sourcefile = 'hiker://files/rules/Src/Ju/jiekou.json';
                            let datalist = JSON.parse(fetch(sourcefile));
                            if (index != -1) {
                                datalist.splice(index, 1);
                            }
                            datalist.push(jsonGitee);
                            writeFile(sourcefile, JSON.stringify(datalist));
                            toast(`聚阅接口<${title}_${jsonGitee.type}>导入成功~`);
                            refreshPage();
                            return;
                        }, title, jsonGitee, index),
                        cancel: $.toString(() => {
                            return "toast://更新接口，则功能不全或有异常"
                        })
                    });
                } else {
                    toast('无新版本~');
                }
            } else {
                toast('无新版本~');
            }
        }
    }
    return;
}

function TextToBase64(str) {
    if (typeof str === 'object' && str !== null) {
        str = JSON.stringify(str);
    }
    return window0.btoa(encodeURIComponent(str).replace(/%([0-9A-F]{2})/g, (_, hex) => {
        return String.fromCharCode(parseInt(hex, 16));
    }));
}

function base64ToText(str) {
    if (typeof str === 'object' && str !== null) {
        str = JSON.stringify(str);
    }
    return decodeURIComponent(window0.atob(str).split('').map(c => {
        return '%' + c.charCodeAt(0).toString(16).padStart(2, '0');
    }).join(''));
}

function yanzhengd(d, str, url, host, a, ua) {
    d.push({
        title: '人机验证',
        url: $('hiker://empty').rule((str, url, t, a, ua) => {
            var d = [];
            d.push({
                col_type: 'x5_webview_single',
                url: url,
                desc: 'list&&screen',
                extra: {
                    ua: !ua ? MOBILE_UA : PC_UA,
                    showProgress: false,
                    js: $.toString((str, url, t, a, ua) => {
                        function check() {
                            let nodes = document.querySelectorAll(str);
                            var co = fba.getCookie('');
                            fba.log(co);
                            let condition;
                            if (a) {
                                condition = (!nodes || nodes.length === 0) && co;
                            } else {
                                condition = nodes && nodes.length > 0 && co;
                            }
                            if (condition) {
                                fba.putVar(t + 'ck', co);
                                fba.parseLazyRule($$$().lazyRule(() => {
                                    back();
                                }));
                            } else {
                                setTimeout(check, 500);
                            }
                        }
                        check();
                    }, str, url, t, a, ua)
                }
            });
            return setResult(d);
        }, str, url, host, a, ua),
        col_type: 'text_1'
    });
    return d;
}
function requestQ(url, host) {
    return request(url, {
        headers: {
            Cookie: getVar(host + 'ck', '')
        }
    });
}

function secondsToHMS(seconds) {
    seconds = Number(seconds);
    const h = Math.floor(seconds / 3600);
    const m = Math.floor((seconds % 3600) / 60);
    const s = Math.floor(seconds % 60);
    const padSec = (num) => num.toString().padStart(2, '0');
    if (h > 0) {
        return `${h}:${padSec(m)}:${padSec(s)}`;
    } else {
        return `${m}:${padSec(s)}`;
    }
}

function downloadLongClick(host) {
    var longClick = [{
        title: '下载',
        js: `'hiker://page/download.view?rule=本地资源管理'`,
    }, {
        title: '书架',
        js: `'hiker://page/Main.view?rule=本地资源管理'`,
    }, {
        title: getItem(host + 'isMultiPage', '1') == 1 ? '分页=>不分页' : '不分页=>分页',
        js: `setItem('${host}isMultiPage',getItem('${host}isMultiPage','1')=='1'?'0':'1');refreshPage();`,
    }];
    var extra = $.toString((host, longClick) => ({
        chapterList: 'hiker://files/_cache/chapterList.txt',
        info: {
            bookName: MY_URL.split('/')[2],
            ruleName: 'photo',
            bookTopPic: 'https://api.xinac.net/icon/?url=' + host,
            parseCode: downloadlazy,
            defaultView: '1'
        },
        longClick: longClick,
    }), host, longClick);
    return extra;
}

function link(d, urlsTemp, titleLast, titleNext, myurl, host) {
    d.push({
        col_type: 'blank_block',
    });
    urlsTemp.forEach((it, index) => {
        d.push({
            title: index == 0 ? (it.startsWith('http')&&it!=host ? '⬅️' + (titleLast?titleLast.replace('下一','上一').replace(/next/i,'previous'):'上一组') : '⬅️没有了') : '➡️' + (titleNext?titleNext.replace('上一','下一').replace(/previous/i,'next'):'下一组'),
            url: $('#noLoading#').lazyRule((url, host, index, url1) => {
                if (url&&url!=host) {
                    putMyVar(host + 'next', url);
                    putVar(host + 'isNextUrl', '1');
                    refreshPage();
                }
                return 'hiker://empty';
            }, it, host, index, myurl),
            col_type: 'text_2',
            extra: {
                lineVisible: 'false',
                textAlign: 'left'
            }
        });
    });
    d.push({
        col_type: 'blank_block',
    });
    return d;
}


function buildUrls(pages, urlBuilder, headers) {
    let urls = [];
    for (let k = 1; k <= pages; k++) {
        let obj = {
            url: urlBuilder(k)
        };
        if (headers) {
            obj.options = {
                headers: headers
            }
        }
        urls.push(obj);
    }
    return urls;
}

function detectCloudStorage(link) {
    link = link.toLowerCase();
    if (link.includes("pan.baidu.com") || link.includes("baidupcs.com")) {
        return "[百度网盘]";
    } else if (link.includes("aliyundrive.com") || link.includes("alipan.com")) {
        return "[阿里云盘]";
    } else if (link.includes("quark.cn")) {
        return "[夸克网盘]";
    } else if (link.includes("uc.cn") || link.includes("yun.uc.cn")) {
        return "[UC网盘]";
    } else if (link.includes("xunlei")) {
        return "[迅雷网盘]";
    } else if (link.includes("magnet")) {
        return "[磁力]";
    } else {
        return "[未知网盘]";
    }
}

function imgCloudStorage(link) {
    link = link.toLowerCase();
    if (/magnet|磁力|磁链/.test(link)) {
        return "https://pp.myapp.com/ma_icon/0/icon_53952947_1677658847/256";
    } else if (/pikpak/.test(link)) {
        return "https://blog.mypikpak.com/wp-content/uploads/2023/08/512.png";
    } else if (/pan.baidu.com|baidupcs.com|百度(网|云)盘|^baidu$|xiongdipan/.test(link)) {
        return "https://img2.baidu.com/it/u=2020777305,1031850894&fm=253&fmt=auto&app=138&f=PNG?w=667&h=500";
    } else if (/aliyundrive.com|alipan.com|阿里(网|云)盘|^ali$|alipansou/.test(link)) {
        return "https://pp.myapp.com/ma_icon/0/icon_54120208_1764918750/256";
    } else if (/quark.cn|夸克(网|云)盘|^quark$|aipanso/.test(link)) {
        return "https://img.onlinedown.net/download/202403/184714-65e849b2afdf5.jpg";
    } else if (/uc.cn|uc(网|云)盘|^uc$|ucyunso/.test(link)) {
        return "https://pp.myapp.com/ma_icon/0/icon_10936_1766990795/256";
    } else if (/xunlei|thunder|迅雷(网|云)盘|^xunlei$|xunjiso/.test(link)) {
        return "https://pp.myapp.com/ma_icon/0/icon_113692_1766656985/256";
    } else if (/115|anxia|115(网|云)盘|^115$/.test(link)) {
        return "https://bkimg.cdn.bcebos.com/pic/f2deb48f8c5494eeb95e781a24f5e0fe99257eb0";
    } else if (/tianyi|189|天翼(网|云)盘|^tianyi$|tianyiso/.test(link)) {
        return "https://b.zol-img.com.cn/soft/7/617/ceQDZnfsQPXs.png";
    } else if (/移动|139|mobile/.test(link)) {
        return "https://bkimg.cdn.bcebos.com/pic/58ee3d6d55fbb2fb4316d9f6261e37a4462308f77680";
    } else if (/123|123(网|云)盘|^115$/.test(link)) {
        return "https://pp.myapp.com/ma_icon/0/icon_54190090_1767233011/256";
    } else {
        return "https://pp.myapp.com/ma_icon/0/icon_251416_1627666026/256";
    }
}

function sourceJump(d, arr, blank, changeSource) {
    let info = storage0.getMyVar('一级源接口信息') || jkdata;
    if (arr.length > 1) {
        arr.forEach((item, index) => {
            let title = item.split('@')[0].replace(/H-|✈️|🔞|🐹/g, '');
            d.push({
                title: info.name == item.split('@')[0] ? title.color('fff') : title,
                url: $('#noLoading#').lazyRule((item) => {
                    if (MY_RULE.title != '聚阅') {
                        let configPath = 'hiker://files/rules/Src/Ju/config.json';
                        let html = fetchPC(configPath);
                        let stype = item.split('@')[1];
                        let sname = item.split('@')[0];
                        if (html) {
                            html = html.replace(/"runMode":".*?"/, `"runMode":"${stype}"`)
                                .replace(new RegExp(`${stype}sourcename.*?,`), `${stype}sourcename":"${sname}",`);
                            writeFile(configPath, html);
                        }
                    } else {
                        let pathConfig = 'hiker://files/rules/Src/Juyue/config.json';
                        let jsonConfig = JSON.parse(fetch(pathConfig));
                        let stype = item.split('@')[1];
                        let sname = item.split('@')[0];
                        let pathJiekou = 'hiker://files/rules/Src/Juyue/jiekou.json';
                        let jsonJiekou = JSON.parse(fetch(pathJiekou));
                        for (let json of jsonJiekou) {
                            if (json.name == sname) {
                                jkdata = json;
                                var id = json.id;
                                break;
                            } else {
                                id = '';
                            }
                        }
                        if (id) {
                            require(config.聚阅.replace(/[^/]*$/, '') + 'SrcJuPublic.js');
                            changeSource(jkdata);
                            toast(`已跳转到${sname}~~`);
                        } else {
                            toast(`没有${sname}接口~~`);
                        }
                    }
                    refreshPage();
                    return 'hiker://empty';
                }, item),
                col_type: 'scroll_button',
                extra: {
                    backgroundColor: info.name == item.split('@')[0] ? getRandomColor(2) : ''
                }
            });
        });
        if (!blank) {
            d.push({
                col_type: 'blank_block',
            });
        }
        return d;
    } else {
        let item = arr[0];
        if (MY_RULE.title != '聚阅') {
            let configPath = 'hiker://files/rules/Src/Ju/config.json';
            let html = fetchPC(configPath);
            let stype = item.split('@')[1];
            let sname = item.split('@')[0];
            if (html) {
                html = html.replace(/"runMode":".*?"/, `"runMode":"${stype}"`)
                    .replace(new RegExp(`${stype}sourcename.*?,`), `${stype}sourcename":"${sname}",`);
                writeFile(configPath, html);
            }
        } else {
            let pathConfig = 'hiker://files/rules/Src/Juyue/config.json';
            let jsonConfig = JSON.parse(fetch(pathConfig));
            let stype = item.split('@')[1];
            let sname = item.split('@')[0];
            let pathJiekou = 'hiker://files/rules/Src/Juyue/jiekou.json';
            let jsonJiekou = JSON.parse(fetch(pathJiekou));
            for (let json of jsonJiekou) {
                if (json.name == sname) {
                    jkdata = json;
                    var id = json.id;
                    break;
                } else {
                    id = '';
                }
            }
            if (id) {
                changeSource(jkdata);
                toast(`已跳转到${sname}~~`);
            } else {
                toast(`没有${sname}接口~~`);
            }
        }
        refreshPage();
        return 'hiker://empty';
    }
}

function cfl(str) {
    return str.replace(/\w\S*/g, function(word) {
        return word.charAt(0) + word.slice(1).toLowerCase();
    });
}

function numberSub(strNumber) {
    return `${strNumber}`.split('').map(h => String.fromCharCode(h * 1 + 8320)).join('');
}

function numberSup(strNumber) {
    const supersDigits = ['⁰', '¹', '²', '³', '⁴', '⁵', '⁶', '⁷', '⁸', '⁹'];
    return `${strNumber}`.split('').map(h => supersDigits[h]).join('');
}

function splitTextByPunctuation(text) {
    let regex = /[^。！？；]+[。！？][^"”]*?["”]?/g;
    let sentences = text.match(regex) || [];
    return sentences.filter(sentence => sentence.trim()).join('<p>');
}

function getArrayFromUrl(url) {
    if (!url) url = 'https://moe.jitsu.top/img/?sort=setu&type=json&num=50&size=m_fill,w_480,h_640';
    let arr = [];
    let html = fetchPC(url);
    if (html.startsWith('{') || html.startsWith('[')) {
        let json = JSON.parse(html);
        if (Array.isArray(json)) {
            arr = json;
        } else {
            for (let key in json) {
                if (Array.isArray(json[key])) {
                    arr = json[key];
                    break;
                }
            }
            if (typeof(arr[0]) === 'object') {
                arr = arr.map(h => h.url);
            }
        }
    } else {
        arr = html.match(/https?:\/\/[^\s,|]+/g);
    }
    return arr;
}

function createDynamicRegex(input) {
    const escapedInput = input.replace(/[.*+?^${}()|[\]\\]/g, '\\$&');
    return new RegExp(escapedInput);
}

function generateStarRating(score) {
    //★★★☆☆//F79329
    var star = '';
    var roundedScore = Math.ceil(score);
    for (var k = 1; k <= roundedScore / 2 + 1; k++) {
        if (roundedScore - k * 2 >= 0) {
            star = star + '★';
        } else if (roundedScore - (k - 1) * 2 == 1) {
            star = star + '☆';
        }
    }
    return star;
}

function isDarkMode() {
    if (darkModeCache && darkModeCache !== null) {
        return darkModeCache; // 返回缓存结果
    }

    try {
        const Context = android.content.Context;
        const Configuration = android.content.res.Configuration;
        const context = getCurrentActivity();
        const configuration = context.getResources().getConfiguration();
        const nightModeFlags = configuration.uiMode & Configuration.UI_MODE_NIGHT_MASK;
        const isDark = nightModeFlags === Configuration.UI_MODE_NIGHT_YES;
        writeFile("hiker://files/cache/darkMode.json", isDark ? '1' : '0');
        var darkModeCache = isDark ? '1' : '0'; // 缓存结果
        return isDark ? '1' : '0';
    } catch (e) {
        console.error("Error checking dark mode:", e.message);
        return '';
    }
}

function titleBackgroundColor(title) {
    return /白字/.test(getItem('darkMode')) ? color(title, 'FFFFFF') : color(title, '000000');
}

function clearClipboardText() {
    const Context = android.content.Context;
    const context = getCurrentActivity();
    let clipboard = context.getSystemService(Context.CLIPBOARD_SERVICE);
    let clipData = clipboard.getPrimaryClip();
    if (clipData != null && clipData.getItemCount() > 0) {
        let text = clipData.getItemAt(0).getText();
        if (text != null) {
            writeFile("hiker://files/cache/ClipboardText.json", String(text.toString()));
        };
    };
    clipboard.clearPrimaryClip();
    return;
}

function getClipboardText(source) {
    try {
        const Context = android.content.Context;
        const context = getCurrentActivity();
        const clipboard = context.getSystemService(Context.CLIPBOARD_SERVICE);
        const clipData = clipboard.getPrimaryClip();
        if (!clipData || clipData.getItemCount() === 0) {
            return null;
        }
        const text = clipData.getItemAt(0).getText();
        if (!text) {
            return null;
        }
        const str = text.toString();
        writeFile("hiker://files/cache/ClipboardText.json", str);
        if (source && !/^\[.*?\]$|^\{.*?\}$|^http|^\/|^云|^海阔视界规则分享.*?\}$|^海阔视界规则分享.*?base64/.test(str)) {
            return null;
        }
        return str;
    } catch (e) {
        return null;
    }
}

function decodeEvalPrivateJS(Strcode, t) {
    Strcode = Strcode.match(/("|').*?(\\|"|')/)[0];
    Strcode = Strcode.slice(1, Strcode.length - 1);
    let decodedValue = aesDecode("hk6666666109", Strcode);
    let jsonStringified = JSON.stringify(decodedValue);
    jsonStringified = jsonStringified.slice(1, jsonStringified.length - 1);
    if (t == 1) jsonStringified = jsonStringified.replace(/\\/g, '\\\\').replace(/"/g, '\\"');
    return jsonStringified;
}

function replaceUrl(url) {
    var urlCodeStr = '';
    for (var i = 1; i < url.length - 4; i++) {
        urlCodeStr += '%' + url.charCodeAt(i).toString(16);
    }
    urlCodeStr = '.' + urlCodeStr + url.slice(-4);
    return urlCodeStr;
}

function bcLongClick() {
    return [{
        title: '背景色样式',
        js: $.toString(() => {
            var 类型 = ["深色模式", "浅色模式", "浅色白字模式", "清除"];
            if (getItem('darkMode')) {
                var index = 类型.indexOf(getItem('darkMode'));
                类型[index] = '👉' + getItem('darkMode');
            }
            showSelectOptions({
                title: "选择样式",
                col: 3,
                options: 类型,
                js: $.toString(() => {
                    if (/清除/.test(input)) {
                        clearItem('darkMode');
                    } else {
                        setItem('darkMode', input.replace('👉', ''));
                    }
                    refreshPage();
                }, )
            });
        }),
    }];
}

function baiduTrans(content, mode) {
    if (typeof(mode) == 'undefined' || !mode) {
        var body = `{"query":"${content}","from":"en","to":"zh","reference":"","corpusIds":[],"needPhonetic":false,"domain":"ai_advanced","milliTimestamp":${new Date().getTime()}}`
    } else if (mode == 1) {
        var body = `{"query":"${content}","from":"zh","to":"en","reference":"","corpusIds":[],"needPhonetic":false,"domain":"ai_advanced","milliTimestamp":${new Date().getTime()}}`

    } else {
        var body = `{"query":"${content}","from":"${mode.split('2')[0]}","to":"${mode.split('2')[1]}","reference":"","corpusIds":[],"needPhonetic":false,"domain":"ai_advanced","milliTimestamp":${new Date().getTime()}}`

    }
    var result = post("https://fanyi.baidu.com/ait/text/translate", {
        "headers": {
            "Content-Type": "application/json"
        },
        body: body
    });
    try {
        return result.match(/dst":"(.*?)"/)[1];
    } catch (e) {
        return content;
    }
}
/*function bcRandom() {
    var str =  '#' + (((Math.random() * 0x1000000 << 0).toString(16)).substr(-6)).padStart(6, Math.ceil(Math.random() * 16).toString(16));
    return str;
}*/
function yanzheng(str, url, t, a, h) {
    if (h) host = h;
    if (!t) t = host;
    d.push({
        title: '人机验证',
        url: $('hiker://empty').rule((str, url, t, a) => {
            var d = [];
            d.push({
                col_type: 'x5_webview_single',
                url: url,
                desc: 'list&&screen',
                extra: {
                    ua: MOBILE_UA,
                    showProgress: false,
                    js: $.toString((str, url, t, a) => {
                        function check() {
                            let nodes = document.querySelectorAll(str);
                            var co = fba.getCookie(url);
                            fba.log(co);
                            let condition;
                            if (a) {
                                condition = (!nodes || nodes.length === 0) && co;
                            } else {
                                condition = nodes && nodes.length > 0 && co;
                            }
                            if (condition) {
                                fba.putVar(t + 'ck', co);
                                fba.parseLazyRule($$$().lazyRule(() => {
                                    back();
                                }));
                            } else {
                                setTimeout(check, 500);
                            }
                        }
                        check();
                    }, str, url, t, a)
                }
            });
            return setResult(d);
        }, str, url, t, a),
        col_type: 'text_1'
    });
}

function tabsWeek() {
    return $.toString(() => {
        var week = new Date().getDay();
        var weeks = ['周一', '周二', '周三', '周四', '周五', '周六', '周日'];
        weeks.forEach((item1, index1) => {
            d.push({
                title: index1 == getMyVar(host + '_index_new', week + '') ? strong((index1 == ((week - 1) == -1 ? 6 : week - 1) ? '今日' : item1), 'ff6699') : (index1 == ((week - 1) == -1 ? 6 : week - 1) ? '今日' : item1),
                col_type: 'scroll_button',
                url: $('#noLoading#').lazyRule((host, index1) => {
                    putMyVar(host + '_index_new', index1 + '');
                    refreshPage(false);
                    return 'hiker://empty';
                }, host, index1),
            });
        });
    });
}

function numbersCircledColor(num, r) {
    if (typeof(r) == 'undefined' || !r) {
        if (num .includes( '❶')) {
            return strongR(num, 'FF2244');
        } else if (num .includes( '❷')) {
            return strongR(num, 'FF6633');
        } else if (num .includes( '❸')) {
            return strongR(num, 'FFBB33');
        } else {
            return strongR(num, '333333');
        }
    } else if (r == 1) {
        if (num .includes(  '❶')) {
            return strong(num, 'FF2244');
        } else if (num .includes(  '❷')) {
            return strong(num, 'FF6633');
        } else if (num .includes(  '❸')) {
            return strong(num, 'FFBB33');
        } else {
            return strong(num, '333333');
        }
    } else if (r == 2) {
        return num;
    }
}

function cytrans(text, mode) {
    if (typeof(mode) == 'undefined' || !mode) {
        var to = 'zh';
    } else {
        var to = mode;
    }
    var from = 'auto';

    function init_data(source_lang, target_lang) {
        return {
            source: '',
            detect: true,
            os_type: 'ios',
            device_id: 'F1F902F7-1780-4C88-848D-71F35D88A602',
            trans_type: source_lang + '2' + target_lang,
            media: 'text',
            request_id: 424238335,
            user_id: '',
            dict: true,
        }
    }

    function getRandomNumber() {
        const rand = Math.floor(Math.random() * 99999) + 100000;
        return rand * 1000;
    }
    const post_data = init_data(from, to);
    post_data.source = text;
    post_data.request_id = getRandomNumber();
    let res = fetch('https://interpreter.cyapi.cn/v1/translator', {
        method: 'POST',
        header: {
            'Content-Type': 'application/json',
            'x-authorization': 'token ssdj273ksdiwi923bsd9',
            'user-agent': 'caiyunInterpreter/5 CFNetwork/1404.0.5 Darwin/22.3.0',
        },
        body: post_data,
    })
    var result = JSON.parse(res).target;
    return result;
}

function getRandomNumber(m, n) {
    const rand = Math.floor(Math.random() * (m - n)) + n;;
    return rand;
}

function timestampToDate(timestamp) {
    timestamp = +((timestamp + '').padEnd(13, '0'));
    const date = new Date(timestamp);
    const year = date.getFullYear();
    const month = String(date.getMonth() + 1).padStart(2, '0');
    const day = String(date.getDate()).padStart(2, '0');
    const hours = String(date.getHours()).padStart(2, '0');
    const minutes = String(date.getMinutes()).padStart(2, '0');
    const seconds = String(date.getSeconds()).padStart(2, '0');

    return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}

function getCommonNonDigitParts(str1, str2) {
    var i = 0,
        j = 0;
    var len1 = str1.length,
        len2 = str2.length;
    var commonParts = [];
    var currentCommon = "";

    while (i < len1 && j < len2) {
        var char1 = str1[i];
        var char2 = str2[j];
        if (char1 === char2) {
            if (/\d/.test(char1)) {
                var num1 = char1,
                    num2 = char2;
                var k = i + 1,
                    l = j + 1;
                while (k < len1 && /\d/.test(str1[k])) {
                    num1 += str1[k++];
                }
                while (l < len2 && /\d/.test(str2[l])) {
                    num2 += str2[l++];
                }
                if (num1 === num2) {
                    currentCommon += num1;
                    i = k;
                    j = l;
                } else {
                    if (currentCommon.length > 0) {
                        commonParts.push(currentCommon);
                        currentCommon = "";
                    }
                    i = k;
                    j = l;
                }
            } else {
                currentCommon += char1;
                i++;
                j++;
            }
        } else {
            if (currentCommon.length > 0) {
                commonParts.push(currentCommon);
                currentCommon = "";
            }
            if (/\d/.test(char1) && /\d/.test(char2)) {
                while (i < len1 && /\d/.test(str1[i])) i++;
                while (j < len2 && /\d/.test(str2[j])) j++;
            } else if (/\d/.test(char1)) {
                i++;
            } else if (/\d/.test(char2)) {
                j++;
            } else {
                i++;
                j++;
            }
        }
    }
    if (currentCommon.length > 0) {
        commonParts.push(currentCommon);
    }
    return commonParts;
}

function sortArray(arr, key, style, order) {
    if (!Array.isArray(arr)) {
        throw new TypeError('第一个参数必须是一个数组');
    }
    order = ['desc', '1', 1].includes(order) ? 'desc' : 'asc';
    style = [1, '1'].includes(style) ? 1 : [3, '3'].includes(style) ? 3 : 2;

    let getBaseStrings = () => {
        if (arr.length < 2) return [null, null];
        let a = key ? arr[0][key] : arr[0];
        let b = key ? arr[1][key] : arr[1];
        return [String(a), String(b)];
    };
    const extractNumber = (aValue, bValue) => {
        // 获取当前比较两项的共同非数字部分
        const strA = String(aValue);
        const strB = String(bValue);
        const commonParts = getCommonNonDigitParts(strA, strB);

        // 构建替换正则
        const pattern = new RegExp(
            commonParts.map(s => s.replace(/[.*+?^${}()|[\]\\]/g, '\\$&')).join('|'),
            'g'
        );
        const extract = (str) => {
            const remaining = str.replace(pattern, '');
            const match = remaining.match(/-?\d+/);
            return match ? parseInt(match[0], 10) : null;
        };
        return {
            aNumber: typeof aValue === 'number' ? aValue : extract(strA),
            bNumber: typeof bValue === 'number' ? bValue : extract(strB)
        };
    };

    function getType(value) {
        if (/^\d+$/.test(value)) return 1;
        if (/^\d+/.test(value)) return 2;
        if (/^[A-Za-z]+/.test(value)) return 2;
        return 3;
    }

    function compare(a, b) {
        const baseStrings = getBaseStrings();
        const aValue = key && typeof a === 'object' ? a[key] : a;
        const bValue = key && typeof b === 'object' ? b[key] : b;

        if (style == 3) {
            const {
                aNumber,
                bNumber
            } = extractNumber(aValue, bValue);
            if (aNumber !== null && bNumber !== null) {
                return order === 'asc' ? aNumber - bNumber : bNumber - aNumber;
            }
            if (aNumber !== null) return order === 'asc' ? -1 : 1;
            if (bNumber !== null) return order === 'asc' ? 1 : -1;
        }
        const aType = getType(aValue);
        const bType = getType(bValue);
        if (aType !== bType) {
            return order === 'asc' ? aType - bType : bType - aType;
        }
        if (aType === 1) {
            return order === 'asc' ? aValue - bValue : bValue - aValue;
        } else if (style === 1) {
            return order === 'asc' ?
                aValue.localeCompare(bValue, 'en') :
                bValue.localeCompare(aValue, 'en');
        } else {
            return order === 'asc' ?
                aValue.localeCompare(bValue, 'zh') :
                bValue.localeCompare(aValue, 'zh');
        }
    }
    return arr.slice().sort(compare);
}

function sortSx(arr, name, style, order) {
    //0:不排序  1:英文排序 2:拼音排序 3:数字排序
    if (typeof(style) == 'undefined' || style == '') {
        style = 0;
    }
    if (style == 0) {
        var arrNew = arr;
    } else if (style == 1) {
        if (typeof(name) == 'undefined' || name == '') {
            var arrNew = arr.sort((a, b) => a.localeCompare(b));
        } else {
            var arrNew = arr.sort((a, b) => a[name].localeCompare(b[name]));
        }
    } else if (style == 2) {
        if (typeof(name) == 'undefined' || name == '') {
            var arrNew = arr.sort((a, b) => a.localeCompare(b));
        } else {
            var arrNew = arr.sort((a, b) => a[name].localeCompare(b[name]));
        }
        for (var m in arrNew) {
            if (typeof(name) == 'undefined' || name == '') {
                var mm = /^[\u4e00-\u9fa5]/.test(arrNew[m]) ? m : '-1';
            } else {
                var mm = /^[\u4e00-\u9fa5]/.test(arrNew[m][name]) ? m : '-1';
            }
            if (mm > -1) break;
        }
        for (var n = arrNew.length - 1; n >= 0; n--) {
            if (typeof(name) == 'undefined' || name == '') {
                var nn = /^[\u4e00-\u9fa5]/.test(arrNew[n]) ? n : '-1';
            } else {
                var nn = /^[\u4e00-\u9fa5]/.test(arrNew[n][name]) ? n : '-1';
            }
            if (nn > -1) break;
        }
        if (mm > -1) {
            var arrTmp = arrNew.splice(m, parseInt(n - m) + 1);
            arrNew = arrNew.concat(arrTmp);
        }

    } else if (style == 3) {
        function compareNumbers(a, b) {
            if (typeof(name) != 'undefined') {
                a = a[name];
                b = b[name];
            }
            a = JSON.stringify(a);
            b = JSON.stringify(b);

            function myFunction(str) {
                if (/\(\d+\)/.test(str)) {
                    var num = parseInt(str.match(/\((\d+)\)/)[1]);
                } else {
                    var num = /\d+/.test(str) ? parseInt(str.match(/\d+/)[0]) : 99999999999999;
                }
                return num;
            }

            var s = [a, b].map(myFunction);
            if (s[0] < s[1]) {
                return -1;
            } else if (s[0] > s[1]) {
                return 1;
            } else {
                return 0;
            }
        }
        var arrNew = arr.sort(compareNumbers);
        for (var m in arrNew) {
            if (typeof(name) == 'undefined' || name == '') {
                var mm = !/\d/.test(arrNew[m]) ? m : '-1';
            } else {
                var mm = !/\d/.test(arrNew[m][name]) ? m : '-1';
            }
            if (mm > -1) break;
        }
        for (var n = arrNew.length - 1; n >= 0; n--) {
            if (typeof(name) == 'undefined' || name == '') {
                var nn = !/\d/.test(arrNew[n]) ? n : '-1';
            } else {
                var nn = !/\d/.test(arrNew[n][name]) ? n : '-1';
            }
            if (nn > -1) break;
        }
        if (mm > -1) {
            var arrTmp = arrNew.splice(m, parseInt(n - m) + 1);
            arrNew = arrNew.concat(sortSx(arrTmp, 'title', 2));
        }
    }

    if (typeof(order) == 'undefined' || order == '' || order == 0) {} else {
        arrNew = arrNew.reverse();
    }
    return arrNew;
}

function lunbo(c) {
    return $.toString((c, toerji) => {
        if (typeof(c.type) == 'undefined') {
            c.type = '影视';
        }
        var k = c.indexbanner.length;
        var n = '0';
        var lazy = '';
        if (c.公共 || c.parse) {
            lazy = $('').lazyRule((c.公共 || c.parse).解析, (c.公共 || c.parse), '', (c.公共 || c.parse).host);
        }
        if (c.json == 1) {
            d.push({
                title: color(c.indexbanner[n][c.title], 'FF3399'),
                img: c.indexbanner[n][c.img],
                col_type: 'card_pic_1',
                desc: '0',
                url: c.host + c.url.split('#')[1] + c.indexbanner[n][c.url.split('#')[0]] + lazy,
                extra: {
                    id: 'lunbo',
                    stype: c.type,
                    name: c.indexbanner[n][c.title],
                }
            });
        } else {
            var title = pdfh(c.indexbanner[n], c.title);
            if (!title) {
                var html = getHtml(pd(c.indexbanner[n], c.url, c.host));
                title = pdfh(html, c.title);
            }
            d.push({
                title: color(title, 'FF3399'),
                img: (!/##/.test(c.img) ? pd(c.indexbanner[n], c.img) : eval(c.img.replace('host', 'c.host').replace('indexbanner', 'c.indexbanner'))) + '@Referer=' + c.host,
                col_type: 'card_pic_1',
                desc: '0',
                url: pd(c.indexbanner[n], c.url, c.host) + lazy,
                extra: {
                    id: 'lunbo',
                    stype: c.type,
                    name: pdfh(c.indexbanner[n], c.name),
                }
            });
        }
        let id = 'juyue';
        let time = 4000;
        let jkdata = MY_RULE.title == '聚阅' ? storage0.getMyVar('一级源接口信息') : {
            type: c.type,
            name: c.name
        };
        registerTask(id, time, $.toString((c, k, toerji, jkdata, 公共) => {
            rc(fc('https://gitee.com/mistywater/hiker_info/raw/master/githubproxy.json') + 'https://raw.githubusercontent.com/mistywater/hiker/main/f', 24);
            var n = getVar(c.host + 'n', '0');
            var lazy = '';
            if (c.公共 || c.parse) {
                lazy = $('').lazyRule((c.公共 || c.parse).解析, (c.公共 || c.parse), '', (c.公共 || c.parse).host);
            }
            if (c.json == 1) {
                let dd = {
                    title: color(c.indexbanner[n][c.title], 'FF3399'),
                    img: c.indexbanner[n][c.img],
                    url: c.host + c.url.split('#')[1] + c.indexbanner[n][c.url.split('#')[0]] + lazy,
                    extra: {
                        id: 'lunbo',
                        stype: c.type,
                        name: c.indexbanner[n][c.title],
                    }
                };
                var item = !lazy ? toerji(dd, jkdata) : dd;
            } else {
                var title = pdfh(c.indexbanner[n], c.title);
                if (!title) {
                    var html = getHtml(pd(c.indexbanner[n], c.url, c.host));
                    title = pdfh(html, c.title);
                }
                let dd = {
                    title: color(title, 'FF3399'),
                    img: (!/##/.test(c.img) ? urla(pdfh(c.indexbanner[n], c.img), c.host) : eval(c.img.replace('host', 'c.host').replace('indexbanner', 'c.indexbanner'))) + '@Referer=' + c.host,
                    url: urla(pdfh(c.indexbanner[n], c.url), c.host) + lazy,
                    extra: {
                        id: 'lunbo',
                        stype: c.type,
                        name: pdfh(c.indexbanner[n], c.title),
                    }
                };
                var item = !lazy ? toerji(dd, jkdata) : dd;
            }
            updateItem('lunbo', item);
            if (n >= k - 1) {
                putVar(c.host + 'n', '0');
            } else {
                putVar(c.host + 'n', (parseInt(n) + 1) + '');
            }
        }, c, k, toerji, jkdata, c.公共));
    }, c, toerji);
}

function numbersCircled(index) {
    if (index < 10) {
        var num = String.fromCharCode(parseInt(index) + 1 + 10101);
    } else if (index < 20) {
        var num = String.fromCharCode(parseInt(index) + 1 + 9440);
    } else if (index < 35) {
        var num = String.fromCharCode(parseInt(index) + 1 + 12860);
    } else if (index < 50) {
        var num = String.fromCharCode(parseInt(index) + 1 + 12941);
    } else {
        var num = parseInt(index) + 1 + '.';
    }
    return num;
}

function clearM3u8(url, reg) {
    let f = cacheM3u8(url);
    let c = readFile(f.split("##")[0]);
    let c2 = c.replace(new RegExp(reg, 'g'), '');
    writeFile(f.split("##")[0], c2);
    return f;
}

function ccc(title, ccc_) {
    ccc_ = ccc_ ? ccc_ : {
        fc: '#FFFFFF',
        bc: getDarkColor(),
    }
    return '‘‘’’<font color="' + ccc_.fc + '"><span style="background-color: ' + ccc_.bc + '">' + title + '</span></font>'
}

function sortPy(arr, name) {
    if (typeof(name) == 'undefined' || name == '') {
        var arrNew = arr.sort((a, b) => a.localeCompare(b));
    } else {
        var arrNew = arr.sort((a, b) => a[name].localeCompare(b[name]));
    }
    for (var m in arrNew) {
        if (typeof(name) == 'undefined' || name == '') {
            var mm = /^[\u4e00-\u9fa5]/.test(arrNew[m]) ? m : '-1';
        } else {
            var mm = /^[\u4e00-\u9fa5]/.test(arrNew[m][name]) ? m : '-1';
        }
        if (mm > -1) {
            break;
        }
    }
    for (var n = arrNew.length - 1; n >= 0; n--) {
        if (typeof(name) == 'undefined' || name == '') {
            var nn = /^[\u4e00-\u9fa5]/.test(arrNew[n]) ? n : '-1';
        } else {
            var nn = /^[\u4e00-\u9fa5]/.test(arrNew[n][name]) ? n : '-1';
        }
        if (nn > -1) {
            break;
        }
    }
    if (mm > -1) {
        var arrTmp = arrNew.splice(m, parseInt(n - m) + 1);
        arrNew = arrNew.concat(arrTmp);
    }
    return arrNew
}

function cpage(t, c) {
    if (!c) {
        var c = 'c';
    }
    return `_c = getMyVar(host + '${c}', '${t}');
        if (_c != getMyVar(host + '_c', '${t}')) {
            clearMyVar(host + 'page');
        }
        page = getMyVar(host + 'page', page + '');`;
}

function vPw(id) {
    evalPrivateJS('tRa+Ef6XEI8XzPzL4MD07/zSoDZsvjf+1+JA5R6hzr0ua3Ne4DB64WY9a+QNC0LkyliGQvjx58VOMjIycg6gE+OLXtJez8J+ktiS1aG934RMQ3oiJvqf/Z6XhMBvAEWqY+kHXbxZA64mVIWy5SmlgQgpYnf44KmTlAPbyUk2jwfGSOBDb3BRRe+RFhfi0WBwNdMrJ8epmmH5U3IGGZqBZcC25DdlfUcUjNmE4xw6ZMpjqySqKedcrspz8waU99FsYCH0584/TooU18Dy7w7dpJ5nM5iZtj1KMqvRjRPafqP8EP0eNQPZ94mXJHRjmZ+21l6HdcufGBEaXqmBEne2gFPwRXUjrvbgxX6wNvIHglGSvN3ZobCVZO1wOYtaiU5U0OQym5z3yvsE4PYGCOPBzrSEChgnS3KU20C15lYc5+O5KuNYzpElY2hvqtjZ37TG+Cipi1vpN+SPg85+8QtHlFArUoXGT6wUlQw22BLyLVPlqzCht3aqeZb4EK1RSRir14aK0SUa9B3wBE7SLwtBvzTRB48hxeYOvR7JvPqJXK8r6rI4l2BNamSGSoSwQ0FmS7wm7sFPy/x+1rJ6/L4Z4ty4W8vl+HthbXoeS51rpPTENZZbfb8HVWGm+uRQRG5pj+zZJR1QXr0UDXbp8VEsAD+zkbEMpQGUjCBkAUecYCaR6Sg2ceoHj5FwIwxv2xtAxqQ26BxTOxCSX6oNg/NfCa5DcNmJ0fQ6Bm2CwY6dJhzCvgmTmNbNdk76Vmv9GgV7uzV05CX3XBNqVCIh+wOLRUqkyPlagERBpwzNP+zCIdKP9rg0eInraKDX/gdHGSBISmZb42pubVagDl8OhPqUyQ340fbz/h8uWulLl3z4shZTk1uBP/Megd+vNlX+qSi4KdyOxWST/HcZh4wYb/SU7JOAXU+b3SJnR1IL1D9CbqFfmWa/TxUkQWd7ePMIL0cZ');
    return;
}

function pageAdd(page, host) {
    if (getMyVar(host + 'page')) {
        putMyVar(host + 'page', (parseInt(page) + 1) + '');
    }
    return;
}

function jinman(picUrl) {
    return $.toString((picUrl) => {
        const ByteArrayOutputStream = java.io.ByteArrayOutputStream;
        const ByteArrayInputStream = java.io.ByteArrayInputStream;
        const Bitmap = android.graphics.Bitmap;
        const BitmapFactory = android.graphics.BitmapFactory;
        const Canvas = android.graphics.Canvas;

        picUrl.match(/photos\/(\d+)?\/(\d+)?/);
        let bookId = RegExp.$1;
        let imgId = RegExp.$2;
        if (!bookId || !imgId) return input;
        if (Number(bookId) <= 220980) {
            return input;
        } else if (Number(bookId) <= 268850) {
            var $num = "10";
        } else if (Number(bookId) <= 421925) {
            var $num = parseInt(md5(bookId + imgId).slice(-1).charCodeAt() % 10) * 2 + 2;
        } else if (Number(bookId) > 421925) {
            var $num = parseInt(md5(bookId + imgId).slice(-1).charCodeAt() % 8) * 2 + 2;
        }
        let imgBitmap = BitmapFactory.decodeStream(input);
        closeMe(input);
        let width = imgBitmap.getWidth();
        let height = imgBitmap.getHeight();
        let y = Math.floor(height / $num);
        let remainder = height % $num;

        let newImgBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
        let canvas = new Canvas(newImgBitmap);
        for (let i = 1; i <= $num; i++) {
            let h = i === $num ? remainder : 0;
            canvas.drawBitmap(Bitmap.createBitmap(imgBitmap, 0, y * (i - 1), width, y + h), 0, y * ($num - i), null);
        }
        let baos = new ByteArrayOutputStream();
        newImgBitmap.compress(Bitmap.CompressFormat.PNG, 100, baos);
        return new ByteArrayInputStream(baos.toByteArray());
    }, picUrl);
}

function extraPic(host, page, pages, ctype, hiker, _chchePath, imgdec, isNovel) {
    if (!_chchePath) _chchePath = '';
    if (!ctype) var ctype = '';
    if (!hiker || hiker == '') var hiker = '1';
    var 类型 = ["movie_1", "movie_2", "movie_3", "movie_3_marquee", "pic_1", "pic_2", "pic_3", "pic_1_full", "pic_1_center", "pic_1_card", "pic_2_card", "pic_3_square", "card_pic_1", "card_pic_2", "card_pic_3", "avatar", "card_pic_3_center", "icon_1_left_pic", "icon_5", "icon_4", "icon_round_4", "icon_3_round_fill", "icon_2_round"];
    var longClick = [{
        title: '样式',
        js: $.toString((host, ctype, 类型, _chchePath) => {
            if (getItem(host + ctype + 'type')) {
                var index = 类型.indexOf(getItem(host + ctype + 'type'));
                类型[index] = '👉' + getItem(host + ctype + 'type');
            }
            showSelectOptions({
                title: "选择样式",
                col: 2,
                options: 类型,
                js: $.toString((host, ctype, _chchePath) => {
                    setItem(host + ctype + 'type', input.replace('👉', ''));
                    if (_chchePath) {
                        writeFile(_chchePath, '');
                    }
                    refreshPage();
                }, host, ctype, _chchePath)
            });
            return "hiker://empty";
        }, host, ctype, 类型, _chchePath),
    }, {
        title: '下载',
        js: `'hiker://page/download.view?rule=本地资源管理'`,
    }, {
        title: '书架',
        js: `'hiker://page/Main.view?rule=本地资源管理'`,
    }, {
        title: '首页',
        js: $.toString((host) => {
            putMyVar(host + 'page', '1');
            refreshPage(false);
            return 'hiker://empty';
        }, host),
    }, {
        title: '当前第' + page + '页',
        js: '',
    }];
    if (typeof(pages) != 'undefined' && pages) {
        var arr = ['输入页码'];
        if (pages <= 200) {
            for (var k = 1; k <= pages; k++) {
                arr.push(k);
                var num = 1;
            }
        } else if (pages <= 1000) {
            for (var k = 1; k <= pages; k = k + 5) {
                arr.push(k);
                var num = 5;
            }
        } else {
            for (var k = 1; k <= pages; k = k + 10) {
                arr.push(k);
                var num = 10;
            }
        }
        var extra1 = {
            title: '跳转',
            js: $.toString((host, arr, num, pages) => {
                return $(arr, 3, '选择页码').select((host, num, pages) => {
                    if (input == '输入页码') {
                        return $('').input((host) => {
                            putMyVar(host + 'page', input);
                            putMyVar('isMoveto', '1');
                            refreshPage(false);
                        }, host);
                    } else if (num == 1) {
                        putMyVar(host + 'page', input);
                        putMyVar('isMoveto', '1');
                        refreshPage(false);
                        return 'hiker://empty';
                    } else {
                        let arr1 = [];
                        for (let k = 0; k < num; k++) {
                            if (input * 1 + k * 1 <= pages) {
                                arr1.push(input * 1 + k * 1);
                            }
                        }
                        return $(arr1, 3, '选择页码').select((host) => {
                            putMyVar(host + 'page', input);
                            putMyVar('isMoveto', '1');
                            refreshPage(false);
                            return 'hiker://empty';
                        }, host);
                    }
                }, host, num, pages);
            }, host, arr, num, pages),
        };
    } else {
        var extra1 = {
            title: '跳转',
            js: $.toString((host) => {
                return $('').input((host) => {
                    putMyVar(host + 'page', input);
                    putMyVar('isMoveto', '1');
                    refreshPage(false);
                }, host);
            }, host),
        };
    }
    longClick.push(extra1);
    if (_chchePath) {
        longClick.push({
            title: '清除缓存',
            js: $.toString((host, _chchePath) => {
                writeFile(_chchePath, '');
                clearMyVar(host + 'page');
                refreshPage(false);
            }, host, _chchePath),
        });
    }
    longClick.unshift({
        title: getItem(host + 'picsMode', '0') == 0 ? '漫画模式' : '图文模式',
        js: $.toString((host, _chchePath) => {
            writeFile(_chchePath, '');
            if (getItem(host + 'picsMode', '0') == 0) {
                setItem(host + 'picsMode', '1');
                refreshPage(false);
            } else {
                setItem(host + 'picsMode', '0');
                refreshPage(false);
            }
        }, host, _chchePath)
    });
    var extra = $.toString((host, hiker, ctype, longClick, imgdec, isNovel) => ({
        chapterList: hiker ? 'hiker://files/_cache/chapterList.txt' : chapterList,
        info: {
            bookName: isNovel ? '全部' : MY_URL.split('/')[2],
            ruleName: isNovel ? storage0.getMyVar('一级源接口信息').name : 'photo',
            bookTopPic: isNovel ? img : 'https://api.xinac.net/icon/?url=' + host,
            decode: imgdec ? $.type(imgdec) == "function" ? $.toString((imgdec) => {
                let imgDecrypt = imgdec;
                return imgDecrypt();
            }, imgdec) : imgdec : "",
            parseCode: downloadlazy,
            defaultView: isNovel ? '0' : '1',
            type: isNovel ? 'novel' : 'comic',

        },
        longClick: longClick,
    }), host, hiker, ctype, longClick, imgdec, isNovel);
    return extra;
}

function imageDecss(key, iv, kiType, mode) {
    const CryptoUtil = $.require("hiker://assets/crypto-java.js");
    let key = CryptoUtil.Data.parseUTF8(key);
    if (kiType == 'base64') {
        let textData = CryptoUtil.Data.parseInputStream(input).base64Decode();
    } else {
        let textData = CryptoUtil.Data.parseInputStream(input);
    }
    if (iv) {
        let iv = CryptoUtil.Data.parseUTF8("8209658041411076");
    }
    let encrypted = CryptoUtil.AES.decrypt(textData, key, {
        mode: mode,
        iv: iv
    });
    if (kiType == 'base64') {
        let base64Text = encrypted.toString().split("base64,")[1];
        let encrypted0 = CryptoUtil.Data.parseBase64(base64Text, _base64.NO_WRAP);
    }
    return encrypted0.toInputStream();
}

function imgDecs(key, iv, kiType, mode) {
    return $.toString((key, iv, kiType, mode) => {
        if (key) {
            var javaImport = new JavaImporter();
            javaImport.importPackage(
                Packages.com.example.hikerview.utils,
                Packages.java.lang,
                Packages.java.security,
                Packages.javax.crypto,
                Packages.javax.crypto.spec
            );
            with(javaImport) {
                let bytes = FileUtil.toBytes(input);
                if (!mode) {
                    mode = 'AES/CBC/PKCS5Padding';
                }
                if (!kiType) {
                    kiType = "String";
                }

                function hexStringToBytes(cipherText) {
                    let str = cipherText.toLowerCase();
                    let length = str.length;
                    let bArr = java.lang.reflect.Array.newInstance(java.lang.Byte.TYPE, length / 2);
                    for (let i = 0, o = 0; i < length; i += 2, o++) {
                        let a = str[i + 1],
                            b = str[i];
                        if (b != "0") {
                            a = b + a;
                        }
                        let hexInt = java.lang.Integer.parseInt(new java.lang.String(a), 16);
                        let inty = hexInt > 127 ? hexInt - 255 - 1 : hexInt;
                        bArr[o] = inty;
                    }

                    return bArr;
                }

                function getBytes(str) {
                    let bytes;
                    if (kiType === "Base64") {
                        bytes = _base64.decode(str, _base64.NO_WRAP);
                    } else if (kiType === "Hex") {
                        bytes = hexStringToBytes(str);
                    } else {
                        bytes = String(str).getBytes("UTF-8");
                    }
                    return bytes;
                }
                key = getBytes(key);
                iv = getBytes(iv);

                let algorithm = mode.split("/")[0];

                function decryptData(_bArr) {
                    let secretKeySpec = new SecretKeySpec(key, algorithm);
                    let ivParameterSpec = new IvParameterSpec(iv);
                    let cipher = Cipher.getInstance(mode);
                    cipher.init(2, secretKeySpec, ivParameterSpec);
                    return cipher.doFinal(_bArr);
                }
                bytes = decryptData(bytes);
                return FileUtil.toInputStream(bytes);
            }
        } else {
            try {
                const CryptoUtil = $.require("hiker://assets/crypto-java.js");
                let textData = CryptoUtil.Data.parseInputStream(input);
                let base64Text = textData.toString().split("base64,")[1];
                let encrypted0 = CryptoUtil.Data.parseBase64(base64Text, _base64.NO_WRAP);
                return encrypted0.toInputStream();
            } catch (e) {
                return;
            }
        }
    }, key, iv, kiType, mode);
}

function hexStringToBytes(cipherText) {
    var javaImport = new JavaImporter();
    javaImport.importPackage(
        Packages.com.example.hikerview.utils,
        Packages.java.lang,
        Packages.java.security,
        Packages.java.util,
        Packages.java.io,
        Packages.java.text,
        Packages.javax.crypto,
        Packages.javax.crypto.spec,
    );
    with(javaImport) {
        cipherText = String(cipherText);
        let str = cipherText.toLowerCase();
        bArr = java.lang.reflect.Array.newInstance(java.lang.Byte.TYPE, 16);
        for (let i = 0, o = 0; i < 32; i += 2, o++) {
            let a = str[i + 1],
                b = str[i];
            if (b != "0") {
                a = b + a;
            }
            let hexInt = java.lang.Integer.parseInt(new java.lang.String(a), 16);
            let inty = hexInt > 127 ? hexInt - 255 - 1 : hexInt;
            bArr[o] = inty;
        }
        return bArr;
    }
}

function pageMoveto(host, page, ctype, pages, _chchePath) {
    if (!_chchePath) _chchePath = '';
    if (!ctype) {
        var ctype = '';
    }
    var longClick = [{
        title: '样式',
        js: $.toString((host, ctype, _chchePath) => {
            var 类型 = ["movie_1", "movie_2", "movie_3", "movie_3_marquee", "pic_1", "pic_2", "pic_3", "pic_1_full", "pic_1_center", "pic_1_card", "pic_2_card", "pic_3_square", "card_pic_1", "card_pic_2", "card_pic_3", "avatar", "card_pic_3_center", "icon_1_left_pic", "icon_5", "icon_4", "icon_round_4", "icon_3_round_fill", "icon_2_round"];
            if (getItem(host + 'type')) {
                var index = 类型.indexOf(getItem(host + ctype + 'type'));
                类型[index] = '👉' + getItem(host + ctype + 'type');
            }
            showSelectOptions({
                title: "选择样式",
                col: 2,
                options: 类型,
                js: $.toString((host, ctype, _chchePath) => {
                    setItem(host + ctype + 'type', input.replace('👉', ''));
                    putMyVar('isMoveto', '1');
                    if (_chchePath) {
                        writeFile(_chchePath, '');
                    }
                    refreshPage();
                }, host, ctype, _chchePath)
            });
            return "hiker://empty";
        }, host, ctype, _chchePath),
    }, {
        title: '书架',
        js: `'hiker://page/Main.view?rule=本地资源管理'`,
    }, {
        title: '首页',
        js: $.toString((host) => {
            host = host;
            putMyVar(host + 'page', '1');
            refreshPage(false);
            return 'hiker://empty';
        }, host),
    }, {
        title: '当前第' + page + '页',
        js: '',
    }, ];
    if (typeof(pages) != 'undefined') {
        var arr = ['输入页码'];
        if (pages <= 200) {
            for (var k = 1; k <= pages; k++) {
                arr.push(k);
                var num = 1;
            }
        } else if (pages <= 1000) {
            for (var k = 1; k <= pages; k = k + 5) {
                arr.push(k);
                var num = 5;
            }
        } else {
            for (var k = 1; k <= pages; k = k + 10) {
                arr.push(k);
                var num = 10;
            }
        }
        var extra1 = {
            title: '跳转',
            js: $.toString((host, arr, num, pages) => {
                return $(arr, 3, '选择页码').select((host, num, pages) => {
                    if (input == '输入页码') {
                        return $('').input((host) => {
                            putMyVar(host + 'page', input);
                            putMyVar('isMoveto', '1');
                            refreshPage(false);
                        }, host);
                    } else if (num == 1) {
                        putMyVar(host + 'page', input);
                        putMyVar('isMoveto', '1');
                        refreshPage(false);
                        return 'hiker://empty';
                    } else {
                        let arr1 = [];
                        for (let k = 0; k < num; k++) {
                            if (input * 1 + k * 1 <= pages) {
                                arr1.push(input * 1 + k * 1);
                            }
                        }
                        return $(arr1, 3, '选择页码').select((host) => {
                            putMyVar(host + 'page', input);
                            putMyVar('isMoveto', '1');
                            refreshPage(false);
                            return 'hiker://empty';
                        }, host);
                    }
                }, host, num, pages);
            }, host, arr, num, pages),
        };
    } else {
        var extra1 = {
            title: '跳转',
            js: $.toString((host) => {
                return $('').input((host) => {
                    putMyVar(host + 'page', input);
                    putMyVar('isMoveto', '1');
                    refreshPage(false);
                }, host);
            }, host),
        };
    }
    longClick.push(extra1);
    if (_chchePath) {
        longClick.push({
            title: '清除缓存',
            js: $.toString((host, _chchePath) => {
                writeFile(_chchePath, '');
                clearMyVar(host + 'page');
                refreshPage(false);
            }, host, _chchePath),
        });
    }
    longClick.unshift({
        title: getItem(host + 'picsMode', '0') == 0 ? '漫画模式' : '图文模式',
        js: $.toString((host, _chchePath) => {
            writeFile(_chchePath, '');
            if (getItem(host + 'picsMode', '0') == 0) {
                setItem(host + 'picsMode', '1');
                refreshPage(false);
            } else {
                setItem(host + 'picsMode', '0');
                refreshPage(false);
            }
        }, host, _chchePath)
    });
    return {
        longClick: longClick
    };
}

function searchMain(page, d, desc, myPage, noDelete) {
    if (page == 1 || getMyVar('isMoveto', '0') == 1 || myPage == getMyVar('MY_PAGE')||(getMyVar('MY_PAGE')!=1&&myPage==1)){
        d.push({
            title: '🔍',
            url: $.toString((r) => {
                putVar('keyword', input);
                return 'hiker://search?rule=' + r + '&s=' + input;
            }, MY_RULE.title),
            desc: desc ? desc : '搜你想要的...',
            col_type: 'input',
            extra: {
                defaultValue: getVar('keyword', ''),
                isDelete: noDelete ? 'noDelete' : ''
            }
        });
    }
    return d;
}

function classTop(index, data, host, d, mode, v, c, f, len, start, end, bgcolor, bgcolorSelected, textcolor, picsCache, darkModeVal) {
    mode = mode || 0;
    v = v || 0;
    c = c || 'c';
    f = f || 'scroll_button';
    len = len || 20;
    bgcolor = bgcolor ? ('#' + bgcolor).replace('##', '') : '';
    bgcolorSelected = bgcolorSelected ? ('#' + bgcolorSelected).replace('##', '') : '';
    textcolor = textcolor || '#000000';
    let isInRange = index >= start && index <= end;
    let isObj = typeof data === 'object' && data !== null;
    let c_title = isObj ? data.title.split('&') : data.split('&');
    let c_id = isObj ? (!data.id ? c_title : data.id === '@@@' ? data.title.replace(/^.*?&/, '&').split('&') : data.id.split('&')) : null;
    let c_img =  picsCache&&picsCache.length > 0 ? picsCache : (isObj && data.img ? data.img.split('&') : []);   
    c_title.forEach((title, index_c) => {
        title = title.replace(/＆＆/g, '&');
        let isSelected = index_c == getMyVar(host + c + 'index' + index, mode || index == v ? '0' : '-1');
        let titleStyled = isSelected ?
            strong(title, isInRange ? 'FFFF00' : 'FF6699') :
            isInRange ?
            color(title, 'FFFFFF') :
            color(title, textcolor);
        d.push({
            title: titleStyled,
            img: c_img[index_c] || '',
            col_type: f,
            url: $('#noLoading#').lazyRule((p) => {
                if (p.mode) {
                    putMyVar(p.host + p.c + p.index, p.id);
                } else {
                    putMyVar(p.host + p.c, p.id);
                    for (let n = p.v; n <= p.v + p.len - 1; n++) {
                        putMyVar(p.host + p.c + 'index' + n, '-1');
                    }
                }
                clearMyVar(p.host + 'page');
                clearMyVar(p.host + 'url');
                putMyVar(p.host + p.c + 'index' + p.index, p.index_c);
                refreshPage(false);
                return 'hiker://empty';
            }, {
                index: index,
                id: c_id ? c_id[index_c] : title,
                index_c: index_c,
                host: host,
                mode: mode,
                v: v,
                c: c,
                len: len 
            }),
            extra: {
                backgroundColor: isInRange ?
                    (isSelected ? bgcolorSelected : bgcolor) || getRandomColor(darkModeVal) : '',
                LongClick: isInRange ? bcLongClick() : [],
            },
        });
    });
    d.push({
        col_type: 'blank_block'
    });
    return d;
}

function classTop1(index, data, host, d, mode, v, c, f, len, start, end) {
    if (!v) {
        v = 0;
    }
    if (!c) {
        c = 'c';
    }
    if (!f) {
        f = 'scroll_button';
    }
    if (!len) {
        len = 20;
    }
    if (/\{/.test(JSON.stringify(data))) {
        var c_title = data.title.split('&');
        if (data.id == '') {
            var c_id = c_title;
        } else if (data.id == '@@@') {
            var c_id = data.title.replace(/^.*?&/, '&').split('&');

        } else {
            var c_id = data.id.split('&');
        }
        c_title.forEach((title, index_c, data) => {
            d.push({
                title: index_c == getMyVar(host + c + 'index' + index, (mode || index == v ? '0' : '-1')) ? (index >= start && index <= end ? strong(title, 'FFFF00') : strong(title, 'FF6699')) : (getItem('darkMode', '深色模式') == '浅色白字模式' && index >= start && index <= end ? color(title, 'FFFFFF') : title),
                col_type: f,
                url: $('#noLoading#').lazyRule((index, id, index_c, host, mode, title, v, c, len) => {
                    if (mode) {
                        putMyVar(host + c + index, id);

                    } else {
                        putMyVar(host + c, id);
                        for (let n = v; n <= v + len - 1; n++) {
                            putMyVar(host + c + 'index' + n, '-1');
                        }
                    }
                    clearMyVar(host + 'page');
                    clearMyVar(host + 'url');
                    putMyVar(host + c + 'index' + index, index_c);
                    refreshPage(false);
                    return 'hiker://empty';
                }, index, c_id[index_c], index_c, host, mode, title, v, c, len),
                extra: {
                    backgroundColor: index >= start && index <= end ? getRandomColor(getItem('darkMode')) : '',
                    LongClick: index >= start && index <= end ? bcLongClick() : [],
                }
            });
        });
        d.push({
            col_type: 'blank_block',
        });
        return d;
    } else {
        var c_title = data.split('&');
        c_title.forEach((title, index_c, data) => {
            d.push({
                title: index_c == getMyVar(host + c + 'index' + index, (mode || index == v ? '0' : '-1')) ? (index >= start && index <= end ? strong(title, 'FFFF00') : strong(title, 'FF6699')) : (getItem('darkMode', '深色模式') == '浅色白字模式' && index >= start && index <= end ? color(title, 'FFFFFF') : title),
                col_type: f,
                url: $('#noLoading#').lazyRule((index, index_c, host, mode, title, v, c, len) => {
                    if (mode) {
                        putMyVar(host + c + index, title);

                    } else {
                        putMyVar(host + c, title);
                        for (let n = v; n <= v + len - 1; n++) {
                            putMyVar(host + c + 'index' + n, '-1');
                        }
                    }
                    clearMyVar(host + 'page');
                    clearMyVar(host + 'url');
                    putMyVar(host + c + 'index' + index, index_c);
                    refreshPage(false);
                    return 'hiker://empty';
                }, index, index_c, host, mode, title, v, c, len),
                extra: {
                    backgroundColor: index >= start && index <= end ? getRandomColor(getItem('darkMode')) : '',
                    LongClick: index >= start && index <= end ? bcLongClick() : [],
                }
            });
        });
        d.push({
            col_type: 'blank_block',
        });
        return d;
    }
}

function downPic(isNovel) {
    var s = `if (list.length != 0) {
            d.push({
                title: '⬇️下载⬇️',
                desc: '',
                url: 'hiker://page/download.view?rule=本地资源管理',
                extra: {
                    chapterList: chapterList,
                    info: {
                        bookName: ${isNovel}?'全部':MY_URL.split('/')[2],
                        ruleName: ${isNovel}?storage0.getMyVar('一级源接口信息').name:'photo',
                        bookTopPic: 'https://api.xinac.net/icon/?url=' + host,
                        parseCode: downloadlazy,
                        defaultView: ${isNovel}?'0':'1',
                        type: ${isNovel}?'novel':'comic',
                    },
                }
            });
        }`;
    return s;
}

function dtfl() {
    return `
        addListener('onClose', $.toString((host) => {
        	clearMyVar(host+'url');
        	clearMyVar(host+'t');
    	},host));
         let categories;
         try {
             categories = pdfa(html, 大类定位).concat(pdfa(html, 拼接分类));
         } catch (e) {
             categories = pdfa(html, 大类定位);
         }
         const initCate = Array(20).fill('0');
         const fold = getMyVar('fold', '1');
         const cateTemp = JSON.parse(getMyVar(host + 't', JSON.stringify(initCate)));
         if (parseInt(MY_PAGE) === 1) {
             d.push({
                 title: fold === '1' ? strong('∨', 'FF0000') : strong('∧', '1aad19'),
                 url: $('#noLoading#').lazyRule((fold) => {
                     putMyVar('fold', fold === '1' ? '0' : '1');
                     refreshPage(false);
                     return 'hiker://empty';
                 }, fold),
                 col_type: 'scroll_button',
             });
             categories.forEach((category, index) => {
                 const subCategories = index === 0 && typeof 小类定位_主 !== 'undefined' ?
                     pdfa(category, 小类定位_主) :
                     pdfa(category, 小类定位);
                 if (index === 0 || fold === '1') {
                     subCategories.forEach((item, key) => {
                         const title = pdfh(item, 分类标题);
                         const isActive = key.toString() === cateTemp[index];
                         d.push({
                             title: isActive ? strong(title, 分类颜色) : strong(title, '666666'),
                             url: $(pd(item, 分类链接,host) + '#noLoading#').lazyRule((params, host) => {
                                 const newCate = params.cate_temp.map((cate, i) =>
                                     i === params.index ? params.key.toString() : cate
                                 );
                                 putMyVar(host + 't', JSON.stringify(newCate));
                                 putMyVar(host + 'url', input);
                                 refreshPage(true);
                                 return 'hiker://empty';
                             }, {
                                 cate_temp: cateTemp,
                                 index: index,
                                 key: key,
                                 page: MY_PAGE,
                             }, host),
                             col_type: 'scroll_button',
                         });
                     });
                     d.push({
                         col_type: 'blank_block',
                     });
                 }
             });
         }
     `;
}

function dtfl1() {
    var dt = `
    const empty = 'hiker://empty'
    addListener('onClose', $.toString((host) => {
        clearMyVar(host+'url');
        clearMyVar(host+'t');
    },host));
    try {
        var categories = pdfa(html, 大类定位).concat(pdfa(html, 拼接分类));
    } catch (e) {
        var categories = pdfa(html, 大类定位);
    }
    let init_cate = [];
    for (let i = 0; i < 20; i++) {
        init_cate.push('0');
    }
    const fold = getMyVar('fold', '1');
    const cate_temp_json = getMyVar(host+'t', JSON.stringify(init_cate));
    const cate_temp = JSON.parse(cate_temp_json);
    if (parseInt(MY_PAGE) === 1) {
        d.push({
            title: fold === '1' ? strong('∨', 'FF0000') : strong('∧', '1aad19'),
            url: $('#noLoading#').lazyRule((fold) => {
                putMyVar('fold', fold === '1' ? '0' : '1');
                refreshPage(false);
                return 'hiker://empty'
            }, fold),
            col_type: 'scroll_button',
        });
        /*d.push({
            title: '🗑️',
            url: $('#noLoading#').lazyRule((fold,host) => {
                clearMyVar(host+'url');
                clearMyVar(host+'t');
                refreshPage();
                return 'hiker://empty';
            },fold,host ),
            col_type: 'scroll_button',
        });*/
        categories.forEach((category, index) => {
            if (index === 0) {
                if (typeof(小类定位_主) != 'undefined') {
                    var sub_categories = pdfa(category, 小类定位_主);
                } else {
                    var sub_categories = pdfa(category, 小类定位);
                }
            } else {
                var sub_categories = pdfa(category, 小类定位);
            }
            if (index === 0) {
                sub_categories.forEach((item, key) => {
                    let title = pdfh(item, 分类标题);
                    d.push({
                        title: key.toString() == cate_temp[index] ? ss(title, 分类颜色) : ss(title,666666),
                        url: $(pd(item, 分类链接) + '#noLoading#').lazyRule((params,host) => {
                            let new_cate = [];
                            params.cate_temp.forEach((cate, index) => {
                                new_cate.push(index === 0 ? params.key.toString() : '0');
                            })
                            putMyVar(host+'t', JSON.stringify(new_cate));
                            putMyVar(host+'url', input);
                            refreshPage(true);
                            return 'hiker://empty';
                        }, {
                            cate_temp: cate_temp,
                            key: key,
                            page: MY_PAGE,
                        },host),
                        col_type: 'scroll_button',
                    });
                });
                d.push({
                    col_type: 'blank_block'
                });
            } else if (fold === '1') {
                sub_categories.forEach((item, key) => {
                    let title = pdfh(item, 分类标题);
                    d.push({
                        title: key.toString() == cate_temp[index] ? ss(title, 分类颜色) : ss(title,666666),
                        url: $(pd(item, 分类链接) + '#noLoading#').lazyRule((params,host) => {
                            params.cate_temp[params.index] = params.key.toString();
                            putMyVar(host+'t', JSON.stringify(params.cate_temp));
                            putMyVar(host+'url', input);
                            refreshPage(true);
                            return 'hiker://empty';
                        }, {
                            cate_temp: cate_temp,
                            index: index,
                            key: key,
                            page: MY_PAGE,
                        },host),
                        col_type: 'scroll_button',
                    });
                });
                d.push({
                    col_type: 'blank_block'
                });
            }
        });
    }`;
    return dt;
}

function getFileSize(size) {
    if (typeof size !== 'number' || size < 0) {
        return '0B'; // 处理无效输入
    }
    const units = ['B', 'KB', 'MB', 'GB', 'TB'];
    const threshold = 1024;
    if (size < threshold) {
        return `${size}B`;
    }
    let unitIndex = 0;
    while (size >= threshold && unitIndex < units.length - 1) {
        size /= threshold;
        unitIndex++;
    }
    return `${size.toFixed(2)}${units[unitIndex]}`;
}

function gfs(size) {
    if (!size)
        return 0;
    var num = 1024.00; //byte
    if (size < num)
        return size + "B";
    if (size < Math.pow(num, 2))
        return (size / num).toFixed(2) + "K"; //kb
    if (size < Math.pow(num, 3))
        return (size / Math.pow(num, 2)).toFixed(2) + "M"; //M
    if (size < Math.pow(num, 4))
        return (size / Math.pow(num, 3)).toFixed(2) + "G"; //G
    return (size / Math.pow(num, 4)).toFixed(2) + "T"; //T
}

function mline(n, d) {
    for (var k = 1; k <= n; k++) {
        d.push({
            col_type: 'line',
        });
    };
    return d;
}
/*function mline(n,d) {
    for (var k = 1; k <= n; k++) {
        d.push({
            col_type: 'big_big_blank_block',
        });
    };
    return;;
}*/
function cm(s, n) {
    if (n == 3) {
        if (s.length == 1) {
            s = '00' + s;
        } else if (s.length == 2) {
            s = '0' + s;
        }
    }
    if (n == 2) {
        s = s.length == 2 ? s : '0' + s;
    }
    return s;
}

function ct(num) {
    num = parseInt(num);
    if (num >= 10000) {
        return (num / 10000).toFixed(1) + 'w';
    } else {
        return num;
    }
}

function rp(data, source) {
    if (!source) {
        var txtReplace = ['平澹_平淡', '噤_禁', '庒_压', '⾼嘲_高潮', '二路_两路', '二具_两具', '二手_两手', '二颗_两颗', '二个_两个', '二条_两条', '満_满', '昑_吟', '聇_耻', '晢_皙', '啂_乳', '舿_胯', '昅_吸', '舂_春', '藌_蜜', '嗕_辱', '啂_乳', '満_满', '蓅_流', '茭_交', '菗_抽', '庇股_屁股', 'zhang_胀', 'yù_欲', 'yu_欲', 'you_诱', 'ying_迎', 'yin3_吟', 'yin2_淫', 'yīn_阴', 'yin_阴', 'ye_液', 'yao_腰', 'yang2_痒', 'yang_阳', 'yan_艳', 'ya_压', 'xue_穴', 'xiong_胸', 'xìng_性', 'xing_性', 'xie2_邪', 'xie_泄', 'xi_吸', 'wei_慰', 'tuo_脱', 'tun2_臀', 'tun_吞', 'ting_挺', 'tian_舔', 'shun_吮', 'shuang_爽', 'shu_熟', 'shi_湿', 'she_射', 'sè_色', 'se_色', 'sao_骚', 'sai_塞', 'rui_蕊', 'ru2_蠕', 'ru_乳', 'rou2_揉', 'rou_肉', 'ri_日', 'qiang_枪', 'qi2_妻', 'qi_骑', 'pi_屁', 'pen_喷', 'nue_虐', 'nong_弄', 'niao_尿', 'nen_嫩', 'nai_奶', 'min_敏', 'mi2_迷', 'mi_蜜', 'mao_毛', 'man_满', 'luo_裸', 'luan_乱', 'lu_撸', 'lou_露', 'liu_流', 'liao_撩', 'lang_浪', 'kua_胯', 'ku_裤', 'jing_精', 'jin_禁', 'jiao_交', 'jian2_奸', 'jian_贱', 'jiān_奸', 'ji3_妓', 'ji2_鸡', 'jī_激', 'ji_激', 'gun_棍', 'gui_龟', 'gong_宫', 'gen_根', 'gao2_睪', 'gao_搞', 'gang_肛', 'gan_感', 'fu_阜', 'feng_缝', 'dong2_胴', 'dong_洞', 'diao_屌', 'dang2_党', 'dàng_荡', 'dang_荡', 'chun2_唇', 'chun_春', 'chuang_床', 'chuan_喘', 'chou_抽', 'chi_耻', 'chao_潮', 'chan_缠', 'cha_插', 'cuo_搓', 'cu_粗', 'huan_欢', 'cao2_肏', 'cao_操', 'bo_勃', 'bō_波', 'bi2_屄', 'bi_逼', 'bao_饱', 'bang_棒', 'ai_爱'];
        data = data.replace(/<img src=\"(image|mom|in)\/(.+?)\.jpg\">/gi, '$2');
    } else if (source == '月亮小说') {
        var txtReplace = ['🌫_啊', '🌍_吧', '🍎_扒', '🍄_逼', '🌡_勃', '🌳_操', '🍇_插', '🌖_差', '🍐_潮', '🌹_处', '🌬_喘', '🍁_荡', '🌱_捣', '🍑_顶', '🌎_恩', '🍆_干', '🌼_肛', '🌇_根', '🍊_龟', '🌦_含', '🍗_滑', '🌌_鸡', '🌯_妓', '🌮_奸', '🌶_浆', '🌛_交', '🌤_叫', '🌊_紧', '🍓_进', '🍚_茎', '🍉_精', '🌘_久', '🍂_菊', '🌟_具', '🌣_口', '🌓_裤', '🍔_浪', '🍒_力', '🌃_莉', '🍍_流', '🌙_乱', '🌀_伦', '🌂_萝', '🍃_裸', '🌩_咪', '🌲_摸', '🌭_奶', '🌠_内', '🌏_嫩', '🌪_哦', '🌅_炮', '🌈_屁', '🍙_翘', '🌝_侵', '🌜_亲', '🌒_裙', '🌑_热', '🌴_日', '🌚_乳', '🌞_入', '🌐_软', '🍕_骚', '🌾_色', '🌄_少', '🍈_射', '🍖_身', '🌨_呻', '🌸_深', '🌋_爽', '🍋_水', '🌕_丝', '🌽_舔', '🍌_腿', '🌆_臀', '🌔_脱', '🌧_吸', '🍘_下', '🍏_泄', '🌿_芯', '🌁_性', '🌉_胸', '🌻_穴', '🌗_丫', '🌺_痒', '🍅_阴', '🌥_吟', '🌷_淫', '🌢_硬', '🌰_幼', '🌵_欲'];
    }
    txtReplace.forEach((it) => {
        data = data.replace(new RegExp(it.split('_')[0], 'gi'), it.split('_')[1]);
    });
    return data;
}

function rp1(data) {
    var m = [],
        n = [];

    function x(a, b) {
        var a;
        var b;
        m.push(a);
        n.push(b);
    }
    x(/菗/gi, "抽");
    x(/嗕/gi, "辱");
    x(/蓅/gi, "流");
    x(/茭/gi, "交");
    x(/zhang/gi, "胀");
    x(/chun2/gi, "唇");
    x(/chun/gi, "春");
    x(/chuang/gi, "床");
    x(/chuan/gi, "喘");
    x(/chou/gi, "抽");
    x(/chi/gi, "耻");
    x(/chao/gi, "潮");
    x(/chan/gi, "缠");
    x(/cha/gi, "插");
    x(/yu/gi, "欲");
    x(/yù/gi, "欲");
    x(/you/gi, "诱");
    x(/ying/gi, "迎");
    x(/yin3/gi, "吟");
    x(/yin2/gi, "淫");
    x(/yin/gi, "阴");
    x(/yīn/gi, "阴");
    x(/ye/gi, "液");
    x(/yao/gi, "腰");
    x(/yang2/gi, "痒");
    x(/yang/gi, "阳");
    x(/yan/gi, "艳");
    x(/ya/gi, "压");
    x(/xue/gi, "穴");
    x(/xiong/gi, "胸");
    x(/xing/gi, "性");
    x(/xìng/gi, "性");
    x(/xie2/gi, "邪");
    x(/xie/gi, "泄");
    x(/xi/gi, "吸");
    x(/wei/gi, "慰");
    x(/tuo/gi, "脱");
    x(/tun2/gi, "臀");
    x(/tun/gi, "吞");
    x(/ting/gi, "挺");
    x(/tian/gi, "舔");
    x(/shun/gi, "吮");
    x(/shuang/gi, "爽");
    x(/shu/gi, "熟");
    x(/shi/gi, "湿");
    x(/she/gi, "射");
    x(/se/gi, "色");
    x(/sè/gi, "色");
    x(/sao/gi, "骚");
    x(/sai/gi, "塞");
    x(/rui/gi, "蕊");
    x(/ru2/gi, "蠕");
    x(/ru/gi, "乳");
    x(/rou2/gi, "揉");
    x(/rou/gi, "肉");
    x(/ri/gi, "日");
    x(/qiang/gi, "枪");
    x(/qi2/gi, "妻");
    x(/qi/gi, "骑");
    x(/pi/gi, "屁");
    x(/pen/gi, "喷");
    x(/nue/gi, "虐");
    x(/nong/gi, "弄");
    x(/niao/gi, "尿");
    x(/nen/gi, "嫩");
    x(/nai/gi, "奶");
    x(/min/gi, "敏");
    x(/mi2/gi, "迷");
    x(/mi/gi, "蜜");
    x(/mao/gi, "毛");
    x(/man/gi, "满");
    x(/luo/gi, "裸");
    x(/luan/gi, "乱");
    x(/lu/gi, "撸");
    x(/lou/gi, "露");
    x(/liu/gi, "流");
    x(/liao/gi, "撩");
    x(/lang/gi, "浪");
    x(/kua/gi, "胯");
    x(/ku/gi, "裤");
    x(/jing/gi, "精");
    x(/jin/gi, "禁");
    x(/jiao/gi, "交");
    x(/jian2/gi, "奸");
    x(/jiān/gi, "奸");
    x(/jian/gi, "贱");
    x(/ji3/gi, "妓");
    x(/ji2/gi, "鸡");
    x(/ji/gi, "激");
    x(/jī/gi, "激");
    x(/huan/gi, "欢");
    x(/gun/gi, "棍");
    x(/gui/gi, "龟");
    x(/gong/gi, "宫");
    x(/gen/gi, "根");
    x(/gao2/gi, "睪");
    x(/gao/gi, "搞");
    x(/gang/gi, "肛");
    x(/gan/gi, "感");
    x(/fu/gi, "阜");
    x(/feng/gi, "缝");
    x(/dong2/gi, "胴");
    x(/dong/gi, "洞");
    x(/diao/gi, "屌");
    x(/dang2/gi, "党");
    x(/dang/gi, "荡");
    x(/dàng/gi, "荡");
    x(/cuo/gi, "搓");
    x(/cu/gi, "粗");
    x(/cao2/gi, "肏");
    x(/cao/gi, "操");
    x(/bo/gi, "勃");
    x(/bō/gi, "波");
    x(/bi2/gi, "屄");
    x(/bi/gi, "逼");
    x(/bao/gi, "饱");
    x(/bang/gi, "棒");
    x(/ai/gi, "爱");
    x(/[MＭmｍ]\.[８8].+[MＭmｍ]/g, "");
    x(/[wｗWＷ]{3}\.[Gｇ].+?[ＳSｓs]\...[MＭmｍ]/g, "");
    x(/(<br>){2,}/g, "<p>");
    data = data.replace(/<img src=\"image\/(.+?)\.jpg\">/g, '$1');
    data = data.replace(/<img src=\"mom\/(.+?)\.jpg\">/g, '$1');
    data = data.replace(/<img src=\"n\/(.+?)\.jpg\">/g, '$1');
    for (var i in m) {
        data = data.replace(m[i], n[i]);
    }
    data = data.replace(/　{1,}/g, '　　');
    return data;
}

function getRandomArray(arr, num) {
    const shuffled = arr.slice();
    let currentIndex = arr.length;
    if (num >= currentIndex) {
        return shuffled;
    }
    while (currentIndex > arr.length - num) {
        const randomIndex = Math.floor(Math.random() * currentIndex);
        currentIndex--;
        [shuffled[currentIndex], shuffled[randomIndex]] = [
            shuffled[randomIndex],
            shuffled[currentIndex],
        ];
    }
    return shuffled.slice(-num);
}

function imgDec(key, iv, a, b) {
    if (!b) {
        b = 'PKCS5Padding';
    }
    var sss = `
            function imgDecrypt() {
                var javaImport = new JavaImporter();
                javaImport.importPackage(
                    Packages.com.example.hikerview.utils,
                    Packages.java.lang,
                    Packages.java.security,
                    Packages.java.util,
                    Packages.java.io,
                    Packages.java.text,
                    Packages.javax.crypto,
                    Packages.javax.crypto.spec,
                );
                with(javaImport) {
                    let bytes = FileUtil.toBytes(input);
                    function decryptData(bArr) {
		    if(/B@/.test("${key}")){
      			var secretKeySpec = new SecretKeySpec(String("${key}"), "${a}");
                    	var ivParameterSpec = new IvParameterSpec(String("${iv}"));
		    }else{
		    	var secretKeySpec = new SecretKeySpec(String("${key}").getBytes(), "${a}");
                    	var ivParameterSpec = new IvParameterSpec(String("${iv}").getBytes());
		     }
                    	var cipher = Cipher.getInstance("${a}"+"/CBC/"+"${b}");
                    	cipher.init(2, secretKeySpec, ivParameterSpec);
                   	 return cipher.doFinal(bArr);
                    }
                    bytes = decryptData(bytes);
                    return FileUtil.toInputStream(bytes);
                }
            }                    
        `;
    putVar('sss', sss);
    var imgdec = $.toString(() => {
        eval(getVar('sss'));
        return imgDecrypt();
    });
    putVar('imgdec', imgdec);
    return imgdec;
}

function en(key, iv, data, mode, encoding) {
    eval(getCryptoJS());
    if (!mode) mode = 'AES/ECB/PKCS7Padding';
    var s0 = mode.split('/')[0];
    var s1 = mode.split('/')[1];
    var s2 = mode.split('/')[2];
    s2 = s2.replace(/PKCS7Padding/, 'PKCS7').replace(/KCS/, 'kcs');
    key = CryptoJS.enc.Utf8.parse(key);
    if (iv) iv = CryptoJS.enc.Utf8.parse(iv);

    function En() {
        if (iv) {
            var encrypted = CryptoJS[s0].encrypt(data, key, {
                iv: iv,
                mode: CryptoJS.mode[s1],
                padding: CryptoJS.pad[s2]
            });
        } else {
            var encrypted = CryptoJS[s0].encrypt(data, key, {
                mode: CryptoJS.mode[s1],
                padding: CryptoJS.pad[s2]
            });
        }
        if (!encoding) {
            return encrypted.toString();
        } else {
            return encrypted.ciphertext.toString();
        }
    };
    return En(data, encoding);
}

function de(key, iv, data, mode, encoding) {
    const Cipher = javax.crypto.Cipher;
    const SecretKeySpec = javax.crypto.spec.SecretKeySpec;
    const IvParameterSpec = javax.crypto.spec.IvParameterSpec;
    const Base64 = android.util.Base64;
    const JString = java.lang.String;
    const JArray = java.lang.reflect.Array;
    const JByte = java.lang.Byte;
    try {
        mode = mode || 'AES/CBC/PKCS7Padding';
        encoding = encoding || 'Base64';
        let algorithm = mode.split("/")[0];
        let modeName = mode.split("/")[1];
        let encryptedBytes;
        if (encoding === 'Hex') {
            let hex = new JString(data).replaceAll("\\s+", "");
            let len = hex.length() / 2;
            try {
                encryptedBytes = java.util.HexFormat.of().parseHex(hex);
            } catch (e) {
                encryptedBytes = JArray.newInstance(JByte.TYPE, len);
                let pos = 0,
                    idx = 0;
                while (pos + 8 <= hex.length()) {
                    let val = java.lang.Long.parseLong(hex.substring(pos, pos + 8), 16);
                    encryptedBytes[idx] = ((val >>> 24) << 24) >> 24;
                    encryptedBytes[idx + 1] = (((val >>> 16) & 0xff) << 24) >> 24;
                    encryptedBytes[idx + 2] = (((val >>> 8) & 0xff) << 24) >> 24;
                    encryptedBytes[idx + 3] = ((val & 0xff) << 24) >> 24;
                    pos += 8;
                    idx += 4;
                }
                if (pos < hex.length()) {
                    let val = java.lang.Integer.parseInt(hex.substring(pos), 16);
                    let remaining = (hex.length() - pos) / 2;
                    for (let i = remaining - 1; i >= 0; i--) {
                        encryptedBytes[idx + i] = ((val & 0xff) << 24) >> 24;
                        val >>>= 8;
                    }
                }
            }
        } else if (encoding === 'Base64') encryptedBytes = Base64.decode(data, Base64.NO_WRAP);
        else encryptedBytes = String(data).getBytes("UTF-8");
        let keyBytes = new JString(key).getBytes("UTF-8");
        let secretKeySpec = new SecretKeySpec(keyBytes, algorithm);
        let cipher = Cipher.getInstance(mode);
        if (modeName === 'ECB') cipher.init(2, secretKeySpec);
        else {
            let ivBytes = new JString(iv || key).getBytes("UTF-8");
            let ivParameterSpec = new IvParameterSpec(ivBytes);
            cipher.init(2, secretKeySpec, ivParameterSpec);
        }
        let resultBytes = cipher.doFinal(encryptedBytes);
        return String(new JString(resultBytes, "UTF-8"));
    } catch (e) {
        log("deJava解密失败: " + e);
        return null;
    }
}

function urla(u, host) {
    let protocolMatch = u.match(/^([a-zA-Z][a-zA-Z0-9+\-.]*):/);
    let protocol = protocolMatch ? protocolMatch[1].toLowerCase() : null;
    if (protocol && protocol !== 'http' && protocol !== 'https') return u;
    if (!/^http/i.test(u)) {
        if (u.substr(0, 2) != '//') {
            if (u.substr(0, 1) != '/') u = host + '/' + u;
            else u = host + u;
        } else {
            u = 'https:' + u;
        }
    }
    return encodeURI(u);
}

function rn(c) {
    return c.replace(/\[.+?]|丨|～|\//g, '|')
        .replace(/\(.+?\)/g, '')
        .replace(/第.+?(章|话) ?-?/g, '|')
        .replace(/\| {1,}| {1,}\|/g, '|')
        .replace(/(\|){1,}/g, '|')
        .replace(/[\[\?!]]/g, '')
        .replace(/^\||\|$/g, '');
}

function r(c) {
    return c.replace(/（/g, '(').replace(/）/g, ')').replace(/｜/g, '|').replace(/？/g, '?').replace(/！/g, '!');
}

function colorCode(d) {
    var str = Array.from(d.toString().replace('#', ''));
    if (str.length != 6) {
        return false;
    } else {
        for (var k in str) {
            if (!((str[k] >= '0' && str[k] <= '9') || (str[k] >= 'a' && str[k] <= 'f') || (str[k] >= 'A' && str[k] <= 'F'))) {
                return false;
            }
        }
        return true;
    }
}

function normalizeColorCode(color) {
    let hex = String(color || '000000').replace(/^#/, '').toLowerCase();
    if (/^[0-9a-f]{3}$/.test(hex)) {
        return hex.split('').map(c => c + c).join('');
    }
    if (/^[0-9a-f]$/.test(hex)) {
        return hex.repeat(6);
    }
    return hex.padEnd(6, '0').slice(0, 6);
}
String.prototype.sub = function(c) {
    return `‘‘’’<sub><small><font color=#${normalizeColorCode(c)}>${this}</font></small></sub>`;
};
String.prototype.subR = function(c) {
    return `<sub><small><font color=#${normalizeColorCode(c)}>${this}</font></small></sub>`;
};
String.prototype.sup = function(c) {
    return `‘‘’’<sup><small><font color=#${normalizeColorCode(c)}>${this}</font></small></sup>`;
};
String.prototype.supR = function(c) {
    return `<sup><small><font color=#${normalizeColorCode(c)}>${this}</font></small></sup>`;
};
String.prototype.ss = function(c) {
    return `‘‘’’<strong><small><font color=#${normalizeColorCode(c)}>${this}</font></small></strong>`;
};
String.prototype.ssR = function(c) {
    return `<strong><small><font color=#${normalizeColorCode(c)}>${this}</font></small></strong>`;
};
String.prototype.sb = function(c) {
    return `‘‘’’<strong><big><font color=#${normalizeColorCode(c)}>${this}</font></big></strong>`;
};
String.prototype.sbR = function(c) {
    return `<strong><big><font color=#${normalizeColorCode(c)}>${this}</font></big></strong>`;
};
String.prototype.color = function(c) {
    return `‘‘’’<font color=#${normalizeColorCode(c)}>${this}</font>`;
};
String.prototype.colorR = function(c) {
    return `<font color=#${normalizeColorCode(c)}>${this}</font>`;
};
String.prototype.small = function(c) {
    return `‘‘’’<small><font color=#${normalizeColorCode(c)}>${this}</font></small>`;
};
String.prototype.smallR = function(c) {
    return `<small><font color=#${normalizeColorCode(c)}>${this}</font></small>`;
};
String.prototype.big = function(c) {
    return `‘‘’’<big><font color=#${normalizeColorCode(c)}>${this}</font></big>`;
};
String.prototype.bigR = function(c) {
    return `<big><font color=#${normalizeColorCode(c)}>${this}</font></big>`;
};
String.prototype.strong = function(c) {
    return `‘‘’’<strong><font color=#${normalizeColorCode(c)}>${this}</font></strong>`;
};
String.prototype.strongR = function(c) {
    return `<strong><font color=#${normalizeColorCode(c)}>${this}</font></strong>`;
};
String.prototype.ssR = function(c) {
    return `<strong><small><font color=#${normalizeColorCode(c)}>${this}</font></small></strong>`;
};

function sub(d, c) {
    return '‘‘’’<sub><small><font color=#' + normalizeColorCode(c) + '>' + d + '</font></small></sub>';
}

function subR(d, c) {
    return '<sub><small><font color=#' + normalizeColorCode(c) + '>' + d + '</font></small></sub>';
}

function sup(d, c) {
    return '‘‘’’<sup><small><font color=#' + normalizeColorCode(c) + '>' + d + '</font></small></sup>';
}

function supR(d, c) {
    return '<sup><small><font color=#' + normalizeColorCode(c) + '>' + d + '</font></small></sup>';
}

function ss(d, c) {
    return '‘‘’’<strong><small><font color=#' + normalizeColorCode(c) + '>' + d + '</font></small></strong>';
}

function ssR(d, c) {
    return '<strong><small><font color=#' + normalizeColorCode(c) + '>' + d + '</font></small></strong>';
}

function sb(d, c) {
    return '‘‘’’<strong><big><font color=#' + normalizeColorCode(c) + '>' + d + '</font></big></strong>';
}

function sbR(d, c) {
    return '<strong><big><font color=#' + normalizeColorCode(c) + '>' + d + '</font></big></strong>';
}

function color(d, c) {
    return '‘‘’’<font color=#' + normalizeColorCode(c) + '>' + d + '</font>';
}

function colorR(d, c) {
    return '<font color=#' + normalizeColorCode(c) + '>' + d + '</font>';
}

function small(d, c) {
    return '‘‘’’<small><font color=#' + normalizeColorCode(c) + '>' + d + '</font></small>';
}

function smallR(d, c) {
    return '<small><font color=#' + normalizeColorCode(c) + '>' + d + '</font></small>';
}

function big(d, c) {
    return '‘‘’’<big><font color=#' + normalizeColorCode(c) + '>' + d + '</font></big>';
}

function bigR(d, c) {
    return '<big><font color=#' + normalizeColorCode(c) + '>' + d + '</font></big>';
}

function strong(d, c) {
    return '‘‘’’<strong><font color=#' + normalizeColorCode(c) + '>' + d + '</font></strong>';
}

function strongR(d, c) {
    return '<strong><font color=#' + normalizeColorCode(c) + '>' + d + '</font></strong>';
}

function jp(d) {
    return JSON.parse(fetch('hiker://page/' + d + '?rule=' + MY_RULE.title)).rule;
}

function e(d) {
    var s = JSON.parse(fetch('hiker://page/' + d + '?rule=' + MY_RULE.title)).rule;
    return eval(s);
}

function fy(s) {
    var strT = [];
    var urls = [];

    for (var list of s) {
        list = list.split(' ').slice(0, 9);
        var strTmp = '';
        for (var k in list) {
            var s = strTmp + ' ' + list[k];
            if (s.length > 45) {
                break
            } else {
                strTmp = strTmp + ' ' + list[k];
            }
        }
        urls.push({
            url: 'https://www.iciba.com/word?w=' + strTmp,
            options: {
                headers: {
                    'User-Agent': PC_UA,
                }
            }
        })
    }
    var strs = bf(urls);
    strs.forEach((item, index) => {
        if (/"translate_result"/.test(item)) {
            var str = item.match(/"translate_result":"(.*?)"/)[1];
        } else {
            var str = s[index];
        }
        strT.push(str);
    });
    return strT;
}
var CHAR_MAP={"錒":"锕","皚":"皑","藹":"蔼","靄":"霭","愛":"爱","噯":"嗳","嬡":"嫒","璦":"瑷","曖":"暧","礙":"碍","諳":"谙","鵪":"鹌","垵":"埯","銨":"铵","骯":"肮","翺":"翱","鰲":"鳌","媼":"媪","襖":"袄","奧":"奥","嶴":"岙","驁":"骜","罷":"罢","壩":"坝","擺":"摆","敗":"败","頒":"颁","鈑":"钣","闆":"板","絆":"绊","辦":"办","幫":"帮","綁":"绑","謗":"谤","鎊":"镑","齙":"龅","飽":"饱","鴇":"鸨","寶":"宝","報":"报","鮑":"鲍","鵯":"鹎","貝":"贝","狽":"狈","備":"备","輩":"辈","鋇":"钡","憊":"惫","唄":"呗","賁":"贲","錛":"锛","繃":"绷","筆":"笔","畢":"毕","閉":"闭","蓽":"荜","嗶":"哔","鉍":"铋","幣":"币","潷":"滗","篳":"筚","蹕":"跸","斃":"毙","編":"编","邊":"边","籩":"笾","貶":"贬","緶":"缏","辮":"辫","辯":"辩","變":"变","颮":"飑","標":"标","鏢":"镖","驃":"骠","飆":"飙","飈":"飚","鑣":"镳","錶":"表","鰾":"鳔","鱉":"鳖","別":"别","癟":"瘪","賓":"宾","儐":"傧","濱":"滨","檳":"槟","瀕":"濒","繽":"缤","鑌":"镔","擯":"摈","殯":"殡","臏":"膑","髕":"髌","鬢":"鬓","稟":"禀","餅":"饼","併":"并","並":"并","剝":"剥","缽":"钵","撥":"拨","餑":"饽","鈸":"钹","鉑":"铂","駁":"驳","鵓":"鹁","蘗":"蘖","蔔":"卜","鈽":"钸","補":"补","佈":"布","鈈":"钚","財":"财","採":"采","參":"参","驂":"骖","殘":"残","慚":"惭","蠶":"蚕","慘":"惨","黲":"黪","燦":"灿","倉":"仓","蒼":"苍","滄":"沧","艙":"舱","冊":"册","側":"侧","廁":"厕","測":"测","惻":"恻","層":"层","鍤":"锸","餷":"馇","詫":"诧","釵":"钗","儕":"侪","蠆":"虿","覘":"觇","摻":"掺","攙":"搀","嬋":"婵","禪":"禅","蟬":"蝉","纏":"缠","讒":"谗","饞":"馋","產":"产","蕆":"蒇","諂":"谄","鏟":"铲","闡":"阐","囅":"冁","懺":"忏","顫":"颤","倀":"伥","閶":"阊","鯧":"鲳","長":"长","萇":"苌","場":"场","腸":"肠","嘗":"尝","嚐":"尝","償":"偿","廠":"厂","悵":"怅","暢":"畅","鈔":"钞","車":"车","硨":"砗","徹":"彻","陳":"陈","塵":"尘","諶":"谌","磣":"碜","齔":"龀","櫬":"榇","襯":"衬","讖":"谶","傖":"伧","稱":"称","撐":"撑","檉":"柽","蟶":"蛏","棖":"枨","誠":"诚","鋮":"铖","懲":"惩","騁":"骋","鴟":"鸱","癡":"痴","馳":"驰","遲":"迟","恥":"耻","齒":"齿","飭":"饬","熾":"炽","沖":"冲","衝":"冲","蟲":"虫","寵":"宠","銃":"铳","綢":"绸","儔":"俦","幬":"帱","疇":"畴","籌":"筹","躊":"踌","讎":"雠","醜":"丑","芻":"刍","鋤":"锄","廚":"厨","雛":"雏","櫥":"橱","躕":"蹰","儲":"储","礎":"础","處":"处","絀":"绌","憷":"怵","觸":"触","傳":"传","釧":"钏","瘡":"疮","闖":"闯","創":"创","愴":"怆","錘":"锤","純":"纯","蒓":"莼","鶉":"鹑","綽":"绰","輟":"辍","齪":"龊","詞":"词","辭":"辞","鶿":"鹚","賜":"赐","囪":"囱","蔥":"葱","蓯":"苁","樅":"枞","聰":"聪","驄":"骢","從":"从","叢":"丛","湊":"凑","輳":"辏","攛":"撺","躥":"蹿","竄":"窜","鹺":"鹾","銼":"锉","錯":"错","噠":"哒","達":"达","韃":"鞑","獃":"呆","帶":"带","紿":"绐","貸":"贷","單":"单","鄲":"郸","殫":"殚","癉":"瘅","簞":"箪","撣":"掸","擔":"担","膽":"胆","誕":"诞","憚":"惮","彈":"弹","澹":"淡","當":"当","襠":"裆","鐺":"铛","擋":"挡","檔":"档","黨":"党","讜":"谠","氹":"凼","碭":"砀","蕩":"荡","盪":"荡","島":"岛","搗":"捣","導":"导","禱":"祷","盜":"盗","燈":"灯","鄧":"邓","鐙":"镫","滌":"涤","敵":"敌","鏑":"镝","糴":"籴","詆":"诋","遞":"递","墑":"墒","締":"缔","諦":"谛","顛":"颠","巔":"巅","癲":"癫","點":"点","電":"电","鈿":"钿","墊":"埝","澱":"淀","鯛":"鲷","釣":"钓","銱":"铞","調":"调","諜":"谍","鰈":"鲽","疊":"叠","釘":"钉","頂":"顶","訂":"订","鋌":"铤","錠":"锭","丟":"丢","銩":"铥","東":"东","鶇":"鸫","凍":"冻","崠":"岽","動":"动","棟":"栋","腖":"胨","鬥":"斗","竇":"窦","獨":"独","瀆":"渎","櫝":"椟","犢":"犊","牘":"牍","讀":"读","黷":"黩","賭":"赌","篤":"笃","鍍":"镀","緞":"缎","鍛":"锻","斷":"断","籪":"簖","兌":"兑","隊":"队","對":"对","懟":"怼","噸":"吨","燉":"炖","鐓":"镦","躉":"趸","鈍":"钝","頓":"顿","奪":"夺","鐸":"铎","綞":"缍","墮":"堕","訛":"讹","鋨":"锇","鵝":"鹅","額":"额","噁":"恶","堊":"垩","軛":"轭","惡":"恶","餓":"饿","諤":"谔","鍔":"锷","顎":"颚","鶚":"鹗","鱷":"鳄","兒":"儿","鴯":"鸸","鮞":"鲕","爾":"尔","鉺":"铒","餌":"饵","邇":"迩","貳":"贰","発":"发","發":"发","廢":"废","閥":"阀","罰":"罚","琺":"珐","髮":"发","釩":"钒","煩":"烦","礬":"矾","氾":"泛","販":"贩","飯":"饭","範":"范","鈁":"钫","魴":"鲂","紡":"纺","訪":"访","飛":"飞","緋":"绯","鯡":"鲱","誹":"诽","費":"费","鐨":"镄","紛":"纷","僨":"偾","墳":"坟","憤":"愤","奮":"奋","糞":"粪","風":"风","楓":"枫","碸":"砜","瘋":"疯","鋒":"锋","豐":"丰","灃":"沣","馮":"冯","縫":"缝","諷":"讽","鳳":"凤","麩":"麸","膚":"肤","紱":"绂","紼":"绋","鳧":"凫","輻":"辐","襆":"幞","輔":"辅","撫":"抚","負":"负","訃":"讣","婦":"妇","復":"复","複":"复","駙":"驸","賦":"赋","鮒":"鲋","縛":"缚","賻":"赙","鰒":"鳆","賅":"赅","該":"该","鈣":"钙","蓋":"盖","尷":"尴","桿":"杆","稈":"秆","趕":"赶","紺":"绀","幹":"干","贛":"赣","岡":"冈","剛":"刚","崗":"岗","綱":"纲","鋼":"钢","臯":"皋","睪":"睾","橰":"槔","縞":"缟","鎬":"镐","誥":"诰","鋯":"锆","擱":"搁","鴿":"鸽","閣":"阁","鎘":"镉","個":"个","鉻":"铬","給":"给","亙":"亘","賡":"赓","綆":"绠","鯁":"鲠","宮":"宫","龔":"龚","鞏":"巩","貢":"贡","鉤":"钩","溝":"沟","緱":"缑","夠":"够","詬":"诟","構":"构","覯":"觏","購":"购","軲":"轱","鴣":"鸪","轂":"毂","詁":"诂","鈷":"钴","穀":"谷","鶻":"鹘","蠱":"蛊","僱":"雇","錮":"锢","顧":"顾","鴰":"鸹","剮":"剐","掛":"挂","詿":"诖","噲":"哙","關":"关","鰥":"鳏","觀":"观","館":"馆","貫":"贯","摜":"掼","慣":"惯","鸛":"鹳","廣":"广","獷":"犷","規":"规","媯":"妫","閨":"闺","龜":"龟","鮭":"鲑","歸":"归","軌":"轨","匭":"匦","詭":"诡","貴":"贵","劌":"刿","劊":"刽","櫃":"柜","鱖":"鳜","袞":"衮","滾":"滚","緄":"绲","輥":"辊","鯀":"鲧","鍋":"锅","蟈":"蝈","國":"国","摑":"掴","幗":"帼","槨":"椁","過":"过","鉿":"铪","還":"还","駭":"骇","頇":"顸","韓":"韩","闞":"阚","釬":"钎","漢":"汉","頷":"颔","絎":"绗","頏":"颃","蠔":"蚝","號":"号","顥":"颢","灝":"灏","訶":"诃","紇":"纥","閡":"阂","頜":"颌","闔":"阖","賀":"贺","鶴":"鹤","橫":"横","轟":"轰","紅":"红","葒":"荭","閎":"闳","鴻":"鸿","黌":"黉","訌":"讧","後":"后","鱟":"鲎","軤":"轷","壺":"壶","鵠":"鹄","鬍":"胡","鶘":"鹕","許":"许","滸":"浒","戶":"户","滬":"沪","護":"护","華":"华","嘩":"哗","鏵":"铧","驊":"骅","畫":"画","話":"话","樺":"桦","劃":"划","懷":"怀","壞":"坏","歡":"欢","環":"环","鍰":"锾","繯":"缳","緩":"缓","奐":"奂","換":"换","喚":"唤","渙":"涣","煥":"焕","瘓":"痪","鯇":"鲩","黃":"黄","鰉":"鳇","謊":"谎","揮":"挥","暉":"晖","詼":"诙","輝":"辉","迴":"回","毀":"毁","匯":"汇","賄":"贿","會":"会","彙":"汇","誨":"诲","薈":"荟","噦":"哕","諱":"讳","澮":"浍","檜":"桧","燴":"烩","穢":"秽","繢":"缋","繪":"绘","葷":"荤","閽":"阍","渾":"浑","琿":"珲","餛":"馄","溷":"混","諢":"诨","鈥":"钬","夥":"伙","貨":"货","禍":"祸","獲":"获","穫":"获","鑊":"镬","賫":"赍","嘰":"叽","緝":"缉","璣":"玑","機":"机","積":"积","擊":"击","磯":"矶","雞":"鸡","譏":"讥","饑":"饥","躋":"跻","齏":"齑","羈":"羁","級":"级","極":"极","嵴":"脊","輯":"辑","藉":"借","覿":"觌","幾":"几","擠":"挤","蟣":"虮","茍":"苟","計":"计","紀":"纪","記":"记","跡":"迹","際":"际","薊":"蓟","劑":"剂","覬":"觊","濟":"济","績":"绩","蹟":"迹","鯽":"鲫","繫":"系","繼":"继","霽":"霁","鱭":"鲚","驥":"骥","浹":"浃","傢":"家","鎵":"镓","夾":"夹","郟":"郏","莢":"荚","蛺":"蛱","鋏":"铗","頰":"颊","賈":"贾","鉀":"钾","價":"价","駕":"驾","駱":"骆","戔":"戋","姦":"奸","堅":"坚","間":"间","監":"监","箋":"笺","緘":"缄","縑":"缣","艱":"艰","殲":"歼","鰹":"鲣","韉":"鞯","梘":"枧","揀":"拣","堿":"碱","減":"减","筧":"笕","戩":"戬","儉":"俭","撿":"捡","檢":"检","繭":"茧","瞼":"睑","簡":"简","鹹":"咸","騫":"骞","譾":"谫","鹼":"硷","見":"见","漸":"渐","賤":"贱","踐":"践","劍":"剑","澗":"涧","薦":"荐","鍵":"键","餞":"饯","諫":"谏","濺":"溅","艦":"舰","鐧":"锏","鑒":"鉴","鑑":"鉴","將":"将","漿":"浆","薑":"姜","韁":"缰","蔣":"蒋","槳":"桨","獎":"奖","講":"讲","絳":"绦","醬":"酱","膠":"胶","澆":"浇","嬌":"娇","鮫":"鲛","驕":"骄","鷦":"鹪","絞":"绞","腳":"脚","僥":"侥","鉸":"铰","餃":"饺","撟":"挢","矯":"矫","繳":"缴","攪":"搅","較":"较","轎":"轿","階":"阶","稭":"秸","嚌":"哜","癤":"疖","訐":"讦","傑":"杰","結":"结","節":"节","詰":"诘","潔":"洁","鮚":"鲒","屆":"届","誡":"诫","巹":"卺","僅":"仅","緊":"紧","儘":"尽","錦":"锦","謹":"谨","饉":"馑","勁":"劲","晉":"晋","進":"进","盡":"尽","縉":"缙","藎":"荩","覲":"觐","燼":"烬","贐":"赆","荊":"荆","莖":"茎","涇":"泾","經":"经","鯨":"鲸","驚":"惊","剄":"刭","頸":"颈","陘":"陉","逕":"迳","徑":"径","凈":"净","弳":"弪","脛":"胫","淨":"净","痙":"痉","靜":"静","鏡":"镜","競":"竞","坰":"垧","糾":"纠","鳩":"鸠","鬮":"阄","廄":"厩","舊":"旧","鷲":"鹫","駒":"驹","鋦":"锔","舉":"举","櫸":"榉","齟":"龃","詎":"讵","鉅":"钜","劇":"剧","據":"据","鋸":"锯","窶":"窭","颶":"飓","屨":"屦","懼":"惧","脧":"睃","鵑":"鹃","鐫":"镌","捲":"卷","錈":"锩","雋":"隽","絹":"绢","決":"决","玨":"珏","訣":"诀","絶":"绝","絕":"绝","譎":"谲","覺":"觉","軍":"军","鈞":"钧","皸":"皲","駿":"骏","開":"开","鐦":"锎","剴":"剀","凱":"凯","塏":"垲","愷":"恺","鍇":"锴","鎧":"铠","愾":"忾","龕":"龛","檻":"槛","閌":"闶","鈧":"钪","銬":"铐","軻":"轲","鈳":"钶","頦":"颏","顆":"颗","課":"课","緙":"缂","錁":"锞","騍":"骒","墾":"垦","懇":"恳","鏗":"铿","摳":"抠","瞘":"眍","庫":"库","絝":"绔","褲":"裤","嚳":"喾","誇":"夸","塊":"块","儈":"侩","鄶":"郐","獪":"狯","膾":"脍","寬":"宽","髖":"髋","誆":"诓","誑":"诳","況":"况","貺":"贶","鄺":"邝","壙":"圹","曠":"旷","礦":"矿","纊":"纩","窺":"窥","虧":"亏","匱":"匮","蕢":"蒉","潰":"溃","憒":"愦","聵":"聩","簣":"篑","饋":"馈","巋":"岿","錕":"锟","鯤":"鲲","閫":"阃","擴":"扩","闊":"阔","臘":"腊","蠟":"蜡","來":"来","萊":"莱","崍":"崃","徠":"徕","淶":"涞","錸":"铼","睞":"睐","賚":"赉","賴":"赖","瀨":"濑","癩":"癞","籟":"籁","嵐":"岚","藍":"蓝","闌":"阑","襤":"褴","攔":"拦","蘭":"兰","籃":"篮","瀾":"澜","欄":"栏","斕":"斓","讕":"谰","鑭":"镧","懶":"懒","覽":"览","攬":"揽","欖":"榄","纜":"缆","濫":"漤","爛":"烂","瑯":"琅","閬":"阆","鋃":"锒","撈":"捞","勞":"劳","嘮":"唠","嶗":"崂","癆":"痨","鐒":"铹","銠":"铑","澇":"涝","鰳":"鳓","縲":"缧","鐳":"镭","誄":"诔","壘":"垒","淚":"泪","類":"类","楞":"愣","貍":"狸","縭":"缡","釐":"厘","離":"离","蘺":"蓠","籬":"篱","驪":"骊","鸝":"鹂","鱺":"鲡","裡":"里","裏":"里","鋰":"锂","禮":"礼","鯉":"鲤","邐":"逦","鱧":"鳢","俐":"利","蒞":"莅","厲":"厉","勵":"励","歷":"历","曆":"历","隸":"隶","癘":"疠","壢":"坜","藶":"苈","櫟":"栎","麗":"丽","礪":"砺","嚦":"呖","瀝":"沥","櫪":"枥","礫":"砾","蠣":"蛎","糲":"粝","酈":"郦","儷":"俪","轢":"轹","靂":"雳","連":"连","蓮":"莲","漣":"涟","奩":"奁","憐":"怜","褳":"裢","聯":"联","簾":"帘","鐮":"镰","鰱":"鲢","璉":"琏","斂":"敛","臉":"脸","襝":"裣","蘞":"蔹","煉":"炼","練":"练","殮":"殓","鍊":"炼","鏈":"链","瀲":"潋","戀":"恋","涼":"凉","糧":"粮","兩":"两","倆":"俩","魎":"魉","靚":"靓","輛":"辆","諒":"谅","遼":"辽","療":"疗","繚":"缭","鷯":"鹩","釕":"钌","瞭":"了","鐐":"镣","獵":"猎","鄰":"邻","臨":"临","轔":"辚","鱗":"鳞","凜":"凛","廩":"廪","懍":"懔","檁":"檩","賃":"赁","藺":"蔺","躪":"躏","淩":"凌","鈴":"铃","綾":"绫","鯪":"鲮","齡":"龄","靈":"灵","欞":"棂","領":"领","嶺":"岭","劉":"刘","鎦":"镏","餾":"馏","瀏":"浏","騮":"骝","綹":"绺","鋶":"锍","鷚":"鹨","龍":"龙","蘢":"茏","嚨":"咙","瀧":"泷","瓏":"珑","櫳":"栊","朧":"胧","礱":"砻","籠":"笼","聾":"聋","隴":"陇","攏":"拢","壟":"垅","婁":"娄","僂":"偻","蔞":"蒌","嘍":"喽","樓":"楼","耬":"耧","螻":"蝼","髏":"髅","摟":"搂","嶁":"嵝","簍":"篓","瘺":"瘘","鏤":"镂","擼":"撸","嚕":"噜","盧":"卢","壚":"垆","蘆":"芦","廬":"庐","瀘":"泸","櫨":"栌","臚":"胪","爐":"炉","艫":"舻","轤":"轳","顱":"颅","鸕":"鸬","鱸":"鲈","鹵":"卤","虜":"虏","魯":"鲁","擄":"掳","櫓":"橹","陸":"陆","淥":"渌","祿":"禄","輅":"辂","賂":"赂","錄":"录","轆":"辘","鷺":"鹭","氌":"氇","巒":"峦","孿":"孪","孌":"娈","欒":"栾","攣":"挛","臠":"脔","灤":"滦","鑾":"銮","鸞":"鸾","亂":"乱","掄":"抡","侖":"仑","倫":"伦","圇":"囵","淪":"沦","綸":"纶","輪":"轮","論":"论","腡":"脶","羅":"罗","鏍":"镙","騾":"骡","蘿":"萝","邏":"逻","玀":"猡","欏":"椤","籮":"箩","鑼":"锣","絡":"络","犖":"荦","濼":"泺","閭":"闾","櫚":"榈","驢":"驴","呂":"吕","侶":"侣","鋁":"铝","屢":"屡","褸":"褛","縷":"缕","綠":"绿","慮":"虑","濾":"滤","鋝":"锊","媽":"妈","嗎":"吗","馬":"马","獁":"犸","瑪":"玛","碼":"码","螞":"蚂","榪":"杩","罵":"骂","駡":"骂","買":"买","蕒":"荬","脈":"脉","麥":"麦","勱":"劢","嘜":"唛","賣":"卖","邁":"迈","顢":"颟","瞞":"瞒","饅":"馒","鰻":"鳗","蠻":"蛮","滿":"满","縵":"缦","謾":"谩","鏝":"镘","貓":"猫","錨":"锚","鉚":"铆","貿":"贸","麼":"么","沒":"没","黴":"霉","鎂":"镁","門":"门","捫":"扪","鍆":"钔","悶":"闷","燜":"焖","懣":"懑","們":"们","勐":"猛","錳":"锰","夢":"梦","謎":"谜","彌":"弥","禰":"祢","獼":"猕","羋":"芈","瞇":"眯","糸":"纟","覓":"觅","冪":"幂","藌":"蜜","謐":"谧","綿":"绵","緬":"缅","麵":"面","緲":"缈","廟":"庙","繆":"缪","滅":"灭","瑉":"珉","緡":"缗","閔":"闵","黽":"黾","閩":"闽","憫":"悯","鳴":"鸣","銘":"铭","謬":"谬","麽":"么","謨":"谟","嬤":"嬷","饃":"馍","歿":"殁","鏌":"镆","驀":"蓦","謀":"谋","嘸":"呒","畝":"亩","鉬":"钼","吶":"呐","納":"纳","鈉":"钠","難":"难","饢":"馕","撓":"挠","鐃":"铙","脳":"脑","堖":"垴","惱":"恼","腦":"脑","鬧":"闹","訥":"讷","餒":"馁","內":"内","嫰":"嫩","鈮":"铌","鯢":"鲵","妳":"你","擬":"拟","膩":"腻","鯰":"鲶","輦":"辇","撚":"捻","攆":"撵","釀":"酿","鳥":"鸟","裊":"袅","蔦":"茑","隉":"陧","聶":"聂","嚙":"啮","鎳":"镍","囁":"嗫","躡":"蹑","鑷":"镊","顳":"颞","苧":"苎","寧":"宁","嚀":"咛","獰":"狞","檸":"柠","聹":"聍","擰":"拧","濘":"泞","紐":"纽","鈕":"钮","農":"农","儂":"侬","噥":"哝","濃":"浓","膿":"脓","穠":"秾","駑":"驽","瘧":"疟","儺":"傩","諾":"诺","釹":"钕","漚":"沤","甌":"瓯","歐":"欧","毆":"殴","謳":"讴","鷗":"鸥","嘔":"呕","慪":"怄","鈀":"钯","盤":"盘","蹣":"蹒","龐":"庞","拋":"抛","麅":"狍","皰":"疱","賠":"赔","轡":"辔","噴":"喷","鵬":"鹏","紕":"纰","鈹":"铍","羆":"罴","闢":"辟","駢":"骈","諞":"谝","騙":"骗","縹":"缥","飄":"飘","貧":"贫","頻":"频","嬪":"嫔","顰":"颦","評":"评","憑":"凭","蘋":"苹","釙":"钋","潑":"泼","鉕":"钷","頗":"颇","撲":"扑","鋪":"铺","僕":"仆","鏷":"镤","樸":"朴","譜":"谱","鐠":"镨","舖":"铺","淒":"凄","棲":"栖","榿":"桤","頎":"颀","齊":"齐","騏":"骐","騎":"骑","臍":"脐","蘄":"蕲","蠐":"蛴","鰭":"鳍","豈":"岂","啟":"启","綺":"绮","氣":"气","訖":"讫","棄":"弃","磧":"碛","薺":"荠","牽":"牵","鉛":"铅","僉":"佥","慳":"悭","遷":"迁","謙":"谦","簽":"签","鶼":"鹣","籤":"签","乾":"干","鈐":"钤","鉗":"钳","鉆":"钻","蕁":"荨","潛":"潜","錢":"钱","淺":"浅","繾":"缱","譴":"谴","塹":"堑","槧":"椠","槍":"枪","戧":"戗","錆":"锖","鏘":"锵","強":"强","墻":"墙","薔":"蔷","嬙":"嫱","檣":"樯","牆":"墙","搶":"抢","羥":"羟","鏹":"镪","嗆":"呛","熗":"炝","蹌":"跄","磽":"硗","鍬":"锹","蹺":"跷","喬":"乔","僑":"侨","蕎":"荞","嶠":"峤","橋":"桥","譙":"谯","殼":"壳","誚":"诮","翹":"翘","竅":"窍","愜":"惬","篋":"箧","鍥":"锲","竊":"窃","寢":"寝","鋟":"锓","唚":"吣","撳":"揿","氫":"氢","傾":"倾","輕":"轻","鯖":"鲭","頃":"顷","請":"请","檾":"苘","慶":"庆","親":"亲","煢":"茕","窮":"穷","瓊":"琼","鰍":"鳅","釓":"钆","巰":"巯","賕":"赇","區":"区","詘":"诎","嶇":"岖","趨":"趋","軀":"躯","驅":"驱","鴝":"鸲","齲":"龋","闃":"阒","覷":"觑","棬":"桊","輇":"辁","詮":"诠","銓":"铨","權":"权","顴":"颧","綣":"绻","勸":"劝","闕":"阙","卻":"却","愨":"悫","確":"确","闋":"阕","鵲":"鹊","讓":"让","嬈":"娆","橈":"桡","饒":"饶","擾":"扰","蟯":"蛲","繞":"绕","熱":"热","紉":"纫","軔":"轫","飪":"饪","韌":"韧","認":"认","絨":"绒","榮":"荣","嶸":"嵘","蠑":"蝾","銣":"铷","縟":"缛","軟":"软","銳":"锐","閏":"闰","潤":"润","灑":"洒","颯":"飒","薩":"萨","鰓":"鳃","賽":"赛","叁":"三","毿":"毵","傘":"伞","糝":"糁","饊":"馓","喪":"丧","顙":"颡","繅":"缫","騷":"骚","掃":"扫","嗇":"啬","銫":"铯","澀":"涩","穡":"穑","剎":"刹","殺":"杀","紗":"纱","鎩":"铩","鯊":"鲨","廈":"厦","篩":"筛","釃":"酾","曬":"晒","刪":"删","姍":"姗","釤":"钐","閃":"闪","訕":"讪","繕":"缮","騸":"骟","贍":"赡","鱔":"鳝","傷":"伤","殤":"殇","觴":"觞","賞":"赏","緔":"绱","燒":"烧","紹":"绍","畬":"畲","賒":"赊","捨":"舍","厙":"厍","設":"设","攝":"摄","灄":"滠","懾":"慑","紳":"绅","詵":"诜","諗":"谂","審":"审","瀋":"渖","嬸":"婶","腎":"肾","滲":"渗","聲":"声","澠":"渑","繩":"绳","勝":"胜","聖":"圣","屍":"尸","師":"师","獅":"狮","詩":"诗","濕":"湿","時":"时","塒":"埘","蒔":"莳","蝕":"蚀","實":"实","識":"识","鰣":"鲥","駛":"驶","視":"视","貰":"贳","勢":"势","軾":"轼","鈰":"铈","弒":"弑","飾":"饰","試":"试","適":"适","謚":"谥","釋":"释","壽":"寿","綬":"绶","獸":"兽","書":"书","紓":"纾","樞":"枢","輸":"输","攄":"摅","贖":"赎","屬":"属","術":"术","豎":"竖","數":"数","樹":"树","帥":"帅","閂":"闩","雙":"双","誰":"谁","稅":"税","順":"顺","說":"说","碩":"硕","爍":"烁","鑠":"铄","絲":"丝","噝":"咝","廝":"厮","緦":"缌","螄":"蛳","鍶":"锶","鷥":"鸶","飼":"饲","駟":"驷","鬆":"松","慫":"怂","聳":"耸","訟":"讼","頌":"颂","誦":"诵","鎪":"锼","餿":"馊","颼":"飕","擻":"擞","藪":"薮","甦":"苏","穌":"稣","蘇":"苏","訴":"诉","肅":"肃","謖":"谡","雖":"虽","綏":"绥","隨":"随","歲":"岁","誶":"谇","孫":"孙","蓀":"荪","猻":"狲","筍":"笋","損":"损","縮":"缩","嗩":"唢","瑣":"琐","鎖":"锁","獺":"獭","鰨":"鳎","撻":"挞","闥":"闼","臺":"台","駘":"骀","鮐":"鲐","擡":"抬","檯":"台","鈦":"钛","態":"态","貪":"贪","攤":"摊","灘":"滩","癱":"瘫","談":"谈","壇":"坛","曇":"昙","譚":"谭","鉭":"钽","嘆":"叹","歎":"叹","賧":"赕","湯":"汤","餳":"饧","鏜":"镗","儻":"傥","燙":"烫","鐋":"铴","濤":"涛","燾":"焘","韜":"韬","討":"讨","鋱":"铽","謄":"誊","騰":"腾","銻":"锑","綈":"绨","緹":"缇","題":"题","鵜":"鹈","體":"体","屜":"屉","闐":"阗","靦":"腼","條":"条","蓧":"莜","齠":"龆","鰷":"鲦","糶":"粜","貼":"贴","鐵":"铁","烴":"烃","聽":"听","廳":"厅","銅":"铜","統":"统","慟":"恸","頭":"头","鈄":"钭","禿":"秃","塗":"涂","圖":"图","釷":"钍","摶":"抟","團":"团","頹":"颓","蛻":"蜕","呑":"吞","飩":"饨","臋":"臀","託":"托","脫":"脱","馱":"驮","鉈":"铊","駝":"驼","鴕":"鸵","鼉":"鼍","橢":"椭","籜":"箨","媧":"娲","窪":"洼","膃":"腽","襪":"袜","咼":"呙","彎":"弯","灣":"湾","紈":"纨","頑":"顽","綰":"绾","萬":"万","網":"网","輞":"辋","為":"为","韋":"韦","幃":"帏","圍":"围","溈":"沩","違":"违","維":"维","潿":"涠","闈":"闱","濰":"潍","偽":"伪","偉":"伟","葦":"苇","瑋":"玮","煒":"炜","諉":"诿","緯":"纬","鮪":"鲔","韙":"韪","衛":"卫","謂":"谓","餵":"喂","溫":"温","紋":"纹","聞":"闻","閿":"阌","穩":"稳","問":"问","甕":"瓮","堝":"埚","萵":"莴","渦":"涡","窩":"窝","撾":"挝","蝸":"蜗","臥":"卧","齷":"龌","烏":"乌","鄔":"邬","嗚":"呜","誣":"诬","鎢":"钨","吳":"吴","無":"无","蕪":"芜","廡":"庑","憮":"怃","嫵":"妩","鵡":"鹉","務":"务","塢":"坞","誤":"误","霧":"雾","騖":"骛","鶩":"鹜","誒":"诶","錫":"锡","犧":"牺","習":"习","覡":"觋","襲":"袭","銑":"铣","璽":"玺","係":"系","郤":"郄","細":"细","戲":"戏","鬩":"阋","餼":"饩","蝦":"虾","俠":"侠","陜":"陕","峽":"峡","狹":"狭","硤":"硖","轄":"辖","芐":"苄","嚇":"吓","秈":"籼","搟":"擀","薟":"莶","鍁":"锨","錟":"锬","鮮":"鲜","躚":"跹","纖":"纤","閑":"闲","閒":"闲","銜":"衔","賢":"贤","嫻":"娴","癇":"痫","鷴":"鹇","蜆":"蚬","險":"险","獫":"猃","蘚":"藓","顯":"显","莧":"苋","峴":"岘","現":"现","羨":"羡","膁":"肷","綫":"线","線":"线","縣":"县","餡":"馅","憲":"宪","獻":"献","鄉":"乡","廂":"厢","薌":"芗","緗":"缃","鑲":"镶","驤":"骧","詳":"详","餉":"饷","饗":"飨","響":"响","項":"项","嚮":"响","梟":"枭","綃":"绡","嘵":"哓","銷":"销","蕭":"萧","簫":"箫","瀟":"潇","囂":"嚣","驍":"骁","曉":"晓","嘯":"啸","蠍":"蝎","協":"协","挾":"挟","脅":"胁","頡":"颉","諧":"谐","擷":"撷","攜":"携","纈":"缬","寫":"写","洩":"泄","紲":"绁","謝":"谢","褻":"亵","瀉":"泻","鋅":"锌","鐔":"镡","釁":"衅","興":"兴","兇":"凶","洶":"汹","鵂":"鸺","饈":"馐","綉":"绣","銹":"锈","繡":"绣","鏽":"锈","虛":"虚","須":"须","頊":"顼","噓":"嘘","詡":"诩","敘":"叙","漵":"溆","緒":"绪","續":"续","軒":"轩","諼":"谖","懸":"悬","選":"选","癬":"癣","絢":"绚","鉉":"铉","鏇":"镟","學":"学","澩":"泶","鱈":"鳕","謔":"谑","勛":"勋","塤":"埙","尋":"寻","詢":"询","潯":"浔","鱘":"鲟","訓":"训","訊":"讯","馴":"驯","遜":"逊","椏":"桠","鴉":"鸦","鴨":"鸭","壓":"压","啞":"哑","亞":"亚","軋":"轧","埡":"垭","訝":"讶","婭":"娅","氬":"氩","煙":"烟","閹":"阉","懨":"恹","訁":"讠","閆":"闫","閻":"阎","顏":"颜","嚴":"严","巖":"岩","鹽":"盐","兗":"兖","厴":"厣","儼":"俨","鼴":"鼹","魘":"魇","彥":"彦","硯":"砚","厭":"厌","諺":"谚","贗":"赝","驗":"验","饜":"餍","艷":"艳","釅":"酽","讞":"谳","豔":"艳","灩":"滟","鴦":"鸯","陽":"阳","揚":"扬","楊":"杨","煬":"炀","瘍":"疡","養":"养","癢":"痒","樣":"样","堯":"尧","軺":"轺","搖":"摇","遙":"遥","瑤":"瑶","銚":"铫","蕘":"荛","窯":"窑","餚":"肴","謠":"谣","鰩":"鳐","藥":"药","鷂":"鹞","鑰":"钥","爺":"爷","鋣":"铘","頁":"页","葉":"叶","業":"业","曄":"晔","燁":"烨","鄴":"邺","謁":"谒","靨":"靥","銥":"铱","醫":"医","貽":"贻","詒":"诒","飴":"饴","遺":"遗","儀":"仪","頤":"颐","彜":"彝","扡":"扦","釔":"钇","蟻":"蚁","艤":"舣","異":"异","訳":"译","軼":"轶","詣":"诣","義":"义","億":"亿","誼":"谊","瘞":"瘗","嶧":"峄","懌":"怿","憶":"忆","縊":"缢","藝":"艺","鎰":"镒","繹":"绎","譯":"译","議":"议","囈":"呓","鐿":"镱","驛":"驿","陰":"阴","蔭":"荫","銦":"铟","婬":"淫","欽":"钦","銀":"银","齦":"龈","飲":"饮","隱":"隐","癮":"瘾","嬰":"婴","攖":"撄","罌":"罂","嚶":"嘤","瓔":"璎","櫻":"樱","鶯":"莺","纓":"缨","鷹":"鹰","鸚":"鹦","塋":"茔","滎":"荥","熒":"荧","瑩":"莹","螢":"萤","營":"营","縈":"萦","鎣":"蓥","蠅":"蝇","瀠":"潆","贏":"赢","潁":"颍","穎":"颖","癭":"瘿","應":"应","瀅":"滢","喲":"哟","傭":"佣","擁":"拥","鏞":"镛","癰":"痈","詠":"咏","湧":"涌","踴":"踊","憂":"忧","優":"优","郵":"邮","猶":"犹","遊":"游","鈾":"铀","蕕":"莸","魷":"鱿","銪":"铕","誘":"诱","紆":"纡","汙":"污","於":"于","馀":"余","娛":"娱","魚":"鱼","崳":"嵛","漁":"渔","餘":"余","諛":"谀","覦":"觎","輿":"舆","歟":"欤","俁":"俣","與":"与","傴":"伛","語":"语","嶼":"屿","齬":"龉","馭":"驭","飫":"饫","鈺":"钰","預":"预","獄":"狱","嫗":"妪","慾":"欲","蕷":"蓣","閾":"阈","閼":"阏","諭":"谕","禦":"御","鵒":"鹆","譽":"誉","鷸":"鹬","鬰":"郁","鬱":"郁","籲":"吁","淵":"渊","鳶":"鸢","鴛":"鸳","員":"员","園":"园","圓":"圆","緣":"缘","黿":"鼋","轅":"辕","櫞":"橼","遠":"远","願":"愿","約":"约","悅":"悦","粵":"粤","鉞":"钺","閱":"阅","樂":"乐","嶽":"岳","躍":"跃","躒":"跞","暈":"晕","氳":"氲","勻":"匀","紜":"纭","雲":"云","鄖":"郧","蕓":"芸","隕":"陨","殞":"殒","鄆":"郓","惲":"恽","運":"运","慍":"愠","醞":"酝","韞":"韫","蘊":"蕴","韻":"韵","雜":"杂","災":"灾","載":"载","攢":"攒","趲":"趱","暫":"暂","鏨":"錾","贊":"赞","瓚":"瓒","讚":"赞","贓":"赃","髒":"脏","駔":"驵","臟":"脏","鑿":"凿","棗":"枣","繰":"缲","竈":"灶","則":"则","責":"责","嘖":"啧","幘":"帻","擇":"择","澤":"泽","簀":"箦","賾":"赜","賊":"贼","譖":"谮","鋥":"锃","繒":"缯","贈":"赠","紮":"扎","劄":"札","閘":"闸","鍘":"铡","柵":"栅","詐":"诈","摣":"揸","齋":"斋","債":"债","氈":"毡","譫":"谵","斬":"斩","盞":"盏","嶄":"崭","輾":"辗","佔":"占","棧":"栈","綻":"绽","戰":"战","驏":"骣","張":"张","漲":"涨","帳":"帐","脹":"胀","賬":"账","釗":"钊","詔":"诏","趙":"赵","輒":"辄","蟄":"蛰","謫":"谪","轍":"辙","鍺":"锗","這":"这","鷓":"鹧","貞":"贞","針":"针","偵":"侦","湞":"浈","楨":"桢","禎":"祯","軫":"轸","診":"诊","縝":"缜","陣":"阵","賑":"赈","鴆":"鸩","鎮":"镇","爭":"争","掙":"挣","崢":"峥","猙":"狰","睜":"睁","鉦":"钲","箏":"筝","錚":"铮","癥":"症","幀":"帧","諍":"诤","鄭":"郑","證":"证","隻":"只","梔":"栀","織":"织","姪":"侄","執":"执","縶":"絷","職":"职","躑":"踯","紙":"纸","軹":"轵","徵":"征","輊":"轾","製":"制","誌":"志","滯":"滞","摯":"挚","幟":"帜","質":"质","緻":"致","擲":"掷","櫛":"栉","贄":"贽","觶":"觯","騭":"骘","鷙":"鸷","躓":"踬","終":"终","锺":"钟","鍾":"锺","鐘":"钟","腫":"肿","種":"种","眾":"众","週":"周","謅":"诌","軸":"轴","紂":"纣","晝":"昼","葤":"荮","皺":"皱","縐":"绉","驟":"骤","誅":"诛","銖":"铢","豬":"猪","諸":"诸","瀦":"潴","櫧":"槠","櫫":"橥","騶":"驺","燭":"烛","囑":"嘱","矚":"瞩","佇":"伫","著":"着","貯":"贮","註":"注","駐":"驻","築":"筑","鑄":"铸","專":"专","磚":"砖","顓":"颛","賺":"赚","轉":"转","饌":"馔","囀":"啭","妝":"妆","莊":"庄","粧":"妆","裝":"装","樁":"桩","壯":"壮","狀":"状","戇":"戆","錐":"锥","騅":"骓","墜":"坠","綴":"缀","縋":"缒","贅":"赘","諄":"谆","準":"准","諑":"诼","濁":"浊","鐲":"镯","茲":"兹","谘":"咨","貲":"赀","資":"资","緇":"缁","輜":"辎","錙":"锱","諮":"谘","鯔":"鲻","齜":"龇","眥":"眦","漬":"渍","綜":"综","蹤":"踪","傯":"偬","總":"总","縱":"纵","鄒":"邹","諏":"诹","鯫":"鲰","鏃":"镞","組":"组","詛":"诅","躦":"躜","纘":"缵","鑽":"钻","鱒":"鳟"};

var regexSP = /[\u4e00-\u9fa5\u3000-\u303f\uff00-\uffef]/g;

function sp(cc) {
    cc = cc.replace(/&#x([0-9a-fA-F]+);/g, function(match, hex) {
        return String.fromCharCode(parseInt(hex, 16));
    });
    cc = cc.replace(/\\u([0-9a-fA-F]{4})/g, function(match, hex) {
        return String.fromCharCode(parseInt(hex, 16));
    });
var regexZhu = /著[名称述书者称录闻]|[显昭卓原译论巨遗名拙新专合编撰土]著/g;
cc = cc.replace(regexZhu, function(m) {
    return m.replace('著', '&#33879;');
});
    cc = cc.replace(/乾[坤隆]/g, m => m.replace(/乾/g, '&#20094;'));
    cc = cc.replace(/伶俐/g, m => m.replace(/俐/g, '&#20432;'));
    cc = cc.replace(/瞭[望哨远]/g, m => m.replace(/瞭/g, '&#30637;'));
    cc = cc.replace(/[慰蕴狼枕]藉/g, m => m.replace(/藉/g, '&#34249;'));
 var str = cc.replace(regexSP, function(m) { 
        return CHAR_MAP[m] || m; 
    });
//var str = cc.replace(regexSP, function(m) { return CHAR_MAP[m]; });
    var regexShen = /[浮昏深石太下星阴鱼真珠沈]沈|沈[淀浮厚昏积寂降静疴李落脉没闷密眠默溺潜沈睡思痛头下陷香箱心毅吟鱼郁冤灶渣着重舟醉]/g;
str = str.replace(regexShen, function(m) {
    return m.replace('沈', '沉'); 
});
    str = str.replace(/[混配]合&#33879;/g, m => m.replace('&#33879;', '着'));
    str = str.replace(/[什怎那这多要也]幺/g, m => m.replace('幺', '么'));
    str = str.replace(/幺[\?？]/g, m => m.replace('幺', '么'));
    return str;
}

function tr(cc) {
    cc = cc.replace(/&#x([0-9a-fA-F]+);/g, function(match, hex) {
        return String.fromCharCode(parseInt(hex, 16));
    });
    cc = cc.replace(/\\u([0-9a-fA-F]{4})/g, function(match, hex) {
        return String.fromCharCode(parseInt(hex, 16));
    });
    var str = '',
        ss = JTPYStr(),
        tt = FTPYStr();
    for (var i = 0; i < cc.length; i++) {
        if (cc.charCodeAt(i) > 10000 && ss.indexOf(cc.charAt(i)) != -1) str += tt.charAt(ss.indexOf(cc.charAt(i)));
        else str += cc.charAt(i);
    }
    return str;
}

function JTPYStr() {
    return '借了三迹鉴锈响谷秾汇锏历尝肴娴姜叹干厘妆台咨净淡脊复卷托并郁郁利着舍胡尽获辟采炼周致闲线表写泄布系蜜臀面吞嫩脱呆内淫荡与征脑板家钟只淡骂猛松绣脏钻墙发余赞制艳欲泛签奸恶你侄占译发绝铺系苏雇回仆里锕皑蔼碍爱嗳嫒瑷暧霭谙铵鹌肮袄奥媪骜鳌坝罢钯摆败呗颁办绊钣帮绑镑谤剥饱宝报鲍鸨龅辈贝钡狈备惫鹎贲锛绷笔毕毙币闭荜哔滗铋筚跸边编贬变辩辫苄缏笾标骠飑飙镖镳鳔鳖别瘪濒滨宾摈傧缤槟殡膑镔髌鬓饼禀拨钵铂驳饽钹鹁补钸财参蚕残惭惨灿骖黪苍舱仓沧厕侧册测恻层诧锸侪钗搀掺蝉馋谗缠铲产阐颤冁谄谶蒇忏婵骣觇禅镡场尝长偿肠厂畅伥苌怅阊鲳钞车彻砗尘陈衬伧谌榇碜龀撑称惩诚骋枨柽铖铛痴迟驰耻齿炽饬鸱冲冲虫宠铳畴踌筹绸俦帱雠橱厨锄雏础储触处刍绌蹰传钏疮闯创怆锤缍纯鹑绰辍龊辞词赐鹚聪葱囱从丛苁骢枞凑辏蹿窜撺错锉鹾达哒鞑带贷骀绐担单郸掸胆惮诞弹殚赕瘅箪当挡党荡档谠砀裆捣岛祷导盗焘灯邓镫敌涤递缔籴诋谛绨觌镝颠点垫电巅钿癫钓调铫鲷谍叠鲽钉顶锭订铤丢铥东动栋冻岽鸫窦犊独读赌镀渎椟牍笃黩锻断缎簖兑队对怼镦吨顿钝炖趸夺堕铎鹅额讹恶饿谔垩阏轭锇锷鹗颚颛鳄诶儿尔饵贰迩铒鸸鲕发罚阀珐矾钒烦贩饭访纺钫鲂飞诽废费绯镄鲱纷坟奋愤粪偾丰枫锋风疯冯缝讽凤沣肤辐抚辅赋复负讣妇缚凫驸绂绋赙麸鲋鳆钆该钙盖赅杆赶秆赣尴擀绀冈刚钢纲岗戆镐睾诰缟锆搁鸽阁铬个纥镉颍给亘赓绠鲠龚宫巩贡钩沟苟构购够诟缑觏蛊顾诂毂钴锢鸪鹄鹘剐挂鸹掴关观馆惯贯诖掼鹳鳏广犷规归龟闺轨诡贵刽匦刿妫桧鲑鳜辊滚衮绲鲧锅国过埚呙帼椁蝈铪骇韩汉阚绗颉号灏颢阂鹤贺诃阖蛎横轰鸿红黉讧荭闳鲎壶护沪户浒鹕哗华画划话骅桦铧怀坏欢环还缓换唤痪焕涣奂缳锾鲩黄谎鳇挥辉毁贿秽会烩汇讳诲绘诙荟哕浍缋珲晖荤浑诨馄阍获货祸钬镬击机积饥迹讥鸡绩缉极辑级挤几蓟剂济计记际继纪讦诘荠叽哜骥玑觊齑矶羁虿跻霁鲚鲫夹荚颊贾钾价驾郏浃铗镓蛲歼监坚笺间艰缄茧检碱硷拣捡简俭减荐槛鉴践贱见键舰剑饯渐溅涧谏缣戋戬睑鹣笕鲣鞯将浆蒋桨奖讲酱绛缰胶浇骄娇搅铰矫侥脚饺缴绞轿较挢峤鹪鲛阶节洁结诫届疖颌鲒紧锦仅谨进晋烬尽劲荆茎卺荩馑缙赆觐鲸惊经颈静镜径痉竞净刭泾迳弪胫靓纠厩旧阄鸠鹫驹举据锯惧剧讵屦榉飓钜锔窭龃鹃绢锩镌隽觉决绝谲珏钧军骏皲开凯剀垲忾恺铠锴龛闶钪铐颗壳课骒缂轲钶锞颔垦恳龈铿抠库裤喾块侩郐哙脍宽狯髋矿旷况诓诳邝圹纩贶亏岿窥馈溃匮蒉愦聩篑阃锟鲲扩阔蛴蜡腊莱来赖崃徕涞濑赉睐铼癞籁蓝栏拦篮阑兰澜谰揽览懒缆烂滥岚榄斓镧褴琅阆锒捞劳涝唠崂铑铹痨乐鳓镭垒类泪诔缧篱狸离鲤礼丽厉励砾历沥隶俪郦坜苈莅蓠呖逦骊缡枥栎轹砺锂鹂疠粝跞雳鲡鳢俩联莲连镰怜涟帘敛脸链恋炼练蔹奁潋琏殓裢裣鲢粮凉两辆谅魉疗辽镣缭钌鹩猎临邻鳞凛赁蔺廪檩辚躏龄铃灵岭领绫棂蛏鲮馏刘浏骝绺镏鹨龙聋咙笼垄拢陇茏泷珑栊胧砻楼娄搂篓偻蒌喽嵝镂瘘耧蝼髅芦卢颅庐炉掳卤虏鲁赂禄录陆垆撸噜闾泸渌栌橹轳辂辘氇胪鸬鹭舻鲈峦挛孪滦乱脔娈栾鸾銮抡轮伦仑沦纶论囵萝罗逻锣箩骡骆络荦猡泺椤脶镙驴吕铝侣屡缕虑滤绿榈褛锊呒妈玛码蚂马骂吗唛嬷杩买麦卖迈脉劢瞒馒蛮满谩缦镘颡鳗猫锚铆贸么没镁门闷们扪焖懑钔锰梦眯谜弥觅幂芈谧猕祢绵缅渑腼黾庙缈缪灭悯闽闵缗鸣铭谬谟蓦馍殁镆谋亩钼呐钠纳难挠脑恼闹铙讷馁内拟腻铌鲵撵辇鲶酿鸟茑袅聂啮镊镍陧蘖嗫颟蹑柠狞宁拧泞苎咛聍钮纽脓浓农侬哝驽钕诺傩疟欧鸥殴呕沤讴怄瓯盘蹒庞抛疱赔辔喷鹏纰罴铍骗谝骈飘缥频贫嫔苹凭评泼颇钋扑铺朴谱镤镨栖脐齐骑岂启气弃讫蕲骐绮桤碛颀颃鳍牵钎铅迁签谦钱钳潜浅谴堑佥荨悭骞缱椠钤枪呛墙蔷强抢嫱樯戗炝锖锵镪羟跄锹桥乔侨翘窍诮谯荞缲硗跷窃惬锲箧钦亲寝锓轻氢倾顷请庆揿鲭琼穷茕蛱巯赇虮鳅趋区躯驱龋诎岖阒觑鸲颧权劝诠绻辁铨却鹊确阕阙悫让饶扰绕荛娆桡热韧认纫饪轫荣绒嵘蝾缛铷颦软锐蚬闰润洒萨飒鳃赛伞毵糁丧骚扫缫涩啬铯穑杀刹纱铩鲨筛晒酾删闪陕赡缮讪姗骟钐鳝墒伤赏垧殇觞烧绍赊摄慑设厍滠畲绅审婶肾渗诜谂渖声绳胜师狮湿诗时蚀实识驶势适释饰视试谥埘莳弑轼贳铈鲥寿兽绶枢输书赎属术树竖数摅纾帅闩双谁税顺说硕烁铄丝饲厮驷缌锶鸶耸怂颂讼诵擞薮馊飕锼苏诉肃谡稣虽随绥岁谇孙损笋荪狲缩琐锁唢睃獭挞闼铊鳎台态钛鲐摊贪瘫滩坛谭谈叹昙钽锬顸汤烫傥饧铴镗涛绦讨韬铽腾誊锑题体屉缇鹈阗条粜龆鲦贴铁厅听烃铜统恸头钭秃图钍团抟颓蜕饨脱鸵驮驼椭箨鼍袜娲腽弯湾顽万纨绾网辋韦违围为潍维苇伟伪纬谓卫诿帏闱沩涠玮韪炜鲔温闻纹稳问阌瓮挝蜗涡窝卧莴龌呜钨乌诬无芜吴坞雾务误邬庑怃妩骛鹉鹜锡牺袭习铣戏细饩阋玺觋虾辖峡侠狭厦吓硖鲜纤贤衔闲显险现献县馅羡宪线苋莶藓岘猃娴鹇痫蚝籼跹厢镶乡详响项芗饷骧缃飨萧嚣销晓啸哓潇骁绡枭箫协挟携胁谐写泻谢亵撷绁缬锌衅兴陉荥凶汹锈绣馐鸺虚嘘须许叙绪续诩顼轩悬选癣绚谖铉镟学谑泶鳕勋询寻驯训讯逊埙浔鲟压鸦鸭哑亚讶垭娅桠氩阉烟盐严岩颜阎艳厌砚彦谚验厣赝俨兖谳恹闫酽魇餍鼹鸯杨扬疡阳痒养样炀瑶摇尧遥窑谣药轺鹞鳐爷页业叶靥谒邺晔烨医铱颐遗仪蚁艺亿忆义诣议谊译异绎诒呓峄饴怿驿缢轶贻钇镒镱瘗舣荫阴银饮隐铟瘾樱婴鹰应缨莹萤营荧蝇赢颖茔莺萦蓥撄嘤滢潆璎鹦瘿颏罂哟拥佣痈踊咏镛优忧邮铀犹诱莸铕鱿舆鱼渔娱与屿语狱誉预驭伛俣谀谕蓣嵛饫阈妪纡觎欤钰鹆鹬龉鸳渊辕园员圆缘远橼鸢鼋约跃钥粤悦阅钺郧匀陨运蕴酝晕韵郓芸恽愠纭韫殒氲杂灾载攒暂赞瓒趱錾赃脏驵凿枣责择则泽赜啧帻箦贼谮赠综缯轧铡闸栅诈斋债毡盏斩辗崭栈战绽谵张涨帐账胀赵诏钊蛰辙锗这谪辄鹧贞针侦诊镇阵浈缜桢轸赈祯鸩挣睁狰争帧症郑证诤峥钲铮筝织职执纸挚掷帜质滞骘栉栀轵轾贽鸷蛳絷踬踯觯钟终种肿众锺诌轴皱昼骤纣绉猪诸诛烛瞩嘱贮铸驻伫槠铢专砖转赚啭馔颞桩庄装妆壮状锥赘坠缀骓缒谆准浊诼镯兹资渍谘缁辎赀眦锱龇鲻踪总纵偬邹诹驺鲰诅组镞钻缵躜鳟翱并卜丑淀斗范干皋柜后伙秸杰诀夸里凌么霉捻凄扦圣尸抬涂洼喂污锨咸蝎彝涌游吁御愿岳云灶扎札筑于志注讠谫郄凼垅垴埯埝苘荬荮莜莼揸吣咝谑幞岙犸狍余馇馓馕愣怵懔溆滟混漤潴甯纟绔绱珉枧桊槔橥轱轷赍肷胨飚砜眍钚钷铘铞锃锍锎';
}

function FTPYStr() {
    return '藉瞭叁蹟鑑鏽嚮穀穠彙鐧曆嚐餚嫻薑歎乾釐粧檯谘淨澹嵴複捲託併鬰鬱俐著捨鬍儘穫闢採鍊週緻閒綫錶寫洩佈繫藌臋麵呑嫰脫獃內婬盪與徵脳闆傢锺隻澹駡勐鬆綉髒鑽牆髮馀讚製豔慾氾籤姦噁妳姪佔訳発絶舖係甦僱迴僕裡錒皚藹礙愛噯嬡璦曖靄諳銨鵪骯襖奧媼驁鰲壩罷鈀擺敗唄頒辦絆鈑幫綁鎊謗剝飽寶報鮑鴇齙輩貝鋇狽備憊鵯賁錛繃筆畢斃幣閉蓽嗶潷鉍篳蹕邊編貶變辯辮芐緶籩標驃颮飆鏢鑣鰾鱉別癟瀕濱賓擯儐繽檳殯臏鑌髕鬢餅稟撥缽鉑駁餑鈸鵓補鈽財參蠶殘慚慘燦驂黲蒼艙倉滄廁側冊測惻層詫鍤儕釵攙摻蟬饞讒纏鏟產闡顫囅諂讖蕆懺嬋驏覘禪鐔場嘗長償腸廠暢倀萇悵閶鯧鈔車徹硨塵陳襯傖諶櫬磣齔撐稱懲誠騁棖檉鋮鐺癡遲馳恥齒熾飭鴟沖衝蟲寵銃疇躊籌綢儔幬讎櫥廚鋤雛礎儲觸處芻絀躕傳釧瘡闖創愴錘綞純鶉綽輟齪辭詞賜鶿聰蔥囪從叢蓯驄樅湊輳躥竄攛錯銼鹺達噠韃帶貸駘紿擔單鄲撣膽憚誕彈殫賧癉簞當擋黨蕩檔讜碭襠搗島禱導盜燾燈鄧鐙敵滌遞締糴詆諦綈覿鏑顛點墊電巔鈿癲釣調銚鯛諜疊鰈釘頂錠訂鋌丟銩東動棟凍崠鶇竇犢獨讀賭鍍瀆櫝牘篤黷鍛斷緞籪兌隊對懟鐓噸頓鈍燉躉奪墮鐸鵝額訛惡餓諤堊閼軛鋨鍔鶚顎顓鱷誒兒爾餌貳邇鉺鴯鮞發罰閥琺礬釩煩販飯訪紡鈁魴飛誹廢費緋鐨鯡紛墳奮憤糞僨豐楓鋒風瘋馮縫諷鳳灃膚輻撫輔賦復負訃婦縛鳧駙紱紼賻麩鮒鰒釓該鈣蓋賅桿趕稈贛尷搟紺岡剛鋼綱崗戇鎬睪誥縞鋯擱鴿閣鉻個紇鎘潁給亙賡綆鯁龔宮鞏貢鉤溝茍構購夠詬緱覯蠱顧詁轂鈷錮鴣鵠鶻剮掛鴰摑關觀館慣貫詿摜鸛鰥廣獷規歸龜閨軌詭貴劊匭劌媯檜鮭鱖輥滾袞緄鯀鍋國過堝咼幗槨蟈鉿駭韓漢闞絎頡號灝顥閡鶴賀訶闔蠣橫轟鴻紅黌訌葒閎鱟壺護滬戶滸鶘嘩華畫劃話驊樺鏵懷壞歡環還緩換喚瘓煥渙奐繯鍰鯇黃謊鰉揮輝毀賄穢會燴匯諱誨繪詼薈噦澮繢琿暉葷渾諢餛閽獲貨禍鈥鑊擊機積饑跡譏雞績緝極輯級擠幾薊劑濟計記際繼紀訐詰薺嘰嚌驥璣覬齏磯羈蠆躋霽鱭鯽夾莢頰賈鉀價駕郟浹鋏鎵蟯殲監堅箋間艱緘繭檢堿鹼揀撿簡儉減薦檻鑒踐賤見鍵艦劍餞漸濺澗諫縑戔戩瞼鶼筧鰹韉將漿蔣槳獎講醬絳韁膠澆驕嬌攪鉸矯僥腳餃繳絞轎較撟嶠鷦鮫階節潔結誡屆癤頜鮚緊錦僅謹進晉燼盡勁荊莖巹藎饉縉贐覲鯨驚經頸靜鏡徑痙競凈剄涇逕弳脛靚糾廄舊鬮鳩鷲駒舉據鋸懼劇詎屨櫸颶鉅鋦窶齟鵑絹錈鐫雋覺決絕譎玨鈞軍駿皸開凱剴塏愾愷鎧鍇龕閌鈧銬顆殼課騍緙軻鈳錁頷墾懇齦鏗摳庫褲嚳塊儈鄶噲膾寬獪髖礦曠況誆誑鄺壙纊貺虧巋窺饋潰匱蕢憒聵簣閫錕鯤擴闊蠐蠟臘萊來賴崍徠淶瀨賚睞錸癩籟藍欄攔籃闌蘭瀾讕攬覽懶纜爛濫嵐欖斕鑭襤瑯閬鋃撈勞澇嘮嶗銠鐒癆樂鰳鐳壘類淚誄縲籬貍離鯉禮麗厲勵礫歷瀝隸儷酈壢藶蒞蘺嚦邐驪縭櫪櫟轢礪鋰鸝癘糲躒靂鱺鱧倆聯蓮連鐮憐漣簾斂臉鏈戀煉練蘞奩瀲璉殮褳襝鰱糧涼兩輛諒魎療遼鐐繚釕鷯獵臨鄰鱗凜賃藺廩檁轔躪齡鈴靈嶺領綾欞蟶鯪餾劉瀏騮綹鎦鷚龍聾嚨籠壟攏隴蘢瀧瓏櫳朧礱樓婁摟簍僂蔞嘍嶁鏤瘺耬螻髏蘆盧顱廬爐擄鹵虜魯賂祿錄陸壚擼嚕閭瀘淥櫨櫓轤輅轆氌臚鸕鷺艫鱸巒攣孿灤亂臠孌欒鸞鑾掄輪倫侖淪綸論圇蘿羅邏鑼籮騾駱絡犖玀濼欏腡鏍驢呂鋁侶屢縷慮濾綠櫚褸鋝嘸媽瑪碼螞馬罵嗎嘜嬤榪買麥賣邁脈勱瞞饅蠻滿謾縵鏝顙鰻貓錨鉚貿麼沒鎂門悶們捫燜懣鍆錳夢瞇謎彌覓冪羋謐獼禰綿緬澠靦黽廟緲繆滅憫閩閔緡鳴銘謬謨驀饃歿鏌謀畝鉬吶鈉納難撓腦惱鬧鐃訥餒內擬膩鈮鯢攆輦鯰釀鳥蔦裊聶嚙鑷鎳隉蘗囁顢躡檸獰寧擰濘苧嚀聹鈕紐膿濃農儂噥駑釹諾儺瘧歐鷗毆嘔漚謳慪甌盤蹣龐拋皰賠轡噴鵬紕羆鈹騙諞駢飄縹頻貧嬪蘋憑評潑頗釙撲鋪樸譜鏷鐠棲臍齊騎豈啟氣棄訖蘄騏綺榿磧頎頏鰭牽釬鉛遷簽謙錢鉗潛淺譴塹僉蕁慳騫繾槧鈐槍嗆墻薔強搶嬙檣戧熗錆鏘鏹羥蹌鍬橋喬僑翹竅誚譙蕎繰磽蹺竊愜鍥篋欽親寢鋟輕氫傾頃請慶撳鯖瓊窮煢蛺巰賕蟣鰍趨區軀驅齲詘嶇闃覷鴝顴權勸詮綣輇銓卻鵲確闋闕愨讓饒擾繞蕘嬈橈熱韌認紉飪軔榮絨嶸蠑縟銣顰軟銳蜆閏潤灑薩颯鰓賽傘毿糝喪騷掃繅澀嗇銫穡殺剎紗鎩鯊篩曬釃刪閃陜贍繕訕姍騸釤鱔墑傷賞坰殤觴燒紹賒攝懾設厙灄畬紳審嬸腎滲詵諗瀋聲繩勝師獅濕詩時蝕實識駛勢適釋飾視試謚塒蒔弒軾貰鈰鰣壽獸綬樞輸書贖屬術樹豎數攄紓帥閂雙誰稅順說碩爍鑠絲飼廝駟緦鍶鷥聳慫頌訟誦擻藪餿颼鎪蘇訴肅謖穌雖隨綏歲誶孫損筍蓀猻縮瑣鎖嗩脧獺撻闥鉈鰨臺態鈦鮐攤貪癱灘壇譚談嘆曇鉭錟頇湯燙儻餳鐋鏜濤絳討韜鋱騰謄銻題體屜緹鵜闐條糶齠鰷貼鐵廳聽烴銅統慟頭鈄禿圖釷團摶頹蛻飩脫鴕馱駝橢籜鼉襪媧膃彎灣頑萬紈綰網輞韋違圍為濰維葦偉偽緯謂衛諉幃闈溈潿瑋韙煒鮪溫聞紋穩問閿甕撾蝸渦窩臥萵齷嗚鎢烏誣無蕪吳塢霧務誤鄔廡憮嫵騖鵡鶩錫犧襲習銑戲細餼鬩璽覡蝦轄峽俠狹廈嚇硤鮮纖賢銜閑顯險現獻縣餡羨憲線莧薟蘚峴獫嫻鷴癇蠔秈躚廂鑲鄉詳響項薌餉驤緗饗蕭囂銷曉嘯嘵瀟驍綃梟簫協挾攜脅諧寫瀉謝褻擷紲纈鋅釁興陘滎兇洶銹繡饈鵂虛噓須許敘緒續詡頊軒懸選癬絢諼鉉鏇學謔澩鱈勛詢尋馴訓訊遜塤潯鱘壓鴉鴨啞亞訝埡婭椏氬閹煙鹽嚴巖顏閻艷厭硯彥諺驗厴贗儼兗讞懨閆釅魘饜鼴鴦楊揚瘍陽癢養樣煬瑤搖堯遙窯謠藥軺鷂鰩爺頁業葉靨謁鄴曄燁醫銥頤遺儀蟻藝億憶義詣議誼譯異繹詒囈嶧飴懌驛縊軼貽釔鎰鐿瘞艤蔭陰銀飲隱銦癮櫻嬰鷹應纓瑩螢營熒蠅贏穎塋鶯縈鎣攖嚶瀅瀠瓔鸚癭頦罌喲擁傭癰踴詠鏞優憂郵鈾猶誘蕕銪魷輿魚漁娛與嶼語獄譽預馭傴俁諛諭蕷崳飫閾嫗紆覦歟鈺鵒鷸齬鴛淵轅園員圓緣遠櫞鳶黿約躍鑰粵悅閱鉞鄖勻隕運蘊醞暈韻鄆蕓惲慍紜韞殞氳雜災載攢暫贊瓚趲鏨贓臟駔鑿棗責擇則澤賾嘖幘簀賊譖贈綜繒軋鍘閘柵詐齋債氈盞斬輾嶄棧戰綻譫張漲帳賬脹趙詔釗蟄轍鍺這謫輒鷓貞針偵診鎮陣湞縝楨軫賑禎鴆掙睜猙爭幀癥鄭證諍崢鉦錚箏織職執紙摯擲幟質滯騭櫛梔軹輊贄鷙螄縶躓躑觶鐘終種腫眾鍾謅軸皺晝驟紂縐豬諸誅燭矚囑貯鑄駐佇櫧銖專磚轉賺囀饌顳樁莊裝妝壯狀錐贅墜綴騅縋諄準濁諑鐲茲資漬諮緇輜貲眥錙齜鯔蹤總縱傯鄒諏騶鯫詛組鏃鉆纘躦鱒翺並蔔醜澱鬥範幹臯櫃後夥稭傑訣誇裏淩麽黴撚淒扡聖屍擡塗窪餵汙鍁鹹蠍彜湧遊籲禦願嶽雲竈紮劄築於誌註訁譾郤氹壟堖垵墊檾蕒葤蓧蒓摣唚噝謔襆嶴獁麅餘餷饊饢楞憷懍漵灩溷濫瀦寧糸絝緔瑉梘棬橰櫫軲軤賫膁腖飈碸瞘鈈鉕鋣銱鋥鋶鐦';
}
