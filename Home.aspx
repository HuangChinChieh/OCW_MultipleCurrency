<%@ Page Language="C#" %>

<!doctype html>
<html lang="zh-Hant-TW" class="innerHtml">

<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Maharaja</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link href="Scripts/vendor/swiper/css/swiper-bundle.min.css" rel="stylesheet" />
    <link href="css/basic.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="css/main.css?a=2">
    <link rel="stylesheet" href="css/newindex.css?a=1">
    <link rel="stylesheet" href="css/swiper-bundle.min.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;400;700&display=swap" rel="stylesheet">
    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.7.1/swiper-bundle.min.js"></script>
    <script type="text/javascript" src="/Scripts/Common.js"></script>
    <script type="text/javascript" src="/Scripts/UIControl.js"></script>
    <script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
    <script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
    <script type="text/javascript" src="/Scripts/date.js"></script>
    <!-- <script type="text/javascript" src="/Scripts/swiper-bundle.min.js"></script> -->
    <script src="https://cdnjs.cloudflare.com/ajax/libs/lozad.js/1.16.0/lozad.min.js"></script>
    <script src="https://genieedmp.com/dmp.js?c=6780&ver=2" async></script>
</head>
<% if (EWinWeb.IsTestSite == false) { %>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-097DC2GB6H"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag() { dataLayer.push(arguments); }
    gtag('js', new Date());

    gtag('config', 'G-097DC2GB6H');
</script>
<% } %>
<script type="text/javascript">
    if (self != top) {
        window.parent.API_LoadingStart();
    }

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();
        mlp = new multiLanguage();
        mlp.loadLanguage(lang, function () {
            if (p != null) {
                changeDataText();
                window.parent.API_LoadingEnd();
            } else {
                window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                    window.parent.location.href = "index.aspx";
                });
            }
        });
    }

    function EWinEventNotify(eventName, isDisplay, param) {
        switch (eventName) {
            case "LoginState":
                //updateBaseInfo();
                break;
            case "BalanceChange":
                break;
            case "SetLanguage":
                lang = param;

                mlp.loadLanguage(lang, function () {
                    changeDataText();
                    window.parent.API_LoadingEnd(1);
                });

                break;
        }
    }

    function changeDataText() {
        for (var i = 0; i < $(".changedatatext").length; i++) {
            let k = $(".changedatatext").eq(i);

            let langText = mlp.getLanguageKey(k.data("text"));
            k.attr("data-text", langText);
        }
    }

    window.onload = init;

</script>
<body>
    <div class="section">
        <div class="section1">
            <div class="content_area">
                <div class="main_girl">
                    <img src="images/newindex/main-girl.png" alt="">
                </div>
                <div class="main_dog">
                    <img src="images/newindex/main-dog.png" alt="">
                </div>
                <div class="medal_area">
                    <div class="medal flex">
                        <img src="images/newindex/gold-leaf-left.svg" alt="" class="leaf_left">
                        <div class="medal_content flex">
                            <img src="images/newindex/3star.svg" alt="" class="">
                            <span class="language_replace">客戶正面評價</span>
                            <p class="number">99<b>%</b></p>
                        </div>
                        <img src="images/newindex/gold-leaf.svg" alt="" class="leaf_right">
                    </div>
                    <div class="medal flex">
                        <img src="images/newindex/gold-leaf-left.svg" alt="" class="leaf_left">
                        <div class="medal_content flex">
                            <img src="images/newindex/3star.svg" alt="" class="">
                            <span class="language_replace">優惠紅利</span>
                            <p class="biger language_replace">業界最高</p>
                        </div>
                        <img src="images/newindex/gold-leaf.svg" alt="" class="leaf_right">
                    </div>
                </div>
                <div class="word">
                    <h1>
                        <span data-text="簡單玩、歡樂玩" class="drop-shadow-text1 before:text-stroke changedatatext">
                            <span class="language_replace">簡單玩、歡樂玩</span>
                        </span>
                    </h1>
                    <h1>
                        <span data-text="安心玩" class="drop-shadow-text1 before:text-stroke changedatatext">
                            <span class="language_replace">安心玩</span>
                        </span>
                    </h1>
                    <h2>
                        <span data-text="1分鐘輕鬆！免費註冊" class="drop-shadow-text2 changedatatext">
                            <span class="language_replace">1分鐘輕鬆！免費註冊</span>
                        </span>
                    </h2>
                    <a class="join language_replace" style="cursor:pointer" onclick="window.parent.API_LoadPage('Register', 'Register.aspx')">立即註冊</a>
                </div>
                <div class="img_777" style="animation-delay: 0.6s">
                    <img src="images/newindex/777.svg" alt="">
                </div>
                <div class="img_chip_blue" style="animation-delay: 0s">
                    <img src="images/newindex/chip-blue.svg" alt="">
                </div>
                <div class="img_chip_red" style="animation-delay: 1s">
                    <img src="images/newindex/chip-red.svg" alt="">
                </div>
                <div class="img_chip_yellow" style="animation-delay: .7s">
                    <img src="images/newindex/chip-yellow.svg" alt="">
                </div>
                <div class="img_dice" style="animation-delay: .2s">
                    <img src="images/newindex/dice.svg" alt="">
                </div>
                <div class="img_card" style="animation-delay: 0s">
                    <img src="images/newindex/card.svg" alt="">
                </div>
                <div class="img_diamond" style="animation-delay: .4s">
                    <img src="images/newindex/diamond.svg" alt="">
                </div>
            </div>
        </div>
        <div class="section2">
            <div class="content_area">
                <div class="title_area">
                    <h1 class="section2_title language_replace">為什麼要選擇maharaja?</h1>
                </div>
                <div class="section2_girl">
                    <span style="animation-delay: 1s" class="language_replace">簡單有趣！</span>
                    <img src="images/newindex/autumn-girl.png" alt="">
                </div>
                <ul>
                    <li>
                        <span class="img_icon">
                            <img src="images/newindex/Slotgame.gif" alt=""></span>
                        <span class="title">
                            <h3 class="language_replace">超豐富！</h3>
                            <p class="language_replace">豐富多樣的遊戲種類。</p>
                        </span>
                    </li>
                    <li>
                        <span class="img_icon">
                            <img src="images/newindex/save.gif" alt=""></span>
                        <span class="title">
                            <h3 class="language_replace">超可靠！</h3>
                            <p class="language_replace">正式許可的合法職業牌照。</p>
                        </span>
                    </li>
                    <li>
                        <span class="img_icon">
                            <img src="images/newindex/gift.gif" alt=""></span>
                        <span class="title">
                            <h3 class="language_replace">超划算！</h3>
                            <p class="language_replace">最優惠的現金回饋活動。</p>
                        </span>
                    </li>
                </ul>
            </div>
        </div>
        <div class="section3">
            <div class="content_area">
                <h1>
                    <span data-text="現在完成註冊並領取註冊獎勵！" class="drop-shadow-text2 before:text-stroke changedatatext">
                        <span class="language_replace">現在完成註冊並領取註冊獎勵！</span>
                    </span>
                </h1>
                <a class="join language_replace" style="cursor:pointer" onclick="window.parent.API_LoadPage('Register', 'Register.aspx')">立即註冊</a>
                <div class="section3_girl">
                    <img src="images/newindex/girl-summer.png" alt="">
                </div>
                <ul>
                    <li>
                        <span class="circlerap">
                            <b>1</b>
                            <p class="language_replace">簡易註冊</p>
                        </span>
                        <span class="imgrap">
                            <img src="images/newindex/phone1.svg" alt="">
                        </span>
                    </li>
                    <li>
                        <span class="circlerap">
                            <b>2</b>
                            <p class="language_replace">完成認證</p>
                        </span>
                        <span class="imgrap">
                            <img src="images/newindex/phone2.svg" alt="">
                        </span>
                    </li>
                    <li>
                        <span class="circlerap">
                            <b>3</b>
                            <p class="language_replace">領取獎勵</p>
                        </span>
                        <span class="imgrap">
                            <img src="images/newindex/phone3.svg" alt="">
                        </span>
                    </li>
                </ul>
            </div>
        </div>
        <div class="section4">
            <div class="content_area">
                <span class="girlhead">
                    <img src="images/newindex/girl-head.png" alt=""></span>
                <h1 class="language_replace">超過3000種以上的高人氣遊戲</h1>
                <h2 class="language_replace">時下最流行的各式類型遊戲大集合！</h2>
            </div>
            <div class="allgame">
                <div class="gamesection" style="animation-duration: 60s;">
                    <div class="singlegame" title="タイガージャングル">
                        <img src="images/newindex/game1.jpg" alt="">
                        <p class="language_replace">叢林之王-集鴻運</p>
                    </div>
                    <div class="singlegame" title="ワイルドファイヤーワークス">
                        <img src="images/newindex/game2.jpg" alt="">
                        <p class="language_replace">火樹贏花</p>
                    </div>
                    <div class="singlegame" title="ゴールドパーティ">
                        <img src="images/newindex/game3.jpg" alt="">
                        <p class="language_replace">黃金派對</p>
                    </div>
                    <div class="singlegame" title="ライス オブ アポロ">
                        <img src="images/newindex/game4.jpg" alt="">
                        <p class="language_replace">太陽神傳說</p>
                    </div>
                    <div class="singlegame" title="プリンセス">
                        <img src="images/newindex/game5.jpg" alt="">
                        <p class="language_replace">星光公主</p>
                    </div>
                    <div class="singlegame" title="ラッキーフォーチュンキャット">
                        <img src="images/newindex/game6.jpg" alt="">
                        <p class="language_replace">招財貓</p>
                    </div>
                    <div class="singlegame" title="ゴールデンチケット">
                        <img src="images/newindex/game7.jpg" alt="">
                        <p class="language_replace">黃金入場券</p>
                    </div>
                    <div class="singlegame" title="フォーチュンタイガー">
                        <img src="images/newindex/game8.jpg" alt="">
                        <p class="language_replace">虎虎生財</p>
                    </div>
                    <div class="singlegame" title="ニンジャvsサムライ">
                        <img src="images/newindex/game9.jpg" alt="">
                        <p class="language_replace">忍者vs武侍</p>
                    </div>
                    <div class="singlegame" title="バタフライブロッサム">
                        <img src="images/newindex/game10.jpg" alt="">
                        <p class="language_replace">蝶戀花</p>
                    </div>
                    <div class="singlegame" title="ウェイズ オブ ザ キリン">
                        <img src="images/newindex/game11.jpg" alt="">
                        <p class="language_replace">麒麟送寶</p>
                    </div>
                    <div class="singlegame" title="ザ ドッグ ハウス">
                        <img src="images/newindex/game12.jpg" alt="">
                        <p class="language_replace">汪汪之家</p>
                    </div>
                    <div class="singlegame" title="ロックベガス">
                        <img src="images/newindex/game13.jpg" alt="">
                        <p class="language_replace">石頭族賭城</p>
                    </div>
                    <div class="singlegame" title="ゲーツ オブ オリンパ">
                        <img src="images/newindex/game14.jpg" alt="">
                        <p class="language_replace">奧林匹斯之門</p>
                    </div>
                    <div class="singlegame" title="シュガーラッシュ">
                        <img src="images/newindex/game15.jpg" alt="">
                        <p class="language_replace">極速糖果</p>
                    </div>
                    <div class="singlegame" title="タイガージャングル">
                        <img src="images/newindex/game1.jpg" alt="">
                        <p class="language_replace">叢林之王-集鴻運</p>
                    </div>
                    <div class="singlegame" title="ワイルドファイヤーワークス">
                        <img src="images/newindex/game2.jpg" alt="">
                        <p class="language_replace">火樹贏花</p>
                    </div>
                    <div class="singlegame" title="ゴールドパーティ">
                        <img src="images/newindex/game3.jpg" alt="">
                        <p class="language_replace">黃金派對</p>
                    </div>
                    <div class="singlegame" title="ライス オブ アポロ">
                        <img src="images/newindex/game4.jpg" alt="">
                        <p class="language_replace">太陽神傳說</p>
                    </div>
                    <div class="singlegame" title="プリンセス">
                        <img src="images/newindex/game5.jpg" alt="">
                        <p class="language_replace">星光公主</p>
                    </div>
                    <div class="singlegame" title="ラッキーフォーチュンキャット">
                        <img src="images/newindex/game6.jpg" alt="">
                        <p class="language_replace">招財貓</p>
                    </div>
                    <div class="singlegame" title="ゴールデンチケット">
                        <img src="images/newindex/game7.jpg" alt="">
                        <p class="language_replace">黃金入場券</p>
                    </div>
                    <div class="singlegame" title="フォーチュンタイガー">
                        <img src="images/newindex/game8.jpg" alt="">
                        <p class="language_replace">虎虎生財</p>
                    </div>
                    <div class="singlegame" title="ニンジャvsサムライ">
                        <img src="images/newindex/game9.jpg" alt="">
                        <p class="language_replace">忍者vs武侍</p>
                    </div>
                    <div class="singlegame" title="バタフライブロッサム">
                        <img src="images/newindex/game10.jpg" alt="">
                        <p class="language_replace">蝶戀花</p>
                    </div>
                    <div class="singlegame" title="ウェイズ オブ ザ キリン">
                        <img src="images/newindex/game11.jpg" alt="">
                        <p class="language_replace">麒麟送寶</p>
                    </div>
                    <div class="singlegame" title="ザ ドッグ ハウス">
                        <img src="images/newindex/game12.jpg" alt="">
                        <p class="language_replace">汪汪之家</p>
                    </div>
                    <div class="singlegame" title="ロックベガス">
                        <img src="images/newindex/game13.jpg" alt="">
                        <p class="language_replace">石頭族賭城</p>
                    </div>
                    <div class="singlegame" title="ゲーツ オブ オリンパ">
                        <img src="images/newindex/game14.jpg" alt="">
                        <p class="language_replace">奧林匹斯之門</p>
                    </div>
                    <div class="singlegame" title="シュガーラッシュ">
                        <img src="images/newindex/game15.jpg" alt="">
                        <p class="language_replace">極速糖果</p>
                    </div>
                </div>
                <div class="gamesection" style="animation-duration: 30s;">
                    <div class="singlegame" title="ウェイズ オブ ザ キリン">
                        <img src="images/newindex/game11.jpg" alt="">
                        <p class="language_replace">麒麟送寶</p>
                    </div>
                    <div class="singlegame" title="ザ ドッグ ハウス">
                        <img src="images/newindex/game12.jpg" alt="">
                        <p class="language_replace">汪汪之家</p>
                    </div>
                    <div class="singlegame" title="ロックベガス">
                        <img src="images/newindex/game13.jpg" alt="">
                        <p class="language_replace">石頭族賭城</p>
                    </div>
                    <div class="singlegame" title="ゲーツ オブ オリンパ">
                        <img src="images/newindex/game14.jpg" alt="">
                        <p class="language_replace">奧林匹斯之門</p>
                    </div>
                    <div class="singlegame" title="シュガーラッシュ">
                        <img src="images/newindex/game15.jpg" alt="">
                        <p class="language_replace">極速糖果</p>
                    </div>
                    <div class="singlegame" title="ゴールデンビューティー">
                        <img src="images/newindex/game16.jpg" alt="">
                        <p class="language_replace">貴妃美人</p>
                    </div>
                    <div class="singlegame" title="ダイヤモンドブリッツ">
                        <img src="images/newindex/game17.jpg" alt="">
                        <p class="language_replace">鑽石閃電戰</p>
                    </div>
                    <div class="singlegame" title="ジャンプハイ2">
                        <img src="images/newindex/game18.jpg" alt="">
                        <p class="language_replace">跳高高2</p>
                    </div>
                    <div class="singlegame" title="ホッカイドウ ウルフ">
                        <img src="images/newindex/game19.jpg" alt="">
                        <p class="language_replace">北海道之狼</p>
                    </div>
                    <div class="singlegame" title="スイートボナンザ">
                        <img src="images/newindex/game20.jpg" alt="">
                        <p class="language_replace">甜入心扉</p>
                    </div>
                    <div class="singlegame" title="タイガージャングル">
                        <img src="images/newindex/game1.jpg" alt="">
                        <p class="language_replace">叢林之王-集鴻運</p>
                    </div>
                    <div class="singlegame" title="ワイルドファイヤーワークス">
                        <img src="images/newindex/game2.jpg" alt="">
                        <p class="language_replace">火樹贏花</p>
                    </div>
                    <div class="singlegame" title="ゴールドパーティ">
                        <img src="images/newindex/game3.jpg" alt="">
                        <p class="language_replace">黃金派對</p>
                    </div>
                    <div class="singlegame" title="ライス オブ アポロ">
                        <img src="images/newindex/game4.jpg" alt="">
                        <p class="language_replace">太陽神傳說</p>
                    </div>
                    <div class="singlegame" title="プリンセス">
                        <img src="images/newindex/game5.jpg" alt="">
                        <p class="language_replace">星光公主</p>
                    </div>
                    <div class="singlegame" title="ウェイズ オブ ザ キリン">
                        <img src="images/newindex/game11.jpg" alt="">
                        <p class="language_replace">麒麟送寶</p>
                    </div>
                    <div class="singlegame" title="ザ ドッグ ハウス">
                        <img src="images/newindex/game12.jpg" alt="">
                        <p class="language_replace">汪汪之家</p>
                    </div>
                    <div class="singlegame" title="ロックベガス">
                        <img src="images/newindex/game13.jpg" alt="">
                        <p class="language_replace">石頭族賭城</p>
                    </div>
                    <div class="singlegame" title="ゲーツ オブ オリンパ">
                        <img src="images/newindex/game14.jpg" alt="">
                        <p class="language_replace">奧林匹斯之門</p>
                    </div>
                    <div class="singlegame" title="シュガーラッシュ">
                        <img src="images/newindex/game15.jpg" alt="">
                        <p class="language_replace">極速糖果</p>
                    </div>
                    <div class="singlegame" title="ゴールデンビューティー">
                        <img src="images/newindex/game16.jpg" alt="">
                        <p class="language_replace">貴妃美人</p>
                    </div>
                    <div class="singlegame" title="ダイヤモンドブリッツ">
                        <img src="images/newindex/game17.jpg" alt="">
                        <p class="language_replace">鑽石閃電戰</p>
                    </div>
                    <div class="singlegame" title="ジャンプハイ2">
                        <img src="images/newindex/game18.jpg" alt="">
                        <p class="language_replace">跳高高2</p>
                    </div>
                    <div class="singlegame" title="ホッカイドウ ウルフ">
                        <img src="images/newindex/game19.jpg" alt="">
                        <p class="language_replace">北海道之狼</p>
                    </div>
                    <div class="singlegame" title="スイートボナンザ">
                        <img src="images/newindex/game20.jpg" alt="">
                        <p class="language_replace">甜入心扉</p>
                    </div>
                    <div class="singlegame" title="タイガージャングル">
                        <img src="images/newindex/game1.jpg" alt="">
                        <p class="language_replace">叢林之王-集鴻運</p>
                    </div>
                    <div class="singlegame" title="ワイルドファイヤーワークス">
                        <img src="images/newindex/game2.jpg" alt="">
                        <p class="language_replace">火樹贏花</p>
                    </div>
                    <div class="singlegame" title="ゴールドパーティ">
                        <img src="images/newindex/game3.jpg" alt="">
                        <p class="language_replace">黃金派對</p>
                    </div>
                    <div class="singlegame" title="ライス オブ アポロ">
                        <img src="images/newindex/game4.jpg" alt="">
                        <p class="language_replace">太陽神傳說</p>
                    </div>
                    <div class="singlegame" title="プリンセス">
                        <img src="images/newindex/game5.jpg" alt="">
                        <p class="language_replace">星光公主</p>
                    </div>
                </div>
            </div>
            <div class="wrapSwiper">
                <div class="swiper mySwiper">
                    <div class="hi_dog"><img src="images/newindex/hi_dog.png" alt=""></div>
                    <div class="hi_girl"><img src="images/newindex/girl-character.png" alt=""></div>
                    <div class="swiper-wrapper">
                      <div class="swiper-slide">
                        <div>
                            <img src="images/newindex/video_logo1.png" class="videologo" alt="">
                            <div class="relative aspect-video">
                                <div>
                                    <video controls autoplay="autoplay" loop="loop" x5-video-player-type="h5" x5-video-player-fullscreen="false" muted playsinline webkit-playsinline>
                                        <source src="video/game_video1.mp4" type="video/mp4" />
                                        <p>Your browser does not support the video tag.</p>
                                    </video>
                                </div>
                            </div>
                        </div>
                      </div>
                      <div class="swiper-slide">
                        <div>
                            <img src="images/newindex/video_logo2.png" class="videologo" alt="">
                            <div class="relative aspect-video">
                                <div>
                                    <video controls autoplay="autoplay" loop="loop" x5-video-player-type="h5" x5-video-player-fullscreen="false" muted playsinline webkit-playsinline>
                                        <source src="video/game_video2.mp4" type="video/mp4" />
                                        <p>Your browser does not support the video tag.</p>
                                    </video>
                                </div>
                            </div>
                        </div>
                      </div>
                      <div class="swiper-slide">
                        <div>
                            <img src="images/newindex/video_logo3.png" class="videologo" alt="">
                            <div class="relative aspect-video">
                                <div>
                                    <video controls autoplay="autoplay" loop="loop" x5-video-player-type="h5" x5-video-player-fullscreen="false" muted playsinline webkit-playsinline>
                                        <source src="video/game_video3.mp4" type="video/mp4" />
                                        <p>Your browser does not support the video tag.</p>
                                    </video>
                                </div>
                            </div>
                        </div>
                      </div>
                      <div class="swiper-slide">
                        <div>
                            <img src="images/newindex/video_logo4.png" class="videologo" alt="">
                            <div class="relative aspect-video">
                                <div>
                                    <video controls autoplay="autoplay" loop="loop" x5-video-player-type="h5" x5-video-player-fullscreen="false" muted playsinline webkit-playsinline>
                                        <source src="video/game_video4.mp4" type="video/mp4" />
                                        <p>Your browser does not support the video tag.</p>
                                    </video>
                                </div>
                            </div>
                        </div>
                      </div>
                      <div class="swiper-slide">
                        <div>
                            <img src="images/newindex/video_logo5.png" class="videologo" alt="">
                            <div class="relative aspect-video">
                                <div>
                                    <video controls autoplay="autoplay" loop="loop" x5-video-player-type="h5" x5-video-player-fullscreen="false" muted playsinline webkit-playsinline>
                                        <source src="video/game_video5.mp4" type="video/mp4" />
                                        <p>Your browser does not support the video tag.</p>
                                    </video>
                                </div>
                            </div>
                        </div>
                      </div>
                    </div>
                    <div class="v-swiper-button-next"></div>
                    <div class="v-swiper-button-prev"></div>
                    <div class="swiper-pagination"></div>
                  </div>
            </div>
            <div class="content_area">
                <div class="video_intro">
                    <a id="video_intro_down" href="#"><span></span>
                        <p class="language_replace">看更多</p>
                    </a>
                    <a id="video_intro_up" href="#"><span></span>
                        <p class="language_replace">關閉</p>
                    </a>
                    <p class="content_wrap">
                        <span class="language_replace">Maharaja擁有種類多樣遊戲，包含各式的老虎機遊戲、以及輪盤和二十一點等桌面遊戲。</span><br>
                        <span class="language_replace">老虎機是 Maharaja 最受歡迎的遊戲之一，華麗感十足的酷炫效果，還可以贏得夢幻般大量的紅利獎金，都是老虎機這款遊戲的魅力所在。只需要點擊『SPIN』按鈕就可以開始遊戲，非常的容易操作。因此很推廌給所有的初學者。</span><br>
                        <span class="language_replace">桌面遊戲也是 Maharaja 中非常受歡迎的遊戲之一，主要是指使用撲克牌和輪盤進行的遊戲，不僅可以遊玩經典的二十一點、百家樂和輪盤，也有設有荷官的桌面遊戲可以選擇。完全可以依照自己的喜好和節奏去玩。</span><br>
                        <span class="language_replace">在Maharaja中，只需點擊您感興趣的遊戲即可開始遊玩，非常簡單好上手！除了可以在個人電腦上玩之外，您隨時隨地都能使用智慧手機或平板電腦輕鬆體驗其中的樂趣。請盡情享受Maharaja的遊戲吧！</span>
                    </p>
                </div>
            </div>
        </div>
        <div class="section5">
            <div class="content_area">
                <h1>
                    <span data-text="業界首創！MAHARAJA專屬活動" class="drop-shadow-text2 before:text-stroke changedatatext">
                        <span class="language_replace">業界首創！MAHARAJA專屬活動</span>
                    </span>
                </h1>
                <p class="language_replace">每天完成洗碼可獲得1,000 Gift</p>
                <p class="language_replace">且連續7天達成洗碼任務再加贈3000(Gift)</p>
                <img src="images/newindex/7day.jpg" alt="">
                <div class="events">
                    <div class="single_event month">
                        <div class="header"><span class="language_replace">每月優專的入金活動</span></div>
                        <div class="event_content">
                            <img src="images/newindex/month_01.jpg" alt="">
                            <img src="images/newindex/month_02.jpg" alt="">
                            <img src="images/newindex/month_03.jpg" alt="">
                            <img src="images/newindex/month_04.jpg" alt="">
                        </div>
                    </div>
                    <div class="single_event special">
                        <div class="header"><span class="language_replace">不定期的廠牌合作活動</span></div>
                        <div class="event_content">
                            <img src="images/newindex/act001.jpg" alt="">
                            <img src="images/newindex/act002.jpg" alt="">
                            <img src="images/newindex/act003.jpg" alt="">
                            <img src="images/newindex/act004.jpg" alt="">
                        </div>
                    </div>
                </div>
                <p class="more_event language_replace">更多精彩活動等你加入MAHARAJA後一起來參加!</p>
            </div>
        </div>
        <div class="section6">
            <div class="top_area">
                <div class="content_area">
                    <span class="section6_girl">
                        <img src="images/newindex/section6-girl.png" alt=""></span>
                    <h3 class="language_replace">世界觀</h3>
                    <p>
                        <span class="language_replace">Maharaja，那是一個五光十色，虛幻飄渺，充滿歡笑與樂音的地方。那裡乘載了許多人的回憶，也包含大山津見大人的回憶。大山津見大人提到Maharaja時總是帶著笑意，也經常告訴四葉：</span><br>
                        <span class="language_replace">「Maharaja就像一個令人快樂的咒語，不開心、遇到挫折的時候就唸唸吧！」因此不知不覺中也變成了四葉的口頭禪。</span><br>
                        <span class="language_replace">這次選中了カジノマハラジャ（Casino Maharaja），大山津見大人一定也有祂考量吧！</span>
                    </p>
                </div>
                <span class="section6_wave">
                    <img src="images/newindex/section6-wave-bg.svg" alt=""></span>
            </div>
            <div class="Character_area">
                <div class="Character_wrap">
                    <div class="Character Character_girl">
                        <div class="girl_intro">
                            <img class="-translate-x-6" src="images/newindex/girl-character.png" alt="">
                            <h3>四葉 (よつば)</h3>
                            <p class="language_replace">在山中生病的小狐狸，奄奄一息的時候被神明──大山津見所救，之後就一直待在祂身邊修行。原本只是普通小狐狸的四葉在多年修行後，好不容易有了靈力，終於能夠化為人形（雖然還藏不住耳朵跟尾巴）。為了讓四葉進一步修行，並貼近人類，大山津見在Casino Maharaja打造了神社，並派遣身為前輩的狛犬「大吉」幫助她，要讓四葉在這裡帶給人類保佑（利益），獲得快樂與幸福，才能夠成為獨當一面的神明使者。</p>
                        </div>
                    </div>
                    <div class="Character Character_dig">
                        <div class="girl_intro">
                            <img class="-translate-x-6" src="images/newindex/dog-character.png" alt="">
                            <h3>大吉</h3>
                            <p class="language_replace">真實身分是如狼犬般威風凜凜，如獅子般兇猛的女神使者「狛犬」。被大山津見大人指派到Casino Maharaja的神社，當四葉的輔佐人。但是因為原本的狛犬形象令四葉害怕，於是為了之後的修行考量，讓四葉決定了自己的形象，變成了柴犬的形象。大吉已經是獨當一面的神明使者，身為四葉的前輩，總是很嚴格，不過其實很擔心四葉。</p>
                        </div>
                    </div>
                </div>
            </div>
            <div class="dialogue_wrap">
                <a id="dialogue_down" href="#"><span></span>
                    <p class="language_replace">看更多</p>
                </a>
                <a id="dialogue_up" href="#"><span></span>
                    <p class="language_replace">關閉</p>
                </a>
                <img class="gd_head" src="images/newindex/girl-dog.png" alt="">
                <div class="dialogue_content">
                    <div class="say dog_say">
                        <span><b class="arrow_r_int"></b>
                            <p class="language_replace">吼──！吼──！（好啦，接下來要開始修行啦！我會嚴格指導，妳認命吧！）</p>
                        </span>
                        <img src="images/newindex/dialogue-dog.png" alt="">
                    </div>
                    <div class="say girl_say">
                        <img src="images/newindex/dialogue-girl.png" alt="">
                        <span><b class="arrow_l_int"></b>
                            <p class="language_replace">…（發抖）</p>
                        </span>
                    </div>
                    <div class="say dog_say">
                        <span><b class="arrow_r_int"></b>
                            <p class="language_replace">吼──！（也不用怕成那樣吧？）</p>
                        </span>
                        <img src="images/newindex/dialogue-dog.png" alt="">
                    </div>
                    <div class="say girl_say">
                        <img src="images/newindex/dialogue-girl.png" alt="">
                        <span><b class="arrow_l_int"></b>
                            <p class="language_replace">因、因為前輩狛犬的樣子很可怕嘛！</p>
                        </span>
                    </div>
                    <div class="say dog_say">
                        <span><b class="arrow_r_int"></b>
                            <p class="language_replace">（你對我這威風凜凜的樣貌有什麼不滿嗎！）</p>
                        </span>
                        <img src="images/newindex/dialogue-dog.png" alt="">
                    </div>
                    <div class="say girl_say">
                        <img src="images/newindex/dialogue-girl.png" alt="">
                        <span><b class="arrow_l_int"></b>
                            <p class="language_replace">…嗚啊（發抖）</p>
                        </span>
                    </div>
                    <div class="say dog_say">
                        <span><b class="arrow_r_int"></b>
                            <p class="language_replace">吼、吼。吼──。吼──。（唉，拿妳沒辦法。那這樣吧，為了之後修行順利進行，由妳來決定我的形象。在腦中想像吧。）</p>
                        </span>
                        <img src="images/newindex/dialogue-dog.png" alt="">
                    </div>
                    <div class="say girl_say">
                        <img src="images/newindex/dialogue-girl.png" alt="">
                        <span><b class="arrow_l_int"></b>
                            <p class="language_replace">可以嗎？謝謝！那就……</p>
                        </span>
                    </div>
                    <div class="say dog_say">
                        <span><b class="arrow_r_int"></b>
                            <p class="language_replace">汪！汪！嗚──汪！（搞、搞什麼！這不是柴犬嗎！一點也不帥！）</p>
                        </span>
                        <img src="images/newindex/dialogue-dog.png" alt="">
                    </div>
                    <div class="say girl_say">
                        <img src="images/newindex/dialogue-girl.png" alt="">
                        <span><b class="arrow_l_int"></b>
                            <p class="language_replace">哇──！好可愛的狗狗！！</p>
                        </span>
                    </div>
                    <div class="say dog_say">
                        <span><b class="arrow_r_int"></b>
                            <p class="language_replace">汪汪汪！嗚汪。嗚──汪、汪！（我才不是狗狗，是狛犬！算了，隨便。之後我們要讓來到Casino Maharaja的人類快樂和幸福喔！）</p>
                        </span>
                        <img src="images/newindex/dialogue-dog.png" alt="">
                    </div>
                    <div class="say girl_say">
                        <img src="images/newindex/dialogue-girl.png" alt="">
                        <span><b class="arrow_l_int"></b>
                            <p class="language_replace">是，我會加油的！マハラジャー、ラジャー！</p>
                        </span>
                    </div>
                </div>
            </div>
        </div>
        <div class="section7">
            <span class="section7_wave">
                <img src="images/newindex/section7-wave-bg.svg" alt=""></span>
            <div class="flower left_flower">
                <img src="images/newindex/flower-left.png" alt="">
            </div>
            <div class="flower right_flower">
                <img src="images/newindex/flower-right.png" alt="">
            </div>
            <div class="content_area">
                <div class="word">
                    <h1>
                        <span data-text="Maharaja獨創的獎勵制度，使用起來更加彈性！" class="drop-shadow-text2 before:text-stroke changedatatext">
                            <span class="language_replace">Maharaja獨創的獎勵制度，使用起來更加彈性！</span>
                        </span>
                    </h1>
                    <a class="join language_replace" style="cursor:pointer" onclick="window.parent.API_LoadPage('Prize','/Guide/prize.html', false)">了解更多關於獎金與禮金</a>
                </div>
                <div class="section7_girl">
                    <img src="images/newindex/autumn-girl.png" alt="">
                </div>
                <div class="img_777" style="animation-delay: 0.6s">
                    <img src="images/newindex/777.svg" alt="">
                </div>
                <div class="img_chip_blue" style="animation-delay: 0s">
                    <img src="images/newindex/chip-blue.svg" alt="">
                </div>
                <div class="img_chip_red" style="animation-delay: 1s">
                    <img src="images/newindex/chip-red.svg" alt="">
                </div>
                <div class="img_chip_yellow" style="animation-delay: .7s">
                    <img src="images/newindex/chip-yellow.svg" alt="">
                </div>
                <div class="img_dice" style="animation-delay: .2s">
                    <img src="images/newindex/dice.svg" alt="">
                </div>
                <div class="img_card" style="animation-delay: 0s">
                    <img src="images/newindex/card.svg" alt="">
                </div>
                <div class="img_diamond" style="animation-delay: .4s">
                    <img src="images/newindex/diamond.svg" alt="">
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript">
        $("#video_intro_up").hide();
        $("#video_intro_down").click(function () {
            $(this).hide();
            $("#video_intro_up").show();
            $(".video_intro p.content_wrap").addClass("allcontent");
            return false;
        });
        $("#video_intro_up").click(function () {
            $(this).hide();
            $("#video_intro_down").show();
            $(".video_intro p.content_wrap").removeClass("allcontent");
            return false;
        });

        $("#dialogue_up").hide();
        $("#dialogue_down").click(function () {
            $(this).hide();
            $("#dialogue_up").show();
            $(".dialogue_content").addClass("allcontent2");
            return false;
        });
        $("#dialogue_up").click(function () {
            $(this).hide();
            $("#dialogue_down").show();
            $(".dialogue_content").removeClass("allcontent2");
            return false;
        });
    </script>
    <script>
        var swiper = new Swiper(".mySwiper", {
            slidesPerView: 1,
            spaceBetween: 50,
            loop: true,
            cssMode: true,
            keyboard: {
                enabled: true,
            },
            navigation: {
                nextEl: ".v-swiper-button-next",
                prevEl: ".v-swiper-button-prev",
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true,
            },
            mousewheel: true,
            keyboard: true,
        });
      </script>
    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>
</body>
</html>
