js:// -*- mode: js -*-
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
        }
        , extra);
        fba.open(JSON.stringify({rule: "\u805a\u9605", title: extra.name || "\u8be6\u60c5", url: "hiker://empty?type=" + jkdata.type + "&page=fypage" + (jkdata.erjisign || "#immersiveTheme#"), group: MY_RULE.group, findRule: findRule, params: JSON.stringify(extra), preRule: MY_RULE.preRule, pages: MY_RULE.pages}));
    }
    , MY_RULE, jkdata, extra);
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
                                                name: getVar('name','')
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
function bgcolorArr(arr,bc){
return arr.map(h => ccc(/<\//.test(h)?pdfh(h, 'body&&Text'):h, {
                        fc: '#FFFFFF',
                        bc: !bc?getDarkColor():'',
                    })).join(' ');
}
function banner(start, arr, data, cfg) {
    if (!data || data.length == 0) {
        return;
    }
    let id = cfg.id||"juyue";
    let rnum = 0;
    let item = data[rnum];
    putMyVar("rnum"+id, rnum+'');
    cfg = cfg || {};
    let time = cfg.time || 4000;
    let col_type = cfg.col_type || "card_pic_1";
    let desc = cfg.desc || "0";
    let extra = item.extra || {};
    extra["id"] = cfg.id||"juyue";
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
    registerTask(id, time, $.toString((obj, toerji,id) => {
        let data = obj.data;
        let rum = getMyVar("rnum"+id);
        let i = Number(getMyVar("banneri"+id, "0"));
        if (rum != "") {
            i = Number(rum) + 1;
            clearMyVar("rnum"+id);
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
        putMyVar("banneri"+id, i);
    }, obj, toerji,id));
}
function proxyPic(url, mode) {
        if (url.startsWith('https://images.weserv.nl/?url=') || url.startsWith('https://i1.wp.com/')) return url;
        if(/blogspot/.test(url))  return 'https://images.weserv.nl/?url=' + url;
        if(/mrcong|misskon/.test(url)&&!url.endsWith('/'))  return 'https://i1.wp.com/' + url.replace(/https?:\/\//, '');
        if(/meitu\.jrants\.com/.test(url))  return 'https://wdkj.eu.org/' + url;
        if (!mode) return 'https://i1.wp.com/' + url.replace(/https?:\/\//, '');
        if (mode == 1) return 'https://images.weserv.nl/?url=' + url;
		if (mode == 2) return 'https://wdkj.eu.org/' + url;
        return url;
    }
function fetchWithRetry(urls, maxRetry) {
    maxRetry = maxRetry || 5;
    let htmls = bf(urls);
    let retryCount = 0;
    function isFailed(html) {
        return !html || html.includes('error code: 1015');
    }
    while (retryCount < maxRetry && htmls.some(html => isFailed(html))) {
        let needRetry = urls.map((urlObj, i) => isFailed(htmls[i]) ? urlObj : {url: 'hiker://empty'});
        let retryResults = bf(needRetry);
        htmls = htmls.map((html, i) => isFailed(html) ? retryResults[i] : html);
        retryCount++;
        if (htmls.every(html => !isFailed(html))) break;
    }
    return htmls.map(html => isFailed(html) ? '' : html);
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
        darkMode = mode == 0 ? '浅色模式' : (mode == 2 ? '浅色白字模式' : ((mode == 3 ? '黑字淡彩色' : '深色模式')));
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
function imgDecsRmw(picUrl){
    return $.toString((picUrl)=>{log(picUrl);
        function customHash(decodedString) {
            let inputBytes;
            if (typeof decodedString === "string") {
                inputBytes = [];
                for (let i = 0; i < decodedString.length; i++) {
                    inputBytes.push(decodedString.charCodeAt(i));
                }
            } else {
                inputBytes = input;
            }
            function bytesToWords(bytes) {
                let words = [];
                for (let i = 0; i < bytes.length; i += 4) {
                    let word = 0;
                    if (i < bytes.length) {
                        word |= (bytes[i] & 255) << 0;
                    }
                    if (i + 1 < bytes.length) {
                        word |= (bytes[i + 1] & 255) << 8;
                    }
                    if (i + 2 < bytes.length) {
                        word |= (bytes[i + 2] & 255) << 16;
                    }
                    if (i + 3 < bytes.length) {
                        word |= (bytes[i + 3] & 255) << 24;
                    }
                    words.push(word);
                }
                return words;
            }
            function wordsToBytes(words) {
                let bytes = [];
                for (let i = 0; i < words.length; i++) {
                    for (let j = 0; j < 4; j++) {
                        bytes.push((words[i] >>> (j * 8)) & 255);
                    }
                }
                return bytes;
            }
            function bytesToHex(bytes) {
                let hex = "";
                for (let i = 0; i < bytes.length; i++) {
                    hex += (bytes[i] < 16 ? "0" : "") + bytes[i].toString(16);
                }
                return hex;
            }
            let _ff = function (t, r, e, n, o, i, f) {
                var u = t + (r & e | ~r & n) + (o >>> 0) + f;
                return (u << i | u >>> 32 - i) + r;
            };
            let _gg = function (t, r, e, n, o, i, f) {
                var u = t + (r & n | e & ~n) + (o >>> 0) + f;
                return (u << i | u >>> 32 - i) + r;
            };
            let _hh = function (t, r, e, n, o, i, f) {
                var u = t + (r ^ e ^ n) + (o >>> 0) + f;
                return (u << i | u >>> 32 - i) + r;
            };
            let _ii = function (t, r, e, n, o, i, f) {
                var u = t + (e ^ (r | ~n)) + (o >>> 0) + f;
                return (u << i | u >>> 32 - i) + r;
            };
            function u(t, r) {
                let e = bytesToWords(t);
                let s = 8 * t.length;
                let a = 1732584193;
                let c = -271733879;
                let h = -1732584194;
                let l = 271733878;
                let index1 = s >>> 5;
                while (e.length <= index1) {
                    e.push(null);
                }
                e[index1] |= 128 << (s % 32);
                let index2 = (((s + 64) >>> 9) << 4) + 14;
                while (e.length <= index2) {
                    e.push(null);
                }
                e[index2] = s;
                for (let p = 0; p < e.length; p += 16) {
                    let b = a, m = c, x = h, w = l;
                    a = _ff(a, c, h, l, e[p + 0], 7, -680876936);
                    l = _ff(l, a, c, h, e[p + 1], 12, -389564586);
                    h = _ff(h, l, a, c, e[p + 2], 17, 606105819);
                    c = _ff(c, h, l, a, e[p + 3], 22, -1044525330);
                    a = _ff(a, c, h, l, e[p + 4], 7, -176418897);
                    l = _ff(l, a, c, h, e[p + 5], 12, 1200080426);
                    h = _ff(h, l, a, c, e[p + 6], 17, -1473231341);
                    c = _ff(c, h, l, a, e[p + 7], 22, -45705983);
                    a = _ff(a, c, h, l, e[p + 8], 7, 1770035416);
                    l = _ff(l, a, c, h, e[p + 9], 12, -1958414417);
                    h = _ff(h, l, a, c, e[p + 10], 17, -42063);
                    c = _ff(c, h, l, a, e[p + 11], 22, -1990404162);
                    a = _ff(a, c, h, l, e[p + 12], 7, 1804603682);
                    l = _ff(l, a, c, h, e[p + 13], 12, -40341101);
                    h = _ff(h, l, a, c, e[p + 14], 17, -1502002290);
                    c = _ff(c, h, l, a, e[p + 15], 22, 1236535329);
                    a = _gg(a, c, h, l, e[p + 1], 5, -165796510);
                    l = _gg(l, a, c, h, e[p + 6], 9, -1069501632);
                    h = _gg(h, l, a, c, e[p + 11], 14, 643717713);
                    c = _gg(c, h, l, a, e[p + 0], 20, -373897302);
                    a = _gg(a, c, h, l, e[p + 5], 5, -701558691);
                    l = _gg(l, a, c, h, e[p + 10], 9, 38016083);
                    h = _gg(h, l, a, c, e[p + 15], 14, -660478335);
                    c = _gg(c, h, l, a, e[p + 4], 20, -405537848);
                    a = _gg(a, c, h, l, e[p + 9], 5, 568446438);
                    l = _gg(l, a, c, h, e[p + 14], 9, -1019803690);
                    h = _gg(h, l, a, c, e[p + 3], 14, -187363961);
                    c = _gg(c, h, l, a, e[p + 8], 20, 1163531501);
                    a = _gg(a, c, h, l, e[p + 13], 5, -1444681467);
                    l = _gg(l, a, c, h, e[p + 2], 9, -51403784);
                    h = _gg(h, l, a, c, e[p + 7], 14, 1735328473);
                    c = _gg(c, h, l, a, e[p + 12], 20, -1926607734);
                    a = _hh(a, c, h, l, e[p + 5], 4, -378558);
                    l = _hh(l, a, c, h, e[p + 8], 11, -2022574463);
                    h = _hh(h, l, a, c, e[p + 11], 16, 1839030562);
                    c = _hh(c, h, l, a, e[p + 14], 23, -35309556);
                    a = _hh(a, c, h, l, e[p + 1], 4, -1530992060);
                    l = _hh(l, a, c, h, e[p + 4], 11, 1272893353);
                    h = _hh(h, l, a, c, e[p + 7], 16, -155497632);
                    c = _hh(c, h, l, a, e[p + 10], 23, -1094730640);
                    a = _hh(a, c, h, l, e[p + 13], 4, 681279174);
                    l = _hh(l, a, c, h, e[p + 0], 11, -358537222);
                    h = _hh(h, l, a, c, e[p + 3], 16, -722521979);
                    c = _hh(c, h, l, a, e[p + 6], 23, 76029189);
                    a = _hh(a, c, h, l, e[p + 9], 4, -640364487);
                    l = _hh(l, a, c, h, e[p + 12], 11, -421815835);
                    h = _hh(h, l, a, c, e[p + 15], 16, 530742520);
                    c = _hh(c, h, l, a, e[p + 2], 23, -995338651);
                    a = _ii(a, c, h, l, e[p + 0], 6, -198630844);
                    l = _ii(l, a, c, h, e[p + 7], 10, 1126891415);
                    h = _ii(h, l, a, c, e[p + 14], 15, -1416354905);
                    c = _ii(c, h, l, a, e[p + 5], 21, -57434055);
                    a = _ii(a, c, h, l, e[p + 12], 6, 1700485571);
                    l = _ii(l, a, c, h, e[p + 3], 10, -1894986606);
                    h = _ii(h, l, a, c, e[p + 10], 15, -1051523);
                    c = _ii(c, h, l, a, e[p + 1], 21, -2054922799);
                    a = _ii(a, c, h, l, e[p + 8], 6, 1873313359);
                    l = _ii(l, a, c, h, e[p + 15], 10, -30611744);
                    h = _ii(h, l, a, c, e[p + 6], 15, -1560198380);
                    c = _ii(c, h, l, a, e[p + 13], 21, 1309151649);
                    a = _ii(a, c, h, l, e[p + 4], 6, -145523070);
                    l = _ii(l, a, c, h, e[p + 11], 10, -1120210379);
                    h = _ii(h, l, a, c, e[p + 2], 15, 718787259);
                    c = _ii(c, h, l, a, e[p + 9], 21, -343485551);
                    a = (a + b) >>> 0;
                    c = (c + m) >>> 0;
                    h = (h + x) >>> 0;
                    l = (l + w) >>> 0;
                }
                return [a, c, h, l];
            }
            let hashWords = u(inputBytes);
            let hashBytes = wordsToBytes(hashWords);
            return bytesToHex(hashBytes);
        }
        const ByteArrayOutputStream = java.io.ByteArrayOutputStream;
        const ByteArrayInputStream = java.io.ByteArrayInputStream;
        const Bitmap = android.graphics.Bitmap;
        const BitmapFactory = android.graphics.BitmapFactory;
        const Canvas = android.graphics.Canvas;
        try {
            let urlParts = picUrl.split("/");
            let fileName = urlParts[urlParts.length - 1];
            let base64Part = fileName.split(".").slice(0, -1).join(".");
            let decodedString = window0.atob(base64Part);
            let hexResult = customHash(decodedString);
            let hashBytes = [];
            for (let i = 0; i < hexResult.length; i += 2) {
                let byteStr = hexResult.substring(i, i + 2);
                hashBytes.push(parseInt(byteStr, 16));
            }
            let lastByte = hashBytes[hashBytes.length - 1];
            let blockCount = lastByte % 10 + 5;
            let imgBitmap = BitmapFactory.decodeStream(input);
            if (!imgBitmap) {
                return input;
            }
            let width = imgBitmap.getWidth();
            let height = imgBitmap.getHeight();
            let blockHeight = Math.floor(height / blockCount);
            let remainder = height % blockCount;
            let newImgBitmap = Bitmap.createBitmap(width, height, Bitmap.Config.ARGB_8888);
            let canvas = new Canvas(newImgBitmap);
            for (let currentBlock = 0; currentBlock < blockCount; currentBlock++) {
                let sourceY, destY, currentBlockHeight;
                sourceY = height - blockHeight * (currentBlock + 1) - remainder;
                destY = blockHeight * currentBlock;
                if (currentBlock === 0) {
                    currentBlockHeight = blockHeight + remainder;
                } else {
                    destY += remainder;
                    currentBlockHeight = blockHeight;
                }
                if (currentBlockHeight <= 0) {
                    continue;
                }
                if (sourceY < 0) {
                    currentBlockHeight += sourceY;
                    sourceY = 0;
                }
                if (sourceY + currentBlockHeight > height) {
                    currentBlockHeight = height - sourceY;
                }
                if (currentBlockHeight > 0) {
                    let blockBitmap = Bitmap.createBitmap(imgBitmap, 0, sourceY, width, currentBlockHeight);
                    canvas.drawBitmap(blockBitmap, 0, destY, null);
                    blockBitmap.recycle();
                }
            }
            let baos = new ByteArrayOutputStream();
            newImgBitmap.compress(Bitmap.CompressFormat.JPEG, 100, baos);
            imgBitmap.recycle();
            newImgBitmap.recycle();
            return new ByteArrayInputStream(baos.toByteArray());
        }
        catch (e) {
            return input;
        }
    }, picUrl ? picUrl : '');
}
function jsExtraClick(e,n) {
            n=!n?0:n;
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
function convertToSingleLineYaml(yamlText) {
    // 获取当前日期
    function getCurrentDate() {
        var now = new Date();
        var year = now.getFullYear();
        var month = String(now.getMonth() + 1).padStart(2, '0');
        var day = String(now.getDate()).padStart(2, '0');
        return year + '/' + month + '/' + day;
    }
    
    var currentDate = getCurrentDate();

    // 辅助函数：解析键值对
    function parseKeyValue(line) {
        var colonIndex = line.indexOf(':');
        if (colonIndex === -1) return [line.trim(), undefined];
        var key = line.substring(0, colonIndex).trim();
        let value = line.substring(colonIndex + 1).trim();

        // 处理空值
        if (value === '') return [key, undefined];
        // 处理空对象
        if (value === '{}') return [key, {}];
        
        // 处理多行字符串符号（>- 或 | 等）
        if (value.startsWith('>-') || value.startsWith('|') || 
            value.startsWith('>') || value.startsWith('|')) {
            return [key, value];
        }

        // 处理引号包裹的值
        if ((value.startsWith('"') && value.endsWith('"')) ||
            (value.startsWith("'") && value.endsWith("'"))) {
            value = value.substring(1, value.length - 1);
        }

        return [key, value];
    }

    // 辅助函数：格式化值
    function formatValue(key, value) {
        if (value === undefined || value === null) return 'null';
        if (typeof value === 'number') return value;
        if (typeof value === 'boolean') return value.toString();
        
        // 处理空对象
        if (typeof value === 'object' && Object.keys(value).length === 0) {
            return '{}';
        }
        
        // 处理数组
        if (Array.isArray(value)) {
            return `[${value.map(v => formatValue(key, v)).join(', ')}]`;
        }
        
        // 对于name字段，添加日期后缀
        if (key === 'name' && typeof value === 'string') {
            value = value + ' ' + currentDate;
        }
        
        // 对于字符串，如果包含特殊字符则添加引号
        if (typeof value === 'string') {
            // 如果包含多行符号，需要特殊处理
            if (value.startsWith('>-') || value.startsWith('|') || 
                value.startsWith('>') || value.includes('\n')) {
                return `"${value}"`;
            }
            
            // 关键修复：包含 ? & = 等URL特殊字符的必须加引号
            if (value.includes('?') || value.includes('&') || value.includes('=') ||
                value.includes(' ') || value.includes(':') || value.includes('{') || 
                value.includes('}') || value.includes('|') || value.includes('[') ||
                value.includes('🇷') || value.includes('🇨') || value.includes('>') || 
                value.includes('-') || value.includes('/')) {
                return `"${value}"`;
            }
            return value;
        }
        
        // 处理嵌套对象
        if (typeof value === 'object' && value !== null) {
            var nestedEntries = Object.entries(value).map(([nestedKey, nestedValue]) => {
                return `${nestedKey}: ${formatValue(nestedKey, nestedValue)}`;
            }).join(', ');
            return `{${nestedEntries}}`;
        }

        return value;
    }

    // 清理对象，移除空对象属性
    function cleanupObject(obj) {
        const cleaned = {};
        for (var [key, value] of Object.entries(obj)) {
            // 跳过空对象属性
            if (typeof value === 'object' && value !== null && 
                !Array.isArray(value) && Object.keys(value).length === 0) {
                continue;
            }
            cleaned[key] = value;
        }
        return cleaned;
    }

    // 1. 找到第一个 - 的缩进级别
    var lines = yamlText.split('\n');
    let firstDashIndent = -1;
    
    for (var i = 0; i < lines.length; i++) {
        var line = lines[i];
        var trimmedLine = line.trim();
        if (trimmedLine.startsWith('-')) {
            firstDashIndent = line.search(/\S|$/);
            break;
        }
    }

    // 2. 按项目分割（只有与第一个 - 相同缩进的 - 才是新项目）
    let items = [];
    let currentItemLines = [];
    
    for (var i = 0; i < lines.length; i++) {
        var line = lines[i];
        var trimmedLine = line.trim();
        
        // 跳过空行和注释
        if (!trimmedLine || trimmedLine.startsWith('#')) continue;
        
        var currentIndent = line.search(/\S|$/);
        
        if (trimmedLine.startsWith('-') && currentIndent === firstDashIndent) {
            // 这是新项目的开始
            if (currentItemLines.length > 0) {
                items.push(currentItemLines);
            }
            currentItemLines = [line];
        } else {
            // 属于当前项目的行
            currentItemLines.push(line);
        }
    }
    
    // 添加最后一个项目
    if (currentItemLines.length > 0) {
        items.push(currentItemLines);
    }

    let result = [];
    
    // 3. 逐个处理每个项目 - 修复嵌套对象解析
    for (var itemLines of items) {
        let obj = {};
        let stack = [{ obj: obj, indent: -1 }]; // 使用栈来处理嵌套
        
        for (var j = 0; j < itemLines.length; j++) {
            var line = itemLines[j];
            var trimmedLine = line.trim();
            var currentIndent = line.search(/\S|$/);
            
            // 跳过纯注释行
            if (trimmedLine.startsWith('#')) continue;
            
            // 调整栈到正确的嵌套级别
            while (stack.length > 1 && currentIndent <= stack[stack.length - 1].indent) {
                stack.pop();
            }
            
            var currentObj = stack[stack.length - 1].obj;
            
            if (trimmedLine.startsWith('-') && j === 0) {
                // 项目的第一行，解析第一个属性
                var firstProp = trimmedLine.substring(1).trim();
                if (firstProp) {
                    var [key, value] = parseKeyValue(firstProp);
                    if (key && value !== undefined) {
                        currentObj[key] = value;
                    }
                }
            } else if (trimmedLine.includes(':')) {
                var [key, value] = parseKeyValue(trimmedLine);
                
                // 检查下一行是否有更深层次的嵌套
                var hasNestedContent = false;
                if (j + 1 < itemLines.length) {
                    var nextLine = itemLines[j + 1];
                    var nextIndent = nextLine.search(/\S|$/);
                    var nextTrimmed = nextLine.trim();
                    
                    // 下一行有更深的缩进且不是注释，可能包含嵌套内容
                    if (nextIndent > currentIndent && nextTrimmed && 
                        !nextTrimmed.startsWith('#') && nextTrimmed.includes(':')) {
                        hasNestedContent = true;
                    }
                }
                
                if (hasNestedContent) {
                    // 创建新的嵌套对象
                    var nestedObj = {};
                    currentObj[key] = nestedObj;
                    stack.push({ obj: nestedObj, indent: currentIndent });
                } else {
                    // 普通键值对
                    currentObj[key] = value;
                }
            }
        }
        
        // 清理空对象属性
        obj = cleanupObject(obj);
        result.push(obj);
    }

    // 4. 过滤掉不包含 type: 的不完整项目
    result = result.filter(obj => obj.hasOwnProperty('type'));

    // 5. 转换为单行YAML格式
    return result.map(obj => {
        var entries = Object.entries(obj).map(([key, value]) => {
            return `${key}: ${formatValue(key, value)}`;
        }).join(', ');

        return `  - {${entries}}`;
    }).join('\n');
}

function toerji(item, jkdata) {
if(!jkdata.url){
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
        }
        );
        item.extra = extra;
    }
    return item;} else{           try {
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
            return item;}
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
        let title = String(item.name ||item.title||item);
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
function ssyz(img, type){
    const MAP = {
        num: {
            'a': '4', 'b': '6', 'd': '0', 'e': '9', 'g': '9',
            'i': '1', 'l': '1', 'm': '3', 's': '5', 't': '7',
            'o': '0', 'q': '9', 'u': '4', 'z': '2'
        },
        alpha: {
            '4': 'a', '6': 'b', '9': 'q', '1': 'l', '3': 'm',
            '5': 's', '7': 't', '0': 'o', '2': 'z'
        }
    };

    const currentMap = MAP[type] || {};
    
    const ocrResult = request('https://api.nn.ci/ocr/b64/text', {
        method: 'POST',
        headers: {'Content-Type': 'application/json'},
        body: convertBase64Image(img).split(',')[1]
    }).split('')
    const result = [];
    for (let i = 0; i < ocrResult.length; i++) {
        let char = ocrResult[i];
        result.push(currentMap[char] || char);
    }
    return result.join('')
}
function linkPages(d,pages,host) {
                    [Array.from({
                        length: pages
                    }, (_, i) => i + 1).join('&')].forEach((item, index, data) => {
                        classTop(index, item, host, d, 0, 0, 'multiPages', 'scroll_button');
                    });
                }
function getDarkColor() {
            let hue;
            do {
                hue = Math.floor(Math.random() * 360);
            } while (hue > 200 && hue < 260); // 跳过蓝色区间

            const saturation = 80 + Math.floor(Math.random() * 20); // 饱和度80-100%
            const lightness = 25 + Math.floor(Math.random() * 35); // 明度25-60%

            // HSL转RGB
            const c = (1 - Math.abs(2 * lightness / 100 - 1)) * saturation / 100;
            const x = c * (1 - Math.abs(((hue / 60) % 2) - 1));
            const m = lightness / 100 - c / 2;

            let r, g, b;
            if (hue < 60)[r, g, b] = [c, x, 0]; // 红-黄区间
            else if (hue < 120)[r, g, b] = [x, c, 0]; // 黄-绿区间
            else if (hue < 180)[r, g, b] = [0, c, x]; // 绿-青区间
            else if (hue < 200)[r, g, b] = [0, x, c]; // 青区间（接近蓝）
            else if (hue < 260)[r, g, b] = [x, 0, c]; // 这段不会执行
            else [r, g, b] = [c, 0, x]; // 紫-红区间

            // RGB转HEX
            const toHex = (n) => Math.round((n + m) * 255).toString(16).padStart(2, '0');
            return `#${toHex(r)}${toHex(g)}${toHex(b)}`;
        }
function safePath(str) {
  return String(str).replace(/https?:\/\//g, '').replace(/[<>:"|?*\/\\]/g, '_');
}
function getdTemp(d, dTemp, _chchePath) {
    d = JSON.parse(fetch(_chchePath) || "[]");
    if (d.length != 0) {
        if (MY_RULE.title == "聚阅" && d[0].title == "🔍" && !/x5toerji|sarr|google|baidu/.test(JSON.stringify(d[0]))) {
            d.splice(0, 1);
        }
      if (MY_RULE.title == "聚阅√" && d[0].title != "🔍"&&!/multiPages/.test(JSON.stringify(d))) {
            d.unshift({"title":"🔍","url":"(\n(r) => {\n    putVar(\"keyword\", input);\n    return \"hiker://search?rule=\" + r + \"&s=\" + input;\n}\n)(\"聚阅√\")","desc":"搜索你想要的...","col_type":"input","extra":{"defaultValue":""}});
        }
        dTemp = d.concat(dTemp);
if (MY_RULE.title == "聚阅√"){
dTemp=JSON.parse(JSON.stringify(dTemp).replace(/config.聚阅/g,'config.依赖'));
}else if (MY_RULE.title == "聚阅"){
dTemp=JSON.parse(JSON.stringify(dTemp).replace(/config.依赖/g,'config.聚阅'));
}
    }
    return dTemp.slice();
}
function getHtml(url, headers, mode, proxy) {
    let html = getMyVar(url);
    if (!html || html.includes('error code: 1015')) {
        const decodedUrl = decodeURIComponent(url);
        const chinesePattern = /[\u3040-\u309F\u30A0-\u30FF\u4E00-\u9FFF\u3400-\u4DBF\uF900-\uFAFF\uAC00-\uD7AF]/;
        if (proxy && !chinesePattern.test(decodedUrl)) {
            urlTrue = url.startsWith('https://wdkj.eu.org/') ? url.replace('?', '%3f') : 'https://wdkj.eu.org/' + url.replace('?', '%3f');
        } else if (proxy && chinesePattern.test(decodedUrl)) {
            toast('中文网址需挂梯子~');
			urlTrue=url;
        } else if (url.startsWith('https://wdkj.eu.org/') && chinesePattern.test(decodedUrl)) {
            urlTrue=decodeURIComponent(url.replace('https://wdkj.eu.org/',''));
        }else{
            urlTrue = url;
        }
        if (mode && mode == 1) html = request(urlTrue, headers || {});
        else if (mode && mode == 2) html = fetchCodeByWebView(urlTrue);
        else html = fetchPC(urlTrue, headers || {});
        if (html &&!/error code: 1015|__cf_chl_tk|cf-error-details/.test(html)) putMyVar(url, html);
    }
    return html;
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
    if (typeof(str)== 'object') {
        str = str.toString();
        str=str.substring(1, str.length - 1);
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
                    url: 'https://www.baidu.com/s?wd=' + getVar('keyword', '').trim()+ '%20site%3A' + parse.host.split('/').at(-1) + '&pn=0',
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
    if (typeof(str)== 'object') {
        str = str.toString();
        str=str.substring(1, str.length - 1);
    } else if (typeof(str) == 'string' && str.startsWith('/')) {
        str = str.substring(1, str.length - 1);
    }
    d.push({
        title: '🔍',
        url: $.toString((str, parse) => {
            putVar('keyword', input);log('https://www.google.com.hk/search?q=' + getVar('keyword', '').trim() + '+site:' + parse.host.replace(/https?:\/\//, '') + '&start=0');
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
                        urlInterceptor: $.toString((str, parse) => { log('___:::' + JSON.stringify(new Date()).split(':').at(-1));
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
    } else if (/aliyundrive|alipan|quark|uc\./.test(url)) {
        //url = "hiker://page/aliyun?page=fypage&rule=云盘君.简&realurl=" + url;
        if (!依赖) 依赖 = 'https://codeberg.org/src48597962/hk/raw/branch/Ju/SrcJu.js';
        require(依赖.match(/http(s)?:\/\/.*\//)[0] + 'SrcParseS.js');
        return SrcParseS.聚阅(url);
    } else if (/(thunder|xunlei|ed2k:|bt:|ftp:|\.torrent|magnet)/.test(url)) {
        if (url.includes('thunder')) {
            url = base64Decode(url.split('//')[1]);
        }
        return "hiker://page/diaoyong?rule=迅雷&page=fypage#" + url;
    } else if (/cloud\.189\.cn|content\.21cn\.com/.test(url)) {
        return "hiker://page/diaoyong?rule=天翼网盘&realurl=" + encodeURIComponent(url)
    } else if (/lanzou/.test(url)) {
        return "hiker://page/diaoyong?rule=蓝奏云盘&page=fypage&realurl=" + encodeURIComponent(url);
    } else if (/123.*?(com|cn)/.test(url)) {
        return "hiker://page/diaoyong?rule=123云盘&page=fypage&realurl=" + encodeURIComponent(url);
    } else if (/yun\.139\.com/.test(url)) {
        return "hiker://page/diaoyong?rule=移动云盘&page=fypage&realurl=" + encodeURIComponent(url);
    }  else {
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

function updateJu(title,record) {
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
						record=record?record:parse['更新说明'];
                        log('verNew:' + verNew);
                        let pathJiekou = 'hiker://files/rules/Src/Juyue/jiekou.json';
                        eval('let jsonJiekou =' + (fetchPC(pathJiekou)));
                        for (let k in jsonJiekou) {
                            if (jsonJiekou[k].name.includes('🐹')&&jsonJiekou[k].name.includes(title)) {
                                var verLocal = jsonJiekou[k].version || '';
                                log('verLocal:' + verLocal);
                                var url = jsonJiekou[k].url;
                                if (verNew > verLocal) {
jsonJiekou[k].version=verNew;writeFile(pathJiekou, JSON.stringify(jsonJiekou));
                                    writeFile(url, codeNew);
                                    const hikerPop = $.require("https://gitee.com/mistywater/hiker_info/raw/master/Popup.js");
                                   record?hikerPop.updateRecordsBottom(record):'';
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

function yanzhengd(d, str, url, host, a,ua) {
    d.push({
        title: '人机验证',
        url: $('hiker://empty').rule((str, url, t, a,ua) => {
            var d = [];
            d.push({
                col_type: 'x5_webview_single',
                url: url,
                desc: 'list&&screen',
                extra: {
                    ua: !ua?MOBILE_UA:PC_UA,
                    showProgress: false,
                    js: $.toString((str, url, t, a,ua) => {
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
                    }, str, url, t, a,ua)
                }
            });
            return setResult(d);
        }, str, url, host, a,ua),
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
            title: index == 0 ? (it.startsWith('http') ? '⬅️' + titleLast : '⬅️没有了') :  '➡️'+titleNext,
            url: $('#noLoading#').lazyRule((url, host, index, url1) => {
                if(url){putMyVar(host + 'next', url);
                putMyVar(host + 'isNextUrl', '1');
                refreshPage();}
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
            url: urlBuilder(k) // 直接调用函数获取URL
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
    // 统一转换为小写，避免大小写影响判断
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
    }  else if (link.includes("magnet")) {
        return "[磁力]";
    } else {
        return "[未知网盘]";
    }
}

function imgCloudStorage(link) {
    // 统一转换为小写，避免大小写影响判断
    link = link.toLowerCase();
    if (/magnet|磁力|磁链/.test(link)) {
        return "https://pp.myapp.com/ma_icon/0/icon_53952947_1677658847/256";
    } else if(/pikpak/.test(link)) {
        return "https://blog.mypikpak.com/wp-content/uploads/2023/08/512.png";
    }else if(/pan.baidu.com|baidupcs.com|百度(网|云)盘|^baidu$|xiongdipan/.test(link)) {
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
    }   else if (/移动|139|mobile/.test(link)) {
        return "https://bkimg.cdn.bcebos.com/pic/58ee3d6d55fbb2fb4316d9f6261e37a4462308f77680";
    }  else if (/123|123(网|云)盘|^115$/.test(link)) {
        return "https://pp.myapp.com/ma_icon/0/icon_54190090_1767233011/256";
    }else {
        return "https://pp.myapp.com/ma_icon/0/icon_251416_1627666026/256";
    }
}

function sourceJump(d, arr, blank, changeSource) {
    let info = storage0.getMyVar('一级源接口信息') || jkdata;
    if (arr.length > 1) {
        arr.forEach((item, index) => {
            let title=item.split('@')[0].replace(/H-|✈️|🔞|🐹/g, '');
            d.push({
                title: info.name == item.split('@')[0]?title.color('fff'):title,
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
    var str =  '#' + (((Math.random() * 0x1000000 << 0).toString(16)).substr(-6)).padStart(6, ‌Math.ceil‌(Math.random() * 16).toString(16));
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
        if (num == '❶') {
            return strongR(num, 'FF2244');
        } else if (num == '❷') {
            return strongR(num, 'FF6633');
        } else if (num == '❸') {
            return strongR(num, 'FFBB33');
        } else {
            return strongR(num, '333333');
        }
    } else if (r == 1) {
        if (num == '❶') {
            return strong(num, 'FF2244');
        } else if (num == '❷') {
            return strong(num, 'FF6633');
        } else if (num == '❸') {
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
    timestamp=+((timestamp+'').padEnd(13,'0'));
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

        // 提取数字部分
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
        if (c.公共||c.parse) {
            lazy = $('').lazyRule((c.公共||c.parse).解析, (c.公共||c.parse), '', (c.公共||c.parse).host);
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
            if (c.公共||c.parse) {
            lazy = $('').lazyRule((c.公共||c.parse).解析, (c.公共||c.parse), '', (c.公共||c.parse).host);
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

function extraPic(host, page, pages, ctype, hiker, _chchePath,imgdec) {if(!_chchePath) _chchePath='';
    if (!ctype) var ctype = '';
    if (!hiker || hiker == '') var hiker = '1';
    var 类型 = ["movie_1", "movie_2", "movie_3", "movie_3_marquee", "pic_1", "pic_2", "pic_3", "pic_1_full", "pic_1_center", "pic_1_card", "pic_2_card", "pic_3_square", "card_pic_1", "card_pic_2", "card_pic_3", "avatar", "card_pic_3_center", "icon_1_left_pic"];
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
            js: $.toString((host, arr, num,pages) => {
                return $(arr, 3, '选择页码').select((host, num,pages) => {
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
                            if(input * 1 + k * 1<=pages){arr1.push(input * 1 + k * 1);}
                        }
                        return $(arr1, 3, '选择页码').select((host) => {
                            putMyVar(host + 'page', input);
putMyVar('isMoveto', '1');
                            refreshPage(false);
                            return 'hiker://empty';
                        }, host);
                    }
                }, host, num,pages);
            }, host, arr, num,pages),
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
            js: $.toString((host,_chchePath) => {
                writeFile(_chchePath, '');clearMyVar(host+'page');
                refreshPage(false);
            },host,_chchePath),
        });
    }
    longClick.unshift({
        title: getItem(host + 'picsMode', '0') == 0 ? '漫画模式' : '图文模式',
        js: $.toString((host,_chchePath) => {
	    writeFile(_chchePath, '');
            if (getItem(host + 'picsMode', '0') == 0) {
                setItem(host + 'picsMode', '1');
                refreshPage(false);
            } else {
                setItem(host + 'picsMode', '0');
                refreshPage(false);
            }
        }, host,_chchePath)
    });
    var extra = $.toString((host, hiker, ctype, longClick, imgdec) => ({
    chapterList: hiker ? 'hiker://files/_cache/chapterList.txt' : chapterList,
    info: {
        bookName: MY_URL.split('/')[2],
        ruleName: 'photo',
        bookTopPic: 'https://api.xinac.net/icon/?url=' + host,
        decode: imgdec? $.type(imgdec) == "function" ? $.toString((imgdec) => {
                                    let imgDecrypt = imgdec;
                                    return imgDecrypt();
                                }, imgdec) : imgdec : "",
        parseCode: downloadlazy,
        defaultView: '1'
    },
    longClick: longClick,
}), host, hiker, ctype, longClick, imgdec);
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

function pageMoveto(host, page, ctype, pages, _chchePath) {if(!_chchePath) _chchePath='';
    if (!ctype) {
        var ctype = '';
    }
    var longClick = [{
        title: '样式',
        js: $.toString((host, ctype, _chchePath) => {
            var 类型 = ["movie_1", "movie_2", "movie_3", "movie_3_marquee", "pic_1", "pic_2", "pic_3", "pic_1_full", "pic_1_center", "pic_1_card", "pic_2_card", "pic_3_square", "card_pic_1", "card_pic_2", "card_pic_3", "avatar", "card_pic_3_center", "icon_1_left_pic"];
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
            js: $.toString((host, arr, num,pages) => {
                return $(arr, 3, '选择页码').select((host, num,pages) => {
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
                            if(input * 1 + k * 1<=pages){arr1.push(input * 1 + k * 1);}
                        }
                        return $(arr1, 3, '选择页码').select((host) => {
                            putMyVar(host + 'page', input);
putMyVar('isMoveto', '1');
                            refreshPage(false);
                            return 'hiker://empty';
                        }, host);
                    }
                }, host, num,pages);
            }, host, arr, num,pages),
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
            js: $.toString((host,_chchePath) => {
                writeFile(_chchePath, '');clearMyVar(host+'page');
                refreshPage(false);
            }, host,_chchePath),
        });
    }
    longClick.unshift({
        title: getItem(host + 'picsMode', '0') == 0 ? '漫画模式' : '图文模式',
        js: $.toString((host,_chchePath) => {
	    writeFile(_chchePath, '');
            if (getItem(host + 'picsMode', '0') == 0) {
                setItem(host + 'picsMode', '1');
                refreshPage(false);
            } else {
                setItem(host + 'picsMode', '0');
                refreshPage(false);
            }
        }, host,_chchePath)
    });
    return {
        longClick: longClick
    };
}

function searchMain(page, d, desc,MY_PAGE) {
   if (page == 1 || getMyVar('isMoveto', '0') == 1 ||MY_PAGE ==1|| MY_PAGE == getMyVar('MY_PAGE')) {
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

function classTop(index, data, host, d, mode, v, c, f, len, start, end,bgcolor,bgcolorSelected,textcolor) {
    if (!mode) mode = 0;
    if (!v) v = 0;
    if (!c) c = 'c';
    if (!f) f = 'scroll_button';
    if (!len) len = 20;
    if (bgcolor) bgcolor=('#'+bgcolor).replace('##','');
    if (bgcolorSelected) bgcolorSelected=('#'+bgcolorSelected).replace('##','');
    if(!textcolor) textcolor='#000000';
    let isDarkMode = getItem('darkMode', '深色模式') === '浅色白字模式';
    let isInRange = index >= start && index <= end;
    let c_title = /\{/.test(JSON.stringify(data)) ? data.title.split('&') : data.split('&');
    let c_id = /\{/.test(JSON.stringify(data)) ? (!data.id ? c_title : data.id === '@@@' ? data.title.replace(/^.*?&/, '&').split('&') : data.id.split('&')) : null;
    let c_img = storage0.getMyVar(host + 'picsClass', []).length != 0 ? storage0.getMyVar(host + 'picsClass') : (data.img ? data.img.split('&') : []);
    c_title.forEach((title, index_c) => {title=title.replace(/＆＆/g,'&');
        let isSelected = index_c == getMyVar(host + c + 'index' + index, mode || index == v ? '0' : '-1');
        let titleStyled = isSelected ?
            strong(title, isInRange ? 'FFFF00' : 'FF6699') :
             isInRange ?
            color(title, 'FFFFFF') :
            color(title, textcolor);
        d.push({
            title: titleStyled,
            img: c_img.length != 0 ? c_img[index_c] : '',
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
                backgroundColor: isInRange 
  ? (isSelected ? bgcolorSelected : bgcolor) || getRandomColor(getItem('darkMode'))
  : '',
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



function downPic() {
    var s = `if (list.length != 0) {
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
                             url: $(pd(item, 分类链接) + '#noLoading#').lazyRule((params, host) => {
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
/*function rulePage(type, page) {
     return $("hiker://empty#noRecordHistory##noHistory#" + (page ? "?page=fypage" : "")).rule((type, r) => {
         require(r);
         getYiData(type);
     }, type, config.依赖);
 }*/
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

function ver() {
    return;
}

function getRandomArray(arr, num) {
    const shuffled = arr.slice(); // 复制原数组
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

/*function toerji(item,sname,stype) {
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
        }*/
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
    if (s1 == 'CBC' && !iv) iv = key;

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

function urla(u, host) {
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

function sp(cc) {
cc = cc.replace(/&#x([0-9a-fA-F]+);/g, function(match, hex) {
        return String.fromCharCode(parseInt(hex, 16));
    });
cc = cc.replace(/\\u([0-9a-fA-F]{4})/g, function(match, hex) {
        return String.fromCharCode(parseInt(hex, 16));
    });
cc = cc.replace(/著名|显著|昭著|卓著|著作|著述|著书|著者|原著|译著|论著|巨著|遗著|名著|拙著|新著|专著|合著|编著|撰著|著称|著录|著闻|土著/g, m => m.replace(/著/g, '&#33879;'));
cc = cc.replace(/乾坤|乾隆/g, m => m.replace(/乾/g, '&#20094;'));
cc = cc.replace(/伶俐/g, m => m.replace(/俐/g, '&#20432;'));
    var str = '',
        ss = JTPYStr(),
        tt = FTPYStr();
    for (var i = 0; i < cc.length; i++) {
        if (cc.charCodeAt(i) > 10000 && tt.indexOf(cc.charAt(i)) != -1) str += ss.charAt(tt.indexOf(cc.charAt(i)));
        else str += cc.charAt(i);
    }
str = str.replace(/浮沈|昏沈|深沈|沈淀|沈浮|沈厚|沈昏|沈积|沈寂|沈降|沈静|沈疴|沈李|沈落|沈脉|沈没|沈闷|沈密|沈眠|沈默|沈溺|沈潜|沈沈|沈睡|沈思|沈痛|沈头|沈下|沈陷|沈香|沈箱|沈心|沈毅|沈吟|沈鱼|沈郁|沈冤|沈灶|沈渣|沈着|沈重|沈舟|沈醉|石沈|太沈|下沈|星沈|阴沈|鱼沈|真沈|珠沈/g, m => m.replace(/沈/g, '沉'));
str = str.replace(/混合&#33879;/g,'混合着');
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
    return '三迹鉴锈响谷秾汇锏历尝肴娴姜叹干厘妆台咨净淡脊复卷托并郁郁利着舍胡尽获辟采炼周致闲线表写泄布系蜜臀面吞嫩脱呆内淫荡与征脑板家钟只淡骂猛松绣脏钻墙发余赞制艳欲泛签奸恶你侄占译发绝铺系苏雇回仆里锕皑蔼碍爱嗳嫒瑷暧霭谙铵鹌肮袄奥媪骜鳌坝罢钯摆败呗颁办绊钣帮绑镑谤剥饱宝报鲍鸨龅辈贝钡狈备惫鹎贲锛绷笔毕毙币闭荜哔滗铋筚跸边编贬变辩辫苄缏笾标骠飑飙镖镳鳔鳖别瘪濒滨宾摈傧缤槟殡膑镔髌鬓饼禀拨钵铂驳饽钹鹁补钸财参蚕残惭惨灿骖黪苍舱仓沧厕侧册测恻层诧锸侪钗搀掺蝉馋谗缠铲产阐颤冁谄谶蒇忏婵骣觇禅镡场尝长偿肠厂畅伥苌怅阊鲳钞车彻砗尘陈衬伧谌榇碜龀撑称惩诚骋枨柽铖铛痴迟驰耻齿炽饬鸱冲冲虫宠铳畴踌筹绸俦帱雠橱厨锄雏础储触处刍绌蹰传钏疮闯创怆锤缍纯鹑绰辍龊辞词赐鹚聪葱囱从丛苁骢枞凑辏蹿窜撺错锉鹾达哒鞑带贷骀绐担单郸掸胆惮诞弹殚赕瘅箪当挡党荡档谠砀裆捣岛祷导盗焘灯邓镫敌涤递缔籴诋谛绨觌镝颠点垫电巅钿癫钓调铫鲷谍叠鲽钉顶锭订铤丢铥东动栋冻岽鸫窦犊独读赌镀渎椟牍笃黩锻断缎簖兑队对怼镦吨顿钝炖趸夺堕铎鹅额讹恶饿谔垩阏轭锇锷鹗颚颛鳄诶儿尔饵贰迩铒鸸鲕发罚阀珐矾钒烦贩饭访纺钫鲂飞诽废费绯镄鲱纷坟奋愤粪偾丰枫锋风疯冯缝讽凤沣肤辐抚辅赋复负讣妇缚凫驸绂绋赙麸鲋鳆钆该钙盖赅杆赶秆赣尴擀绀冈刚钢纲岗戆镐睾诰缟锆搁鸽阁铬个纥镉颍给亘赓绠鲠龚宫巩贡钩沟苟构购够诟缑觏蛊顾诂毂钴锢鸪鹄鹘剐挂鸹掴关观馆惯贯诖掼鹳鳏广犷规归龟闺轨诡贵刽匦刿妫桧鲑鳜辊滚衮绲鲧锅国过埚呙帼椁蝈铪骇韩汉阚绗颉号灏颢阂鹤贺诃阖蛎横轰鸿红黉讧荭闳鲎壶护沪户浒鹕哗华画划话骅桦铧怀坏欢环还缓换唤痪焕涣奂缳锾鲩黄谎鳇挥辉毁贿秽会烩汇讳诲绘诙荟哕浍缋珲晖荤浑诨馄阍获货祸钬镬击机积饥迹讥鸡绩缉极辑级挤几蓟剂济计记际继纪讦诘荠叽哜骥玑觊齑矶羁虿跻霁鲚鲫夹荚颊贾钾价驾郏浃铗镓蛲歼监坚笺间艰缄茧检碱硷拣捡简俭减荐槛鉴践贱见键舰剑饯渐溅涧谏缣戋戬睑鹣笕鲣鞯将浆蒋桨奖讲酱绛缰胶浇骄娇搅铰矫侥脚饺缴绞轿较挢峤鹪鲛阶节洁结诫届疖颌鲒紧锦仅谨进晋烬尽劲荆茎卺荩馑缙赆觐鲸惊经颈静镜径痉竞净刭泾迳弪胫靓纠厩旧阄鸠鹫驹举据锯惧剧讵屦榉飓钜锔窭龃鹃绢锩镌隽觉决绝谲珏钧军骏皲开凯剀垲忾恺铠锴龛闶钪铐颗壳课骒缂轲钶锞颔垦恳龈铿抠库裤喾块侩郐哙脍宽狯髋矿旷况诓诳邝圹纩贶亏岿窥馈溃匮蒉愦聩篑阃锟鲲扩阔蛴蜡腊莱来赖崃徕涞濑赉睐铼癞籁蓝栏拦篮阑兰澜谰揽览懒缆烂滥岚榄斓镧褴琅阆锒捞劳涝唠崂铑铹痨乐鳓镭垒类泪诔缧篱狸离鲤礼丽厉励砾历沥隶俪郦坜苈莅蓠呖逦骊缡枥栎轹砺锂鹂疠粝跞雳鲡鳢俩联莲连镰怜涟帘敛脸链恋炼练蔹奁潋琏殓裢裣鲢粮凉两辆谅魉疗辽镣缭钌鹩猎临邻鳞凛赁蔺廪檩辚躏龄铃灵岭领绫棂蛏鲮馏刘浏骝绺镏鹨龙聋咙笼垄拢陇茏泷珑栊胧砻楼娄搂篓偻蒌喽嵝镂瘘耧蝼髅芦卢颅庐炉掳卤虏鲁赂禄录陆垆撸噜闾泸渌栌橹轳辂辘氇胪鸬鹭舻鲈峦挛孪滦乱脔娈栾鸾銮抡轮伦仑沦纶论囵萝罗逻锣箩骡骆络荦猡泺椤脶镙驴吕铝侣屡缕虑滤绿榈褛锊呒妈玛码蚂马骂吗唛嬷杩买麦卖迈脉劢瞒馒蛮满谩缦镘颡鳗猫锚铆贸么没镁门闷们扪焖懑钔锰梦眯谜弥觅幂芈谧猕祢绵缅渑腼黾庙缈缪灭悯闽闵缗鸣铭谬谟蓦馍殁镆谋亩钼呐钠纳难挠脑恼闹铙讷馁内拟腻铌鲵撵辇鲶酿鸟茑袅聂啮镊镍陧蘖嗫颟蹑柠狞宁拧泞苎咛聍钮纽脓浓农侬哝驽钕诺傩疟欧鸥殴呕沤讴怄瓯盘蹒庞抛疱赔辔喷鹏纰罴铍骗谝骈飘缥频贫嫔苹凭评泼颇钋扑铺朴谱镤镨栖脐齐骑岂启气弃讫蕲骐绮桤碛颀颃鳍牵钎铅迁签谦钱钳潜浅谴堑佥荨悭骞缱椠钤枪呛墙蔷强抢嫱樯戗炝锖锵镪羟跄锹桥乔侨翘窍诮谯荞缲硗跷窃惬锲箧钦亲寝锓轻氢倾顷请庆揿鲭琼穷茕蛱巯赇虮鳅趋区躯驱龋诎岖阒觑鸲颧权劝诠绻辁铨却鹊确阕阙悫让饶扰绕荛娆桡热韧认纫饪轫荣绒嵘蝾缛铷颦软锐蚬闰润洒萨飒鳃赛伞毵糁丧骚扫缫涩啬铯穑杀刹纱铩鲨筛晒酾删闪陕赡缮讪姗骟钐鳝墒伤赏垧殇觞烧绍赊摄慑设厍滠畲绅审婶肾渗诜谂渖声绳胜师狮湿诗时蚀实识驶势适释饰视试谥埘莳弑轼贳铈鲥寿兽绶枢输书赎属术树竖数摅纾帅闩双谁税顺说硕烁铄丝饲厮驷缌锶鸶耸怂颂讼诵擞薮馊飕锼苏诉肃谡稣虽随绥岁谇孙损笋荪狲缩琐锁唢睃獭挞闼铊鳎台态钛鲐摊贪瘫滩坛谭谈叹昙钽锬顸汤烫傥饧铴镗涛绦讨韬铽腾誊锑题体屉缇鹈阗条粜龆鲦贴铁厅听烃铜统恸头钭秃图钍团抟颓蜕饨脱鸵驮驼椭箨鼍袜娲腽弯湾顽万纨绾网辋韦违围为潍维苇伟伪纬谓卫诿帏闱沩涠玮韪炜鲔温闻纹稳问阌瓮挝蜗涡窝卧莴龌呜钨乌诬无芜吴坞雾务误邬庑怃妩骛鹉鹜锡牺袭习铣戏细饩阋玺觋虾辖峡侠狭厦吓硖鲜纤贤衔闲显险现献县馅羡宪线苋莶藓岘猃娴鹇痫蚝籼跹厢镶乡详响项芗饷骧缃飨萧嚣销晓啸哓潇骁绡枭箫协挟携胁谐写泻谢亵撷绁缬锌衅兴陉荥凶汹锈绣馐鸺虚嘘须许叙绪续诩顼轩悬选癣绚谖铉镟学谑泶鳕勋询寻驯训讯逊埙浔鲟压鸦鸭哑亚讶垭娅桠氩阉烟盐严岩颜阎艳厌砚彦谚验厣赝俨兖谳恹闫酽魇餍鼹鸯杨扬疡阳痒养样炀瑶摇尧遥窑谣药轺鹞鳐爷页业叶靥谒邺晔烨医铱颐遗仪蚁艺亿忆义诣议谊译异绎诒呓峄饴怿驿缢轶贻钇镒镱瘗舣荫阴银饮隐铟瘾樱婴鹰应缨莹萤营荧蝇赢颖茔莺萦蓥撄嘤滢潆璎鹦瘿颏罂哟拥佣痈踊咏镛优忧邮铀犹诱莸铕鱿舆鱼渔娱与屿语狱誉预驭伛俣谀谕蓣嵛饫阈妪纡觎欤钰鹆鹬龉鸳渊辕园员圆缘远橼鸢鼋约跃钥粤悦阅钺郧匀陨运蕴酝晕韵郓芸恽愠纭韫殒氲杂灾载攒暂赞瓒趱錾赃脏驵凿枣责择则泽赜啧帻箦贼谮赠综缯轧铡闸栅诈斋债毡盏斩辗崭栈战绽谵张涨帐账胀赵诏钊蛰辙锗这谪辄鹧贞针侦诊镇阵浈缜桢轸赈祯鸩挣睁狰争帧症郑证诤峥钲铮筝织职执纸挚掷帜质滞骘栉栀轵轾贽鸷蛳絷踬踯觯钟终种肿众锺诌轴皱昼骤纣绉猪诸诛烛瞩嘱贮铸驻伫槠铢专砖转赚啭馔颞桩庄装妆壮状锥赘坠缀骓缒谆准浊诼镯兹资渍谘缁辎赀眦锱龇鲻踪总纵偬邹诹驺鲰诅组镞钻缵躜鳟翱并卜丑淀斗范干皋柜后伙秸杰诀夸里凌么霉捻凄扦圣尸抬涂洼喂污锨咸蝎彝涌游吁御愿岳云灶扎札筑于志注讠谫郄凼垅垴埯埝苘荬荮莜莼揸吣咝谑幞岙犸狍余馇馓馕愣怵懔溆滟混漤潴甯纟绔绱珉枧桊槔橥轱轷赍肷胨飚砜眍钚钷铘铞锃锍锎';
}

function FTPYStr() {
    return '叁蹟鑑鏽嚮穀穠彙鐧曆嚐餚嫻薑歎乾釐粧檯谘淨澹嵴複捲託併鬰鬱俐著捨鬍儘穫闢採鍊週緻閒綫錶寫洩佈繫藌臋麵呑嫰脫獃內婬盪與徵脳闆傢锺隻澹駡勐鬆綉髒鑽牆髮馀讚製豔慾氾籤姦噁妳姪佔訳発絶舖係甦僱迴僕裡錒皚藹礙愛噯嬡璦曖靄諳銨鵪骯襖奧媼驁鰲壩罷鈀擺敗唄頒辦絆鈑幫綁鎊謗剝飽寶報鮑鴇齙輩貝鋇狽備憊鵯賁錛繃筆畢斃幣閉蓽嗶潷鉍篳蹕邊編貶變辯辮芐緶籩標驃颮飆鏢鑣鰾鱉別癟瀕濱賓擯儐繽檳殯臏鑌髕鬢餅稟撥缽鉑駁餑鈸鵓補鈽財參蠶殘慚慘燦驂黲蒼艙倉滄廁側冊測惻層詫鍤儕釵攙摻蟬饞讒纏鏟產闡顫囅諂讖蕆懺嬋驏覘禪鐔場嘗長償腸廠暢倀萇悵閶鯧鈔車徹硨塵陳襯傖諶櫬磣齔撐稱懲誠騁棖檉鋮鐺癡遲馳恥齒熾飭鴟沖衝蟲寵銃疇躊籌綢儔幬讎櫥廚鋤雛礎儲觸處芻絀躕傳釧瘡闖創愴錘綞純鶉綽輟齪辭詞賜鶿聰蔥囪從叢蓯驄樅湊輳躥竄攛錯銼鹺達噠韃帶貸駘紿擔單鄲撣膽憚誕彈殫賧癉簞當擋黨蕩檔讜碭襠搗島禱導盜燾燈鄧鐙敵滌遞締糴詆諦綈覿鏑顛點墊電巔鈿癲釣調銚鯛諜疊鰈釘頂錠訂鋌丟銩東動棟凍崠鶇竇犢獨讀賭鍍瀆櫝牘篤黷鍛斷緞籪兌隊對懟鐓噸頓鈍燉躉奪墮鐸鵝額訛惡餓諤堊閼軛鋨鍔鶚顎顓鱷誒兒爾餌貳邇鉺鴯鮞發罰閥琺礬釩煩販飯訪紡鈁魴飛誹廢費緋鐨鯡紛墳奮憤糞僨豐楓鋒風瘋馮縫諷鳳灃膚輻撫輔賦復負訃婦縛鳧駙紱紼賻麩鮒鰒釓該鈣蓋賅桿趕稈贛尷搟紺岡剛鋼綱崗戇鎬睪誥縞鋯擱鴿閣鉻個紇鎘潁給亙賡綆鯁龔宮鞏貢鉤溝茍構購夠詬緱覯蠱顧詁轂鈷錮鴣鵠鶻剮掛鴰摑關觀館慣貫詿摜鸛鰥廣獷規歸龜閨軌詭貴劊匭劌媯檜鮭鱖輥滾袞緄鯀鍋國過堝咼幗槨蟈鉿駭韓漢闞絎頡號灝顥閡鶴賀訶闔蠣橫轟鴻紅黌訌葒閎鱟壺護滬戶滸鶘嘩華畫劃話驊樺鏵懷壞歡環還緩換喚瘓煥渙奐繯鍰鯇黃謊鰉揮輝毀賄穢會燴匯諱誨繪詼薈噦澮繢琿暉葷渾諢餛閽獲貨禍鈥鑊擊機積饑跡譏雞績緝極輯級擠幾薊劑濟計記際繼紀訐詰薺嘰嚌驥璣覬齏磯羈蠆躋霽鱭鯽夾莢頰賈鉀價駕郟浹鋏鎵蟯殲監堅箋間艱緘繭檢堿鹼揀撿簡儉減薦檻鑒踐賤見鍵艦劍餞漸濺澗諫縑戔戩瞼鶼筧鰹韉將漿蔣槳獎講醬絳韁膠澆驕嬌攪鉸矯僥腳餃繳絞轎較撟嶠鷦鮫階節潔結誡屆癤頜鮚緊錦僅謹進晉燼盡勁荊莖巹藎饉縉贐覲鯨驚經頸靜鏡徑痙競凈剄涇逕弳脛靚糾廄舊鬮鳩鷲駒舉據鋸懼劇詎屨櫸颶鉅鋦窶齟鵑絹錈鐫雋覺決絕譎玨鈞軍駿皸開凱剴塏愾愷鎧鍇龕閌鈧銬顆殼課騍緙軻鈳錁頷墾懇齦鏗摳庫褲嚳塊儈鄶噲膾寬獪髖礦曠況誆誑鄺壙纊貺虧巋窺饋潰匱蕢憒聵簣閫錕鯤擴闊蠐蠟臘萊來賴崍徠淶瀨賚睞錸癩籟藍欄攔籃闌蘭瀾讕攬覽懶纜爛濫嵐欖斕鑭襤瑯閬鋃撈勞澇嘮嶗銠鐒癆樂鰳鐳壘類淚誄縲籬貍離鯉禮麗厲勵礫歷瀝隸儷酈壢藶蒞蘺嚦邐驪縭櫪櫟轢礪鋰鸝癘糲躒靂鱺鱧倆聯蓮連鐮憐漣簾斂臉鏈戀煉練蘞奩瀲璉殮褳襝鰱糧涼兩輛諒魎療遼鐐繚釕鷯獵臨鄰鱗凜賃藺廩檁轔躪齡鈴靈嶺領綾欞蟶鯪餾劉瀏騮綹鎦鷚龍聾嚨籠壟攏隴蘢瀧瓏櫳朧礱樓婁摟簍僂蔞嘍嶁鏤瘺耬螻髏蘆盧顱廬爐擄鹵虜魯賂祿錄陸壚擼嚕閭瀘淥櫨櫓轤輅轆氌臚鸕鷺艫鱸巒攣孿灤亂臠孌欒鸞鑾掄輪倫侖淪綸論圇蘿羅邏鑼籮騾駱絡犖玀濼欏腡鏍驢呂鋁侶屢縷慮濾綠櫚褸鋝嘸媽瑪碼螞馬罵嗎嘜嬤榪買麥賣邁脈勱瞞饅蠻滿謾縵鏝顙鰻貓錨鉚貿麼沒鎂門悶們捫燜懣鍆錳夢瞇謎彌覓冪羋謐獼禰綿緬澠靦黽廟緲繆滅憫閩閔緡鳴銘謬謨驀饃歿鏌謀畝鉬吶鈉納難撓腦惱鬧鐃訥餒內擬膩鈮鯢攆輦鯰釀鳥蔦裊聶嚙鑷鎳隉蘗囁顢躡檸獰寧擰濘苧嚀聹鈕紐膿濃農儂噥駑釹諾儺瘧歐鷗毆嘔漚謳慪甌盤蹣龐拋皰賠轡噴鵬紕羆鈹騙諞駢飄縹頻貧嬪蘋憑評潑頗釙撲鋪樸譜鏷鐠棲臍齊騎豈啟氣棄訖蘄騏綺榿磧頎頏鰭牽釬鉛遷簽謙錢鉗潛淺譴塹僉蕁慳騫繾槧鈐槍嗆墻薔強搶嬙檣戧熗錆鏘鏹羥蹌鍬橋喬僑翹竅誚譙蕎繰磽蹺竊愜鍥篋欽親寢鋟輕氫傾頃請慶撳鯖瓊窮煢蛺巰賕蟣鰍趨區軀驅齲詘嶇闃覷鴝顴權勸詮綣輇銓卻鵲確闋闕愨讓饒擾繞蕘嬈橈熱韌認紉飪軔榮絨嶸蠑縟銣顰軟銳蜆閏潤灑薩颯鰓賽傘毿糝喪騷掃繅澀嗇銫穡殺剎紗鎩鯊篩曬釃刪閃陜贍繕訕姍騸釤鱔墑傷賞坰殤觴燒紹賒攝懾設厙灄畬紳審嬸腎滲詵諗瀋聲繩勝師獅濕詩時蝕實識駛勢適釋飾視試謚塒蒔弒軾貰鈰鰣壽獸綬樞輸書贖屬術樹豎數攄紓帥閂雙誰稅順說碩爍鑠絲飼廝駟緦鍶鷥聳慫頌訟誦擻藪餿颼鎪蘇訴肅謖穌雖隨綏歲誶孫損筍蓀猻縮瑣鎖嗩脧獺撻闥鉈鰨臺態鈦鮐攤貪癱灘壇譚談嘆曇鉭錟頇湯燙儻餳鐋鏜濤絳討韜鋱騰謄銻題體屜緹鵜闐條糶齠鰷貼鐵廳聽烴銅統慟頭鈄禿圖釷團摶頹蛻飩脫鴕馱駝橢籜鼉襪媧膃彎灣頑萬紈綰網輞韋違圍為濰維葦偉偽緯謂衛諉幃闈溈潿瑋韙煒鮪溫聞紋穩問閿甕撾蝸渦窩臥萵齷嗚鎢烏誣無蕪吳塢霧務誤鄔廡憮嫵騖鵡鶩錫犧襲習銑戲細餼鬩璽覡蝦轄峽俠狹廈嚇硤鮮纖賢銜閑顯險現獻縣餡羨憲線莧薟蘚峴獫嫻鷴癇蠔秈躚廂鑲鄉詳響項薌餉驤緗饗蕭囂銷曉嘯嘵瀟驍綃梟簫協挾攜脅諧寫瀉謝褻擷紲纈鋅釁興陘滎兇洶銹繡饈鵂虛噓須許敘緒續詡頊軒懸選癬絢諼鉉鏇學謔澩鱈勛詢尋馴訓訊遜塤潯鱘壓鴉鴨啞亞訝埡婭椏氬閹煙鹽嚴巖顏閻艷厭硯彥諺驗厴贗儼兗讞懨閆釅魘饜鼴鴦楊揚瘍陽癢養樣煬瑤搖堯遙窯謠藥軺鷂鰩爺頁業葉靨謁鄴曄燁醫銥頤遺儀蟻藝億憶義詣議誼譯異繹詒囈嶧飴懌驛縊軼貽釔鎰鐿瘞艤蔭陰銀飲隱銦癮櫻嬰鷹應纓瑩螢營熒蠅贏穎塋鶯縈鎣攖嚶瀅瀠瓔鸚癭頦罌喲擁傭癰踴詠鏞優憂郵鈾猶誘蕕銪魷輿魚漁娛與嶼語獄譽預馭傴俁諛諭蕷崳飫閾嫗紆覦歟鈺鵒鷸齬鴛淵轅園員圓緣遠櫞鳶黿約躍鑰粵悅閱鉞鄖勻隕運蘊醞暈韻鄆蕓惲慍紜韞殞氳雜災載攢暫贊瓚趲鏨贓臟駔鑿棗責擇則澤賾嘖幘簀賊譖贈綜繒軋鍘閘柵詐齋債氈盞斬輾嶄棧戰綻譫張漲帳賬脹趙詔釗蟄轍鍺這謫輒鷓貞針偵診鎮陣湞縝楨軫賑禎鴆掙睜猙爭幀癥鄭證諍崢鉦錚箏織職執紙摯擲幟質滯騭櫛梔軹輊贄鷙螄縶躓躑觶鐘終種腫眾鍾謅軸皺晝驟紂縐豬諸誅燭矚囑貯鑄駐佇櫧銖專磚轉賺囀饌顳樁莊裝妝壯狀錐贅墜綴騅縋諄準濁諑鐲茲資漬諮緇輜貲眥錙齜鯔蹤總縱傯鄒諏騶鯫詛組鏃鉆纘躦鱒翺並蔔醜澱鬥範幹臯櫃後夥稭傑訣誇裏淩麽黴撚淒扡聖屍擡塗窪餵汙鍁鹹蠍彜湧遊籲禦願嶽雲竈紮劄築於誌註訁譾郤氹壟堖垵墊檾蕒葤蓧蒓摣唚噝謔襆嶴獁麅餘餷饊饢楞憷懍漵灩溷濫瀦寧糸絝緔瑉梘棬橰櫫軲軤賫膁腖飈碸瞘鈈鉕鋣銱鋥鋶鐦';
}

function data_xchina() {
    var data = `var cvideo = [
    [{
        name: '全部成人影片',
        url: domain + '/videos/1.html'
    }],
    [{
        name: '中文AV(14039)',
        url: domain + '/videos/series-63824a975d8ae/1.html'
    }, {
        name: '麻豆传媒(3519)',
        url: domain + '/videos/series-5f904550b8fcc/1.html'
    }, {
        name: '独立创作者(1640)',
        url: domain + '/videos/series-61bf6e439fed6/1.html'
    },{
        name: '糖心Vlog(1207)',
        url: domain + '/videos/series-61014080dbfde/1.html'
    }, {
        name: '蜜桃传媒(1107)',
        url: domain + '/videos/series-5fe8403919165/1.html'
    },{
        name: '星空传媒(1003)',
        url: domain + '/videos/series-6054e93356ded/1.html'
    }, {
        name: '天美传媒(780)',
        url: domain + '/videos/series-60153c49058ce/1.html'
    }, {
        name: '果冻传媒(627)',
        url: domain + '/videos/series-5fe840718d665/1.html'
    },{
        name: '香蕉视频(573)',
        url: domain + '/videos/series-65e5f74e4605c/1.html'
    }, {
        name: '精东影业(536)',
        url: domain + '/videos/series-60126bcfb97fa/1.html'
    }, {
        name: '杏吧原版(403)',
        url: domain + '/videos/series-6072997559b46/1.html'
    }, {
        name: '爱豆传媒(393)',
        url: domain + '/videos/series-63d134c7a0a15/1.html'
    }, {
        name: 'IBiZa Media(321)',
        url: domain + '/videos/series-64e9cce89da21/1.html'
    },{
        name: '性视界(315)',
        url: domain + '/videos/series-63490362dac45/1.html'
    },  {
        name: 'EDMosaic(285)',
        url: domain + '/videos/series-63732f5c3d36b/1.html'
    }, {
        name: '大象传媒(244)',
        url: domain + '/videos/series-60c2555958858/1.html'
    },{
        name: '扣扣传媒(201)',
        url: domain + '/videos/series-6230974ada989/1.html'
    },{
        name: '萝莉社(190)',
        url: domain + '/videos/series-5fe8403919165/1.html'
    },{
        name: '其他中文AV(171)',
        url: domain + '/videos/series-63986aec205d8/1.html'
    }, {
        name: 'SA国际传媒(159)',
        url: domain + '/videos/series-6360ca9706ecb/1.html'
    }, {
        name: '抖阴(53)',
        url: domain + '/videos/series-6248705dab604/1.html'
    }, {
        name: '葫芦影业(47)',
        url: domain + '/videos/series-6193d27975579/1.html'
    },  {
        name: '乌托邦(43)',
        url: domain + '/videos/series-637750ae0ee71/1.html'
    }, {
        name: '爱神传媒(38)',
        url: domain + '/videos/series-6405b6842705b/1.html'
    }, {
        name: '乐播传媒(34)',
        url: domain + '/videos/series-60589daa8ff97/1.html'
    }, {
        name: '91茄子(31)',
        url: domain + '/videos/series-639c8d983b7d5/1.html'
    },  {
        name: '草莓视频(26)',
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
        name: '西瓜影视(11)',
        url: domain + '/videos/series-648e1071386ef/1.html'
    }, {
        name: '思春社(5)',
        url: domain + '/videos/series-64be8551bd0f1/1.html'
    }],
    [ {
        name: '模特私拍(2741)',
        url: domain + '/videos/series-6030196781d85/1.html'
    }, {
        name: 'PANS视频(1752)',
        url: domain + '/videos/series-63963186ae145/1.html'
    },{
        name: '其他模特私拍(463)',
        url: domain + '/videos/series-63963534a9e49/1.html'
    }, {
        name: '热舞(258)',
        url: domain + '/videos/series-64edbeccedb2e/1.html'
    }, {
        name: '相约中国(154)',
        url: domain + '/videos/series-63ed0f22e9177/1.html'
    }, {
        name: '果哥作品(56)',
        url: domain + '/videos/series-6396315ed2e49/1.html'
    },{
        name: 'SweatGirl(17)',
        url: domain + '/videos/series-68456564f2710/1.html'
    },  {
        name: '风吟鸟唱作品(11)',
        url: domain + '/videos/series-6396319e6b823/1.html'
    }, {
        name: '色艺无间(10)',
        url: domain + '/videos/series-6754a97d2b343/1.html'
    }, {
        name: '黄甫(7)',
        url: domain + '/videos/series-668c3b2de7f1c/1.html'
    }, {
        name: '日月俱乐部(1)',
        url: domain + '/videos/series-63ab1dd83a1c6/1.html'
    }],
    [{
        name: '业余拍摄(717)',
        url: domain + '/videos/series-617d3e7acdcc8/1.html'
    }, {
        name: '探花现场(604)',
        url: domain + '/videos/series-63965bf7b7f51/1.html'
    }, {
        name: '主播现场(113)',
        url: domain + '/videos/series-63965bd5335fc/1.html'
    }],
    [{
        name: '日本AV(8558)',
        url: domain + '/videos/series-6206216719462/1.html'
    }, {
        name: '有码AV(5718)',
        url: domain + '/videos/series-6395aba3deb74/1.html'
    }, {
        name: '无码AV(2181)',
        url: domain + '/videos/series-6395ab7fee104/1.html'
    }, {
        name: 'AV解说(597)',
        url: domain + '/videos/series-6608638e5fcf7/1.html'
    }],
    [{
        name: '其他影片(292)',
        url: domain + '/videos/series-60192e83c9e05/1.html'
    }, {
        name: '其他亚洲影片(130)',
        url: domain + '/videos/series-63963ea949a82/1.html'
    }, {
        name: '门事件(89)',
        url: domain + '/videos/series-63963de3f2a0f/1.html'
    },  {
        name: '其他欧美影片(51)',
        url: domain + '/videos/series-6396404e6bdb5/1.html'
    },  {
        name: '无关情色(22)',
        url: domain + '/videos/series-66643478ceedd/1.html'
    }],
    [{
        name: '情色电影(344)',
        url: domain + '/videos/series-61c4d9b653b6d/1.html'
    }, {
        name: '华语电影(241)',
        url: domain + '/videos/series-6396492fdb1a0/1.html'
    }, {
        name: '日韩电影(81)',
        url: domain + '/videos/series-6396494584b57/1.html'
    }, {
        name: '欧美电影(22)',
        url: domain + '/videos/series-63964959ddb1b/1.html'
    }]
];
var sort_videos = [{
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
    }],
    [{
        name: '专辑',
        url: domain + '/photos/album-1/1.html'
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
        name: '秀人网旗下(16193)',
        url: domain + '/photos/series-6660093348354/1.html'
    }, {
        name: '秀人网(10883)',
        url: domain + '/photos/series-5f1476781eab4/1.html'
    },{
        name: '语画界(750)',
        url: domain + '/photos/series-601ef80997845/1.html'
    },{
        name: '爱蜜社(741)',
        url: domain + '/photos/series-5f71afc92d8ab/1.html'
    },  {
        name: '私购流出(668)',
        url: domain + '/photos/series-66600a3a227ee/1.html'
    }, {
        name: '花漾(630)',
        url: domain + '/photos/series-5fc4ce40386af/1.html'
    },{
        name: '尤蜜荟(586)',
        url: domain + '/photos/series-5f184ff551888/1.html'
    }, {
        name: '模范学院(568)',
        url: domain + '/photos/series-5f181625966a6/1.html'
    },  {
        name: '美媛馆(504)',
        url: domain + '/photos/series-5f1495dbda4de/1.html'
    }, {
        name: '星颜社(304)',
        url: domain + '/photos/series-6141c88882a36/1.html'
    },  {
        name: '尤物馆(175)',
        url: domain + '/photos/series-60673bec9dd11/1.html'
    }, {
        name: '蜜桃社(149)',
        url: domain + '/photos/series-5f1dd5a7ebe9a/1.html'
    }, {
        name: '爱尤物(33)',
        url: domain + '/photos/series-5f148046cb2c7/1.html'
    }, {
        name: 'FEILIN嗲囡囡(125)',
        url: domain + '/photos/series-5f14a3105d3e8/1.html'
    }, {
        name: '瑞丝馆(88)',
        url: domain + '/photos/series-61263de287e2f/1.html'
    }, {
        name: '影私荟(22)',
        url: domain + '/photos/series-63d435352808c/1.html'
    }],
    [{
        name: '中国工作室(4707)',
        url: domain + '/photos/series-6310ce9b90056/1.html'
    }, {
        name: 'PANS(1675)',
        url: domain + '/photos/series-6310ce9b90056/1.html'
    }, {
        name: '丽图100(537)',
        url: domain + '/photos/series-5f1d784995865/1.html'
    }, {
        name: '相约中国(381)',
        url: domain + '/photos/series-5f1dcdeaee582/1.html'
    }, {
        name: '轰趴猫(264)',
        url: domain + '/photos/series-5f1ae6caae922/1.html'
    }, {
        name: '潘多拉(192)',
        url: domain + '/photos/series-5f23c44cd66bd/1.html'
    }, {
        name: '其他(144)',
        url: domain + '/photos/series-665f7d787d681/1.html'
    },{
        name: '行色(140)',
        url: domain + '/photos/series-64f44d99ce673/1.html'
    },  {
        name: '果团网(132)',
        url: domain + '/photos/series-5f1817b42772b/1.html'
    }, {
        name: '爱丝(132)',
        url: domain + '/photos/series-5f15f389e993e/1.html'
    }, {
        name: '黄甫(128)',
        url: domain + '/photos/series-665f8bafab4bc/1.html'
    },{
        name: '妖精社(99)',
        url: domain + '/photos/series-5f4b5f4eb8b71/1.html'
    },  {
        name: '无忌影社(90)',
        url: domain + '/photos/series-619a92aa1fa7a/1.html'
    }, {
        name: '推女郎(87)',
        url: domain + '/photos/series-5f14a5eb5b0d7/1.html'
    }, {
        name: '风吟鸟唱(79)',
        url: domain + '/photos/series-63b54e804a694/1.html'
    },{
        name: '蜜丝(74)',
        url: domain + '/photos/series-5f2089564c6c2/1.html'
    },  {
        name: '头条女神(53)',
        url: domain + '/photos/series-5f14806585bef/1.html'
    }, {
        name: '深夜企划(47)',
        url: domain + '/photos/series-638e5a60b1770/1.html'
    }, {
        name: '希威社(44)',
        url: domain + '/photos/series-665f8595408fa/1.html'
    }, {
        name: '北京天使(41)',
        url: domain + '/photos/series-622c7f95220a4/1.html'
    }, {
        name: 'ISS系列(39)',
        url: domain + '/photos/series-646c69b675f3d/1.html'
    }, {
        name: '尤美(38)',
        url: domain + '/photos/series-61b997728043b/1.html'
    }, {
        name: 'A4U(34)',
        url: domain + '/photos/series-5f60b98248a81/1.html'
    }, {
        name: 'DDY(28)',
        url: domain + '/photos/series-5f15f727df393/1.html'
    },  {
        name: '蜜柚摄影(27)',
        url: domain + '/photos/series-676c3e9b90749/1.html'
    },{
        name: '东莞V女郎(26)',
        url: domain + '/photos/series-5f22ea422221c/1.html'
    }, {
        name: 'SK丝库(22)',
        url: domain + '/photos/series-5f382ba894af4/1.html'
    }, {
        name: 'U238(11)',
        url: domain + '/photos/series-67028a27d02a6/1.html'
    }],
    [{
        name: '日本工作室(624)',
        url: domain + '/photos/series-6450b47c9db0b/1.html'
    }, {
        name: 'Graphis(241)',
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
        name: '韩国工作室(518)',
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
        name: '台湾工作室(475)',
        url: domain + '/photos/series-665f7c561767e/1.html'
    }, {
        name: 'JVID(394)',
        url: domain + '/photos/series-637b2029d2347/1.html'
    }, {
        name: 'Fantasy Factory(42)',
        url: domain + '/photos/series-5f889afb37619/1.html'
    }, {
        name: 'TPimage(23)',
        url: domain + '/photos/series-5f7a0a80d3d66/1.html'
    }, {
        name: 'ED Mosaic(16)',
        url: domain + '/photos/series-68610041d0aa8/1.html'
    }],
    [{
        name: '各国其他套图(6847)',
        url: domain + '/photos/series-618e4909ea9b6/1.html'
    }, {
        name: '国模套图(5478)',
        url: domain + '/photos/series-64be21c972ca4/1.html'
    }, {
        name: '日模套图(545)',
        url: domain + '/photos/series-64be2283bf3af/1.html'
    }, {
        name: '韩模套图(391)',
        url: domain + '/photos/series-64be22b4a0fa0/1.html'
    }, {
        name: '台模套图(263)',
        url: domain + '/photos/series-64be21ef4cc51/1.html'
    }, {
        name: '港模套图(59)',
        url: domain + '/photos/series-64be224b662c0/1.html'
    }, {
        name: '其他地区套图(28)',
        url: domain + '/photos/series-64be239ce73d4/1.html'
    }],[{
        name: '台模套图(263)',
        url: domain + '/photos/series-64be21ef4cc51/1.html'
    },{
        name: '其他套图(562)',
        url: domain + '/photos/series-665f66f97ec4d/1.html'
    },{
        name: '书籍扫描(398)',
        url: domain + '/photos/series-6860e3d718c78/1.html'
    },{
        name: '街拍(149)',
        url: domain + '/photos/series-6836cd1a2d51d/1.html'
    }, {
        name: 'AI图区(15)',
        url: domain + '/photos/series-6443d480eb757/1.html'
    } ]
];
var sort_photos = [{
    name: '更新时间',
    url: ''
}, {
    name: '最热门',
    url: '/sort-hot'
}, {
    name: '评论最多',
    url: '/sort-comment'
}, {
    name: '最近评论',
    url: '/sort-recent'
}];
var cfiction = [{
    name: '全部小说(18236)',
    url: domain + '/fictions/1.html'
},  {
    name: '人妻女友(6609)',
    url: domain + '/fictions/tag-1/1.html'
},{
    name: '编辑推荐(6138)',
    url: domain + '/fictions/tag-101/1.html'
}, {
    name: '长篇连载(6071)',
    url: domain + '/fictions/tag-102/1.html'
},{
    name: '都市生活(5548)',
    url: domain + '/fictions/tag-4/1.html'
}, {
    name: '家庭乱伦(4726)',
    url: domain + '/fictions/tag-9/1.html'
}, {
    name: '多人群交(2787)',
    url: domain + '/fictions/tag-10/1.html'
}, {
    name: '强暴性虐(2607))',
    url: domain + '/fictions/tag-13/1.html'
},{
    name: '古典玄幻(2200)',
    url: domain + '/fictions/tag-8/1.html'
},  {
    name: '绿帽主题(1850)',
    url: domain + '/fictions/tag-16/1.html'
},  {
    name: '学生校园(1812)',
    url: domain + '/fictions/tag-2/1.html'
},{
    name: '公司职场(1450)',
    url: domain + '/fictions/tag-11/1.html'
}, {
    name: '经验故事(1255)',
    url: domain + '/fictions/tag-7/1.html'
}, {
    name: '露出暴露(1021)',
    url: domain + '/fictions/tag-12/1.html'
}, {
    name: '有声小说(897)',
    url: domain + '/fictions/tag-999/1.html'
},  {
    name: '西方主题(563)',
    url: domain + '/fictions/tag-14/1.html'
},{
    name: '动漫游戏(312)',
    url: domain + '/fictions/tag-5/1.html'
}, {
    name: '同性主题(286)',
    url: domain + '/fictions/tag-15/1.html'
},{
    name: '伴侣交换(281)',
    url: domain + '/fictions/tag-3/1.html'
}, {
    name: '名人明星(160)',
    url: domain + '/fictions/tag-6/1.html'
},   {
    name: '经典回忆(109)',
    url: domain + '/fictions/tag-103/1.html'
},{
    name: '耽美小说(21)',
    url: domain + '/fictions/tag-99/1.html'
},{
    name: '漫画小说(4)',
    url: domain + '/fictions/tag-998/1.html'
},{
    name: '色友发表(69)',
    url: domain + '/fictions/tag-1000/1.html'
}];
var sort_fictions = [{
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
var sort1_fictions = [{
    name: '更新时间',
    url: ''
}, {
    name: '浏览最多',
    url: '/sort-read'
}, {
    name: '评论最多',
    url: '/sort-comment'
}];
var cmodel = [{
    name: '全部模特(1660)',
    url: domain + '/models/1.html'
}, {
    name: '华人模特(1670)',
    url: domain + '/models/type-4/1.html'
}, {
    name: '韩国模特(91)',
    url: domain + '/models/type-5/1.html'
}, {
    name: '华人女优(587)',
    url: domain + '/models/type-7/1.html'
},  {
    name: '华人男优(8)',
    url: domain + '/models/type-8/1.html'
}, {
    name: '其他女优(2)',
    url: domain + '/models/type-9/1.html'
}, {
    name: '日本女优(2400)',
    url: domain + '/models/type-10/1.html'
}, {
    name: '日本男优(280)',
    url: domain + '/models/type-11/1.html'
}, {
    name: '名人明星(28)',
    url: domain + '/models/type-98/1.html'
}, {
    name: '摄影师(49)',
    url: domain + '/models/type-99/1.html'
}];
var sort_models = [{
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
