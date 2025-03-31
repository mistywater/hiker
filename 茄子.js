const csdown = {
    urlClone:'https://raw.githubusercontent.com/csdown/hiker_info/refs/heads/main/rules/%E8%8C%84%E5%AD%90.js',
    d: [],
    author: '流苏',
    version: '20250331',
    rely: (data) => {
        return data.match(/\{([\s\S]*)\}/)[0].replace(/\{([\s\S]*)\}/, '$1')
    },
    home: () => {
        var d = csdown.d;
        if (getItem('up' + csdown.version, '') == '') {
            confirm({
                title: '更新内容',
                content: '版本号：' + csdown.version + '\n1.修复一些bug\n2.增加一些bug\n3.增加长按更新茄子服务器数据\n4.增加长按更换线路(没事别换)\n5.搜索界面增加搜索框\n6.增加av百科\n7.首页增加部分模块\n8.综合部分二级页面修改\n9.看不了的是服务器问题，与我无关\n10.待续',
                confirm: $.toString((version) => {
                    setItem('up' + version, '1')
                }, csdown.version),
                cancel: $.toString(() => {})
            })
        }
        if (MY_PAGE == 1) {
            d.push({   
                title: "搜索 ",
                url: $.toString(() => {
                    putMyVar('keyword', input)
                    return "hiker://empty?page=fypage&kw=" + input + '@rule=js:$.require("csdown").search()'
                }),
                   desc: "请输入搜索关键词",
                   col_type: "input",
                extra: {
                    defaultValue: getMyVar('keyword', ''),
                }
            })
        };
        var list = [{
            title: '首页&综合',
            id: '1&2&3&4&5',
            img: 'https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/127.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/137.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/113.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/114.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/122.svg'
        }];
        if (MY_PAGE == 1) {
            function strong(d, c) {
                return '‘‘’’<strong><font color=#' + (c || '000000') + '>' + d + '</font></strong>';
            }
            var index_n = list[0].id.split('&')[0];
            list.forEach(data => {
                var title = data.title.split('&');
                var id = data.id.split('&');
                var img = data.img.split('&');
                title.forEach((title, index) => {
                    d.push({
                        title: (getMyVar('首页', index_n) == id[index] ? strong(title, 'FF6699') : title),
                        img: img[index],
                        url: $('#noLoading#').lazyRule((title, id) => {
                            putMyVar('首页', id);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, title, id[index]),
                        col_type: 'icon_2_round',
                        extra: {
                            longClick: [{
                                title: '更新数据',
                                js: $.toString(() => {
                                    eval($.require('csdown').rely($.require('csdown').aes));
                                    let shouye = qzDecrypt(request('http://003.22s.lol/encrypt/api.php?path=qiezi/shouye'));
                                    let data = qzDecrypt(request('http://003.22s.lol/encrypt/api.php?path=qiezi/zonghe'));
                                    let search = fetch('http://003.22s.lol/searchconfig/vipapi/vipconfig.txt');
                                    // var kuozhan=qzDecrypt(request('http://004.22s.lol/encrypt/api.php?path=qiezi/heikeji'));
                                    // var yuming=qzDecrypt(request('http://01.xka3a.top/encrypt/api.php?path=yuming/yuming'));
                                    //  var gonggao=qzDecrypt(request('http://003.22s.lol/encrypt/api.php?path=qiezi/qz'));
                                    let avbk = fetch('https://app.caoppht.com/avbk132.php');
                                    //茄子数据
                                    //http://api.xka1.top/qiezi/shouye.txt
                                    //http://api.xka1.top/qiezi/zonghe.txt
                                    //小可爱数据
                                    //http://api.xka1.top/xiaokeai/shouye.txt
                                    //http://api.xka1.top/xiaokeai/zonghe.txt
                                    setItem('shouye', shouye);
                                    setItem('data', data);
                                    setItem('search', search);
                                    setItem('avbk', avbk);
                                    // setItem('yuming',yuming);
                                    //setItem('kuozhan',kuozhan);
                                    // setItem('gonggao',gonggao);
                                    refreshPage(false);
                                    toast('数据已更新');
                                    log('数据已更新');
                                    return 'hiker://empty';
                                })
                            }, {
                                title: '更换线路',
                                js: $.toString(() => {
                                    var url = 'https://api1.yilushunfeng.top|https://api.changfapiaopiao.top|http://api1.yilushunfeng.top|http://api.changfapiaopiao.top|http://api1.apijiekou.top/api|http://api.phpjiekou.top|http://004.22s.lol/api'.split('|');
                                    var option = '线路1(推荐)&线路2&线路3&线路4&线路5&线路6&线路7'.split('&')
                                    var Line = {
                                        title: '切换线路',
                                        options: option,
                                        col: 2,
                                        js: $.toString((url) => {
                                            var index = input.match(/\d+/)[0];
                                            var host = url[index - 1];
                                            setItem('host', host);
                                            refreshPage(false);
                                            toast('线路已更换');
                                        }, url)
                                    }
                                    return 'select://' + JSON.stringify(Line);
                                })
                            }]
                        }
                    })
                })
                d.push({
                    col_type: 'blank_block',
                });
            })
            d.push({
                col_type: 'big_blank_block',
            });
        }
        //setPreResult(d)
        var 分类 = getMyVar('首页', '1');
        if (分类 == 1) {
            csdown.video()
        } else if (分类 == 2) {
            csdown.zonghe()
        }
        setResult(d)
    },
    video: () => {
        eval(csdown.rely(csdown.aes))
        try {
            var d = csdown.d;
            //log(getItem('shouye'))
            //log(getItem('data'))
            //log(getItem('gonggao'))
            //log(getItem('avbk'))
            var list = getItem('shouye').split('首页数据开始')[1].split('首页数据结束')[0].replace(/https?\:\/\/(api1?\.)?(changfapiaopiao|yilushunfeng|phpjiekou|apijiekou)\.top(\/api)?/g, getItem('host')).split('换行');
            list.forEach(data => {
                var qd = sp(data, "qd(", ")");
                var tp = sp(data, "tp(", ")");
                var mc = sp(data, "mc(", ")");
                var wz = sp(data, "gjc(", ")");
                var ym = sp(data, "ym(", ")");
                var lx = sp(data, "lx(", ")");
                var qb = qd + '  ' + mc + '  ' + wz + '  ' + ym + '  ' + lx;
                if (qd == '麻豆TV') {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").madou()',
                        col_type: 'icon_4_card'
                    })
                } else if (qd == '91TV') {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").tv_91()',
                        col_type: 'icon_4_card'
                    })
                } else if (qd == '猫咪') {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").maomi()',
                        col_type: 'icon_4_card'
                    })
                } else if (qd == '猫咪原创') {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").maomiyuanchuang()',
                        col_type: 'icon_4_card'
                    })
                } else {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").syvideo()',
                        col_type: 'icon_4_card',
                        extra: {
                            host: `${ym}/${wz}.php`,
                            wz: wz,
                        }
                    })
                }
            })
            d.push({
                    title: '撸先生',
                    img: 'http://api.xka1.top/6img/lusir.png',
                    url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").syvideo()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/video1/lusir.php`,
                        wz: 'lusir',
                    }
                }, {
                    title: '猫咪视频',
                    img: 'http://api.xka1.top/6img/maomisq.png',
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").maomiav()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}`,
                        wz: 'maomiav',
                    }
                }, {
                    title: 'JAV日本区',
                    img: 'http://api.xka1.top/6img/javn.png',
                    url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").syvideo()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/video2/jav123/jav.php`,
                        wz: 'jav',
                    }
                },
                /*
                 {
                    title: '秘爱',
                    img: 'http://api.xka1.top/6img/miai.jpg',
                    url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").syvideo()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/video2/xinghuafang/miai.php`,
                        wz: 'miai',
                    }
                },
                */
                {
                    title: 'UAA视频',
                    img: 'http://api.xka1.top/6img/uaa.png',
                    url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").syvideo()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/video2/uaa/uaa.php`,
                        wz: 'uaa',
                    }
                },
                /*
                {
                    title: 'UU视频',
                    img: 'http://api.xka1.top/6img/uusp.png',
                    url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").syvideo()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/video1/caoliusp_xilie/uushipin.php`,
                        wz: 'uushipin',
                    }
                }, 
                */
                {
                    title: '图宅',
                    img: 'http://api.xka1.top/6img/tuzac.png',
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").picerji()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/picture/tuzac.php`,
                        wz: 'tuzac',
                    }
                },
                /*
                 {
                    title: '嘿嘿连载',
                    img: 'http://api.xka1.top/6img/heiheilz.png',
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").manhuaerji()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/comic/heiheilz.php`,
                        wz: 'heiheilz',
                    }
                }, {
                    title: '禁漫天堂[新]',
                    img: 'http://api.xka1.top/6img/jinmantt.png',
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").manhuaerji()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/comic/jinmantt.php`,
                        wz: 'jinmantt',
                    }
                }, 
                */
                {
                    title: '暗网[每日大赛]',
                    img: 'http://api.xka1.top/6img/meiridasai.png',
                    url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").videoerji()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/erji/meiridasai/aw/mrds.php`,
                        wz: 'mrds',
                    }
                }, {
                    title: '帖子[每日大赛]',
                    img: 'http://api.xka1.top/6img/meiridasai.png',
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").blackerji()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/erji/meiridasai/daily.php`,
                        wz: 'daily',
                    }
                }, {
                    title: '博天堂',
                    img: 'http://api.xka1.top/6img/f4.png',
                    url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").syvideo()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: `${getItem('host')}/video2/botiantang/btt.php`,
                        wz: 'btt',
                    }
                },
                /*
                    {
                        title: '小狐狸',
                        img: 'http://api.xka1.top/6img/xiaohuli1.png',
                        url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").syvideo()',
                        col_type: 'icon_4_card',
                        extra: {
                            host: `${getItem('host')}/video1/xiaohuli.php`,
                            wz: 'xiaohuli',
                        }
                }
                */
            )

            var list1 = getItem('shouye').split('分割线')[1].replace(/https?\:\/\/(api1?\.)?(changfapiaopiao|yilushunfeng|phpjiekou|apijiekou)\.top(\/api)?/g, getItem('host')).split('换行');
            list1.forEach(data => {
                var qd = sp(data, "qd(", ")");
                var tp = sp(data, "tp(", ")");
                var mc = sp(data, "mc(", ")");
                var wz = sp(data, "gjc(", ")");
                var ym = sp(data, "ym(", ")");
                var lx = sp(data, "lx(", ")");
                var qb = qd + '  ' + mc + '  ' + wz + '  ' + ym + '  ' + lx;
                if (tp != null) {
                    if ((wz == 'xiangjiao') | (wz == '91dsp') | (wz == 'tiktok18') | (wz == 'ogfap') | (wz == 'tiktok18long') | (wz == 'xiaohuli')) {} else {
                        d.push({
                            title: mc,
                            desc: qb,
                            img: 'http://api.xka1.top' + tp,
                            url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").syvideo()',
                            col_type: 'icon_4_card',
                            extra: {
                                host: `${ym}/${wz}.php`,
                                wz: wz,
                            }
                        })
                    }
                }
            })

            var list2 = JSON.parse(getItem('avbk')).api;
            list2.forEach(data => {
                d.push({
                    title: data.mz,
                    desc: data.ck,
                    img: data.tp,
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").baike()',
                    col_type: 'icon_4_card',
                    extra: {
                        host: data.dz,
                        mz: data.mz,
                        sj: data.sj,
                    }
                })
            })
        } catch (e) {
            log(e.message)
            if (getMyVar('a') == '') {
                const host = 'https://api1.yilushunfeng.top';
                const shouye = qzDecrypt(request('http://003.22s.lol/encrypt/api.php?path=qiezi/shouye'))
                const data = qzDecrypt(request('http://003.22s.lol/encrypt/api.php?path=qiezi/zonghe'))
                const search = fetch('http://003.22s.lol/searchconfig/vipapi/vipconfig.txt')
                // var kuozhan=qzDecrypt(request('http://004.22s.lol/encrypt/api.php?path=qiezi/heikeji'))
                // var yuming=qzDecrypt(request('http://01.xka3a.top/encrypt/api.php?path=yuming/yuming'))
                //  var gonggao=qzDecrypt(request('http://003.22s.lol/encrypt/api.php?path=qiezi/qz'))
                const avbk = fetch('https://app.caoppht.com/avbk132.php');
                putMyVar('a', '1');
                setItem('host', host);
                setItem('shouye', shouye);
                setItem('data', data);
                setItem('search', search);
                setItem('avbk', avbk);
                // setItem('yuming',yuming)
                //setItem('kuozhan',kuozhan)
                // setItem('gonggao',gonggao)
                refreshPage(false);
                toast('数据已更新');
                log('数据已更新');
                /*  
    域名替换匹配表达式https?://(api1?\.)?(changfapiaopiao|yilushunfeng|phpjiekou|apijiekou)\.top(\/api)?《
线路集合https://api1.yilushunfeng.top|https://api.changfapiaopiao.top|http://api1.yilushunfeng.top|http://api.changfapiaopiao.top|http://api1.apijiekou.top/api|http://api.phpjiekou.top|http://004.22s.lol/api《
失效域名集合https://api.yilushunfeng.top|http://api.yilushunfeng.top|http://api11.phpjiekou.top《
最新接口域名https://api1.yilushunfeng.top《
*/
            }
        }
    },
    zonghe: () => {
        eval(csdown.rely(csdown.aes));
        try {
            const d = csdown.d;
            // var list=getItem('data').split('综合数据开始')[1].split('综合数据结束')[0].split('换行');
            var list = getItem('data').split('综合数据开始')[1].split('AV百科')[0].replace(/https?\:\/\/(api1?\.)?(changfapiaopiao|yilushunfeng|phpjiekou|apijiekou)\.top(\/api)?/g, getItem('host')).replace(/分割线/g, '换行').split('换行');
            list.forEach(data => {
                var qd = sp(data, "qd(", ")");
                var tp = sp(data, "tp(", ")");
                var mc = sp(data, "mc(", ")");
                var wz = sp(data, "gjc(", ")");
                var ym = sp(data, "ym(", ")");
                var lx = sp(data, "lx(", ")");
                var qb = qd + '  ' + mc + '  ' + wz + '  ' + ym + '  ' + lx;
                if (lx == '二级菜单') {
                    if (wz == 'caoliu' || wz == 'heiliaoshequ') {
                        d.push({
                            title: mc,
                            desc: qb,
                            img: 'http://api.xka1.top' + tp,
                            url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").videoerji()',
                            col_type: 'icon_4_card',
                            extra: {
                                host: `${getItem('host')}/erji/caoliu_xilie/${wz}.php`,
                                wz: wz,
                            }
                        })
                    } else {
                        d.push({
                            title: mc,
                            desc: qb,
                            img: 'http://api.xka1.top' + tp,
                            url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").videoerji()',
                            col_type: 'icon_4_card',
                            extra: {
                                host: `${ym}/${wz}.php`,
                                wz: wz,
                            }
                        })
                    }
                } else if (lx == '黑料') {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").blackerji()',
                        col_type: 'icon_4_card',
                        extra: {
                            host: `${ym}/${wz}.php`,
                            wz: wz,
                        }
                    })
                } else if (lx == '国内直播') {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty?@rule=js:$.require("csdown").zhiboerji()',
                        col_type: 'icon_4_card',
                        extra: {
                            host: `${ym}/${wz}.php`,
                            wz: wz,
                        }
                    })
                } else if ((lx == '国外直播') | (lx == '视频')) {
                    if (!mc.includes('全网搜')) {
                        d.push({
                            title: mc,
                            desc: qb,
                            img: 'http://api.xka1.top' + tp,
                            url: 'hiker://empty?page=fypage&#noHistory#@rule=js:$.require("csdown").syvideo()',
                            col_type: 'icon_4_card',
                            extra: {
                                host: `${ym}/${wz}.php`,
                                wz: wz,
                            }
                        })
                    }
                } else if (lx.includes('女') & lx.includes('优')) {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").nvyouerji()',
                        col_type: 'icon_4_card',
                        extra: {
                            host: `${ym}/${wz}.php`,
                            wz: wz,
                        }
                    })
                } else if (lx == '帖子') {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").tieerji()',
                        col_type: 'icon_4_card',
                        extra: {
                            host: `${ym}/${wz}.php`,
                            wz: wz,
                        }
                    })
                } else if (lx == '直播') {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty@rule=js:$.require("csdown").zhibojuheerji()',
                        col_type: 'icon_4_card',
                        extra: {
                            wz: mc,
                        }
                    })
                } else if (lx == '漫画') {
                    if (mc == '猫咪漫画') {
                        d.push({
                            title: mc,
                            desc: qb,
                            img: 'http://api.xka1.top' + tp,
                            url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").maomimanhua()',
                            col_type: 'icon_4_card'
                        })
                    } else {
                        d.push({
                            title: mc,
                            desc: qb,
                            img: 'http://api.xka1.top' + tp,
                            url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").manhuaerji()',
                            col_type: 'icon_4_card',
                            extra: {
                                host: `${ym}/${wz}.php`,
                                wz: wz,
                            }
                        })
                    }
                } else if (lx == '小说') {
                    d.push({
                        title: mc,
                        desc: qb,
                        img: 'http://api.xka1.top' + tp,
                        url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").xiaoshuoerji()',
                        col_type: 'icon_4_card',
                        extra: {
                            host: `${ym}/${wz}.php`,
                            wz: wz,
                        }
                    })
                } else if (lx == '图片') {
                    if (mc == '猫咪美图') {
                        d.push({
                            title: mc,
                            desc: qb,
                            img: 'http://api.xka1.top' + tp,
                            url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").maomimeitu()',
                            col_type: 'icon_4_card'
                        })
                    } else if (mc != '美图色图') {
                        d.push({
                            title: mc,
                            desc: qb,
                            img: 'http://api.xka1.top' + tp,
                            url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").picerji()',
                            col_type: 'icon_4_card',
                            extra: {
                                host: `${ym}/${wz}.php`,
                                wz: wz,
                            }
                        })
                    }
                } else if (lx == '有声小说') {
                    if (mc == '猫咪FM') {
                        d.push({
                            title: mc,
                            desc: qb,
                            img: 'http://api.xka1.top' + tp,
                            url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").maomiFM()',
                            col_type: 'icon_4_card'
                        })
                    }
                }
            })
        } catch (e) {
            log(e.message)
        }
    },
    search: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes))
        var pg = getParam('page');
        try {
            if (MY_PAGE == 1) {
                d.push({   
                    title: "搜索 ",
                    url: $.toString(() => {
                        putMyVar('keyword', input)
                        refreshPage(false)
                        return "hiker://empty"
                    }),
                       desc: "请输入搜索关键词",
                       col_type: "input",
                    extra: {
                        defaultValue: getMyVar('keyword', ''),
                        pageTitle: '搜索结果'
                    }
                })
                var data = JSON.parse(getItem('search')).config;
                var url_n = data[0].api + data[0].platform;
                data.forEach(data => {
                    var url = data.api + data.platform;
                    if ((data.title != '福利') & (!data.platform.includes('yuepao'))) {
                        d.push({
                            title: getMyVar('搜索分类', url_n) == url ? strong(data.title, 'FF6699') : data.title,
                            url: $('#noLoading#').lazyRule((title, url, cate) => {
                                putMyVar('搜索分类', url);
                                putMyVar('搜索分类名', title);
                                refreshPage(false);
                                return 'hiker://empty';
                            }, data.title, url, '搜索分类'),
                            col_type: 'scroll_button',
                            extra: {
                                key: '搜索分类: ' + getMyVar('搜索分类', url_n),
                                word: '搜索分类名: ' + getMyVar('搜索分类名', '视频'),
                                keyword: getMyVar('keyword'),
                            }
                        })
                    }
                })
                d.push({
                    col_type: 'blank_block'
                })
                var list = JSON.parse(fetch(getMyVar('搜索分类', 'http://003.22s.lol/searchconfig/video.txt')).replace('yindangmao', 'caoliusp_xilie/yindangmao').replace('erji/missav/missav', 'video1/caoliusp_xilie/zhongkoushe').replace('日本专区', '重口社')).searchapi;
                var url_n = getItem('host') + '/' + list[0].platform + '.php';
                putMyVar('url_n', url_n);
                list.forEach(data => {
                    var url = getItem('host') + '/' + data.platform + '.php';
                    d.push({
                        title: getMyVar(getMyVar('搜索分类名', '视频') + '搜索列表', url_n) == url ? strong(data.title, 'FF6699') : data.title,
                        url: $('#noLoading#').lazyRule((title, url, cate) => {
                            putMyVar(getMyVar('搜索分类名', '视频') + '搜索列表', url);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, data.title, url, getMyVar('搜索分类名', '视频') + '搜索列表'),
                        col_type: 'scroll_button',
                        extra: {
                            key: getMyVar('搜索分类名', '视频') + '搜索列表',
                            url: url,
                            wz: data.platform,
                            keyword: getMyVar('keyword'),
                            search_url: getMyVar(getMyVar('搜索分类名', '视频') + '搜索列表', url_n) + '?keyword=' + getMyVar('keyword') + '&page=' + pg,
                        }
                    })
                })
            }
        } catch (e) {
            log(e.toString())
        }
        try {
            var search_url = getMyVar(getMyVar('搜索分类名', '视频') + '搜索列表', getMyVar('url_n')) + '?keyword=' + getMyVar('keyword') + '&page=' + pg;
            //log(search_url)
            var host = search_url.split('?')[0];
            if (getMyVar('搜索分类名', '视频') == '视频') {
                var Arr = ['lusir', '51lieqi', 'tangtoutiao', '50du', 'tiktok', 'xingba', 'anwangjiemi', 'qiyou', 'caoliushequ', '91paofu', 'meiridasai', 'pornhub', 'douyinmax', '51luoli', '91porn_sfktv', 'shuiguopai', 'sifangktv', 'weimiquan', 'heiliaobdy', '51chigua'];
                var Brr = ['lutube'];
                var Crr = ['ins'];
                var Drr = ['souavsp'];
                var platform = host.match(/top\/.*\.php/)[0].split('.php')[0].split('/')[2];
                //log(platform)
                var item = JSON.parse(fetch(search_url)).videos;
                item.forEach(data => {
                    if (Arr.includes(platform)) {
                        d.push({
                            title: data.title,
                            desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                            img: data.image + lazy,
                            url: host + '?id=' + data.id + vod,
                            col_type: 'movie_2',
                            extra: {
                                id: data.id,
                            }
                        })
                    } else if (Brr.includes(platform)) {
                        d.push({
                            title: data.title,
                            desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                            img: data.image + lulazy,
                            url: host + '?id=' + data.id + $('').lazyRule(() => {
                                eval($.require('csdown').rely($.require('csdown').aes));;
                                try {
                                    //duration.match(/(\d+)/)[1]>60判断并不准确
                                    var url = JSON.parse(fetch(input + '&type=short')).video;
                                    if (url == null) {
                                        var url = JSON.parse(fetch(input + '&type=long')).video;
                                    }
                                    return url + `#isVideo=true#`
                                } catch (e) {
                                    log(e.message)
                                    return 'toast://请求失败'
                                }
                            }),
                            col_type: 'movie_2'
                        })
                    } else if (Crr.includes(platform)) {
                        d.push({
                            title: data.title,
                            desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                            img: data.image + inslazy,
                            url: host + '?id=' + data.id + vod,
                            col_type: 'movie_2'
                        })
                    } else if (Drr.includes(platform)) {
                        d.push({
                            title: data.title,
                            desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                            img: data.image,
                            url: $('').lazyRule((host, id) => {
                                var url = host + '?id=' + id;
                                var url0 = JSON.parse(fetch(url)).video;
                                if (url0.includes('https://www.savsp.com')) {
                                    // 设置域名组
                                    var domainGroup = [
                                        'https://cdn4.yd2.cn:8683/m3u8',
                                        'https://cdn13.yd2.cn:886/m3u8',
                                        'https://cdn14.yd2.cn:8088/m3u8',
                                        'https://cdn5.yd2.cn:444/m3u8',
                                        'https://cdn7.yd2.cn:7879/m3u8',
                                        'https://cdn.yd2.cn:8083/m3u8',
                                        'https://cdn9.yd2.cn:7788/m3u8'
                                    ];
                                    url0 = url0.replace('https://www.savsp.com', '')
                                    for (var i in domainGroup) {
                                        domainGroup[i] = domainGroup[i] + url0;
                                    }
                                    var url1 = {
                                        urls: domainGroup
                                    }
                                    return url1;
                                } else {
                                    return url0
                                }
                            }, host, data.id),
                            col_type: 'movie_2'
                        })
                    } else {
                        d.push({
                            title: data.title,
                            desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                            img: data.image,
                            url: host + '?id=' + data.id + vod,
                            col_type: 'movie_2'
                        })
                    }
                })
            } else if (getMyVar('搜索分类名', '视频') == '全网破解') {
                var Arr = ['ttt', 'loanword', 'loanword_2', '91short', 'sepone', 'lusir', 'cape', 'degree', 'burma', 'novelty', 'intimate', 'confidential', 'park'];
                var platform = host.match(/top\/.*\.php/)[0].split('.php')[0].split('/')[4];
                var item = JSON.parse(fetch(search_url)).videos;
                // log(item)
                item.forEach(data => {
                    if (Arr.includes(platform)) {
                        d.push({
                            title: data.title,
                            img: data.image.replace(/\{.*/, '') + lazy,
                            url: host + '?id=' + data.id + vod,
                            col_type: 'movie_2'
                        })
                    } else {
                        d.push({
                            title: data.title,
                            img: data.image,
                            url: host + '?id=' + data.id + vod,
                            col_type: 'movie_2'
                        })
                    }
                })
            } else if (getMyVar('搜索分类名', '视频') == '短视频') {
                var Arr = ['tiktok18new', '91dspweb', 'douyinmax', '91porn_sifangktv', 'fantasi'];
                var platform = host.match(/top\/.*\.php/)[0].split('.php')[0].split('/')[2];
                var item = JSON.parse(fetch(search_url)).videos;
                // log(item)
                item.forEach(data => {
                    if (Arr.includes(platform)) {
                        d.push({
                            title: data.title,
                            img: data.image + lazy,
                            desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                            url: host + '?id=' + data.id + vod,
                            col_type: 'movie_2'
                        })
                    } else {
                        d.push({
                            title: data.title,
                            desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                            img: data.image,
                            url: host + '?id=' + data.id + vod,
                            col_type: 'movie_2'
                        })
                    }
                })
            } else if (getMyVar('搜索分类').includes('actress') | (getMyVar('搜索分类名', '视频') == '番号') | (getMyVar('搜索分类名', '视频') == '三级')) {
                var Arr = ['shuiguopai'];
                var platform = host.match(/top\/.*\.php/)[0].split('.php')[0].split('/')[2];
                var item = JSON.parse(fetch(search_url)).videos;
                // log(item)
                item.forEach(data => {
                    if (Arr.includes(platform)) {
                        d.push({
                            title: data.title,
                            img: data.image + lazy,
                            desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                            url: host + '?id=' + data.id + vod,
                            col_type: 'movie_2'
                        })
                    } else {
                        d.push({
                            title: data.title,
                            desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                            img: data.image,
                            url: host + '?id=' + data.id + vod,
                            col_type: 'movie_2'
                        })
                    }
                })
            } else if (getMyVar('搜索分类名', '视频') == '吃瓜') {
                var wz = host.match(/top\/.*\.php/)[0].split('.php')[0].split('/')[3];
                var list = JSON.parse(fetch(search_url)).videos;
                // log(item)
                if (wz == 'haijiao') {
                    list.forEach(data => {
                        d.push({
                            title: data.title,
                            desc: data.date,
                            img: data.image + hjlazy,
                            url: 'hiker://empty@rule=js:$.require("csdown").blackerji1()',
                            col_type: 'pic_1',
                            extra: {
                                host: `${host}?id=${data.id}`,
                                wz: wz,
                            }
                        })
                    })
                } else {
                    list.forEach(data => {
                        d.push({
                            title: data.title,
                            desc: data.date,
                            img: ((wz == '51cg') | (wz == 'hlbdy') | (wz == 'tiktok18')) ? (data.image + lazy) : data.image,
                            url: 'hiker://empty@rule=js:$.require("csdown").blackerji1()',
                            col_type: 'pic_1',
                            extra: {
                                host: `${host}?id=${data.id}`,
                                wz: wz,
                            }
                        })
                    })
                }
            } else if (getMyVar('搜索分类名', '视频') == '小说') {
                var wz = host.match(/top\/.*\.php/)[0].split('.php')[0].split('/')[3];
                var list = JSON.parse(fetch(search_url)).videos;
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        url: 'hiker://empty?#readTheme#@rule=js:$.require("csdown").xiaoshuoerji1()',
                        col_type: 'text_1',
                        extra: {
                            host: `${host}?id=${data.id}`,
                            wz: wz,
                        }
                    })
                })
            } else if (getMyVar('搜索分类名', '视频') == '漫画') {
                var wz = host.match(/top\/.*\.php/)[0].split('.php')[0].split('/')[2];
                var list = JSON.parse(fetch(search_url)).videos;
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: data.date,
                        img: data.image,
                        url: 'hiker://empty@rule=js:$.require("csdown").manhuaerji1()',
                        col_type: 'movie_3',
                        extra: {
                            host: `${host}?id=${data.id}`,
                            wz: wz,
                        }
                    })
                })
            } else if (getMyVar('搜索分类名', '视频') == '图片') {
                var wz = host.match(/top\/.*\.php/)[0].split('.php')[0].split('/')[2];
                var list = JSON.parse(fetch(search_url)).videos;
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: data.date,
                        img: wz == 'tiktok18' ? (data.image + lazy) : data.image,
                        //url:'hiker://empty?page=fypage@rule=js:$.require("csdown").tupianerji()',
                        url: wz == 'tuzac' ? (host + '?id=' + data.id + tuzpics) : (host + '?id=' + data.id + pics),
                        col_type: 'movie_3',
                        extra: {
                            host: `${host}?id=${data.id}`,
                            wz: wz,
                        }
                    })
                })
            }
        } catch (e) {
            log(e.message)
        }
        setResult(d)
    },
    aes: $.toString(() => {
        //加载CryptoJS库
        eval(getCryptoJS())
        //13位时间戳
        var t = Math.floor(Date.now());
        //简单匹配
        let sp = (it, s, e) => String(it.split(s)[1]).split(e)[0];
        //颜色
        function strong(d, c) {
            return '‘‘’’<strong><font color=#' + (c || '000000') + '>' + d + '</font></strong>';
        }
        //列表,col默认为'scroll_button'
        function Cate(list, n, d, col) {
            if (!col) {
                col = 'scroll_button';
            }
            var index_n = list[0].id.split('&')[0] + '';
            list.forEach(data => {
                var title = data.title.split('&');
                var id = data.id.split('&');
                if (data.img != null) {
                    var img = data.img.split('&');
                } else {
                    var img = [];
                }
                title.forEach((title, index) => {
                    d.push({
                        title: (getMyVar(n, index_n) == id[index] ? strong(title, 'FF6699') : title),
                        img: img[index],
                        url: $('#noLoading#').lazyRule((n, title, id) => {
                            putMyVar(n, id);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, n, title, id[index] + ''),
                        col_type: col,
                    })
                })
                d.push({
                    col_type: 'blank_block',
                });
            })
            return d;
        }
        //生成时间戳
        function getCurrentTimestamp() {
            return new Date().getTime();
        }
        //md5加密
        function md5(str) {
            return CryptoJS.MD5(str).toString();
        }
        //sha256加密
        function sha256(str) {
            return CryptoJS.SHA256(str).toString();
        }
        //颜色
        function color(txt) {
            return '<b><font color=' + '#FF6699' + '>' + txt + '</font></b>'
        }
        //茄子解密函数
        function qzDecrypt(word) {
            const key = CryptoJS.enc.Utf8.parse("yinsu12345abcdef");
            const iv = CryptoJS.enc.Utf8.parse("keji123456999999");
            let encryptedHexStr = CryptoJS.enc.Base64.parse(word);
            let decrypt = CryptoJS.AES.decrypt({
                ciphertext: encryptedHexStr
            }, key, {
                iv: iv,
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.Pkcs7
            });
            if (decrypt) {
                let decryptedStr = decrypt.toString(CryptoJS.enc.Utf8);
                return decryptedStr;
            } else {
                // 解密失败，返回null或错误信息
                return null;
            }
        }

        // 猫咪视频解密函数
        function mmDecrypt(word, iv0) {
            const key = CryptoJS.enc.Utf8.parse("IdTJq0HklpuI6mu8iB%OO@!vd^4K&uXW");
            const iv = CryptoJS.enc.Utf8.parse("$0v@krH7V2" + iv0);
            let encryptedHexStr = CryptoJS.enc.Base64.parse(word);
            let decrypt = CryptoJS.AES.decrypt({
                ciphertext: encryptedHexStr
            }, key, {
                iv: iv,
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.Pkcs7
            });
            if (decrypt) {
                let decryptedStr = decrypt.toString(CryptoJS.enc.Utf8);
                return decryptedStr;
            } else {
                // 解密失败，返回null或错误信息
                return null;
            }
        }
        //猫咪视频图片
        var mmlazy = $('').image(() => {
            const CryptoUtil = $.require("hiker://assets/crypto-java.js");
            let textData = CryptoUtil.Data.parseInputStream(input);
            let base64Text = textData.toString().split("base64,")[1];
            let encrypted0 = CryptoUtil.Data.parseBase64(base64Text, _base64.NO_WRAP);
            return encrypted0.toInputStream();
        })

        //猫咪视频请求
        var mmvod = $('').lazyRule(() => {
            eval($.require('csdown').rely($.require('csdown').aes));
            try {
                var wsTime = Math.floor(Date.now() / 1000);
                var wsSecret = md5('D7hGKHnWThaECaQ3ji4XyAF3MfYKJ53M' + input + wsTime);
                return getItem('maomi_video') + input + '?wsSecret=' + wsSecret + '&wsTime=' + wsTime + `#isVideo=true#`
            } catch (e) {
                log(e.message)
                return 'toast://请求失败'
            }
        })

        // 猫咪解密函数
        function Decrypt(word) {
            const key = CryptoJS.enc.Utf8.parse("625222f9149e961d");
            const iv = CryptoJS.enc.Utf8.parse("5efdtf6060e2o330");
            let encryptedHexStr = CryptoJS.enc.Hex.parse(word);
            let decrypt = CryptoJS.AES.decrypt({
                ciphertext: encryptedHexStr
            }, key, {
                iv: iv,
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.Pkcs7
            });
            if (decrypt) {
                let decryptedStr = decrypt.toString(CryptoJS.enc.Utf8);
                return decryptedStr;
            } else {
                // 解密失败，返回null或错误信息
                return null;
            }
        }

        // 猫咪加密函数
        function Encrypt(plaintext) {
            const key = CryptoJS.enc.Utf8.parse("625222f9149e961d");
            const iv = CryptoJS.enc.Utf8.parse("5efdtf6060e2o330");
            var encrypted = CryptoJS.AES.encrypt(plaintext, key, {
                iv: iv,
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.Pkcs7
            });
            var ciphertext = encrypted.ciphertext.toString(CryptoJS.enc.Hex);
            return ciphertext.toUpperCase();
        }

        var lazy = $('').image(() => {
            const CryptoUtil = $.require("hiker://assets/crypto-java.js");
            let id = CryptoUtil.Data.parseUTF8("f5d965df75336270");
            let iv = CryptoUtil.Data.parseUTF8("97b60394abc2fbe1");
            let textData = CryptoUtil.Data.parseInputStream(input);
            let encrypted = CryptoUtil.AES.decrypt(textData, id, {
                mode: "AES/CBC/PKCS7Padding",
                iv: iv
            });
            return encrypted.toInputStream();
        })

        //视频请求
        var vod = $('').lazyRule(() => {
            try {
                var url = JSON.parse(fetch(input)).video;
                return url + `#isVideo=true#`
            } catch (e) {
                log(e.message)
                return 'toast://请求失败'
            }
        })
        //图片请求
        var pics = $('').lazyRule(() => {
            try {
                let img = JSON.parse(fetch(input)).content.replace(/\$/g, '').replace(/分割/g, '').split('@');
                return 'pics://' + img.join('&&');
            } catch (e) {
                log(e.toString())
                return 'toast://请求失败，请重试'
            }
        })
        //图宅
        var tuzpics = $('').lazyRule(() => {
            try {
                let img = request(input).match(/\"\$http.*\@\"/g)[0].split('"')[1].replace(/\\/g, '').replace(/\$/g, '').replace(/分割/g, '').split('@');
                return 'pics://' + img.join('&&');
            } catch (e) {
                log(e.toString())
                return 'taost://响应慢，可以多试几次'
            }
        })
        //猫咪漫画解析
        var maomimanhuajx = $('').lazyRule(() => {
            eval($.require('csdown').rely($.require('csdown').aes));
            var sign = Encrypt('{"user_id":1790368,"list_id":' + input + '}');
            var host = 'http://119.28.52.193:8089/api/comic/watch?params=' + sign;
            var body = 'params=' + sign;
            var html = fetch(host, {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                method: 'POST'
            });
            var html2 = Decrypt(html)
            var list = JSON.parse(html2).data;
            let picArr = [];
            let len = list.length - 1;
            for (i = 0; i <= len; i++) {
                picArr[i] = list[i].image;
            }
            return 'pics://' + picArr.join('&&');
        })

        //猫咪FM解析
        var maomifmjx = $('').lazyRule(() => {
            eval($.require('csdown').rely($.require('csdown').aes));
            var sign = Encrypt('{"id":' + input + '}');
            var host = 'http://119.28.52.193:8089/api/book/detail?params=' + sign;
            var body = 'params=' + sign;
            var html = fetch(host, {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                method: 'POST'
            });
            var html2 = Decrypt(html)
            var url = JSON.parse(html2).data.data[0].content;
            return url
        })

        //猫咪解析
        var maomijx = $('').lazyRule(() => {
            eval($.require('csdown').rely($.require('csdown').aes));
            var sign = Encrypt('{"id":' + input + '}');
            var host = 'http://119.28.52.193:8089/api/video/detail?params=' + sign;
            var body = 'params=' + sign;
            var html = fetch(host, {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                method: 'POST'
            });
            var html2 = Decrypt(html)
            //下载
            //var down=JSON.parse(html2).data.videos[0].down;
            //文件
            var url = JSON.parse(html2).data.videos[0].file;
            return url
        })

        //麻豆加密函数
        function mdEncrypt(plaintext) {
            const key = CryptoJS.enc.Utf8.parse("Vq234zBeSdGgYXzVTEfnnjjdmaTkk7A4");
            const iv = CryptoJS.enc.Utf8.parse("-p9B[~PnPs173150");
            var encrypted = CryptoJS.AES.encrypt(plaintext, key, {
                iv: iv,
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.Pkcs7 // 注意这里应该是CryptoJS.pad.NoPadding
            });
            var ciphertext = encrypted.ciphertext.toString(CryptoJS.enc.Base64);
            return ciphertext;
        }

        // 麻豆解密函数
        function mdDecrypt(word) {
            const key = CryptoJS.enc.Utf8.parse("Vq234zBeSdGgYXzVTEfnnjjdmaTkk7A4");
            const iv = CryptoJS.enc.Utf8.parse("-p9B[~PnPs" + iv0);
            let encryptedHexStr = CryptoJS.enc.Base64.parse(word);
            let decrypt = CryptoJS.AES.decrypt({
                ciphertext: encryptedHexStr
            }, key, {
                iv: iv,
                mode: CryptoJS.mode.CBC,
                padding: CryptoJS.pad.Pkcs7 // 注意这里应该是CryptoJS.pad.NoPadding
            });
            if (decrypt) {
                let decryptedStr = decrypt.toString(CryptoJS.enc.Utf8);
                return decryptedStr;
            } else {
                // 解密失败，返回null或错误信息
                return null;
            }
        }

        //麻豆图片解密
        var mdlazy = $('').image(() => {
            const CryptoUtil = $.require("hiker://assets/crypto-java.js");
            let key = CryptoUtil.Data.parseUTF8("pnhXgN0U");
            let iv = CryptoUtil.Data.parseUTF8("GY4gEvBD");
            let textData = CryptoUtil.Data.parseInputStream(input).base64Decode();
            let encrypted = CryptoUtil.DES.decrypt(textData, key, {
                mode: "DES/CBC/PKCS7Padding",
                iv: iv
            });
            let base64Text = encrypted.toString().split("base64,")[1];
            let encrypted0 = CryptoUtil.Data.parseBase64(base64Text, _base64.NO_WRAP);
            return encrypted0.toInputStream();
        })

        //91tv视频解析
        var tvvod = $('').lazyRule(() => {
            eval(getCryptoJS())

            function md5(str) {
                return CryptoJS.MD5(str).toString();
            }
            var t0 = Math.floor(Date.now() / 1000) + 1;
            var wsSecret = md5('E9MpC7D5AqWvjmXL3hGkQ2XjZNohAQ' + input.replace(/http(s)?:\/\/.*?\//g, '/') + t0);
            var url = input + '?wsSecret=' + wsSecret + '&wsTime=' + t0;
            writeFile('hiker://files/cache/video0.m3u8', request(url));
            return getPath('hiker://files/cache/video0.m3u8') + '#' + url;
        })
        //lutube图片解密
        var lulazy = $('').image(() => {
            const CryptoUtil = $.require("hiker://assets/crypto-java.js");
            let key = CryptoUtil.Data.parseHex("b2f3842866f9583d1ece61c4e055c255");
            let iv = CryptoUtil.Data.parseHex("e01ede6331d37afcc7be05597d654d22");
            let textData = CryptoUtil.Data.parseInputStream(input);
            let encrypted = CryptoUtil.AES.decrypt(textData, key, {
                mode: "AES/CBC/PKCS7Padding",
                iv: iv
            });
            return encrypted.toInputStream();
        })
        //ins图片解密，base64
        var inslazy = $('').image(() => {
            const CryptoUtil = $.require("hiker://assets/crypto-java.js");
            let textData = CryptoUtil.Data.parseInputStream(input);
            let base64Text = textData.toString().split("base64,")[1];
            let encrypted0 = CryptoUtil.Data.parseBase64(base64Text, _base64.NO_WRAP);
            return encrypted0.toInputStream();
        })


        //海角图片解密
        var hjlazy = $('').image(() => {
            var n = function(e) {
                for (o = "", i = 0, a = 0, void 0; i < e.length;) {
                    var t, n, o, i, a;
                    (t = e.charCodeAt(i)) < 128 ? (o += String.fromCharCode(t), i++) : 191 < t && t < 224 ? (a = e.charCodeAt(i + 1), o += String.fromCharCode((31 & t) << 6 | 63 & a), i += 2) : (a = e.charCodeAt(i + 1), n = e.charCodeAt(i + 2), o += String.fromCharCode((15 & t) << 12 | (63 & a) << 6 | 63 & n), i += 3);
                }
                return o;
            };
            var decryptData = function(t) {
                var o, i, a, r, s, c, u = "",
                    d = 0,
                    tt = "ABCD*EFGHIJKLMNOPQRSTUVWX#YZabcdefghijklmnopqrstuvwxyz1234567890"
                for (t = t.replace(/[^A-Za-z0-9\*\#]/g, ""); d < t.length;) a = tt.indexOf(t.charAt(d++)), o = (15 & (r = tt.indexOf(t.charAt(d++)))) << 4 | (s = tt.indexOf(t.charAt(d++))) >> 2, i = (3 & s) << 6 | (c = tt.indexOf(t.charAt(d++))), u += String.fromCharCode(a << 2 | r >> 4), 64 != s && (u += String.fromCharCode(o)), 64 != c && (u += String.fromCharCode(i));
                return n(u);
            };

            let javaImport = new JavaImporter();
            javaImport.importPackage(
                Packages.com.example.hikerview.utils
            );
            with(javaImport) {
                let bytes = FileUtil.toBytes(input);
                bytes = new java.lang.String(bytes, 'UTF-8')
                let res = decryptData(bytes + "");
                res = new java.lang.String(res)
                res = res.split("base64,")[1];
                return FileUtil.toInputStream(_base64.decode(res, _base64.NO_WRAP));
            }
        })
        //时间戳转换
        function timestampToTime(tm, ts) {
            var date = new Date(tm * 1000); //时间戳为10位需*1000，时间戳为13位的话不需乘1000
            var Y = date.getFullYear() + '-';
            var M = (date.getMonth() + 1 < 10 ? '0' + (date.getMonth() + 1) : date.getMonth() + 1) + '-';
            var D = date.getDate();
            var h = ' | ' + date.getHours() + ':';
            var m = date.getMinutes();
            if (m < 10) m = '0' + m;
            m = m + ':'
            var s = date.getSeconds();
            if (s < 10) s = '0' + s;
            if (ts == 0) return Y + M + D;
            if (ts == 1) return Y + M + D + h + m + s;
        }


        function pageAdd(page) {
            if (getMyVar("page")) {
                putMyVar("page", (parseInt(page) + 1) + '');
            }
            return;
        } //翻页

        function pageMoveto(page, pages) {
            var longClick = [{
                title: "首页",
                js: $.toString(() => {
                    putMyVar("page", "1");
                    refreshPage(false);
                    return "hiker://empty";
                }),
            }, {
                title: "上页",
                js: $.toString((page) => {
                    if (page > 1) {
                        putMyVar("page", (parseInt(page) - 1));
                        refreshPage(false);
                        return "hiker://empty";
                    }
                }, page),
            }, {
                title: "当前第" + page + "页",
                js: "",
            }, {
                title: "跳转",
                js: $.toString(() => {
                    return $("").input(() => {
                        putMyVar("page", input);
                        refreshPage(false);
                    });
                }),
            }];
            if (typeof(pages) != 'undefined') {
                var extra1 = {
                    title: "尾页" + pages,
                    js: $.toString((pages) => {
                        putMyVar("page", pages);
                        refreshPage(false);
                        return "hiker://empty";
                    }, pages),
                };
                longClick.push(extra1)
            }
            return longClick
        } //长按跳页
    }),
    syvideo: () => {
        js: var d = csdown.d;
        eval(csdown.rely(csdown.aes))
        try {
            let host = MY_PARAMS.host;
            var wz = MY_PARAMS.wz;
            var pg = getParam('page');
            if (wz == 'baomads') {
                var host = MY_PARAMS.host.replace('baomads', 'baoma/baomads');
            }
            if (MY_PAGE == 1) {
                var 首页视频分类 = fetch(host + '?getsort')
                var data = JSON.parse(首页视频分类).categories;
                var index_n = data[0].id.toString();
                putMyVar('index_' + wz, index_n)
                data.forEach(data => {
                    d.push({
                        title: getMyVar('首页视频分类' + wz, index_n) == data.id.toString() ? strong(data.title, 'FF6699') : data.title,
                        url: $('#noLoading#').lazyRule((title, id, wz) => {
                            putMyVar('首页视频分类' + wz, id);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, data.title, data.id.toString(), wz),
                        col_type: 'scroll_button'
                    })
                })
            }

            var list = JSON.parse(fetch(host + '?sort=' + getMyVar('首页视频分类' + wz, getMyVar('index_' + wz)) + '&page=' + pg)).videos;
            var Arr = ['lutube', 'pali'];
            var Brr = ['kuaimao', 'fed', 'mmsp', 'cmav', 'hsck2', 'xiangjiao', 'xiangjiaonew', '97dy', 'btt', 'tasexy', 'kuaimaoweb', 'kuaimao_new'];
            list.forEach(data => {
                if (Arr.includes(wz)) {
                    d.push({
                        title: data.title,
                        desc: data.date + '   ' + data.duration,
                        img: data.image + lulazy,
                        url: host + '?id=' + data.id + $('').lazyRule(() => {
                            eval($.require('csdown').rely($.require('csdown').aes));;
                            try {
                                //duration.match(/(\d+)/)[1]>60判断并不准确
                                var url = JSON.parse(fetch(input + '&type=short')).video;
                                if (url == null) {
                                    var url = JSON.parse(fetch(input + '&type=long')).video;
                                }
                                return url + `#isVideo=true#`
                            } catch (e) {
                                log(e.message)
                                return 'toast://请求失败'
                            }
                        }),
                        col_type: 'movie_2'
                    })
                } else if (Brr.includes(wz)) {
                    d.push({
                        title: data.title,
                        desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.createtime == null ? '' : data.createtime) + '  ' + (data.date == null ? '' : data.date),
                        img: data.image,
                        url: host + '?id=' + data.id + vod,
                        col_type: 'movie_2'
                    })
                } else if (wz == 'ins') {
                    d.push({
                        title: data.title,
                        desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                        img: data.image + inslazy,
                        url: host + '?id=' + data.id + vod,
                        col_type: 'movie_2'
                    })
                } else if (wz == 'savsp') {
                    d.push({
                        title: data.title,
                        desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                        img: data.image,
                        url: $('').lazyRule((host, id) => {
                            var url = host + '?id=' + id;
                            try {
                                var url0 = JSON.parse(fetch(url)).video;
                                if (url0.includes('https://www.savsp.com')) {
                                    // 设置域名组
                                    var domainGroup = [
                                        'https://cdn4.yd2.cn:8683/m3u8',
                                        'https://cdn13.yd2.cn:886/m3u8',
                                        'https://cdn14.yd2.cn:8088/m3u8',
                                        'https://cdn5.yd2.cn:444/m3u8',
                                        'https://cdn7.yd2.cn:7879/m3u8',
                                        'https://cdn.yd2.cn:8083/m3u8',
                                        'https://cdn9.yd2.cn:7788/m3u8'
                                    ];
                                    url0 = url0.replace('https://www.savsp.com', '')
                                    for (var i in domainGroup) {
                                        domainGroup[i] = domainGroup[i] + url0;
                                    }
                                    var url1 = {
                                        urls: domainGroup
                                    }
                                    return url1;
                                } else {
                                    return url0 + `#isVideo=true#`;
                                }
                            } catch (e) {
                                log(e.toString())
                            }
                        }, host, data.id),
                        col_type: 'movie_2'
                    })
                } else {
                    if (data.image) {
                        var img = data.image;
                        d.push({
                            title: data.title,
                            desc: (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date) + '  ' + (data.duration == null ? '' : data.duration),
                            img: (img.includes('upload') || img.includes('new.')) ? (data.image + lazy) : data.image,
                            url: host + '?id=' + data.id + vod,
                            col_type: 'movie_2'
                        })
                    }
                }
            })
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    maomiFM: () => {
        var d = $.require('csdown').d;
        eval($.require('csdown').rely($.require('csdown').aes));
        //var pg = getParam('page');
        var pg = MY_PAGE
        var 猫咪FM = [{
            title: '都市激情&家庭乱 伦&另类小说&青春校园&情 色笑话&人 妻乱 伦&性 爱技巧&玄幻奇幻',
            id: '8&9&10&11&12&13&14&15'
        }];
        if (MY_PAGE == 1) {
            Cate(猫咪FM, '猫咪FM', d);
        }
        var sign = Encrypt('{"page":' + pg + ',"cate_id":' + getMyVar('猫咪FM', '8') + ',"status":0,"type":0,"new":0}');
        var host = 'http://119.28.52.193:8089/api/book/index?params=' + sign;
        var body = 'params=' + sign;
        var html = fetch(host, {
            headers: {
                'Content-Type': 'application/x-www-form-urlencoded',
            },
            body: body,
            method: 'POST'
        });
        var html2 = Decrypt(html)
        var list = JSON.parse(html2).data.data;
        list.forEach(data => {
            d.push({
                title: data.name,
                img: data.thumb,
                url: data.id + maomifmjx,
                col_type: 'movie_3'
            })
        })

        setResult(d)
    },
    videoerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes))
        try {
            let host = MY_PARAMS.host;
            var wz = MY_PARAMS.wz;
            let pg = getParam('page');
            if (MY_PAGE == 1) {
                var 视频分类 = fetch(host + '?getsort')
                let data = JSON.parse(视频分类);
                //log(data)
                var keys = Object.keys(data).slice(2);
                //log(keys)
                var key_n = keys[0];
                putMyVar('key_' + wz, key_n);
                keys.forEach(key => {
                    d.push({
                        title: getMyVar('视频分类' + wz, getMyVar('key_' + wz)) == key ? strong(key, 'FF6699') : key,
                        url: $('#noLoading#').lazyRule((key, wz) => {
                            putMyVar('视频分类' + wz, key);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, key, wz),
                        col_type: 'scroll_button',
                    })
                })
                d.push({
                    col_type: 'blank_block',
                });
                var id_n = getMyVar('视频分类二级' + getMyVar('视频分类' + wz, getMyVar('key_' + wz)) + wz, data[getMyVar('视频分类' + wz, getMyVar('key_' + wz))][0].id + '');
                putMyVar('id_' + wz, id_n);
                data[getMyVar('视频分类' + wz, getMyVar('key_' + wz))].forEach(data => {
                    d.push({
                        title: getMyVar('视频分类二级' + getMyVar('视频分类' + wz, getMyVar('key_' + wz)) + wz, id_n) == data.id ? strong(data.title, 'FF6699') : data.title,
                        //url: 'hiker://page/voderji1?page=fypage&#noHistory#',
                        url: $('#noLoading#').lazyRule((n, title, id) => {
                            putMyVar(n, id);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, '视频分类二级' + getMyVar('视频分类' + wz, getMyVar('key_' + wz)) + wz, data.title, data.id),
                        col_type: 'scroll_button',
                        extra: {
                            host: `${host}?sort=${data.id}&page=`,
                            wz: wz,
                        }
                    })
                })
            }
            var Arr = ['xbk', 'md', 'caoliu', 'heiliaoshequ', 'maomi', 'xcl', 'qisemao']
            var url_a = `${host}?sort=${getMyVar('视频分类二级'+ getMyVar('视频分类' + wz, getMyVar('key_' + wz)) + wz,getMyVar('id_' + wz))}&page=` + pg;
            var url = url_a.split('?')[0];
            var list = JSON.parse(fetch(url_a)).videos;
            // log(list)
            if (Arr.includes(wz)) {
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: (data.duration == null ? '' : data.duration) + (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                        img: data.image,
                        url: url + '?id=' + data.id + vod,
                        col_type: 'movie_2'
                    })
                })
            } else if (wz == '91pf') {
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: parseInt(data.duration / 60) + ':' + parseInt(data.duration % 60),
                        img: data.image + lazy,
                        url: url + '?id=' + data.id + vod,
                        col_type: 'movie_2'
                    })
                })
            } else {
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: (data.date.includes('-') ? data.date : data.created_date) + '\t\t\t\t' + (data.duration == null ? '' : data.duration),
                        img: data.image + lazy,
                        url: url + '?id=' + data.id + vod,
                        col_type: 'movie_2'
                    })
                })
            }
        } catch (e) {
            log(e.message)
            toast('未获取到内容，请更换分类')
        }
        setResult(d)
    },
    voderji1: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes))
        var pg = getParam('page');
        var host = MY_PARAMS.host + pg;
        var url = host.split('?')[0];
        var wz = MY_PARAMS.wz;
        try {
            var Arr = ['xbk', 'md', 'caoliu', 'heiliaoshequ', 'maomi', 'xcl', 'qisemao']
            var list = JSON.parse(fetch(host)).videos;
            // log(list)
            if (Arr.includes(wz)) {
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: (data.duration == null ? '' : data.duration) + (data.created_date == null ? '' : data.created_date) + '  ' + (data.date == null ? '' : data.date),
                        img: data.image,
                        url: url + '?id=' + data.id + vod,
                        col_type: 'movie_2'
                    })
                })
            } else if (wz == '91pf') {
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: parseInt(data.duration / 60) + ':' + parseInt(data.duration % 60),
                        img: data.image + lazy,
                        url: url + '?id=' + data.id + vod,
                        col_type: 'movie_2'
                    })
                })
            } else {
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: (data.date.includes('-') ? data.date : data.created_date) + '\t\t\t\t' + (data.duration == null ? '' : data.duration),
                        img: data.image + lazy,
                        url: url + '?id=' + data.id + vod,
                        col_type: 'movie_2'
                    })
                })
            }

        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    blackerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            var host = MY_PARAMS.host;
            var wz = MY_PARAMS.wz;
            var pg = getParam('page');
            if (MY_PAGE == 1) {
                var 黑料分类 = fetch(host + '?getsort')
                var data = JSON.parse(黑料分类).categories;
                var index_n = data[0].id.toString();
                putMyVar('index_' + wz, index_n)
                data.forEach(data => {
                    d.push({
                        title: getMyVar('黑料分类' + wz, index_n) == data.id.toString() ? strong(data.title, 'FF6699') : data.title,
                        url: $('#noLoading#').lazyRule((title, id, wz) => {
                            putMyVar('黑料分类' + wz, id);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, data.title, data.id.toString(), wz),
                        col_type: 'scroll_button'
                    })
                })
            }
            var list = JSON.parse(fetch(host + '?sort=' + getMyVar('黑料分类' + wz, getMyVar('index_' + wz)) + '&page=' + pg)).videos;
            //log(list)
            if (wz == 'haijiao') {
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: data.date,
                        img: data.image + hjlazy,
                        url: 'hiker://empty@rule=js:$.require("csdown").blackerji1()',
                        col_type: 'pic_1_card',
                        extra: {
                            host: `${host}?id=${data.id}`,
                            wz: wz,
                        }
                    })
                })
            } else {
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: data.date,
                        img: wz == 'hlbdy' || wz == 'daily' || wz == '51cg' ? (data.image + lazy) : data.image,
                        url: 'hiker://empty@rule=js:$.require("csdown").blackerji1()',
                        col_type: 'pic_1_card',
                        extra: {
                            host: `${host}?id=${data.id}`,
                            wz: wz,
                        }
                    })
                })
            }
        } catch (e) {
            log(e.message)
        }
        setResult(d)
    },
    blackerji1: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes))
        var url = MY_PARAMS.host;
        var wz = MY_PARAMS.wz;
        try {
            var data = JSON.parse(fetch(url));
            //log(data)
            d.push({
                title: pdfh(data.titleCode, 'h1&&Text') == '' ? pdfh(data.titleCode, 'h2&&Text') : pdfh(data.titleCode, 'h1&&Text'),
                col_type: 'rich_text'
            })
            if (wz == 'cgw') {
                var videos = data.video.replace(/\$/g, '').split('@');
                var img = data.imgcode.match(/src\=\".*?\".*?alt/)[0].split('"')[1];
                videos.forEach((item, index) => {
                    var n = index + 1;
                    if (item) {
                        d.push({
                            title: '视频' + n,
                            desc: '0',
                            img: img,
                            url: item.replace('分割', ''),
                            col_type: 'card_pic_1',
                        });
                    }
                })
                d.push({
                    title: data.imgcode,
                    col_type: 'rich_text',
                })
            } else if (wz == 'gtl') {
                var videos = data.video.replace(/\$/g, '').split('@');
                var img = data.picCode.match(/src\=\".*?\".*?alt/)[0].split('"')[1];
                videos.forEach((item, index) => {
                    var n = index + 1;
                    if (item) {
                        d.push({
                            title: '视频' + n,
                            desc: '0',
                            img: img,
                            url: item.replace('分割', ''),
                            col_type: 'card_pic_1',
                        });
                    }
                })
                d.push({
                    title: data.picCode,
                    col_type: 'rich_text',
                })
            } else if (wz == 'tiktok18') {
                var videos = data.video.replace(/\$/g, '').split('@');
                var imgs = data.picCode.replace(/\$/g, '').split('@分割');
                videos.forEach((item, index) => {
                    var n = index + 1;
                    if (item) {
                        d.push({
                            title: '视频' + n,
                            desc: '0',
                            img: imgs[0] + lazy,
                            url: item.replace('分割', ''),
                            col_type: 'card_pic_1',
                        });
                    }
                })
                var texts = data.imgcode.replace(/\<p\>/, '&&&<p>').replace(/\<\/p\>/, '&&&</p>').split('&&&');
                //  log(texts)
                texts.forEach((item, index) => {
                    if (pdfh(item, 'p&&Text')) {
                        d.push({
                            title: pdfh(item, 'p&&Text'),
                            col_type: 'rich_text',
                        });
                    }
                    if (pdfh(item, 'h1&&Text')) {
                        d.push({
                            title: pdfh(item, 'p&&Text'),
                            col_type: 'rich_text',
                        });
                    }
                    if (pdfh(item, 'h2&&Text')) {
                        d.push({
                            title: pdfh(item, 'p&&Text'),
                            col_type: 'rich_text',
                        });
                    }
                })
                var imgs = data.picCode.replace(/\$/g, '').split('@分割');
                imgs.forEach((item, index) => {
                    if (item) {
                        d.push({
                            img: item + lazy,
                            url: item + lazy,
                            col_type: 'pic_1_full',
                        });
                    }
                })
            } else if (wz == '51cg' || wz == 'daily') {
                var n = 0
                var texts = data.imgcode.replace(/pstyle/g, 'p style').replace(/\<\/p.*?\>\<p.*?\>/g, '</p>&&<p>').split('&&');
                // log(texts)
                texts.forEach((item, index) => {
                    if (pdfh(item, '.dplayer&&data-config') != '') {
                        let url = JSON.parse(pdfh(item, '.dplayer&&data-config')).video;
                        n++;
                        d.push({
                            title: '““视频””  ' + n,
                            desc: '0',
                            img: url.pic + lazy,
                            url: url.url.replace(/\/\/.*play\./, '//long.'),
                            col_type: 'card_pic_1'
                        });
                    }
                })
                texts.forEach((item, index) => {
                    if (pdfh(item, 'p&&Text')) {
                        d.push({
                            title: pdfh(item, 'p&&Text'),
                            col_type: 'rich_text',
                        });
                    }
                    var imgs = pdfa(item, 'p&&img').map(h => pdfh(h, 'img&&data-xkrkllgl'));
                    imgs.forEach(item2 => {
                        d.push({
                            title: '',
                            img: item2 + lazy,
                            url: item2 + lazy,
                            col_type: 'pic_1_full'
                        });
                    });
                    if (pdfh(item, '.dplayer&&data-config') != '') {
                        let url = JSON.parse(pdfh(item, '.dplayer&&data-config')).video;
                        n++;
                        d.push({
                            title: '““视频””  ' + n,
                            desc: '0',
                            img: url.pic + lazy,
                            url: url.url.replace(/\/\/.*play\./, '//long.'),
                            col_type: 'card_pic_1'
                        });
                    }
                })
            } else if (wz == 'hlbdy') {
                var n = 0
                var texts = data.picCode.replace(/\<\/p\>\n\<p\>/g, '</p>&&<p>').split('&&');
                // log(texts)
                texts.forEach((item, index) => {
                    if (pdfh(item, '.dplayer&&config') != '') {
                        let url = JSON.parse(pdfh(item, '.dplayer&&config')).video;
                        n++;
                        d.push({
                            title: '““视频””  ' + n,
                            desc: '0',
                            img: url.pic + lazy,
                            url: url.url.replace(/\/\/.*play\./, '//long.'),
                            col_type: 'card_pic_1'
                        });
                    }
                })
                var n = 0;
                texts.forEach((item, index) => {
                    if (pdfh(item, 'p&&Text')) {
                        d.push({
                            title: pdfh(item, 'p&&Text'),
                            col_type: 'rich_text',
                        });
                    }
                    var imgs = pdfa(item, 'p&&img').map(h => pdfh(h, 'img&&onload'));
                    imgs.forEach(item2 => {
                        d.push({
                            title: '',
                            img: item2.split("(this,'")[1].split("')")[0] + lazy,
                            url: item2.split("(this,'")[1].split("')")[0] + lazy,
                            col_type: 'pic_1_full'
                        });
                    });
                    if (pdfh(item, '.dplayer&&config') != '') {
                        let url = JSON.parse(pdfh(item, '.dplayer&&config')).video;
                        n++;
                        d.push({
                            title: '““视频””  ' + n,
                            desc: '0',
                            img: url.pic + lazy,
                            url: url.url.replace(/\/\/.*play\./, '//long.'),
                            col_type: 'card_pic_1'
                        });
                    }
                })
            } else if (wz == 'haijiao') {
                try {
                    var videos = data.video.replace(/\$/g, '').split('@');
                    var img = data.picCode.match(/xkrkllgl\=\".*?\".*?alt/)[0].split('"')[1];
                    videos.forEach((item, index) => {
                        var n = index + 1;
                        if (item) {
                            d.push({
                                title: '视频' + n,
                                desc: '0',
                                img: img + hjlazy,
                                url: item.replace('分割', '') + '#isVideo=true#',
                                col_type: 'card_pic_1',
                            });
                        }
                    })
                    var texts = data.picCode.replace(/pstyle/g, 'p style').replace(/\<\/p\>/g, '</p>&&').split('&&');
                    texts.forEach((item, index) => {
                        if (pdfh(item, 'p&&Text')) {
                            d.push({
                                title: pdfh(item, 'p&&Text'),
                                col_type: 'rich_text',
                            });
                        }
                        var img = item.match(/xkrkllgl\=\".*?\".*?alt/);
                        if (img) {
                            // log(img)
                            d.push({
                                img: img[0].split('"')[1] + hjlazy,
                                url: img[0].split('"')[1] + hjlazy,
                                col_type: 'pic_1_full'
                            })
                        }
                    })
                } catch {}
            } else if (wz == 'kanliao') {
                var texts = data.picCode.replace(/\<br\>/g, '&&').split('&&');
                var n = 0;
                texts.forEach((item, index) => {
                    if (pdfh(item, '.dplayer&&data-config') != '') {
                        let url = JSON.parse(pdfh(item, '.dplayer&&data-config')).video;
                        n++;
                        d.push({
                            title: '视频 ' + n,
                            // desc:'0',
                            img: url.pic,
                            url: url.url.replace(/\/\/.*play\./, '//long.'),
                            col_type: 'text_1'
                        });
                    }
                })
                d.push({
                    title: data.picCode,
                    col_type: 'rich_text',
                })
            }

        } catch {}
        setResult(d)
    },
    nvyouerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            let host = MY_PARAMS.host;
            var wz = MY_PARAMS.wz;
            var pg = getParam('page');
            var item = request(host + '?actress=&page=' + pg)
            var data = JSON.parse(item).actresses;
            data.forEach(data => {
                d.push({
                    title: data.title,
                    desc: data.number,
                    img: data.image,
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").nvyouerji1()',
                    col_type: 'card_pic_3',
                    extra: {
                        host: `${host}?sort=${data.id}&page=`,
                        wz: wz,
                    }
                })
            })

        } catch (e) {
            log(e.message)
        }
        setResult(d)
    },
    nvyouerji1: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        var pg = getParam('page');
        var host = MY_PARAMS.host + pg;
        var url = host.split('?')[0];
        var wz = MY_PARAMS.wz;
        try {
            let list = JSON.parse(fetch(host)).videos;
            //log(list)
            list.forEach(data => {
                d.push({
                    title: data.title,
                    img: data.image,
                    desc: (data.createtime == null ? '' : data.createtime) + '  ' + (data.date == null ? '' : data.date),
                    url: url + '?id=' + data.id + vod,
                    col_type: 'movie_2'
                })
            })
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    picerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            let host = MY_PARAMS.host.replace('comic', 'picture');
            var wz = MY_PARAMS.wz;
            var pg = getParam('page');
            if (MY_PAGE == 1) {
                var 图片分类 = fetch(host + '?getsort')
                var data = JSON.parse(图片分类).categories;
                var index_n = data[0].id.toString();
                putMyVar('index_' + wz, index_n);
                data.forEach(data => {
                    d.push({
                        title: getMyVar('图片分类' + wz, index_n) == data.id.toString() ? strong(data.title, 'FF6699') : data.title,
                        url: $('#noLoading#').lazyRule((title, id, wz) => {
                            putMyVar('图片分类' + wz, id);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, data.title, data.id.toString(), wz),
                        col_type: 'scroll_button'
                    })
                })
            }
            var list = JSON.parse(fetch(host + '?sort=' + getMyVar('图片分类' + wz, getMyVar('index_' + wz)) + '&page=' + pg)).videos;
            //log(list)
            if (list != null) {
                list.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: data.date,
                        img: wz == 'tiktok18' ? (data.image + lazy) : data.image,
                        //url: 'hiker://empty?@rule=js:$.require("csdown").tupianerji()',
                        url: wz == 'tuzac' ? (host + '?id=' + data.id + tuzpics) : (host + '?id=' + data.id + pics),
                        col_type: 'movie_3',
                        extra: {
                            host: `${host}?id=${data.id}`,
                            wz: wz,
                        }
                    })
                })
            } else {
                toast('换个分类试试吧!')
            }
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    tupianerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        let host = MY_PARAMS.host;
        let url = host.split('?')[0];
        var wz = MY_PARAMS.wz;
        try {
            let img = JSON.parse(fetch(host)).content.replace(/\$/g, '').replace(/分割/g, '').split('@');
            img.forEach(data => {
                d.push({
                    img: data,
                    url: 'pics://' + img.join('&&'),
                    col_type: 'pic_1_full'
                })
            })

        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    zhiboerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            let host = MY_PARAMS.host;
            var wz = MY_PARAMS.wz;
            if (MY_PAGE == 1) {
                var 直播分类 = fetch(host + '?getpingtai')
                var data = JSON.parse(直播分类).pingtai;
                data.forEach(data => {
                    d.push({
                        title: data.title,
                        img: data.image,
                        url: 'hiker://empty?@rule=js:$.require("csdown").zhiboerji1()',
                        col_type: 'card_pic_3',
                        extra: {
                            host: `${host}?pingtai=${data.id}`,
                            wz: wz,
                        }
                    })
                })
            }
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    zhiboerji1: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        let host = MY_PARAMS.host;
        let url = host.split('?')[0];
        var wz = MY_PARAMS.wz;
        try {
            let list = JSON.parse(fetch(host)).zhubo;
            //log(list)
            list.forEach(data => {
                d.push({
                    title: data.title,
                    img: data.image,
                    url: url + '?id=' + data.id + vod,
                    col_type: 'movie_3'
                })
            })
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    xiaoshuoerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            let host = MY_PARAMS.host;
            var wz = MY_PARAMS.wz;
            var pg = getParam('page');
            if (MY_PAGE == 1) {
                var 小说分类 = fetch(host + '?getsort')
                var data = JSON.parse(小说分类).categories;
                var index_n = data[0].id.toString();
                putMyVar('index_' + wz, index_n);
                data.forEach(data => {
                    d.push({
                        title: getMyVar('小说分类' + wz, index_n) == data.id.toString() ? strong(data.title, 'FF6699') : data.title,
                        url: $('').lazyRule((title, id, wz) => {
                            putMyVar('小说分类' + wz, id);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, data.title, data.id.toString(), wz),
                        col_type: 'scroll_button'
                    })
                })
            }
            var list = JSON.parse(fetch(host + '?sort=' + getMyVar('小说分类' + wz, getMyVar('index_' + wz)) + '&page=' + pg)).list;
            //log(list)
            list.forEach(data => {
                d.push({
                    title: data.title,
                    url: 'hiker://empty?#readTheme#@rule=js:$.require("csdown").xiaoshuoerji1()',
                    col_type: 'text_1',
                    extra: {
                        host: `${host}?id=${data.id}`,
                        wz: wz,
                    }
                })
            })
        } catch {}
        setResult(d)
    },
    xiaoshuoerji1: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        let host = MY_PARAMS.host;
        let url = host.split('?')[0];
        var wz = MY_PARAMS.wz;
        try {
            if ((wz == 'jinjishuwu') | (wz == 'lebo') | (wz == 'huanxiang') | (wz == 'jkun')) {
                let novel = JSON.parse(fetch(host)).novel;
                d.push({
                    title: novel,
                    col_type: 'rich_text'
                })
            } else {
                let id = JSON.parse(fetch(host)).id;
                loadReadContentPage(id)
            }
        } catch {
            toast('谁特么看小说啊！')
        }
        setResult(d)
    },
    tieerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            let host = MY_PARAMS.host;
            var wz = MY_PARAMS.wz;
            var pg = getParam('page');
            if (MY_PAGE == 1) {
                var 帖子分类 = fetch(host + '?getsort')
                var data = JSON.parse(帖子分类).categories;
                var index_n = data[0].id.toString();
                data.forEach(data => {
                    d.push({
                        title: getMyVar('帖子分类' + wz, index_n) == data.id.toString() ? strong(data.title, 'FF6699') : data.title,
                        url: $('#noLoading#').lazyRule((title, id, wz) => {
                            putMyVar('帖子分类' + wz, id);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, data.title, data.id.toString(), wz),
                        col_type: 'scroll_button'
                    })
                })
            }
            var list = JSON.parse(fetch(host + '?sort=' + getMyVar('帖子分类' + wz, index_n) + '&page=' + pg)).videos;
            list.forEach(data => {
                d.push({
                    title: data.title,
                    desc: data.date,
                    //img: 'https://images.xoowbs.com/upload_01'+data.image.split('upload_01')[1],
                    img: wz == 'haijiao' ? (data.image + hjlazy) : (data.image + lazy),
                    url: 'hiker://empty?@rule=js:$.require("csdown").blackerji1()',
                    col_type: 'pic_1',
                    extra: {
                        host: `${host}?id=${data.id}`,
                        wz: wz,
                    }
                })
            })
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    manhuaerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            let host = MY_PARAMS.host;
            var wz = MY_PARAMS.wz;
            var pg = getParam('page');
            if (MY_PAGE == 1) {
                var 漫画分类 = fetch(host + '?getsort')
                var data = JSON.parse(漫画分类).categories;
                var index_n = data[0].id.toString();
                putMyVar('index_' + wz, index_n)
                data.forEach(data => {
                    d.push({
                        title: getMyVar('漫画分类' + wz, index_n) == data.id.toString() ? strong(data.title, 'FF6699') : data.title,
                        url: $('#noLoading#').lazyRule((title, id, wz) => {
                            putMyVar('漫画分类' + wz, id);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, data.title, data.id.toString(), wz),
                        col_type: 'scroll_button'
                    })
                })
            }
            var list = JSON.parse(fetch(host + '?sort=' + getMyVar('漫画分类' + wz, getMyVar('index_' + wz)) + '&page=' + pg)).videos;
            //log(list)
            list.forEach(data => {
                d.push({
                    title: data.title,
                    desc: data.date,
                    img: data.image,
                    url: 'hiker://empty@rule=js:$.require("csdown").manhuaerji1()',
                    col_type: 'movie_3',
                    extra: {
                        host: `${host}?id=${data.id}`,
                        wz: wz,
                    }
                })
            })
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    manhuaerji1: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        let host = MY_PARAMS.host;
        let url = host.split('?')[0];
        var wz = MY_PARAMS.wz;
        try {
            let list = JSON.parse(fetch(host)).chapters;
            //log(list)
            list.forEach(data => {
                d.push({
                    title: data.title,
                    url: url + '?id=' + data.id + pics,
                    col_type: 'text_2'
                })
            })
            var preview = getItem('preview', "0");
            d.push({
                title: ('““””预览漫画' + (preview == "0" ? "[关]".fontcolor("red") : "[开]".fontcolor("green"))).small(),
                col_type: 'text_center_1',
                url: $('').lazyRule(() => {
                    var i = getItem('preview', "0");
                    setItem('preview', i == "0" ? "1" : "0");
                    refreshPage();
                    return 'hiker://empty'
                }),
                extra: {
                    lineVisible: false
                }
            })

            if (preview == "1") {
                let img = JSON.parse(fetch(host)).content.replace(/\$/g, '').replace(/分割/g, '').split('@');
                img.forEach(data => {
                    d.push({
                        img: data,
                        url: 'pics://' + img.join('&&'),
                        col_type: 'pic_1_full'
                    })
                })
            }
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    tv_91: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        //md5加密
        function md5(str) {
            return CryptoJS.MD5(str).toString();
        }
        var t = Math.floor(Date.now());
        var pg = getParam('page');
        var tv = [{
            title: '首页&频道&标签',
            id: '1&2&3',
            img: 'https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/111.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/112.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/113.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/114.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/122.svg'
        }];
        if (MY_PAGE == 1) {
            Cate(tv, 'tv', d);
            d.push({
                col_type: 'line',
            }, {
                col_type: 'big_blank_block',
            }, {
                col_type: 'big_blank_block',
            });
        }
        let 分类 = getMyVar('tv', '1');

        if (分类 == 1) {
            var sign = md5('list_row=20&page=' + pg + '&timestamp=' + t + '&type=2' + '&m}q%ea6:LDcmS?aK)CeF287bPvd99@E,9Up^');
            var data0 = {
                "encode_sign": sign,
                "list_row": "20",
                "page": pg,
                "timestamp": t,
                "type": "2"
            };
            var data = mdEncrypt(JSON.stringify(data0));
            var body = 'post-data=' + data;
            var url = 'https://tvv.zjqfart.cn/video/listcache';

        } else {
            var sign = md5('timestamp=' + t + '&m}q%ea6:LDcmS?aK)CeF287bPvd99@E,9Up^');
            var data0 = {
                "encode_sign": sign,
                "timestamp": t
            };
            var data = mdEncrypt(JSON.stringify(data0));
            var body = 'post-data=' + data;
            if (分类 == 2) {
                var url = 'https://tvv.zjqfart.cn/video/channel';
            } else if (分类 == 3) {
                var url = 'https://tvv.zjqfart.cn/video/tags';
            }
        };
        var html = fetch(url, {
            headers: {
                'suffix': '173150',
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: body,
            method: 'POST'
        });
        let html1 = JSON.parse(html).data;
        var iv0 = JSON.parse(html).suffix;
        let html2 = mdDecrypt(html1);
        if (分类 == 1) {
            var html3 = fetch(JSON.parse(html2).data.file_name);
            var list = JSON.parse(html3).data;
            list.forEach((data) => {
                var tag = data.tags;
                var str1 = '';
                for (i in tag) {
                    var str1 = str1 + tag[i].name + '   ';
                }
                d.push({
                    title: data.title,
                    desc: str1,
                    img: data.thumb + mdlazy,
                    col_type: "pic_1",
                    url: data.video_url + tvvod,
                })
            })
        } else if (分类 == 2) {
            var list = JSON.parse(html2).data;
            list.forEach((data) => {
                d.push({
                    title: data.name,
                    desc: data.total + '个片儿',
                    pic_url: data.image,
                    col_type: "icon_3",
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").pindao_91tv()',
                    extra: {
                        id: data.id,
                    }
                })
            })
        } else if (分类 == 3) {
            var list = JSON.parse(html2).data;
            //log(list)
            list.forEach((data) => {
                d.push({
                    title: data.name,
                    //img:data.thumb+mdlazy,
                    col_type: "text_3",
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").biaoqian_91tv()',
                    extra: {
                        id: data.id,
                    }
                })
            })
        }
        setResult(d)
    },
    pindao_91tv: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            //md5加密
            function md5(str) {
                return CryptoJS.MD5(str).toString();
            }
            var t = Math.floor(Date.now());
            var t0 = Math.floor(Date.now() / 1000);
            let id = MY_PARAMS.id;
            let p = getParam('page');
            var sign = md5('channel=' + id + '&list_row=60&page=' + p + '&timestamp=' + t + '&type=2&m}q%ea6:LDcmS?aK)CeF287bPvd99@E,9Up^');
            let data0 = {
                "channel": id,
                "encode_sign": sign,
                "list_row": "60",
                "page": p,
                "timestamp": t,
                "type": "2"
            }
            var data = mdEncrypt(JSON.stringify(data0));
            var body = 'post-data=' + data;
            var url = 'https://tvv.zjqfart.cn/video/listcache';
            var html = fetch(url, {
                headers: {
                    'suffix': '173150',
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: body,
                method: 'POST'
            });
            let html1 = JSON.parse(html).data;
            var iv0 = JSON.parse(html).suffix;
            let html2 = mdDecrypt(html1);
            var html3 = fetch(JSON.parse(html2).data.file_name);
            var list = JSON.parse(html3).data;
            list.forEach((data) => {
                var tag = data.tags;
                var str1 = '';
                for (i in tag) {
                    var str1 = str1 + tag[i].name + '   ';
                }
                d.push({
                    title: data.title,
                    desc: str1,
                    img: data.thumb + mdlazy,
                    col_type: "pic_1",
                    url: data.video_url + tvvod,
                })
            })
        } catch {}
        setResult(d)
    },
    biaoqian_91tv: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            //md5加密
            function md5(str) {
                return CryptoJS.MD5(str).toString();
            }
            var t = Math.floor(Date.now());
            var t0 = Math.floor(Date.now() / 1000);
            let id = MY_PARAMS.id;
            let p = getParam('page');
            var sign = md5('list_row=60&page=' + p + '&tags=' + id + '&timestamp=' + t + '&type=2&m}q%ea6:LDcmS?aK)CeF287bPvd99@E,9Up^'); //log(sign)

            let data0 = {
                "encode_sign": sign,
                "list_row": "60",
                "page": p,
                "tags": id,
                "timestamp": t,
                "type": "2"
            }
            var data = mdEncrypt(JSON.stringify(data0));
            var body = 'post-data=' + data;
            var url = 'https://tvv.zjqfart.cn/video/listcache';
            var html = fetch(url, {
                headers: {
                    'suffix': '173150',
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: body,
                method: 'POST'
            });
            let html1 = JSON.parse(html).data;
            var iv0 = JSON.parse(html).suffix;
            let html2 = mdDecrypt(html1);
            var html3 = fetch(JSON.parse(html2).data.file_name);
            var list = JSON.parse(html3).data;
            list.forEach((data) => {
                var tag = data.tags;
                var str1 = '';
                for (i in tag) {
                    var str1 = str1 + tag[i].name + '   ';
                }
                d.push({
                    title: data.title,
                    desc: str1,
                    img: data.thumb + mdlazy,
                    col_type: "pic_1",
                    url: data.video_url + tvvod,
                })
            })
        } catch {}
        setResult(d)
    },
    baike: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        if (MY_PAGE == 1) {
            d.push({   
                title: "搜索 ",
                url: $.toString(() => {
                    putMyVar('keyword', input)
                    return "hiker://empty?page=fypage&kw=" + input + '@rule=js:$.require("csdown").avbkss()'
                }),
                   desc: "请输入搜索关键词",
                   col_type: "input",
                extra: {
                    defaultValue: getMyVar('keyword', ''),
                }
            })
        };
        try {
            var host = MY_PARAMS.host;
            var mz = MY_PARAMS.mz;
            var sj = MY_PARAMS.sj;
            var pg = getParam('page');
            var data = fetch('https://api1.ffudingdang.com:9002/leixing.php?t=' + mz).split('-');
            var index_n = data[0]
            if (MY_PAGE == 1) {
                data.forEach(data => {
                    d.push({
                        title: getMyVar('AV百科' + mz, index_n) == data ? strong(data, 'FF6699') : data,
                        url: $('#noLoading#').lazyRule((title, id, mz) => {
                            putMyVar('AV百科' + mz, id);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, data, data, mz),
                        col_type: 'scroll_button'
                    })
                })
            }
            var list = JSON.parse(fetch(host + '?t=' + getMyVar('AV百科' + mz, index_n) + '&p=' + pg + sj)).data;
            //log(list)
            list.forEach(data => {
                if (data.leixing != '精品推荐') {
                    d.push({
                        title: data.biaoti,
                        desc: data.leixing + '  ' + data.shijian,
                        img: data.tupian,
                        url: data.dizhi,
                        col_type: 'movie_2'
                    })
                }
            })
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    avbkss: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        var pg = getParam('page');
        if (MY_PAGE == 1) {
            d.push({   
                title: "搜索 ",
                url: $.toString(() => {
                    putMyVar('keyword', input)
                    refreshPage(false)
                    return "hiker://empty"
                }),
                   desc: "请输入搜索关键词",
                   col_type: "input",
                extra: {
                    defaultValue: getMyVar('keyword', ''),
                    pageTitle: '搜索结果'
                }
            })
        }
        try {
            if (MY_PAGE == 1) {
                var avbkss = JSON.parse(getItem('avbk')).sousuo;
                var avbkss_n = avbkss[0].dz;
                avbkss.forEach(data => {
                    d.push({
                        title: getMyVar('AV百科搜索', avbkss_n) == data.dz ? strong(data.mz, 'FF6699') : data.mz,
                        url: $('#noLoading#').lazyRule((title, url, sj, cate) => {
                            putMyVar('AV百科搜索', url);
                            putMyVar('AV百科搜索名', title);
                            putMyVar('AV百科sj', sj);
                            refreshPage(false);
                            return 'hiker://empty';
                        }, data.mz, data.dz, data.sj, 'AV百科搜索'),
                        col_type: 'scroll_button',
                        extra: {
                            key: '搜索分类: ' + getMyVar('AV百科搜索', avbkss_n),
                            word: '搜索分类名: ' + getMyVar('AV百科搜索名', '视频'),
                            keyword: getMyVar('keyword'),
                        }
                    })
                })
            }
            var list = JSON.parse(fetch(getMyVar('AV百科搜索', avbkss_n) + getMyVar('keyword') + '&p=' + pg + getMyVar('AV百科sj'))).data;
            //log(list)
            list.forEach(data => {
                if (data.leixing != '精品推荐') {
                    d.push({
                        title: data.biaoti,
                        desc: data.leixing + '  ' + data.shijian,
                        img: data.tupian,
                        url: data.dizhi,
                        col_type: 'movie_2'
                    })
                }
            })
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    maomi: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        var pg = getParam('page');
        var 猫咪 = [{
            title: '猫咪原创&AI制作&不雅视频&亚洲无 码&抖音妹集合&热剧成人版&韩国三级&人气女 优',
            id: '10&16&5&9&11&12&13&6'
        }];
        if (MY_PAGE == 1) {
            Cate(猫咪, '猫咪', d);
        }
        var sign = Encrypt('{"special_id":' + getMyVar('猫咪', '10') + ',"page":' + pg + '}');
        try {
            var host = 'http://119.28.52.193:8089/api/special/video?params=' + sign;
            var body = 'params=' + sign;
            var html = fetch(host, {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: body,
                method: 'POST'
            });
            var html2 = Decrypt(html)
            var list = JSON.parse(html2).data.data;
            list.forEach(data => {
                d.push({
                    title: data.video_name,
                    desc: data.create_at,
                    img: data.image,
                    url: data.video_id + maomijx,
                    col_type: 'movie_2'
                })
            })
        } catch {}
        setResult(d)
    },
    maomiyuanchuang: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        var pg = getParam('page');
        var 猫咪原创 = [{
            title: '最新&热门',
            id: '3&1'
        }];
        if (MY_PAGE == 1) {
            Cate(猫咪原创, '猫咪原创', d);
        }
        var sign = Encrypt('{"user_id":1790368,"type":' + getMyVar('猫咪原创', '3') + ',"page":' + pg + '}');
        try {
            var host = 'http://119.28.52.193:8089/api/original/index?params=' + sign;
            var body = 'params=' + sign;
            var html = fetch(host, {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: body,
                method: 'POST'
            });
            var html2 = Decrypt(html)
            var list = JSON.parse(html2).data.data;
            list.forEach(data => {
                d.push({
                    title: data.title,
                    desc: data.create_at,
                    img: data.video_img,
                    url: data.m3u8,
                    col_type: 'movie_3',
                    extra: {
                        longClick: [{
                            title: '下载',
                            js: $.toString((url) => {
                                return 'download://' + url
                            }, data.down)
                        }]
                    }
                })
            })
        } catch {}
        setResult(d)
    },
    maomimanhua: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        var pg = getParam('page');
        try {
            var 猫咪漫画 = [{
                title: '推荐&最新&精华',
                id: 'recommend&update&popular'
            }];
            if (MY_PAGE == 1) {
                Cate(猫咪漫画, '猫咪漫画', d);
            }
            var sign = Encrypt('{"page":' + pg + '}');
            var host = 'http://119.28.52.193:8089/api/comic/' + getMyVar('猫咪漫画', 'recommend') + '?params=' + sign;
            var body = 'params=' + sign;
            var html = fetch(host, {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: body,
                method: 'POST'
            });
            var html2 = Decrypt(html)
            //log(html2)
            var list = JSON.parse(html2).data.data;
            list.forEach(data => {
                d.push({
                    title: data.title,
                    img: data.thumb,
                    url: 'hiker://empty?page=fypage&#immersiveTheme#@rule=js:$.require("csdown").maomimanhuaerji()',
                    //url:data.id+maomimanhuajx,
                    col_type: 'movie_3',
                    extra: {
                        id: data.id,
                    }
                })
            })
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    maomimanhuaerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        var pg = getParam('page');
        var id = MY_PARAMS.id;
        try {
            var sign = Encrypt('{"id":' + id + ',"page":' + pg + ',"sort":0}');
            var host = 'http://119.28.52.193:8089/api/comic/lists?params=' + sign;
            var body = 'params=' + sign;
            var html = fetch(host, {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                method: 'POST'
            });
            var html2 = Decrypt(html)
            var list = JSON.parse(html2).data.data;
            list.forEach(data => {
                d.push({
                    title: data.name,
                    img: data.image,
                    url: data.id + maomimanhuajx,
                    col_type: "movie_1_vertical_pic_blur",
                })
            })
        } catch {}
        setResult(d)
    },
    maomimeitu: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        var pg = getParam('page');
        try {
            var 猫咪美图 = [{
                title: '热门&闲聊讨论&蕾丝女同&美腿玉足&巨乳美胸&男同&原创自拍&动漫&认证&sm&课堂&我妻&高潮脸&网红大咖&制服诱惑&蜜汁美臀',
                id: '0&3&7&9&10&22&1&8&26&6&31&23&2&18&4&21'
            }];
            if (MY_PAGE == 1) {
                Cate(猫咪美图, '猫咪美图', d);
            }
            var sign = Encrypt('{"page":' + pg + ',"cate":' + getMyVar('猫咪美图', '0') + ',"type":1}');
            var host = 'http://119.28.52.193:8089/api/v2/post/home?params=' + sign;
            var body = 'params=' + sign;
            var html = fetch(host, {
                headers: {
                    'Content-Type': 'application/x-www-form-urlencoded',
                },
                body: body,
                method: 'POST'
            });
            var html2 = Decrypt(html)
            var list = JSON.parse(html2).data;
            list.forEach(data => {
                if (data.images) {
                    d.push({
                        title: data.title,
                        desc: data.time,
                        img: data.images[0].image,
                        url: $('').lazyRule(data => {
                            let picArr = [];
                            let img = data.images;
                            let len = img.length - 1;
                            for (i = 0; i <= len; i++) {
                                picArr[i] = img[i].image;
                            }
                            return "pics://" + picArr.join("&&")
                        }, data),
                        col_type: 'movie_3'
                    })
                }
            })
        } catch {}
        setResult(d)
    },
    maomiav: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        var pg = getParam('page');
        //加载配置
        if (getItem('maomi_tp', '') == '') {
            var config_url = 'http://47.243.62.112/data/config/base-1.js';
            var config_post = JSON.parse(request(config_url));
            var config_data = JSON.parse(mmDecrypt(config_post.data, config_post.suffix));
            setItem('maomi_tp', config_data.image_url);
            setItem('maomi_video', config_data.m3u8_host_encrypt);
        }
        if (getItem('maomi_categories', '') == '') {
            var categories_url = 'https://mjson.szaction.cc/data/apps/categories.js';
            var categories_post = JSON.parse(request(categories_url));
            var categories_data = mmDecrypt(categories_post.data, categories_post.suffix);
            setItem('maomi_categories', categories_data)
        }
        if (MY_PAGE == 1) {
            var maomiav = [{
                title: '首页&VIP',
                id: 'library&vip_section&topic&benefit',
                img: 'https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/129.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/142.svg'
            }];
            Cate(maomiav, 'maomiav', d, 'icon_2_round');
            var cate_library = JSON.parse(getItem('maomi_categories')).apps_categories[getMyVar('maomiav', 'library')];
            var cate_library_n = cate_library[0].id + '';
            cate_library.forEach((data, index) => {
                d.push({
                    title: getMyVar('maomi_cate_library', cate_library_n) == data.id ? strong(data.name, 'FF6699') : data.name,
                    url: $('#noLoading#').lazyRule((n, title, id, index) => {
                        putMyVar(n, id);
                        putMyVar('index_n', index + '')
                        refreshPage(false);
                        return 'hiker://empty';
                    }, 'maomi_cate_library', data.name, data.id + '', index),
                    col_type: 'scroll_button',
                })
            })
            var child = cate_library[getMyVar('index_n', 0 + '')].child;
            child.forEach(data => {
                d.push({
                    title: data.name,
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").maomiav_erji()',
                    col_type: 'text_3',
                    extra: {
                        id: data.id,
                    }
                })
            })
        }
        var url = `https://mjson.szaction.cc/data/apps/videos/index-${getMyVar('maomi_cate_library',cate_library_n)}.js`;
        try {
            var url_post = JSON.parse(request(url))
            var list = JSON.parse(mmDecrypt(url_post.data, url_post.suffix)).apps_categories;
            list.forEach(data => {
                d.push({
                    title: color(data.name),
                    img: 'hiker://images/icon_right5',
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").maomiav_erji()',
                    col_type: 'text_icon',
                    extra: {
                        id: data.id,
                    },
                })
                var videos = data.videos;
                videos.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: timestampToTime(data.update_time, 1) + '   ' + parseInt(data.duration / 60) + ':' + parseInt(data.duration % 60),
                        img: getItem('maomi_tp') + data.thumb + '.txt' + mmlazy,
                        url: data.video_url + mmvod,
                        col_type: 'movie_2',
                    })
                })
            })
        } catch (e) {}
        setResult(d)
    },
    maomiav_erji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        var pg = getParam('page');
        var id = MY_PARAMS.id;
        var maomisp_erji = [{
            title: '最新&热门',
            id: 'latest&popular'
        }];
        if (MY_PAGE == 1) {
            Cate(maomisp_erji, 'maomisp_erji', d);
        }
        var maomisp_cate = [{
            title: '全部&长视频&短视频',
            id: 'all&long&short'
        }];
        if (MY_PAGE == 1) {
            Cate(maomisp_cate, 'maomisp_cate', d);
        }
        try {
            var url = 'https://mjson.szaction.cc/data/apps/videos/list-' + id + '-' + getMyVar('maomisp_cate', 'all') + '-' + getMyVar('maomisp_erji', 'latest') + '-' + pg + '.js';
            var url_post = JSON.parse(request(url));
            var list = JSON.parse(mmDecrypt(url_post.data, url_post.suffix)).videos.data;
            list.forEach(data => {
                d.push({
                    title: data.title,
                    desc: timestampToTime(data.update_time, 1) + '   ' + parseInt(data.duration / 60) + ':' + parseInt(data.duration % 60),
                    img: getItem('maomi_tp') + data.thumb + '.txt' + mmlazy,
                    url: data.video_url + mmvod,
                    col_type: 'movie_2',
                })
            })
        } catch {}
        setResult(d)
    },
    zhibojuheerji: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            let wz = MY_PARAMS.wz;
            if (wz == '直播聚合') {
                host = 'http://api.vipmisss.com:81/xcdsw/'
            } else {
                host = 'http://api.maiyoux.com:81/mf/'
                //host='http://api.hclyz.com:81/mf/'
            }
            if (MY_PAGE == 1) {
                var 直播聚合 = request(host + 'json.txt')
                var data = JSON.parse(直播聚合).pingtai;
                data.forEach(data => {
                    d.push({
                        title: data.title,
                        desc: data.Number,
                        img: data.xinimg,
                        url: 'hiker://empty@rule=js:$.require("csdown").zhibojuheerji1()',
                        col_type: 'card_pic_3',
                        extra: {
                            host: `${host}${data.address}`,
                            wz: wz,
                        }
                    })
                })
            }
        } catch (e) {
            log(e.message)
            toast('看不了')
        }
        setResult(d)
    },
    zhibojuheerji1: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        let host = MY_PARAMS.host;
        try {
            let list = JSON.parse(fetch(host)).zhubo;
            //log(list)
            list.forEach(data => {
                if (!data.title.includes('9999')) {
                    d.push({
                        title: data.title,
                        img: data.img,
                        url: data.address,
                        col_type: 'movie_2'
                    })
                }
            })
        } catch {}
        setResult(d)
    },
    madou: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        //md5加密
        function md5(str) {
            return CryptoJS.MD5(str).toString();
        }
        var t = Math.floor(Date.now());
        let pg = getParam('page');
        var md = [{
            title: '首页&频道&标签',
            id: '1&2&3',
            img: 'https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/111.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/112.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/113.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/114.svg&https://ghproxy.net/https://raw.githubusercontent.com/ls125781003/tubiao/main/movie/122.svg'
        }];
        if (MY_PAGE == 1) {
            Cate(md, 'md', d);
            d.push({
                col_type: 'line',
            }, {
                col_type: 'big_blank_block',
            }, {
                col_type: 'big_blank_block',
            });
        }
        let 分类 = getMyVar('md', '1');

        if (分类 == 1) {
            var sign = md5('list_row=20&page=' + pg + '&timestamp=' + t + '&type=2' + '&m}q%ea6:LDcmS?aK)CeF287bPvd99@E,9Up^');
            var data0 = {
                "encode_sign": sign,
                "list_row": "20",
                "page": pg,
                "timestamp": t,
                "type": "2"
            };
            var data = mdEncrypt(JSON.stringify(data0));
            var body = 'post-data=' + data;
            var url = 'https://api.nzp1ve.com/video/listcache';

        } else {
            var sign = md5('timestamp=' + t + '&m}q%ea6:LDcmS?aK)CeF287bPvd99@E,9Up^');
            var data0 = {
                "encode_sign": sign,
                "timestamp": t
            };
            var data = mdEncrypt(JSON.stringify(data0));
            var body = 'post-data=' + data;
            if (分类 == 2) {
                var url = 'https://api.nzp1ve.com/video/channel';
            } else if (分类 == 3) {
                var url = 'https://api.nzp1ve.com/video/tags';
            }
        };
        var html = fetch(url, {
            headers: {
                'suffix': '173150',
                'Content-Type': 'application/x-www-form-urlencoded'
            },
            body: body,
            method: 'POST'
        });

        let html1 = JSON.parse(html).data;
        var iv0 = JSON.parse(html).suffix;
        let html2 = mdDecrypt(html1);
        if (分类 == 1) {
            var list = JSON.parse(html2).data.data;
            list.forEach((data) => {
                var tag = data.tags;
                var str1 = '';
                for (i in tag) {
                    var str1 = str1 + tag[i].name + '   ';
                }
                d.push({
                    title: data.title,
                    desc: str1,
                    pic_url: data.panorama.replace('_sync.webp', '.jpg'),
                    col_type: "pic_1",
                    url: data.video_url,
                })
            })
        } else if (分类 == 2) {
            var list = JSON.parse(html2).data;
            list.forEach((data) => {
                d.push({
                    title: data.name,
                    desc: data.total + '个片儿',
                    pic_url: data.image,
                    col_type: "icon_3",
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").madoupindao()',
                    extra: {
                        id: data.id,
                    }
                })
            })
        } else if (分类 == 3) {
            var list = JSON.parse(html2).data;
            list.forEach((data) => {
                d.push({
                    title: data.name,
                    //pic_url:data.thumb,
                    col_type: "text_3",
                    url: 'hiker://empty?page=fypage@rule=js:$.require("csdown").madoubiaoqian()',
                    extra: {
                        id: data.id,
                    }
                })
            })
        }
        setResult(d)
    },
    madoupindao: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            //md5加密
            function md5(str) {
                return CryptoJS.MD5(str).toString();
            }
            var t = Math.floor(Date.now());
            var t0 = Math.floor(Date.now() / 1000);
            let id = MY_PARAMS.id;
            let p = getParam('page');
            var sign = md5('channel=' + id + '&list_row=60&page=' + p + '&timestamp=' + t + '&type=2&m}q%ea6:LDcmS?aK)CeF287bPvd99@E,9Up^'); //log(sign)

            let data0 = {
                "channel": id,
                "encode_sign": sign,
                "list_row": "60",
                "page": p,
                "timestamp": t,
                "type": "2"
            }
            //log(data0)
            var data = mdEncrypt(JSON.stringify(data0));
            //log(data)
            var body = 'post-data=' + data;
            var url = 'https://api.nzp1ve.com/video/listcache';
            var html = fetch(url, {
                headers: {
                    'suffix': '173150',
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: body,
                method: 'POST'
            });
            //log(html)

            let html1 = JSON.parse(html).data;
            //log(html1)
            var iv0 = JSON.parse(html).suffix;
            //log(iv0);
            let html2 = mdDecrypt(html1);
            //log(html2)

            var list = JSON.parse(html2).data.data;
            //log(list);
            list.forEach((data) => {
                var tag = data.tags;
                var str1 = '';
                for (i in tag) {
                    var str1 = str1 + tag[i].name + '   ';
                }
                d.push({
                    title: data.title,
                    desc: str1,
                    pic_url: data.panorama.replace('_sync.webp', '.jpg').replace('_longPreview', ''),
                    col_type: "pic_1",
                    url: data.video_url,
                })
            })
        } catch {}
        setResult(d)
    },
    madoubiaoqian: () => {
        var d = csdown.d;
        eval(csdown.rely(csdown.aes));
        try {
            //md5加密
            function md5(str) {
                return CryptoJS.MD5(str).toString();
            }
            var t = Math.floor(Date.now());
            var t0 = Math.floor(Date.now() / 1000);
            let id = MY_PARAMS.id;
            let p = getParam('page');
            var sign = md5('list_row=60&page=' + p + '&tags=' + id + '&timestamp=' + t + '&type=2&m}q%ea6:LDcmS?aK)CeF287bPvd99@E,9Up^'); //log(sign)

            let data0 = {
                "encode_sign": sign,
                "list_row": "60",
                "page": p,
                "tags": id,
                "timestamp": t,
                "type": "2"
            }
            //log(data0)
            var data = mdEncrypt(JSON.stringify(data0));
            //log(data)
            var body = 'post-data=' + data;
            var url = 'https://api.nzp1ve.com/video/listcache';
            var html = fetch(url, {
                headers: {
                    'suffix': '173150',
                    'Content-Type': 'application/x-www-form-urlencoded'
                },
                body: body,
                method: 'POST'
            });
            //log(html)

            let html1 = JSON.parse(html).data;
            //log(html1)
            var iv0 = JSON.parse(html).suffix;
            //log(iv0);
            let html2 = mdDecrypt(html1);
            //log(html2)

            var list = JSON.parse(html2).data.data;
            //log(list);
            list.forEach((data) => {
                var tag = data.tags;
                var str1 = '';
                for (i in tag) {
                    var str1 = str1 + tag[i].name + '   ';
                }
                d.push({
                    title: data.title,
                    desc: str1,
                    pic_url: data.panorama.replace('_sync.webp', '.jpg').replace('_longPreview', ''),
                    col_type: "pic_1",
                    url: data.video_url,
                })
            })
        } catch {}
        setResult(d)
    },
}
$.exports = csdown
