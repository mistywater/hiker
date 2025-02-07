js:
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
function bcLongClick(){
	return [{
            title: '背景色样式',
            js: $.toString(() => {
                var Type = ["深色模式", "浅色模式", "浅色白字模式"];
                if (getItem('darkMode')) {
                    var index = Type.indexOf(getItem('darkMode'));
                    Type[index] = '👉' + getItem('darkMode');
                }
                showSelectOptions({
                    title: "选择样式",
                    col: 3,
                    options: Type,
                    js: $.toString(() => {
                        setItem('darkMode', input.replace('👉', ''));
                        refreshPage();
                    }, )
                });
            }),
        }];
}
function getRandomColor(darkMode) {
    const maxBrightness = 200;
    const minBrightness = 50;
    let r, g, b;
    do {
        r = Math.floor(Math.random() * 256);
        g = Math.floor(Math.random() * 256);
        b = Math.floor(Math.random() * 256);
        var brightness = 0.299 * r + 0.587 * g + 0.114 * b;
    } while (/白字|深色/.test(darkMode) ? brightness > maxBrightness : brightness < minBrightness);

    const toHex = (value) => {
        const hex = value.toString(16);
        return hex.length === 1 ? '0' + hex : hex;
    };
    return `#${toHex(r)}${toHex(g)}${toHex(b)}`;
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
function hsvToHex(h, s, v) {
    // 将HSV转换为RGB
    let r, g, b, i, f, p, q, t;
    if (arguments.length === 1) {
        s = h.s, v = h.v, h = h.h;
    }
    h = h / 360;
    s = s / 100;
    v = v / 100;
    i = Math.floor(h * 6);
    f = h * 6 - i;
    p = v * (1 - s);
    q = v * (1 - f * s);
    t = v * (1 - (1 - f) * s);

    switch (i % 6) {
        case 0:
            r = v, g = t, b = p;
            break;
        case 1:
            r = q, g = v, b = p;
            break;
        case 2:
            r = p, g = v, b = t;
            break;
        case 3:
            r = p, g = q, b = v;
            break;
        case 4:
            r = t, g = p, b = v;
            break;
        case 5:
            r = v, g = p, b = q;
            break;
    }
    // 将RGB转换为十六进制颜色代码
    const hexR = Math.round(r * 255).toString(16).padStart(2, '0');
    const hexG = Math.round(g * 255).toString(16).padStart(2, '0');
    const hexB = Math.round(b * 255).toString(16).padStart(2, '0');
    return `#${hexR}${hexG}${hexB}`.toUpperCase();
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
    var str =  '#' + (((Math.random() * 0x1000000 << 0).toString(16)).substr(-6)).padStart(6, ‌Math.ceil‌(Math.random() * 16).toString(16));
    return str;
}*/
function yanzheng(str, url) {
        return `d.push({
            title: '人机验证',
            url: $('hiker://empty').rule((host) => {
                var d = [];
                d.push({
                    col_type: 'x5_webview_single',
                    url: '${url}',
                    desc: 'list&&screen',
                    extra: {
                        ua: MOBILE_UA,
                        showProgress: false,
                        js: $.toString((host) => {
                            function check() {
                                let nodes = document.querySelectorAll('${str}');
                                var co = fba.getCookie('${url}');
                                if (nodes && nodes.length > 0 && co ) {
                                    fba.putVar(host + 'ck', co);
                                    //fba.log(fba.getVar(host + 'ck'));
                                    fba.parseLazyRule($$$().lazyRule(() => {
                                        back();
                                    }));
                                } else {
                                    setTimeout(check, 500);
                                }
                            }
                            check();
                        },  host)
                    }
                });
                return setResult(d);
            }, host),
            col_type: 'text_1'
        });`;
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
function numbersCircledColor(num,r) {            
	if(typeof(r)=='undefined'||!r) {
    if (num == '❶') {
                return strongR(num, 'FF2244');
            } else if (num == '❷') {
                return strongR(num, 'FF6633');
            } else if (num == '❸') {
                return strongR(num, 'FFBB33');
            } else {
                return strongR(num,'333333');
            }}else if(r==1){
	    if (num == '❶') {
                return strong(num, 'FF2244');
            } else if (num == '❷') {
                return strong(num, 'FF6633');
            } else if (num == '❸') {
                return strong(num, 'FFBB33');
            } else {
                return strong(num,'333333');
            }
	    }else if(r==2){
	    
                return num;

	    }
        }
function cytrans(text,mode) {
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
function getRandomNumber(m,n) {
        const rand = Math.floor(Math.random() * (m-n)) + n;;
        return rand;
    }
function timestampToDate(timestamp) {
  const date = new Date(timestamp);
  const year = date.getFullYear();
  const month = String(date.getMonth() + 1).padStart(2, '0');
  const day = String(date.getDate()).padStart(2, '0');
  const hours = String(date.getHours()).padStart(2, '0');
  const minutes = String(date.getMinutes()).padStart(2, '0');
  const seconds = String(date.getSeconds()).padStart(2, '0');
 
  return `${year}-${month}-${day} ${hours}:${minutes}:${seconds}`;
}
function sortArray(arr, key, style, order) {
    if (!Array.isArray(arr)) {
        throw new TypeError('第一个参数必须是一个数组');
    }
    if (order === 'desc' || order === '1' || order === 1) {
        order = 'desc';
    } else {
        order = 'asc';
    }
    if (style === 1 || style === '1') {
        style = 1;
    } else if (style === 3 || style === '3') {
        style = 3;
    } else {
        style = 2;
    }

    function extractNumber(value) {
        const match = value.match(/\d+/);
        return match ? parseInt(match[0], 10) : null;
    }

    function getType(value) {
        if (/^\d+/.test(value)) return 1;
        if (/^[A-Za-z]+/.test(value)) return 2;
        return 3;
    }

    function compare(a, b) {
        const aValue = key && typeof a === 'object' ? a[key] : a;
        const bValue = key && typeof b === 'object' ? b[key] : b;

        if (style == 3) {
            const aNumber = typeof(aValue) == 'number' ? aValue : extractNumber(aValue);
            const bNumber = typeof(bValue) == 'number' ? bValue : extractNumber(bValue);
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
                } return num;
            }
            
            var s = [a, b].map(myFunction);
            if (s[0] < s[1]) {return -1;}
            else if (s[0] > s[1]) {return 1;}
            else {return 0;}
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
    return $.toString((c) => {
        if (typeof(c.type) == 'undefined') {
            c.type = '影视';
        }
        var k = c.indexbanner.length;
        var n = '0';
        if (c.json == 1) {
            d.push({
                title: color(c.indexbanner[n][c.title], 'FF3399'),
                img: c.indexbanner[n][c.img],
                col_type: 'card_pic_1',
                desc: '0',
                url: c.host + c.url.split('#')[1] + c.indexbanner[n][c.url.split('#')[0]],
                extra: {
                    id: 'lunbo',
                    stype: c.type,
                    name: c.indexbanner[n][c.title],
                }
            });
        } else {
            d.push({
                title: color(pdfh(c.indexbanner[n], c.title), 'FF3399'),
                img: (!/##/.test(c.img) ? pd(c.indexbanner[n], c.img) : eval(c.img.replace('host', 'c.host').replace('indexbanner', 'c.indexbanner')))+ '@Referer='+c.host,
                col_type: 'card_pic_1',
                desc: '0',
                url: pd(c.indexbanner[n], c.url),
                extra: {
                    id: 'lunbo',
                    stype: c.type,
                    name: pdfh(c.indexbanner[n], c.name),
                }
            });
        }
        let id = 'juyue';
        let time = 4000;
        registerTask(id, time, $.toString((c, k) => {
            rc(fc('https://gitee.com/mistywater/hiker_info/raw/master/githubproxy.json') + 'https://raw.githubusercontent.com/mistywater/hiker/main/f', 24);
            var n = getVar(c.host + 'n', '0');
            if (c.json == 1) {
                var item = toerji({
                    title: color(c.indexbanner[n][c.title], 'FF3399'),
                    img: c.indexbanner[n][c.img],
                    url: c.host + c.url.split('#')[1] + c.indexbanner[n][c.url.split('#')[0]],
                    extra: {
                        id: 'lunbo',
                        stype: c.type,
                        name: c.indexbanner[n][c.title],
                    }
                }, c.name, c.type);
            } else {
                var item = toerji({
                    title: color(pdfh(c.indexbanner[n], c.title), 'FF3399'),
                    img: (!/##/.test(c.img) ? urla(pdfh(c.indexbanner[n], c.img), c.host) : eval(c.img.replace('host', 'c.host').replace('indexbanner', 'c.indexbanner')))+ '@Referer='+c.host,
                    url: urla(pdfh(c.indexbanner[n], c.url), c.host),
                    extra: {
                        id: 'lunbo',
                        stype: c.type,
                        name: pdfh(c.indexbanner[n], c.title),
                    }
                }, c.name, c.type);
            }
            updateItem('lunbo', item);
            if (n >= k - 1) {
                putVar(c.host + 'n', '0');
            } else {
                putVar(c.host + 'n', (parseInt(n) + 1) + '');
            }
        }, c, k));
    }, c);
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
    }else{
    var num = parseInt(index)+1+'.';
    }
    return num;
}
function clearM3u8(url,reg) {
        let f = cacheM3u8(url);
        let c = readFile(f.split("##")[0]);
        let c2 = c.replace(new RegExp(reg,'g'), '');
        writeFile(f.split("##")[0], c2);
        return f;
}
function ccc(title, ccc_) {
	ccc_ = ccc_ ? ccc_ : {
		fc: '#FFFFFF',
		bc: '#FF435E',
	}
	return '‘‘’’<font color="' + ccc_.fc + '"><span style="background-color: ' + ccc_.bc + '">' + title + '</span></font>'
}
function sortPy(arr, name) {
    if (typeof(name)=='undefined'||name=='') {
        var arrNew = arr.sort((a, b) => a.localeCompare(b));
    } else {
        var arrNew = arr.sort((a, b) => a[name].localeCompare(b[name]));
    }
    for (var m in arrNew) {
        if (typeof(name)=='undefined'||name=='') {
	       var mm = /^[\u4e00-\u9fa5]/.test(arrNew[m]) ? m : '-1';
	}else{
            var mm = /^[\u4e00-\u9fa5]/.test(arrNew[m][name]) ? m : '-1';
	}
        if (mm > -1) {
            break;
        }
    }
    for (var n = arrNew.length - 1; n >= 0; n--) {
        if (typeof(name)=='undefined'||name=='') {
	    var nn = /^[\u4e00-\u9fa5]/.test(arrNew[n]) ? n : '-1';
	}else{
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
function cpage(t,c){
	if(!c){var c='c';}
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
function pageAdd(page,host){
    	if (getMyVar(host + 'page')) {
        	putMyVar(host + 'page', (parseInt(page) + 1) + '');
    	}
	return;
}
function jinman(picUrl) {
	return $.toString((picUrl)=>{
		const ByteArrayOutputStream = java.io.ByteArrayOutputStream;
		const ByteArrayInputStream = java.io.ByteArrayInputStream;
		const Bitmap = android.graphics.Bitmap;
		const BitmapFactory = android.graphics.BitmapFactory;
		const Canvas = android.graphics.Canvas;

		picUrl.match(/photos\/(\d+)?\/(\d+)?/);
		let bookId = RegExp.$1;
		let imgId = RegExp.$2;
		if (!bookId || !imgId) return input;
		if (Number(bookId) <= 220980){
  			return input;
     		}else if (Number(bookId) <= 268850) {
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
			let h = i === $num ? remainder: 0;
			canvas.drawBitmap(Bitmap.createBitmap(imgBitmap, 0, y * (i - 1), width, y + h), 0, y * ($num - i), null);
		}
		let baos = new ByteArrayOutputStream();
		newImgBitmap.compress(Bitmap.CompressFormat.PNG, 100, baos);
		return new ByteArrayInputStream(baos.toByteArray());
	},picUrl);
}
function extraPic(host, page, pages, ctype, hiker) {
    if (!ctype) var ctype = '';
    if (!hiker || hiker == '') var hiker = '1';
    var longClick = [{
        title: '样式',
        js: $.toString((host, ctype) => {
            var Type = ["movie_1", "movie_2", "movie_3", "pic_1", "pic_2", "pic_3", "pic_1_full", "pic_1_center", "pic_1_card", "pic_2_card", "pic_3_square", "card_pic_1", "card_pic_2", "card_pic_3", "card_pic_3_center"];
            if (getItem(host + ctype + 'type')) {
                var index = Type.indexOf(getItem(host + ctype + 'type'));
                Type[index] = '👉' + getItem(host + ctype + 'type');
            }
            showSelectOptions({
                title: "选择样式",
                col: 2,
                options: Type,
                js: $.toString((host, ctype) => {
                    setItem(host + ctype + 'type', input.replace('👉', ''));
                    refreshPage();
                }, host, ctype)
            });
            return "hiker://empty";
        }, host, ctype),
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
            }
        } else if (pages <= 1000) {
            for (var k = 1; k <= pages; k = k + 5) {
                arr.push(k);
            }
        } else {
            for (var k = 1; k <= pages; k = k + 10) {
                arr.push(k);
            }
        }
        var extra1 = {
            title: '跳转',
            js: $.toString((host, arr) => {
                return $(arr, 3, '选择页码').select((host) => {
                    if (input == '输入页码') {
                        return $('').input((host) => {
                            putMyVar(host + 'page', input);
                            refreshPage(false);
                        }, host);
                    } else {
                        putMyVar(host + 'page', input);
                        refreshPage(false);
                        return 'hiker://empty';
                    }
                }, host);
            }, host, arr),
        };
    } else {
        var extra1 = {
            title: '跳转',
            js: $.toString((host) => {
                return $('').input((host) => {
                    putMyVar(host + 'page', input);
                    refreshPage(false);
                }, host);
            }, host),
        };
    }
    longClick.push(extra1);
   longClick.unshift({
                    title: getItem(host + 'picsMode', '0') == 0 ? '漫画模式' : '图文模式',
                    js: $.toString((host) => {
                        if (getItem(host + 'picsMode', '0') == 0) {
                            setItem(host + 'picsMode', '1');
                            refreshPage(false);
                        } else {
                            setItem(host + 'picsMode', '0');
                            refreshPage(false);
                        }
                    }, host)
                });
    var extra = $.toString((host, hiker, ctype, longClick) => ({
        chapterList: hiker ? 'hiker://files/_cache/chapterList.txt' : chapterList,
        info: {
            bookName: MY_URL.split('/')[2],
            ruleName: 'photo',
            bookTopPic: 'https://api.xinac.net/icon/?url=' + host,
            parseCode: downloadlazy,
            defaultView: '1'
        },
        longClick: longClick,
    }), host, hiker, ctype, longClick);
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
        if(key){var javaImport = new JavaImporter();
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
                //cipherText = String(cipherText);
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
        }}else{ try {
                const CryptoUtil = $.require("hiker://assets/crypto-java.js");
                let textData = CryptoUtil.Data.parseInputStream(input);
                let base64Text = textData.toString().split("base64,")[1];
                let encrypted0 = CryptoUtil.Data.parseBase64(base64Text, _base64.NO_WRAP);
                return encrypted0.toInputStream();
            } catch (e) {
                return;
            }}
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
    return bArr;}
}
function pageMoveto(host, page, ctype,pages) {
    if(!ctype){var ctype='';}
    var longClick=[{
            title: '样式',
            js: $.toString((host,ctype) => {
                var Type = ["movie_1", "movie_2", "movie_3", "pic_1", "pic_2", "pic_3", "pic_1_full", "pic_1_center", "pic_1_card", "pic_2_card", "pic_3_square", "card_pic_1", "card_pic_2", "card_pic_3", "card_pic_3_center"];
                if (getItem(host + 'type')) {
                    var index = Type.indexOf(getItem(host +ctype+ 'type'));
                    Type[index] = '👉' + getItem(host +ctype+ 'type');
                }
                showSelectOptions({
                    title: "选择样式",
                    col: 2,
                    options: Type,
                    js: $.toString((host,ctype) => {
                        setItem(host +ctype+ 'type', input.replace('👉', ''));
                        refreshPage();
                    }, host,ctype)
                });
                return "hiker://empty";
            }, host,ctype),
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
    if(typeof(pages)!='undefined'){
        
        var arr = ['输入页码'];
        if(pages<=200){for(var k=1;k<=pages;k++){
            arr.push(k);
        }}else if(pages<=1000){for(var k=1;k<=pages;k=k+5){
            arr.push(k);
        }}else {for(var k=1;k<=pages;k=k+10){
            arr.push(k);
        }}
        var extra1 = {
            title: '跳转',
            js: $.toString((host, arr) => {
                return $(arr, 3, '选择页码').select((host) => {
                    if (input == '输入页码') {
                        return $('').input((host) => {
                            putMyVar(host + 'page', input);
                            refreshPage(false);
                        }, host);
                    } else {
                        putMyVar(host + 'page', input);
                        refreshPage(false);
                        return 'hiker://empty';
                    }
                }, host);
            }, host, arr),
        };
        
    }else{
        var extra1={
            title: '跳转',
            js: $.toString((host) => {
                return $('').input((host) => {
                    putMyVar(host + 'page', input);
                    refreshPage(false);
                }, host);
            }, host),
        };
    }
    longClick.push(extra1);longClick.unshift({
                    title: getItem(host + 'picsMode', '0') == 0 ? '漫画模式' : '图文模式',
                    js: $.toString((host) => {
                        if (getItem(host + 'picsMode', '0') == 0) {
                            setItem(host + 'picsMode', '1');
                            refreshPage(false);
                        } else {
                            setItem(host + 'picsMode', '0');
                            refreshPage(false);
                        }
                    }, host)
                });
    return {longClick:longClick};
}
function searchMain(page, d, desc) {
    if (page == 1) {
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
            }
        });
    }
    return d;
}
function classTop(index, data, host, d, mode, v, c, f, len, start, end) {
    if (!mode) mode = 0;
    if (!v) v = 0;
    if (!c) c = 'c';
    if (!f) f = 'scroll_button';
    if (!len) len = 20;

    let isDarkMode = getItem('darkMode', '深色模式') === '浅色白字模式';
    let isInRange = index >= start && index <= end;
    let c_title = /\{/.test(JSON.stringify(data)) ? data.title.split('&') : data.split('&');
    let c_id = /\{/.test(JSON.stringify(data)) ? (data.id === '' ? c_title : data.id === '@@@' ? data.title.replace(/^.*?&/, '&').split('&') : data.id.split('&')) : null;
    c_title.forEach((title, index_c) => {
        let isSelected = index_c == getMyVar(host + c + 'index' + index, mode || index == v ? '0' : '-1');
        let titleStyled = isSelected ?
            strong(title, isInRange ? 'FFFF00' : 'FF6699') :
            isDarkMode && isInRange ?
            color(title, 'FFFFFF') :
            title;
        d.push({
            title: titleStyled,
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
            }, index, c_id ? c_id[index_c] : title, index_c, host, mode, title, v, c, len),
            extra: {
                backgroundColor: isInRange ? getRandomColor(getItem('darkMode')) : '',
                LongClick: isInRange ? bcLongClick() : [],
            },
        });
    });
    d.push({
        col_type: 'blank_block'
    });
    return d;
}
function classTop1(index, data, host, d, mode, v, c, f,len,start,end) {
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
                title: index_c == getMyVar(host + c + 'index' + index, (mode || index == v ? '0' : '-1')) ? (index>=start&&index<=end?strong(title, 'FFFF00'):strong(title, 'FF6699')) : (getItem('darkMode', '深色模式') == '浅色白字模式'&&index>=start&&index<=end?color(title,'FFFFFF'):title),
                col_type: f,
                url: $('#noLoading#').lazyRule((index, id, index_c, host, mode, title, v, c,len) => {
                    if (mode) {
                        putMyVar(host + c + index, id);

                    } else {
                        putMyVar(host + c, id);
                        for (let n = v; n <= v+len-1; n++) {
                            putMyVar(host + c + 'index' + n, '-1');
                        }
                    }
                    clearMyVar(host + 'page');
                    clearMyVar(host + 'url');
                    putMyVar(host + c + 'index' + index, index_c);
                    refreshPage(false);
                    return 'hiker://empty';
                }, index, c_id[index_c], index_c, host, mode, title, v, c,len),
		extra:{backgroundColor:index>=start&&index<=end?getRandomColor(getItem('darkMode')):'',LongClick:index>=start&&index<=end?bcLongClick():[],}
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
                title: index_c == getMyVar(host + c + 'index' + index, (mode || index == v ? '0' : '-1')) ? (index>=start&&index<=end?strong(title, 'FFFF00'):strong(title, 'FF6699')) : (getItem('darkMode', '深色模式') == '浅色白字模式'&&index>=start&&index<=end?color(title,'FFFFFF'):title),
                col_type: f,
                url: $('#noLoading#').lazyRule((index, index_c, host, mode, title, v, c,len) => {
                    if (mode) {
                        putMyVar(host + c + index, title);

                    } else {
                        putMyVar(host + c, title);
                        for (let n = v; n <= v+len-1; n++) {
                            putMyVar(host + c + 'index' + n, '-1');
                        }
                    }
                    clearMyVar(host + 'page');
                    clearMyVar(host + 'url');
                    putMyVar(host + c + 'index' + index, index_c);
                    refreshPage(false);
                    return 'hiker://empty';
                }, index, index_c, host, mode, title, v, c,len),
		extra:{backgroundColor:index>=start&&index<=end?getRandomColor(getItem('darkMode')):'',LongClick:index>=start&&index<=end?bcLongClick():[],}
            });
        });
        d.push({
            col_type: 'blank_block',
        });
        return d;
    }
}



function downPic() {
var s=`if (list.length != 0) {
            d.push({
                title: '⬇️下载⬇️',
                desc: '',
                url: 'hiker://page/download.view?rule=本地资源管理',
                extra: {
                    chapterList: chapterList,
                    info: {
                        bookName: host.split('/')[2],
                        ruleName: 'photo',
                        bookTopPic: 'https://api.xinac.net/icon/?url=' + host,
                        parseCode: downloadlazy,
                        defaultView: '1',
                    },
                }
            });
        }`;
        return s;
}
function dtfl() {
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
function mline(n) {
    for (var k = 1; k <= n; k++) {
        d.push({
            col_type: 'line',
        });
    };
    return;;
}
function mline(n) {
    for (var k = 1; k <= n; k++) {
        d.push({
            col_type: 'big_big_blank_block',
        });
    };
    return;;
}
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
function rulePage(type, page) {
     return $("hiker://empty#noRecordHistory##noHistory#" + (page ? "?page=fypage" : "")).rule((type, r) => {
         require(r);
         getYiData(type);
     }, type, config.依赖);
 }
function rp(data) {
    var txtReplace = ['嗕_辱', '啂_乳', '満_满', '蓅_流', '茭_交', '菗_抽', '庇股_屁股', 'zhang_胀', 'yù_欲', 'yu_欲', 'you_诱', 'ying_迎', 'yin3_吟', 'yin2_淫', 'yīn_阴', 'yin_阴', 'ye_液', 'yao_腰', 'yang2_痒', 'yang_阳', 'yan_艳', 'ya_压', 'xue_穴', 'xiong_胸', 'xìng_性', 'xing_性', 'xie2_邪', 'xie_泄', 'xi_吸', 'wei_慰', 'tuo_脱', 'tun2_臀', 'tun_吞', 'ting_挺', 'tian_舔', 'shun_吮', 'shuang_爽', 'shu_熟', 'shi_湿', 'she_射', 'sè_色', 'se_色', 'sao_骚', 'sai_塞', 'rui_蕊', 'ru2_蠕', 'ru_乳', 'rou2_揉', 'rou_肉', 'ri_日', 'qiang_枪', 'qi2_妻', 'qi_骑', 'pi_屁', 'pen_喷', 'nue_虐', 'nong_弄', 'niao_尿', 'nen_嫩', 'nai_奶', 'min_敏', 'mi2_迷', 'mi_蜜', 'mao_毛', 'man_满', 'luo_裸', 'luan_乱', 'lu_撸', 'lou_露', 'liu_流', 'liao_撩', 'lang_浪', 'kua_胯', 'ku_裤', 'jing_精', 'jin_禁', 'jiao_交', 'jian2_奸', 'jian_贱', 'jiān_奸', 'ji3_妓', 'ji2_鸡', 'jī_激', 'ji_激', 'gun_棍', 'gui_龟', 'gong_宫', 'gen_根', 'gao2_睪', 'gao_搞', 'gang_肛', 'gan_感', 'fu_阜', 'feng_缝', 'dong2_胴', 'dong_洞', 'diao_屌', 'dang2_党', 'dàng_荡', 'dang_荡', 'chun2_唇', 'chun_春', 'chuang_床', 'chuan_喘', 'chou_抽', 'chi_耻', 'chao_潮', 'chan_缠', 'cha_插', 'cuo_搓', 'cu_粗', 'huan_欢', 'cao2_肏', 'cao_操', 'bo_勃', 'bō_波', 'bi2_屄', 'bi_逼', 'bao_饱', 'bang_棒', 'ai_爱'];
    data = data.replace(/<img src=\"(image|mom|in)\/(.+?)\.jpg\">/gi, '$2');
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
data=data.replace(/　{1,}/g,'　　');
	return data;
}
function ver() {
	return ;
}
function gra(arr, num) {
            var sData = arr.slice(0);
            var i = arr.length;
            var min = i - num;
            var item, index;
            while (i-- > min) {
                index = Math.floor((i + 1) * Math.random());
                item = sData[index];
                sData[index] = sData[i];
                sData[i] = item;
            }
            return sData.slice(min);
        }
function imgDec(key,iv,a,b){
	if(!b){
 		b='PKCS5Padding';
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

function toerji(item,sname,stype) {
            let info = storage0.getMyVar('主页源信息');
            let extra = item.extra || {};
            extra.name = extra.name || extra.pageTitle || item.title;
            extra.img = extra.img || item.pic_url || item.img;
            extra.stype = extra.stype||stype||'漫画';
            extra.pageTitle = extra.pageTitle || extra.name;
            if (item.url && !/js:|select:|\(|\)|=>|@/.test(item.url)) {
                extra.surl = item.url.replace(/hiker:\/\/empty|#immersiveTheme#|#autoCache#|#noRecordHistory#|#noHistory#|#noLoading#|#/g, "");
                extra.sname = sname;
            }
            if ((item.col_type != "scroll_button") || item.extra) {
                item.extra = extra;
            }
            item.url = (extra.surl || !item.url) ? $('hiker://empty#immersiveTheme##autoCache#').rule(() => {
                require(config.依赖);
                erji();
            }) : item.url
            return item;
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
        eval(getCryptoJS());
        if (!mode) mode = 'AES/ECB/PKCS7Padding';
        var s0 = mode.split('/')[0];
        var s1 = mode.split('/')[1];
        var s2 = mode.split('/')[2];
        s2 = s2.replace(/PKCS7Padding/, 'PKCS7').replace(/KCS/, 'kcs');
        key = CryptoJS.enc.Utf8.parse(key);
        if (iv) iv = CryptoJS.enc.Utf8.parse(iv);

        function De() {
            if (iv) {
                var decrypted = CryptoJS[s0].decrypt(data, key, {
                    iv: iv,
                    mode: CryptoJS.mode[s1],
                    padding: CryptoJS.pad[s2]
                });
            } else {
                var decrypted = CryptoJS[s0].decrypt(data, key, {
                    mode: CryptoJS.mode[s1],
                    padding: CryptoJS.pad[s2]
                });
            }
            if (!encoding) {
                return decrypted.toString(CryptoJS.enc.Utf8);
            } else {
                return decrypted.toString(CryptoJS.enc[encoding]);
            }
        };
        return De(data, encoding);
    }

function im() {
	return '#immersiveTheme##autoCache#';
}

function urla(u,host) {
	if (u.indexOf("http") < 0) {
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
function ss(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '‘‘’’<strong><small><font color=#' + (c || '000000') + '>' + d + '</font></small></strong>';
}
function ssR(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '<strong><small><font color=#' + (c || '000000') + '>' + d + '</font></small></strong>';
}

function sb(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '‘‘’’<strong><big><font color=#' + (c || '000000') + '>' + d + '</font></big></strong>';
}

function sbR(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '<strong><big><font color=#' + (c || '000000') + '>' + d + '</font></big></strong>';
}

function color(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '‘‘’’<font color=#' + (c || '000000') + '>' + d + '</font>';
}

function colorR(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '<font color=#' + (c || '000000') + '>' + d + '</font>';
}

function small(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '‘‘’’<small><font color=#' + (c || '000000') + '>' + d + '</font></small>';
}

function smallR(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '<small><font color=#' + (c || '000000') + '>' + d + '</font></small>';
}

function big(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '‘‘’’<big><font color=#' + (c || '000000') + '>' + d + '</font></big>';
}

function bigR(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '<big><font color=#' + (c || '000000') + '>' + d + '</font></big>';
}

function strong(d, c) {
    if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '‘‘’’<strong><font color=#' + (c || '000000') + '>' + d + '</font></strong>';
}

function strongR(d, c) {if (colorCode(d) && !colorCode(c)) {
        var tmp = d;
        d = c;
        c = tmp;
    }
    return '<strong><font color=#' + (c || '000000') + '>' + d + '</font></strong>';
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
            }else{
                strTmp=strTmp + ' ' + list[k];
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

function sp(cc) {
    var str = '',
        ss = JTPYStr(),
        tt = FTPYStr();
    for (var i = 0; i < cc.length; i++) {
        if (cc.charCodeAt(i) > 10000 && tt.indexOf(cc.charAt(i)) != -1) str += ss.charAt(tt.indexOf(cc.charAt(i)));
        else str += cc.charAt(i);
    }
    return str;
}

function tr(cc) {
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
    return '与征脑板家钟只淡骂猛松绣脏钻墙发余赞么制艳欲泛签奸恶你侄占译发绝铺系苏雇回仆里锕皑蔼碍爱嗳嫒瑷暧霭谙铵鹌肮袄奥媪骜鳌坝罢钯摆败呗颁办绊钣帮绑镑谤剥饱宝报鲍鸨龅辈贝钡狈备惫鹎贲锛绷笔毕毙币闭荜哔滗铋筚跸边编贬变辩辫苄缏笾标骠飑飙镖镳鳔鳖别瘪濒滨宾摈傧缤槟殡膑镔髌鬓饼禀拨钵铂驳饽钹鹁补钸财参蚕残惭惨灿骖黪苍舱仓沧厕侧册测恻层诧锸侪钗搀掺蝉馋谗缠铲产阐颤冁谄谶蒇忏婵骣觇禅镡场尝长偿肠厂畅伥苌怅阊鲳钞车彻砗尘陈衬伧谌榇碜龀撑称惩诚骋枨柽铖铛痴迟驰耻齿炽饬鸱冲冲虫宠铳畴踌筹绸俦帱雠橱厨锄雏础储触处刍绌蹰传钏疮闯创怆锤缍纯鹑绰辍龊辞词赐鹚聪葱囱从丛苁骢枞凑辏蹿窜撺错锉鹾达哒鞑带贷骀绐担单郸掸胆惮诞弹殚赕瘅箪当挡党荡档谠砀裆捣岛祷导盗焘灯邓镫敌涤递缔籴诋谛绨觌镝颠点垫电巅钿癫钓调铫鲷谍叠鲽钉顶锭订铤丢铥东动栋冻岽鸫窦犊独读赌镀渎椟牍笃黩锻断缎簖兑队对怼镦吨顿钝炖趸夺堕铎鹅额讹恶饿谔垩阏轭锇锷鹗颚颛鳄诶儿尔饵贰迩铒鸸鲕发罚阀珐矾钒烦贩饭访纺钫鲂飞诽废费绯镄鲱纷坟奋愤粪偾丰枫锋风疯冯缝讽凤沣肤辐抚辅赋复负讣妇缚凫驸绂绋赙麸鲋鳆钆该钙盖赅杆赶秆赣尴擀绀冈刚钢纲岗戆镐睾诰缟锆搁鸽阁铬个纥镉颍给亘赓绠鲠龚宫巩贡钩沟苟构购够诟缑觏蛊顾诂毂钴锢鸪鹄鹘剐挂鸹掴关观馆惯贯诖掼鹳鳏广犷规归龟闺轨诡贵刽匦刿妫桧鲑鳜辊滚衮绲鲧锅国过埚呙帼椁蝈铪骇韩汉阚绗颉号灏颢阂鹤贺诃阖蛎横轰鸿红黉讧荭闳鲎壶护沪户浒鹕哗华画划话骅桦铧怀坏欢环还缓换唤痪焕涣奂缳锾鲩黄谎鳇挥辉毁贿秽会烩汇讳诲绘诙荟哕浍缋珲晖荤浑诨馄阍获货祸钬镬击机积饥迹讥鸡绩缉极辑级挤几蓟剂济计记际继纪讦诘荠叽哜骥玑觊齑矶羁虿跻霁鲚鲫夹荚颊贾钾价驾郏浃铗镓蛲歼监坚笺间艰缄茧检碱硷拣捡简俭减荐槛鉴践贱见键舰剑饯渐溅涧谏缣戋戬睑鹣笕鲣鞯将浆蒋桨奖讲酱绛缰胶浇骄娇搅铰矫侥脚饺缴绞轿较挢峤鹪鲛阶节洁结诫届疖颌鲒紧锦仅谨进晋烬尽劲荆茎卺荩馑缙赆觐鲸惊经颈静镜径痉竞净刭泾迳弪胫靓纠厩旧阄鸠鹫驹举据锯惧剧讵屦榉飓钜锔窭龃鹃绢锩镌隽觉决绝谲珏钧军骏皲开凯剀垲忾恺铠锴龛闶钪铐颗壳课骒缂轲钶锞颔垦恳龈铿抠库裤喾块侩郐哙脍宽狯髋矿旷况诓诳邝圹纩贶亏岿窥馈溃匮蒉愦聩篑阃锟鲲扩阔蛴蜡腊莱来赖崃徕涞濑赉睐铼癞籁蓝栏拦篮阑兰澜谰揽览懒缆烂滥岚榄斓镧褴琅阆锒捞劳涝唠崂铑铹痨乐鳓镭垒类泪诔缧篱狸离鲤礼丽厉励砾历沥隶俪郦坜苈莅蓠呖逦骊缡枥栎轹砺锂鹂疠粝跞雳鲡鳢俩联莲连镰怜涟帘敛脸链恋炼练蔹奁潋琏殓裢裣鲢粮凉两辆谅魉疗辽镣缭钌鹩猎临邻鳞凛赁蔺廪檩辚躏龄铃灵岭领绫棂蛏鲮馏刘浏骝绺镏鹨龙聋咙笼垄拢陇茏泷珑栊胧砻楼娄搂篓偻蒌喽嵝镂瘘耧蝼髅芦卢颅庐炉掳卤虏鲁赂禄录陆垆撸噜闾泸渌栌橹轳辂辘氇胪鸬鹭舻鲈峦挛孪滦乱脔娈栾鸾銮抡轮伦仑沦纶论囵萝罗逻锣箩骡骆络荦猡泺椤脶镙驴吕铝侣屡缕虑滤绿榈褛锊呒妈玛码蚂马骂吗唛嬷杩买麦卖迈脉劢瞒馒蛮满谩缦镘颡鳗猫锚铆贸麽没镁门闷们扪焖懑钔锰梦眯谜弥觅幂芈谧猕祢绵缅渑腼黾庙缈缪灭悯闽闵缗鸣铭谬谟蓦馍殁镆谋亩钼呐钠纳难挠脑恼闹铙讷馁内拟腻铌鲵撵辇鲶酿鸟茑袅聂啮镊镍陧蘖嗫颟蹑柠狞宁拧泞苎咛聍钮纽脓浓农侬哝驽钕诺傩疟欧鸥殴呕沤讴怄瓯盘蹒庞抛疱赔辔喷鹏纰罴铍骗谝骈飘缥频贫嫔苹凭评泼颇钋扑铺朴谱镤镨栖脐齐骑岂启气弃讫蕲骐绮桤碛颀颃鳍牵钎铅迁签谦钱钳潜浅谴堑佥荨悭骞缱椠钤枪呛墙蔷强抢嫱樯戗炝锖锵镪羟跄锹桥乔侨翘窍诮谯荞缲硗跷窃惬锲箧钦亲寝锓轻氢倾顷请庆揿鲭琼穷茕蛱巯赇虮鳅趋区躯驱龋诎岖阒觑鸲颧权劝诠绻辁铨却鹊确阕阙悫让饶扰绕荛娆桡热韧认纫饪轫荣绒嵘蝾缛铷颦软锐蚬闰润洒萨飒鳃赛伞毵糁丧骚扫缫涩啬铯穑杀刹纱铩鲨筛晒酾删闪陕赡缮讪姗骟钐鳝墒伤赏垧殇觞烧绍赊摄慑设厍滠畲绅审婶肾渗诜谂渖声绳胜师狮湿诗时蚀实识驶势适释饰视试谥埘莳弑轼贳铈鲥寿兽绶枢输书赎属术树竖数摅纾帅闩双谁税顺说硕烁铄丝饲厮驷缌锶鸶耸怂颂讼诵擞薮馊飕锼苏诉肃谡稣虽随绥岁谇孙损笋荪狲缩琐锁唢睃獭挞闼铊鳎台态钛鲐摊贪瘫滩坛谭谈叹昙钽锬顸汤烫傥饧铴镗涛绦讨韬铽腾誊锑题体屉缇鹈阗条粜龆鲦贴铁厅听烃铜统恸头钭秃图钍团抟颓蜕饨脱鸵驮驼椭箨鼍袜娲腽弯湾顽万纨绾网辋韦违围为潍维苇伟伪纬谓卫诿帏闱沩涠玮韪炜鲔温闻纹稳问阌瓮挝蜗涡窝卧莴龌呜钨乌诬无芜吴坞雾务误邬庑怃妩骛鹉鹜锡牺袭习铣戏细饩阋玺觋虾辖峡侠狭厦吓硖鲜纤贤衔闲显险现献县馅羡宪线苋莶藓岘猃娴鹇痫蚝籼跹厢镶乡详响项芗饷骧缃飨萧嚣销晓啸哓潇骁绡枭箫协挟携胁谐写泻谢亵撷绁缬锌衅兴陉荥凶汹锈绣馐鸺虚嘘须许叙绪续诩顼轩悬选癣绚谖铉镟学谑泶鳕勋询寻驯训讯逊埙浔鲟压鸦鸭哑亚讶垭娅桠氩阉烟盐严岩颜阎艳厌砚彦谚验厣赝俨兖谳恹闫酽魇餍鼹鸯杨扬疡阳痒养样炀瑶摇尧遥窑谣药轺鹞鳐爷页业叶靥谒邺晔烨医铱颐遗仪蚁艺亿忆义诣议谊译异绎诒呓峄饴怿驿缢轶贻钇镒镱瘗舣荫阴银饮隐铟瘾樱婴鹰应缨莹萤营荧蝇赢颖茔莺萦蓥撄嘤滢潆璎鹦瘿颏罂哟拥佣痈踊咏镛优忧邮铀犹诱莸铕鱿舆鱼渔娱与屿语狱誉预驭伛俣谀谕蓣嵛饫阈妪纡觎欤钰鹆鹬龉鸳渊辕园员圆缘远橼鸢鼋约跃钥粤悦阅钺郧匀陨运蕴酝晕韵郓芸恽愠纭韫殒氲杂灾载攒暂赞瓒趱錾赃脏驵凿枣责择则泽赜啧帻箦贼谮赠综缯轧铡闸栅诈斋债毡盏斩辗崭栈战绽谵张涨帐账胀赵诏钊蛰辙锗这谪辄鹧贞针侦诊镇阵浈缜桢轸赈祯鸩挣睁狰争帧症郑证诤峥钲铮筝织职执纸挚掷帜质滞骘栉栀轵轾贽鸷蛳絷踬踯觯钟终种肿众锺诌轴皱昼骤纣绉猪诸诛烛瞩嘱贮铸驻伫槠铢专砖转赚啭馔颞桩庄装妆壮状锥赘坠缀骓缒谆准着浊诼镯兹资渍谘缁辎赀眦锱龇鲻踪总纵偬邹诹驺鲰诅组镞钻缵躜鳟翱并卜沉丑淀迭斗范干皋硅柜后伙秸杰诀夸里凌么霉捻凄扦圣尸抬涂洼喂污锨咸蝎彝涌游吁御愿岳云灶扎札筑于志注凋讠谫郄勐凼坂垅垴埯埝苘荬荮莜莼菰藁揸吒吣咔咝咴噘噼嚯幞岙嵴彷徼犸狍馀馇馓馕愣憷懔丬溆滟混漤潴澹甯纟绔绱珉枧桊桉槔橥轱轷赍肷胨飚煳煅熘愍淼砜磙眍钚钷铘铞锃锍锎';
}

function FTPYStr() {
    return '與徵脳闆傢锺隻澹駡勐鬆綉髒鑽牆髮馀讚麽製豔慾氾籤姦噁妳姪佔訳発絶舖係甦僱迴僕裡錒皚藹礙愛噯嬡璦曖靄諳銨鵪骯襖奧媼驁鰲壩罷鈀擺敗唄頒辦絆鈑幫綁鎊謗剝飽寶報鮑鴇齙輩貝鋇狽備憊鵯賁錛繃筆畢斃幣閉蓽嗶潷鉍篳蹕邊編貶變辯辮芐緶籩標驃颮飆鏢鑣鰾鱉別癟瀕濱賓擯儐繽檳殯臏鑌髕鬢餅稟撥缽鉑駁餑鈸鵓補鈽財參蠶殘慚慘燦驂黲蒼艙倉滄廁側冊測惻層詫鍤儕釵攙摻蟬饞讒纏鏟產闡顫囅諂讖蕆懺嬋驏覘禪鐔場嘗長償腸廠暢倀萇悵閶鯧鈔車徹硨塵陳襯傖諶櫬磣齔撐稱懲誠騁棖檉鋮鐺癡遲馳恥齒熾飭鴟沖衝蟲寵銃疇躊籌綢儔幬讎櫥廚鋤雛礎儲觸處芻絀躕傳釧瘡闖創愴錘綞純鶉綽輟齪辭詞賜鶿聰蔥囪從叢蓯驄樅湊輳躥竄攛錯銼鹺達噠韃帶貸駘紿擔單鄲撣膽憚誕彈殫賧癉簞當擋黨蕩檔讜碭襠搗島禱導盜燾燈鄧鐙敵滌遞締糴詆諦綈覿鏑顛點墊電巔鈿癲釣調銚鯛諜疊鰈釘頂錠訂鋌丟銩東動棟凍崠鶇竇犢獨讀賭鍍瀆櫝牘篤黷鍛斷緞籪兌隊對懟鐓噸頓鈍燉躉奪墮鐸鵝額訛惡餓諤堊閼軛鋨鍔鶚顎顓鱷誒兒爾餌貳邇鉺鴯鮞發罰閥琺礬釩煩販飯訪紡鈁魴飛誹廢費緋鐨鯡紛墳奮憤糞僨豐楓鋒風瘋馮縫諷鳳灃膚輻撫輔賦復負訃婦縛鳧駙紱紼賻麩鮒鰒釓該鈣蓋賅桿趕稈贛尷搟紺岡剛鋼綱崗戇鎬睪誥縞鋯擱鴿閣鉻個紇鎘潁給亙賡綆鯁龔宮鞏貢鉤溝茍構購夠詬緱覯蠱顧詁轂鈷錮鴣鵠鶻剮掛鴰摑關觀館慣貫詿摜鸛鰥廣獷規歸龜閨軌詭貴劊匭劌媯檜鮭鱖輥滾袞緄鯀鍋國過堝咼幗槨蟈鉿駭韓漢闞絎頡號灝顥閡鶴賀訶闔蠣橫轟鴻紅黌訌葒閎鱟壺護滬戶滸鶘嘩華畫劃話驊樺鏵懷壞歡環還緩換喚瘓煥渙奐繯鍰鯇黃謊鰉揮輝毀賄穢會燴匯諱誨繪詼薈噦澮繢琿暉葷渾諢餛閽獲貨禍鈥鑊擊機積饑跡譏雞績緝極輯級擠幾薊劑濟計記際繼紀訐詰薺嘰嚌驥璣覬齏磯羈蠆躋霽鱭鯽夾莢頰賈鉀價駕郟浹鋏鎵蟯殲監堅箋間艱緘繭檢堿鹼揀撿簡儉減薦檻鑒踐賤見鍵艦劍餞漸濺澗諫縑戔戩瞼鶼筧鰹韉將漿蔣槳獎講醬絳韁膠澆驕嬌攪鉸矯僥腳餃繳絞轎較撟嶠鷦鮫階節潔結誡屆癤頜鮚緊錦僅謹進晉燼盡勁荊莖巹藎饉縉贐覲鯨驚經頸靜鏡徑痙競凈剄涇逕弳脛靚糾廄舊鬮鳩鷲駒舉據鋸懼劇詎屨櫸颶鉅鋦窶齟鵑絹錈鐫雋覺決絕譎玨鈞軍駿皸開凱剴塏愾愷鎧鍇龕閌鈧銬顆殼課騍緙軻鈳錁頷墾懇齦鏗摳庫褲嚳塊儈鄶噲膾寬獪髖礦曠況誆誑鄺壙纊貺虧巋窺饋潰匱蕢憒聵簣閫錕鯤擴闊蠐蠟臘萊來賴崍徠淶瀨賚睞錸癩籟藍欄攔籃闌蘭瀾讕攬覽懶纜爛濫嵐欖斕鑭襤瑯閬鋃撈勞澇嘮嶗銠鐒癆樂鰳鐳壘類淚誄縲籬貍離鯉禮麗厲勵礫歷瀝隸儷酈壢藶蒞蘺嚦邐驪縭櫪櫟轢礪鋰鸝癘糲躒靂鱺鱧倆聯蓮連鐮憐漣簾斂臉鏈戀煉練蘞奩瀲璉殮褳襝鰱糧涼兩輛諒魎療遼鐐繚釕鷯獵臨鄰鱗凜賃藺廩檁轔躪齡鈴靈嶺領綾欞蟶鯪餾劉瀏騮綹鎦鷚龍聾嚨籠壟攏隴蘢瀧瓏櫳朧礱樓婁摟簍僂蔞嘍嶁鏤瘺耬螻髏蘆盧顱廬爐擄鹵虜魯賂祿錄陸壚擼嚕閭瀘淥櫨櫓轤輅轆氌臚鸕鷺艫鱸巒攣孿灤亂臠孌欒鸞鑾掄輪倫侖淪綸論圇蘿羅邏鑼籮騾駱絡犖玀濼欏腡鏍驢呂鋁侶屢縷慮濾綠櫚褸鋝嘸媽瑪碼螞馬罵嗎嘜嬤榪買麥賣邁脈勱瞞饅蠻滿謾縵鏝顙鰻貓錨鉚貿麼沒鎂門悶們捫燜懣鍆錳夢瞇謎彌覓冪羋謐獼禰綿緬澠靦黽廟緲繆滅憫閩閔緡鳴銘謬謨驀饃歿鏌謀畝鉬吶鈉納難撓腦惱鬧鐃訥餒內擬膩鈮鯢攆輦鯰釀鳥蔦裊聶嚙鑷鎳隉蘗囁顢躡檸獰寧擰濘苧嚀聹鈕紐膿濃農儂噥駑釹諾儺瘧歐鷗毆嘔漚謳慪甌盤蹣龐拋皰賠轡噴鵬紕羆鈹騙諞駢飄縹頻貧嬪蘋憑評潑頗釙撲鋪樸譜鏷鐠棲臍齊騎豈啟氣棄訖蘄騏綺榿磧頎頏鰭牽釬鉛遷簽謙錢鉗潛淺譴塹僉蕁慳騫繾槧鈐槍嗆墻薔強搶嬙檣戧熗錆鏘鏹羥蹌鍬橋喬僑翹竅誚譙蕎繰磽蹺竊愜鍥篋欽親寢鋟輕氫傾頃請慶撳鯖瓊窮煢蛺巰賕蟣鰍趨區軀驅齲詘嶇闃覷鴝顴權勸詮綣輇銓卻鵲確闋闕愨讓饒擾繞蕘嬈橈熱韌認紉飪軔榮絨嶸蠑縟銣顰軟銳蜆閏潤灑薩颯鰓賽傘毿糝喪騷掃繅澀嗇銫穡殺剎紗鎩鯊篩曬釃刪閃陜贍繕訕姍騸釤鱔墑傷賞坰殤觴燒紹賒攝懾設厙灄畬紳審嬸腎滲詵諗瀋聲繩勝師獅濕詩時蝕實識駛勢適釋飾視試謚塒蒔弒軾貰鈰鰣壽獸綬樞輸書贖屬術樹豎數攄紓帥閂雙誰稅順說碩爍鑠絲飼廝駟緦鍶鷥聳慫頌訟誦擻藪餿颼鎪蘇訴肅謖穌雖隨綏歲誶孫損筍蓀猻縮瑣鎖嗩脧獺撻闥鉈鰨臺態鈦鮐攤貪癱灘壇譚談嘆曇鉭錟頇湯燙儻餳鐋鏜濤絳討韜鋱騰謄銻題體屜緹鵜闐條糶齠鰷貼鐵廳聽烴銅統慟頭鈄禿圖釷團摶頹蛻飩脫鴕馱駝橢籜鼉襪媧膃彎灣頑萬紈綰網輞韋違圍為濰維葦偉偽緯謂衛諉幃闈溈潿瑋韙煒鮪溫聞紋穩問閿甕撾蝸渦窩臥萵齷嗚鎢烏誣無蕪吳塢霧務誤鄔廡憮嫵騖鵡鶩錫犧襲習銑戲細餼鬩璽覡蝦轄峽俠狹廈嚇硤鮮纖賢銜閑顯險現獻縣餡羨憲線莧薟蘚峴獫嫻鷴癇蠔秈躚廂鑲鄉詳響項薌餉驤緗饗蕭囂銷曉嘯嘵瀟驍綃梟簫協挾攜脅諧寫瀉謝褻擷紲纈鋅釁興陘滎兇洶銹繡饈鵂虛噓須許敘緒續詡頊軒懸選癬絢諼鉉鏇學謔澩鱈勛詢尋馴訓訊遜塤潯鱘壓鴉鴨啞亞訝埡婭椏氬閹煙鹽嚴巖顏閻艷厭硯彥諺驗厴贗儼兗讞懨閆釅魘饜鼴鴦楊揚瘍陽癢養樣煬瑤搖堯遙窯謠藥軺鷂鰩爺頁業葉靨謁鄴曄燁醫銥頤遺儀蟻藝億憶義詣議誼譯異繹詒囈嶧飴懌驛縊軼貽釔鎰鐿瘞艤蔭陰銀飲隱銦癮櫻嬰鷹應纓瑩螢營熒蠅贏穎塋鶯縈鎣攖嚶瀅瀠瓔鸚癭頦罌喲擁傭癰踴詠鏞優憂郵鈾猶誘蕕銪魷輿魚漁娛與嶼語獄譽預馭傴俁諛諭蕷崳飫閾嫗紆覦歟鈺鵒鷸齬鴛淵轅園員圓緣遠櫞鳶黿約躍鑰粵悅閱鉞鄖勻隕運蘊醞暈韻鄆蕓惲慍紜韞殞氳雜災載攢暫贊瓚趲鏨贓臟駔鑿棗責擇則澤賾嘖幘簀賊譖贈綜繒軋鍘閘柵詐齋債氈盞斬輾嶄棧戰綻譫張漲帳賬脹趙詔釗蟄轍鍺這謫輒鷓貞針偵診鎮陣湞縝楨軫賑禎鴆掙睜猙爭幀癥鄭證諍崢鉦錚箏織職執紙摯擲幟質滯騭櫛梔軹輊贄鷙螄縶躓躑觶鐘終種腫眾鍾謅軸皺晝驟紂縐豬諸誅燭矚囑貯鑄駐佇櫧銖專磚轉賺囀饌顳樁莊裝妝壯狀錐贅墜綴騅縋諄準著濁諑鐲茲資漬諮緇輜貲眥錙齜鯔蹤總縱傯鄒諏騶鯫詛組鏃鉆纘躦鱒翺並蔔沈醜澱叠鬥範幹臯矽櫃後夥稭傑訣誇裏淩麽黴撚淒扡聖屍擡塗窪餵汙鍁鹹蠍彜湧遊籲禦願嶽雲竈紮劄築於誌註雕訁譾郤猛氹阪壟堖垵墊檾蕒葤蓧蒓菇槁摣咤唚哢噝噅撅劈謔襆嶴脊仿僥獁麅餘餷饊饢楞怵懍爿漵灩溷濫瀦淡寧糸絝緔瑉梘棬案橰櫫軲軤賫膁腖飈糊煆溜湣渺碸滾瞘鈈鉕鋣銱鋥鋶鐦';
}
function data_xchina() {
    var data = `var cvideo = [
    [{
        name: '全部成人影片',
        url: domain + '/videos/1.html'
    }],
    [{
        name: '中文AV(11912)',
        url: domain + '/videos/series-63824a975d8ae/1.html'
    }, {
        name: '麻豆传媒(3345)',
        url: domain + '/videos/series-5f904550b8fcc/1.html'
    }, {
        name: '蜜桃传媒(1083)',
        url: domain + '/videos/series-5fe8403919165/1.html'
    },{
        name: '星空传媒(946)',
        url: domain + '/videos/series-6054e93356ded/1.html'
    },{
        name: '糖心Vlog(888)',
        url: domain + '/videos/series-61014080dbfde/1.html'
    }, {
        name: '天美传媒(774)',
        url: domain + '/videos/series-60153c49058ce/1.html'
    }, {
        name: '果冻传媒(628)',
        url: domain + '/videos/series-5fe840718d665/1.html'
    }, {
        name: '精东影业(526)',
        url: domain + '/videos/series-60126bcfb97fa/1.html'
    }, {
        name: '其他中文AV(517)',
        url: domain + '/videos/series-63986aec205d8/1.html'
    }, {
        name: 'OnlyFans(405)',
        url: domain + '/videos/series-61bf6e439fed6/1.html'
    },{
        name: '爱豆传媒(349)',
        url: domain + '/videos/series-63d134c7a0a15/1.html'
    },{
        name: '香蕉视频(341)',
        url: domain + '/videos/series-65e5f74e4605c/1.html'
    }, {
        name: '杏吧原版(329)',
        url: domain + '/videos/series-6072997559b46/1.html'
    }, {
        name: 'IBiZa Media(321)',
        url: domain + '/videos/series-64e9cce89da21/1.html'
    }, {
        name: '性视界(304)',
        url: domain + '/videos/series-63490362dac45/1.html'
    }, {
        name: '大象传媒(223)',
        url: domain + '/videos/series-60c2555958858/1.html'
    }, {
        name: '扣扣传媒(200)',
        url: domain + '/videos/series-6230974ada989/1.html'
    },{
        name: '萝莉社(188)',
        url: domain + '/videos/series-5fe8403919165/1.html'
    }, {
        name: 'SA国际传媒(131)',
        url: domain + '/videos/series-6360ca9706ecb/1.html'
    }, {
        name: 'EDMosaic(85)',
        url: domain + '/videos/series-63732f5c3d36b/1.html'
    },  {
        name: '葫芦影业(47)',
        url: domain + '/videos/series-6193d27975579/1.html'
    }, {
        name: '乌托邦(43)',
        url: domain + '/videos/series-637750ae0ee71/1.html'
    }, {
        name: '爱神传媒(38)',
        url: domain + '/videos/series-6405b6842705b/1.html'
    }, {
        name: '乐播传媒(34)',
        url: domain + '/videos/series-60589daa8ff97/1.html'
    }, {
        name: '91茄子(30)',
        url: domain + '/videos/series-639c8d983b7d5/1.html'
    }, {
        name: '抖阴(29)',
        url: domain + '/videos/series-6248705dab604/1.html'
    }, {
        name: '草莓视频(25)',
        url: domain + '/videos/series-671ddc0b358ca/1.html'
    }, {
        name: 'YOYO(20)',
        url: domain + '/videos/series-64eda52c1c3fb/1.html'
    }, {
        name: '51吃瓜(17)',
        url: domain + '/videos/series-671dd88d06dd3/1.html'
    },  {
        name: '哔哩传媒(16)',
        url: domain + '/videos/series-64458e7da05e6/1.html'
    }, {
        name: '映秀传媒(15)',
        url: domain + '/videos/series-6447fc202ffdf/1.html'
    }, {
        name: '西瓜影视(10)',
        url: domain + '/videos/series-648e1071386ef/1.html'
    }, {
        name: '思春社(5)',
        url: domain + '/videos/series-64be8551bd0f1/1.html'
    }, {
        name: '起点传媒(14)',
        url: domain + '/videos/series-639377d93a682/1.html'
    }, {
        name: '乌鸦传媒(11)',
        url: domain + '/videos/series-601fdc25ab544/1.html'
    }, {
        name: 'MisAV(10)',
        url: domain + '/videos/series-62263c03a735c/1.html'
    }, {
        name: 'TWAV(8)',
        url: domain + '/videos/series-62263c03a735c/1.html'
    }, {
        name: 'mini传媒(7)',
        url: domain + '/videos/series-60da356dc166c/1.html'
    },{
        name: 'CCAV(5)',
        url: domain + '/videos/series-61b88a26d1e61/1.html'
    }, {
        name: '开心鬼传媒(4)',
        url: domain + '/videos/series-609e4c6e7a174/1.html'
    }],
    [ {
        name: '模特私拍(2034)',
        url: domain + '/videos/series-6030196781d85/1.html'
    }, {
        name: 'PANS视频(1206)',
        url: domain + '/videos/series-63963186ae145/1.html'
    },{
        name: '其他模特私拍(394)',
        url: domain + '/videos/series-63963534a9e49/1.html'
    }, {
        name: '热舞(195)',
        url: domain + '/videos/series-64edbeccedb2e/1.html'
    }, {
        name: '相约中国(154)',
        url: domain + '/videos/series-63ed0f22e9177/1.html'
    }, {
        name: '果哥作品(56)',
        url: domain + '/videos/series-6396315ed2e49/1.html'
    }, {
        name: '风吟鸟唱作品(11)',
        url: domain + '/videos/series-6396319e6b823/1.html'
    }, {
        name: '色艺无间(10)',
        url: domain + '/videos/series-6754a97d2b343/1.html'
    }, {
        name: '黄甫(7)',
        url: domain + '/videos/series-668c3b2de7f1c/1.html'
    }],
    [{
        name: '业余拍摄(647)',
        url: domain + '/videos/series-617d3e7acdcc8/1.html'
    }, {
        name: '探花现场(569)',
        url: domain + '/videos/series-63965bf7b7f51/1.html'
    }, {
        name: '主播现场(78)',
        url: domain + '/videos/series-63965bd5335fc/1.html'
    }],
    [{
        name: '日本AV(5204)',
        url: domain + '/videos/series-6206216719462/1.html'
    }, {
        name: '有码AV(2896)',
        url: domain + '/videos/series-6395aba3deb74/1.html'
    }, {
        name: '无码AV(1848)',
        url: domain + '/videos/series-6395ab7fee104/1.html'
    }, {
        name: 'AV解说(460)',
        url: domain + '/videos/series-6608638e5fcf7/1.html'
    }],
    [{
        name: '其他影片(264)',
        url: domain + '/videos/series-60192e83c9e05/1.html'
    }, {
        name: '其他亚洲影片(133)',
        url: domain + '/videos/series-63963ea949a82/1.html'
    }, {
        name: '门事件(71)',
        url: domain + '/videos/series-63963de3f2a0f/1.html'
    },  {
        name: '其他欧美影片(49)',
        url: domain + '/videos/series-6396404e6bdb5/1.html'
    },  {
        name: '无关情色(10)',
        url: domain + '/videos/series-66643478ceedd/1.html'
    }],
    [{
        name: '情色电影(300)',
        url: domain + '/videos/series-61c4d9b653b6d/1.html'
    }, {
        name: '华语电影(223)',
        url: domain + '/videos/series-6396492fdb1a0/1.html'
    }, {
        name: '日韩电影(69)',
        url: domain + '/videos/series-6396494584b57/1.html'
    }, {
        name: '欧美电影(8)',
        url: domain + '/videos/series-63964959ddb1b/1.html'
    }]
];
var sort_data = [{
    name: '更新时间',
    url: ''
}, {
    name: '观看最多',
    url: '/sort-read'
}, {
    name: '评论最多',
    url: '/sort-comment'
}, {
    name: '最近评论',
    url: '/sort-recent'
},{
    name: '时长最长',
    url: '/sort-length'
}];
var cphoto = [
    [{
        name: '全部情色套图',
        url: domain + '/photos/kind-1/1.html'
    }, {
        name: '全部情色套图',
        url: domain + '/photos/kind-1/1.html'
    }, {
        name: 'AI图区',
        url: domain + '/photos/series-6443d480eb757/1.html'
    }],
    [{
        name: '专辑',
        url: ''
    }, {
        name: '秀人网特色主题',
        url: domain + '/photos/album-1/1.html'
    }, {
        name: '大尺度主题',
        url: domain + '/photos/album-2/1.html'
    }, {
        name: '性爱主题',
        url: domain + '/photos/album-3/1.html'
    }, {
        name: '露出主题',
        url: domain + '/photos/album-4/1.html'
    }, {
        name: 'Cosplay主题',
        url: domain + '/photos/album-5/1.html'
    }, {
        name: '道具主题',
        url: domain + '/photos/album-6/1.html'
    }, {
        name: '捆绑主题',
        url: domain + '/photos/album-7/1.html'
    }, {
        name: '白虎主题',
        url: domain + '/photos/album-8/1.html'
    }, {
        name: '女同主题',
        url: domain + '/photos/album-9/1.html'
    }, {
        name: '丝袜内衣主题',
        url: domain + '/photos/album-10/1.html'
    }, {
        name: '有视频',
        url: domain + '/photos/album-11/1.html'
    }, {
        name: '业余自拍',
        url: domain + '/photos/album-12/1.html'
    }],
    [{
        name: '秀人网旗下',
        url: domain + '/photos/series-6660093348354/1.html'
    }, {
        name: '秀人网旗下(14099)',
        url: domain + '/photos/series-6660093348354/1.html'
    }, {
        name: '秀人网(9425)',
        url: domain + '/photos/series-5f1476781eab4/1.html'
    }, {
        name: '语画界(750)',
        url: domain + '/photos/series-601ef80997845/1.html'
    }, {
        name: '爱蜜社(721)',
        url: domain + '/photos/series-5f71afc92d8ab/1.html'
    }, {
        name: '花漾(604)',
        url: domain + '/photos/series-5fc4ce40386af/1.html'
    }, {
        name: '模范学院(568)',
        url: domain + '/photos/series-5f181625966a6/1.html'
    }, {
        name: '尤蜜荟(510)',
        url: domain + '/photos/series-5f184ff551888/1.html'
    }, {
        name: '美媛馆(503)',
        url: domain + '/photos/series-5f1495dbda4de/1.html'
    }, {
        name: '私钩流出(310)',
        url: domain + '/photos/series-66600a3a227ee/1.html'
    }, {
        name: '尤物馆(175)',
        url: domain + '/photos/series-60673bec9dd11/1.html'
    }, {
        name: '星颜社(156)',
        url: domain + '/photos/series-6141c88882a36/1.html'
    }, {
        name: '蜜桃社(149)',
        url: domain + '/photos/series-5f1dd5a7ebe9a/1.html'
    }, {
        name: '爱尤物(125)',
        url: domain + '/photos/series-5f148046cb2c7/1.html'
    }, {
        name: 'FEILIN嗲囡囡(118)',
        url: domain + '/photos/series-5f14a3105d3e8/1.html'
    }, {
        name: '瑞丝馆(88)',
        url: domain + '/photos/series-61263de287e2f/1.html'
    }, {
        name: '影私荟(22)',
        url: domain + '/photos/series-63d435352808c/1.html'
    }],
    [{
        name: '中国工作室(4094)',
        url: ''
    }, {
        name: 'PANS(1199)',
        url: domain + '/photos/series-6310ce9b90056/1.html'
    }, {
        name: '丽图100(537)',
        url: domain + '/photos/series-5f1d784995865/1.html'
    }, {
        name: '相约中国(382)',
        url: domain + '/photos/series-5f1dcdeaee582/1.html'
    }, {
        name: '轰趴猫(263)',
        url: domain + '/photos/series-5f1ae6caae922/1.html'
    }, {
        name: '潘多拉(192)',
        url: domain + '/photos/series-5f23c44cd66bd/1.html'
    }, {
        name: '其他(134)',
        url: domain + '/photos/series-665f7d787d681/1.html'
    }, {
        name: '果团网(132)',
        url: domain + '/photos/series-5f1817b42772b/1.html'
    }, {
        name: '爱丝(132)',
        url: domain + '/photos/series-5f15f389e993e/1.html'
    }, {
        name: '妖精社(99)',
        url: domain + '/photos/series-5f4b5f4eb8b71/1.html'
    }, {
        name: '行色(97)',
        url: domain + '/photos/series-64f44d99ce673/1.html'
    }, {
        name: '黄甫(92)',
        url: domain + '/photos/series-665f8bafab4bc/1.html'
    }, {
        name: '无忌影社(91)',
        url: domain + '/photos/series-619a92aa1fa7a/1.html'
    }, {
        name: '推女郎(87)',
        url: domain + '/photos/series-5f14a5eb5b0d7/1.html'
    }, {
        name: '蜜丝(74)',
        url: domain + '/photos/series-5f2089564c6c2/1.html'
    }, {
        name: '风吟鸟唱(70)',
        url: domain + '/photos/series-63b54e804a694/1.html'
    }, {
        name: '头条女神(53)',
        url: domain + '/photos/series-5f14806585bef/1.html'
    }, {
        name: '深夜企划(47)',
        url: domain + '/photos/series-638e5a60b1770/1.html'
    }, {
        name: '北京天使(41)',
        url: domain + '/photos/series-622c7f95220a4/1.html'
    }, {
        name: '尤美(38)',
        url: domain + '/photos/series-61b997728043b/1.html'
    }, {
        name: '希威社(38)',
        url: domain + '/photos/series-665f8595408fa/1.html'
    }, {
        name: 'ISS系列(34)',
        url: domain + '/photos/series-646c69b675f3d/1.html'
    }, {
        name: 'A4U(34)',
        url: domain + '/photos/series-5f60b98248a81/1.html'
    }, {
        name: 'DDY(28)',
        url: domain + '/photos/series-5f15f727df393/1.html'
    }, {
        name: '东莞V女郎(26)',
        url: domain + '/photos/series-5f22ea422221c/1.html'
    }, {
        name: 'SK丝库(22)',
        url: domain + '/photos/series-5f382ba894af4/1.html'
    }, {
        name: '蜜柚摄影(17)',
        url: domain + '/photos/series-676c3e9b90749/1.html'
    }, {
        name: 'U238(10)',
        url: domain + '/photos/series-67028a27d02a6/1.html'
    }, {
        name: 'AI图区(38)',
        url: domain + '/photos/series-6443d480eb757/1.html'
    }],
    [{
        name: '日本工作室(746)',
        url: domain + '/photos/series-6395a1e929f23/1.html'
    }, {
        name: 'Graphis(231)',
        url: domain + '/photos/series-6450b47c9db0b/1.html'
    }, {
        name: 'KUNI Scan(144)',
        url: domain + '/photos/series-66f9665804471/1.html'
    }, {
        name: 'FRIDAY(85)',
        url: domain + '/photos/series-66659e2d94489/1.html'
    }, {
        name: 'Prestige(60)',
        url: domain + '/photos/series-670791f5f2f0f/1.html'
    }, {
        name: 'Escape(57)',
        url: domain + '/photos/series-66603af933ec9/1.html'
    }, {
        name: '周刊ポストデジタル写真集（每周数码摄影）(42)',
        url: domain + '/photos/series-66e68b9c96ab0/1.html'
    }, {
        name: 'アサ芸SEXY(32)',
        url: domain + '/photos/series-670d7142b3d88/1.html'
    }, {
        name: 'Super Pose Book(31)',
        url: domain + '/photos/series-62a0a15911f16/1.html'
    }, {
        name: 'Urabon(29)',
        url: domain + '/photos/series-6692ea004cc75/1.html'
    }, {
        name: 'X-City(26)',
        url: domain + '/photos/series-66fb8cca706ae/1.html'
    }, {
        name: 'FLASHデジタル写真集(9)',
        url: domain + '/photos/series-672a2029d6a32/1.html'
    }],
    [{
        name: '韩国工作室(512)',
        url: domain + '/photos/series-665f6627c7295/1.html'
    }, {
        name: 'ArtGravia(199)',
        url: domain + '/photos/series-60a4a953ca563/1.html'
    }, {
        name: 'Pure Media(146)',
        url: domain + '/photos/series-6224e755e21f4/1.html'
    }, {
        name: 'Makemodel(106)',
        url: domain + '/photos/series-665f81885f103/1.html'
    }, {
        name: 'Espacia Korea(42)',
        url: domain + '/photos/series-665a2385a2367/1.html'
    }, {
        name: 'Loozy(19)',
        url: domain + '/photos/series-62888afad416b/1.html'
    }],
    [{
        name: '台湾工作室(512)',
        url: domain + '/photos/series-665f7c561767e/1.html'
    }, {
        name: 'JVID(318)',
        url: domain + '/photos/series-637b2029d2347/1.html'
    }, {
        name: 'Fantasy Factory(42)',
        url: domain + '/photos/series-5f889afb37619/1.html'
    }, {
        name: 'TPimage(23)',
        url: domain + '/photos/series-5f7a0a80d3d66/1.html'
    }],
    [{
        name: '各国其他套图(512)',
        url: domain + '/photos/series-618e4909ea9b6/1.html'
    }, {
        name: '国模套图(4838)',
        url: domain + '/photos/series-64be21c972ca4/1.html'
    }, {
        name: '日模套图(535)',
        url: domain + '/photos/series-64be2283bf3af/1.html'
    }, {
        name: '韩模套图(366)',
        url: domain + '/photos/series-64be22b4a0fa0/1.html'
    }, {
        name: '台模套图(252)',
        url: domain + '/photos/series-64be21ef4cc51/1.html'
    }, {
        name: '港模套图(93)',
        url: domain + '/photos/series-64be224b662c0/1.html'
    }, {
        name: '其他地区套图(14)',
        url: domain + '/photos/series-64be239ce73d4/1.html'
    }]
];
var cfiction = [{
    name: '全部小说(17722)',
    url: domain + '/fictions/1.html'
}, {
    name: '编辑推荐(5631)',
    url: domain + '/fictions/tag-编辑推荐/1.html'
}, {
    name: '人妻女友(6221)',
    url: domain + '/fictions/tag-%e4%ba%ba%e5%a6%bb女友/1.html'
}, {
    name: '学生校园(1751)',
    url: domain + '/fictions/tag-学生校园/1.html'
}, {
    name: '伴侣交换(274)',
    url: domain + '/fictions/tag-伴侣交换/1.html'
}, {
    name: '都市生活(5041)',
    url: domain + '/fictions/tag-都市生活/1.html'
}, {
    name: '动漫游戏(299)',
    url: domain + '/fictions/tag-动漫游戏/1.html'
}, {
    name: '名人明星(154)',
    url: domain + '/fictions/tag-名人明星/1.html'
}, {
    name: '经验故事(1098)',
    url: domain + '/fictions/tag-经验故事/1.html'
}, {
    name: '古典玄幻(2115)',
    url: domain + '/fictions/tag-古典玄幻/1.html'
}, {
    name: '家庭乱伦(4493)',
    url: domain + '/fictions/tag-家庭%e4%b9%b1%e4%bc%a6/1.html'
}, {
    name: '多人群交(2552)',
    url: domain + '/fictions/tag-多人群交/1.html'
}, {
    name: '公司职场(1327)',
    url: domain + '/fictions/tag-公司职场/1.html'
}, {
    name: '露出暴露(932)',
    url: domain + '/fictions/tag-露出暴露/1.html'
}, {
    name: '强暴性虐(2427))',
    url: domain + '/fictions/tag-强暴性虐/1.html'
}, {
    name: '西方主题(516)',
    url: domain + '/fictions/tag-西方主题/1.html'
}, {
    name: '同性主题(255)',
    url: domain + '/fictions/tag-同性主题/1.html'
}, {
    name: '绿帽主题(1699)',
    url: domain + '/fictions/tag-绿帽主题/1.html'
}, {
    name: '长篇连载(5567)',
    url: domain + '/fictions/tag-长篇连载/1.html'
}, {
    name: '经典回忆(109)',
    url: domain + '/fictions/tag-经典回忆/1.html'
}, {
    name: '有声小说(814)',
    url: domain + '/fictions/tag-有声小说/1.html'
}];
var sort_fiction = [{
    name: '篇幅不限',
    url: ''
}, {
    name: '短篇',
    url: '/length-1'
}, {
    name: '中长篇',
    url: '/length-2'
}, {
    name: '超长篇',
    url: '/length-3'
}];
var cmodel = [{
    name: '全部模特(1660)',
    url: domain + '/models/1.html'
}, {
    name: '华人模特(1508)',
    url: domain + '/models/type-4/1.html'
}, {
    name: '韩国模特(85)',
    url: domain + '/models/type-5/1.html'
}, {
    name: '华人女优(545)',
    url: domain + '/models/type-7/1.html'
}, {
    name: '日本女优(1849)',
    url: domain + '/models/type-8/1.html'
}, {
    name: '日本男优(233)',
    url: domain + '/models/type-9/1.html'
}, {
    name: '名人明星(27)',
    url: domain + '/models/type-10/1.html'
}, {
    name: '摄影师(44)',
    url: domain + '/models/type-11/1.html'
}];
var sort_model = [{
    name: '浏览最多',
    url: ''
}, {
    name: '作品最多',
    url: '/sort-works'
}, {
    name: '最新加入',
    url: '/sort-recently'
}];
var ctorrent = [{
    name: '最新资源',
    url: domain + '/torrents/1.html'
}, {
    name: '视频下载(网盘)',
    url: domain + '/torrents/category-KVideo/1.html'
}, {
    name: '套图下载(网盘)',
    url: domain + '/torrents/category-KPhoto/1.html'
}, {
    name: '国产原版(磁链)',
    url: domain + '/torrents/category-U3C3/1.html'
}, {
    name: '视频下载(磁链)',
    url: domain + '/torrents/category-Video/1.html'
}, {
    name: '图片下载(磁链)',
    url: domain + '/torrents/category-Photo/1.html'
}, {
    name: '游戏下载(磁链)',
    url: domain + '/torrents/category-Game/1.html'
}, {
    name: '图书下载(磁链)',
    url: domain + '/torrents/category-Book/1.html'
}, {
    name: '其他下载(磁链)',
    url: domain + '/torrents/category-Other/1.html'
}];
var sort1_torrent = [{
    name: '新表',
    url: ''
}, {
    name: '新表',
    url: '/tb-1'
}];
var sort2_torrent = [{
    name: '更新时间',
    url: ''
}, {
    name: '下载最多',
    url: '/sort-read'
}];`;
return data;
}

function data_yituyu() {
    var data=`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`;

    return data;
}
if(typeof(MY_RULE)!='undefined'&&MY_RULE!=null){
    if(/伊甸园/.test(MY_RULE.title)){
    toast('出错了!!!');
    setResult([]);}
}





