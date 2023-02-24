<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;
%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maharaja</title>

    <link rel="stylesheet" href="Scripts/OutSrc/lib/bootstrap/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="css/icons.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/global.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/wallet.css" type="text/css" />
    <link href="css/footer-new.css" rel="stylesheet" />
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;500&display=swap" rel="Prefetch" as="style" onload="this.rel = 'stylesheet'" />
    <script src="https://genieedmp.com/dmp.js?c=6780&ver=2" async></script>
    <style>
        
    </style>
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
<script src="Scripts/OutSrc/js/wallet.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/libphonenumber.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script>
    if (self != top) {
        window.parent.API_LoadingStart();
    }
    var WebInfo;
    var lang;
    var mlp;
    var IsFullRegistration = 0;
    var v = "<%:Version%>";

    function init() {

        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();


        lang = window.parent.API_GetLang();
        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();

            IsFullRegistration = window.parent.API_GetUserIsFullRegistration();
            if (IsFullRegistration == 0) {
                window.parent.showMessageOK("", mlp.getLanguageKey("您尚未完成認證，即將前往認證頁面"), function () {
                    window.parent.API_LoadPage('MemberCenter', 'MemberCenter.aspx?needShowRegister=1', true);
                });
            }
        }, "PaymentAPI");
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
                    window.parent.API_LoadingEnd(1);
                });
                break;
        }
    }

    function TempAlert() {
        window.parent.API_ShowMessageOK("", "<p style='font-size:2em;text-align:center;margin:auto'>" +  mlp.getLanguageKey("近期開放") + "</p>");
    }

    window.onload = init;

</script>
<body>
    <div class="page-container">
        <!-- Heading-Top -->
        <div id="heading-top"></div>

        <div class="page-content">

            <section class="sec-wrap">
                <!-- 頁面標題 -->
                <div class="page-title-container">
                    <div class="page-title-wrap">
                        <div class="page-title-inner">
                            <h3 class="title language_replace">存款</h3>
                        </div>
                    </div>
                </div>

                <!-- 步驟 -->
                <div class="progress-container progress-line">
                    <div class="progress-step cur">
                        <div class="progress-step-item"></div>
                            <span class="progressline-step language_replace">step1</span>
                    </div>
                    <div class="progress-step">
                        <div class="progress-step-item"></div>
                            <span class="progressline-step language_replace">step2</span>
                    </div>
                    <div class="progress-step">
                        <div class="progress-step-item"></div>
                            <span class="progressline-step language_replace">step3</span>
                    </div>
                    <div class="progress-step">
                        <div class="progress-step-item"></div>
                         <span class="progressline-step language_replace">Finish</span>
                    </div>
                </div>
                <div class="text-wrap progress-title">
                    <p class="language_replace">選擇存款管道</p>
                </div>

                <!-- 選擇存款管道  -->
                <div class="card-container">
                    <!-- PayPal -->
                    <div class="card-item sd-08" id="idDepositPaypal">
                        <a class="card-item-link" onclick="window.parent.API_LoadPage('DepositPayPal','DepositPayPal.aspx')">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span class="language_replace">電子錢包</span>
                                    <!-- <span>Electronic Wallet</span>  -->
                                </div>
                                <div class="logo vertical-center">
                                    <img src="images/assets/card-surface/icon-logo-paypal-w.svg">
                                </div>
                            </div>
                            <img src="images/assets/card-surface/card-08.svg" class="card-item-bg">
                        </a>
                    </div>
                    <!-- 虛擬錢包 -->
                    <div class="card-item sd-02" style="">
                        <a class="card-item-link" onclick="window.parent.API_LoadPage('DepositCrypto','DepositCrypto.aspx')">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span>Crypto Wallet</span>
                                </div>
                                <div class="title vertical-center">
                                    <span class="language_replace">虛擬貨幣</span>
                                </div>
                                <!-- <div class="desc">
                                    <b>30</b> € -  <b>5,000</b> € No Fee                                   
                                </div> -->
                                <div class="logo">
                                    <i class="icon-logo-usdt"></i>
                                    <!-- <i class="icon-logo-eth-o"></i> -->
                                    <!-- <i class="icon-logo-nissin"></i> -->
                                    <i class="icon-logo-eth"></i>
                                    <i class="icon-logo-btc"></i>
                                    
                                    <!-- <i class="icon-logo-doge"></i> -->
                                    <!-- <i class="icon-logo-tron"></i> -->
                                </div>
                                <!-- <div class="instructions-crypto">
                                    <i class="icon-info_circle_outline"></i>
                                    <span onclick="window.open('instructions-crypto.html')" class="language_replace">使用說明</span>
                                </div>                                -->
                            </div>
                            <img src="images/assets/card-surface/card-02.svg" class="card-item-bg">
                        </a>
                    </div>
                    <!-- EPay -->
                    <div class="card-item sd-03" id="idDepositEPay">
                        <a class="card-item-link" onclick="window.parent.API_LoadPage('DepositEPay','DepositEPay.aspx')">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span class="language_replace">Maharaja</span>
                                    <!-- <span>Electronic Wallet</span>  -->
                                </div>
                                <div class="logo vertical-center text-center"> 
                                    <!-- <span class="text language_replace">銀行振込</span> -->
                                    <img src="images/assets/card-surface/icon-logo-NissinPay-2.svg">
                                </div>
                            </div>
                            <img src="images/assets/card-surface/card-03.svg" class="card-item-bg">
                        </a>
                    </div>
                       <!-- EPay -->
                    <div class="card-item sd-04" id="idDepositTigerPay">
                        <a class="card-item-link" onclick="window.parent.API_LoadPage('DepositEPay','DepositTigerPay.aspx')">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span class="language_replace">TigerPay</span>
                                    <!-- <span>Electronic Wallet</span>  -->
                                </div>
                                <div class="logo vertical-center text-center"> 
                                    <!-- <span class="text language_replace">銀行振込</span> -->
                                    <img src="images/assets/card-surface/tigerpay.png">
                                </div>
                            </div>
                            <img src="images/assets/card-surface/card-09.svg" class="card-item-bg">
                        </a>
                    </div>
                </div>
                <!-- 存款紀錄 -->
                <div class="notice-container mt-5">
                    <div class="notice-item">
                        <i class="icon-wallet"></i>
                        <div class="text-wrap">
                            <p class="title language_replace text-link" onclick="window.parent.API_LoadPage('record','record.aspx', true)">檢視存款紀錄</p>
                        </div>
                    </div>
                </div>
                <div class="notice-container mt-5">
                    <div class="notice-item">
                        <i class="icon-info_circle_outline"></i>
                        <div class="text-wrap">
                            <p class="title language_replace" style="cursor:pointer" onclick="window.parent.API_LoadPage('record','Article/guide_CashQa_jp.html', true)">各入金方法の手順説明</p>
                        </div>
                    </div>
                </div>
                <!-- 溫馨提醒 -->
                <div class="notice-container mt-5">
                    <div class="notice-item">
                        <i class="icon-info_circle_outline"></i>
                        <div class="text-wrap">
                            <p class="title language_replace">溫馨提醒</p>
                            <p class="language_replace">1.OCOIN是客人在マハラジャ遊玩的幣別總稱</p>
                            <p class="language_replace">2.不同的存款管道可能影響存款金額到達玩家錢包的時間。最遲一個營業日為合理的範圍。</p>
                            <p class="language_replace">3.關於出金門檻倍率</p>
                            <p class="language_replace">PayPal・主要加密貨幣＝入金額の1.5倍</p>
                            <p class="language_replace">（計算範例）</p>
                            <p class="language_replace">PayPal 10000+獎金10000的情況</p>
                            <p class="language_replace">10,000×1.5倍+10,000×20倍=215,000​</p>
                            <p class="language_replace">關於出金門檻的詳細說明於</p>
                            <p class="language_replace">4.持有的OCoin在100以下時入金，或是領取領獎中心的OCoin即可解除原有的出金門檻。</p>
                        </div>
                    </div>
                </div>

            </section>


        </div>
    </div>
    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>
</body>
</html>
