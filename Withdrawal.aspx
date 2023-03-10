<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;
    string InOpenTime = EWinWeb.CheckInWithdrawalTime() ? "Y" : "N";
    string IsWithdrawlTemporaryMaintenance = EWinWeb.IsWithdrawlTemporaryMaintenance() ? "Y" : "N";
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
       <style>
        .tempCard {
        cursor:pointer;
        }
        .comingSoon {
            position: absolute;
            top: 10px;
            left: 10px;
            z-index: 99999;
            height: calc(100% - 20px);
            width: calc(100% - 20px);
        }
    </style>
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
    var lang;
    var mlp;
    var v = "<%:Version%>";
    var IsOpenTime = "<%:InOpenTime%>";
    var IsWithdrawlTemporaryMaintenance = "<%:IsWithdrawlTemporaryMaintenance%>";
    var IsFullRegistration = 0;

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        lang = window.parent.API_GetLang();
        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();

            IsFullRegistration = window.parent.API_GetUserIsFullRegistration();

            if (IsFullRegistration == 0) {
                window.parent.showMessageOK("", mlp.getLanguageKey("????????????????????????????????????????????????"), function () {
                    window.parent.API_LoadPage('MemberCenter', 'MemberCenter.aspx?needShowRegister=1', true);
                });
            } else {
                if (IsOpenTime == "N") {
                    window.parent.API_NonCloseShowMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("NotInOpenTime"), function () {
                        window.parent.API_Reload();
                    });
                } else {
                    if (IsWithdrawlTemporaryMaintenance == "Y") {
                        window.parent.API_NonCloseShowMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("WithdrawlTemporaryMaintenance"), function () {
                            window.parent.API_Reload();
                        });
                    } else {
                        showWithdrawlPrecautions();
                    }
                }
            }
        }, "PaymentAPI");
    }

    function showWithdrawlPrecautions() {
        window.top.API_ShowMessageOK("", `<p>??????????????????????????????????????????????????????????????????????????????????????????????????????2022???10???19????????????????????????????????????????????????????????????????????????KYC???????????????????????????????????????</p> </br>
<p style='margin:0'>???????????????????????????????????????</p> </br>
<p style='margin:0'>-???????????????????????????????????????</p> </br>
<p style='margin:0'>-???????????????????????????????????????</p> </br>
<p style='margin:0'>-???????????????</p> </br>
<p style='margin:0'>-???????????????????????????</p> </br>
<p style='margin:0'>-??????????????????????????????????????????</p> </br>
<p style='margin:0'>?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????</p> </br>
<p style='margin:0'>???????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????</p> </br>
<p style='margin:0'>????????????????????????service@casino-maharaja.com</p> </br>`);
    }

    function API_showMessageOK(title, message, cbOK) {
        if ($("#alertContact").attr("aria-hidden") == 'true') {
            var divMessageBox = document.getElementById("alertContact");
            var divMessageBoxCloseButton = divMessageBox.querySelector(".alertContact_Close");
            var divMessageBoxOKButton = divMessageBox.querySelector(".alertContact_OK");
            //var divMessageBoxTitle = divMessageBox.querySelector(".alertContact_Text");
            var divMessageBoxContent = divMessageBox.querySelector(".alertContact_Text");

            if (messageModal == null) {
                messageModal = new bootstrap.Modal(divMessageBox);
            }

            if (divMessageBox != null) {
                messageModal.show();

                if (divMessageBoxCloseButton != null) {
                    divMessageBoxCloseButton.classList.add("is-hide");
                }

                if (divMessageBoxOKButton != null) {
                    //divMessageBoxOKButton.style.display = "inline";

                    divMessageBoxOKButton.onclick = function () {
                        messageModal.hide();

                        if (cbOK != null)
                            cbOK();
                    }
                }

                //divMessageBoxTitle.innerHTML = title;
                divMessageBoxContent.innerHTML = message;
            }
        }
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
        window.parent.API_ShowMessageOK("", "<p style='font-size:2em;text-align:center;margin:auto'>" + mlp.getLanguageKey("????????????") + "</p>");
    }

    window.onload = init;

</script>
<body>
    <div class="page-container">
        <!-- Heading-Top -->
        <div id="heading-top"></div>

        <div class="page-content">

            <section class="sec-wrap">
                <!-- ???????????? -->
                <div class="page-title-container">
                    <div class="page-title-wrap">
                        <div class="page-title-inner">
                            <h3 class="title language_replace">??????</h3>
                        </div>
                    </div>
                </div>

                <!-- ?????? -->
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
                    <p class="language_replace">??????????????????</p>
                </div>

                <!-- ??????????????????  -->
                <div class="card-container">

                    <!-- PayPal -->
                    <%--                    <div class="card-item sd-08">
                        <a class="card-item-link" onclick="window.parent.API_LoadPage('DepositPayPal','DepositPayPal.aspx')">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span class="language_replace">????????????</span>
                                    <!-- <span>Electronic Wallet</span>  -->
                                </div>
                                <div class="logo vertical-center">
                                    <img src="images/assets/card-surface/icon-logo-paypal-w.svg">
                                </div>
                            </div>
                            <img src="images/assets/card-surface/card-08.svg" class="card-item-bg">
                        </a>      

                    </div>--%>
                    <!-- ???????????? -->
                  <%--  <div class="card-item sd-02" style="">
                        <a class="card-item-link" onclick="window.parent.API_LoadPage('WithdrawalCrypto','WithdrawalCrypto.aspx')">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span>Crypto Wallet</span>
                                </div>
                                <div class="title vertical-center">
                                    <span class="language_replace">????????????</span>
                                </div>
                                <!-- <div class="desc">
                                    <b>30</b> ??? -  <b>5,000</b> ??? No Fee                                   
                                </div> -->
                                <div class="logo">
                                    <i class="icon-logo-usdt"></i>
                                    <!-- <i class="icon-logo-eth-o"></i> -->
                                    <i class="icon-logo-eth"></i>
                                    <i class="icon-logo-btc"></i>
                                    <!-- <i class="icon-logo-doge"></i> -->
                                    <!-- <i class="icon-logo-tron"></i> -->
                                </div>
                                <!-- <div class="instructions-crypto">
                                    <i class="icon-info_circle_outline"></i>
                                    <span onclick="window.open('instructions-crypto.html')" class="language_replace">????????????</span>
                                </div>                                -->
                            </div>
                            <img src="images/assets/card-surface/card-02.svg" class="card-item-bg">
                        </a>
                    </div>--%>
                    <!-- EPay -->
                    <div class="card-item sd-04 tempCard"  onclick="window.parent.API_LoadPage('WithdrawalEPay','WithdrawalEPay.aspx')">
                        <a class="card-item-link ">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span class="language_replace">Maharaja</span>
                                    <!-- <span>Electronic Wallet</span>  -->
                                </div>
                                <div class="logo vertical-center text-center">
                                    <!-- <span class="text language_replace">????????????</span> -->
                                    <img src="images/assets/card-surface/icon-logo-NissinPay-2.svg">
                                </div>
                            </div>
                        </a>
                           <%--<img class="comingSoon" src="../images/assets/card-surface/cs.png">--%>
                    </div>
                         <!-- EPay -->
                    <div class="card-item sd-04 tempCard" onclick="window.parent.API_LoadPage('WithdrawalTigerPay','WithdrawalTigerPay.aspx')">
                        <a class="card-item-link ">
                            <div class="card-item-inner">
                                <div class="title">
                                    <span class="language_replace">TigerPay</span>
                                    <!-- <span>Electronic Wallet</span>  -->
                                </div>
                                <div class="logo vertical-center text-center">
                                    <!-- <span class="text language_replace">????????????</span> -->
                                    <img src="images/assets/card-surface/tigerpay.png">
                                </div>
                            </div>
                        </a>
                            <img src="images/assets/card-surface/card-09.svg" class="card-item-bg">
                    </div>
                </div>
                <!-- ???????????? -->
                <div class="notice-container mt-5">
                    <div class="notice-item">
                        <i class="icon-wallet"></i>
                        <div class="text-wrap">
                            <p class="title language_replace text-link" onclick="window.parent.API_LoadPage('record','record.aspx', true)">??????????????????</p>
                        </div>
                    </div>
                </div>
                <div class="notice-container mt-5">
                    <div class="notice-item">
                        <i class="icon-info_circle_outline"></i>
                        <div class="text-wrap">
                            <p class="title language_replace text-link" onclick="window.parent.API_LoadPage('record','Article/guide_withdrawMoney_jp.html', true)">??????????????????????????????</p>
                        </div>
                    </div>
                </div>
                <!-- ???????????? -->
                <div class="notice-container mt-5">
                    <div class="notice-item">
                        <i class="icon-info_circle_outline"></i>
                        <div class="text-wrap">
                            <p class="title language_replace">????????????</p>
                            <p class="language_replace">1.OCOIN????????????????????????????????????????????????</p>
                            <p class="language_replace">2.?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????</p>
                            <p class="language_replace">3. 1????????????????????????????????????:???1????????????????????????1?????????????????????100???Ocoin????????????????????????</p>
                            <p class="language_replace">4.???????????????????????????????????????????????????????????????</p>
                            <p class="language_replace">5.???????????????365?????????????????????10????????????18????????????</p>
                        </div>
                    </div>
                </div>

            </section>


        </div>
    </div>
    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>
</body>
</html>
