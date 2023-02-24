<%@ Page Language="C#" %>

<%
    string PCode = Request["PCode"];
    string Version = EWinWeb.Version;
%>
<!doctype html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maharaja</title>

    <link rel="stylesheet" href="Scripts/OutSrc/lib/bootstrap/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="css/icons.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/global.css?<%:Version%>" type="text/css" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;500&display=swap" rel="Prefetch" as="style" onload="this.rel = 'stylesheet'" />
    <script src="https://genieedmp.com/dmp.js?c=6780&ver=2" async></script>
</head>
<% if (EWinWeb.IsTestSite == false)
    { %>
<!-- Global site tag (gtag.js) - Google Analytics -->
<script async src="https://www.googletagmanager.com/gtag/js?id=G-097DC2GB6H"></script>
<script>
    window.dataLayer = window.dataLayer || [];
    function gtag() { dataLayer.push(arguments); }
    gtag('js', new Date());

    gtag('config', 'G-097DC2GB6H');
</script>
<% } %>
    
<script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
<script src="Scripts/OutSrc/js/script.js"></script>
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/libphonenumber.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script>      
    if (self != top) {
        window.parent.API_LoadingStart();
    }
    var c = new common();
    var pCode = "<%=PCode%>";
    var WebInfo;
    var p;
    var mlp;
    var lang;
    var PhoneNumberUtil = libphonenumber.PhoneNumberUtil.getInstance();
    var v ="<%:Version%>";
    var isSent = false;
    var isSent_Phone = false;
    var LoginAccount;

    function BackHome() {
        window.parent.API_Casino();
    }

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        p = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();

        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd(1);
        });
    }

    function EWinEventNotify(eventName, isDisplay, param) {
        switch (eventName) {
            case "LoginState":

                break;
            case "BalanceChange":
                break;

            case "SetLanguage":
                var lang = param;

                mlp.loadLanguage(lang, function () {
                    window.parent.API_LoadingEnd(1);
                });
                break;
        }
    }
    window.onload = init;
</script>
<body>
    <div class="layout-full-screen sign-container" data-form-group="signContainer">

        <!-- <div class="logo" data-click-btn="backToHome">
            <img src="images/assets/logo-icon.png">
        </div> -->

        <div class="btn-back is-hide" data-click-btn="backToSign">
            <div></div>
        </div>

        <!-- 主內容框 -->
        <div class="main-panel">
            <!-- 註冊完成 -->
            <div id="contentFinish" class="form-container">
                <div class="heading-title">
                    <h1>Welcome</h1>
                </div>
                <div class="heading-sub-desc text-wrap">
                    <h5 class="mb-4 language_replace">歡迎來到 Maharaja！</h5>
                    <p class="language_replace">感謝您註冊我們的新會員，真正非常的感謝您 ！</p>
                    <p>
                        <span class="language_replace">您現在可以馬上進入遊戲裡盡情的遊玩我們為您準備的優質遊戲。</span>
                        <br>
                        <span class="language_replace">另外還準備了很多的特典在等待您!</span>

                    </p>
                    <p class="language_replace">如果有任何不清楚的地方，歡迎您利用客服與我們聯絡。</p>
                </div>

                <div class="btn-container pt-4 mb-4">
                    <button type="button" class="btn btn-primary" onclick="window.parent.API_LoadPage('Login','Login.aspx')"><span class="language_replace">立刻登入</span></button>
                </div>
                <div class="d-flex justify-content-center">
                    <a class="text-link underline" onclick="BackHome()">
                        <span class="language_replace">首頁</span>
                    </a>
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>
</body>
</html>
