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
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bignumber.js/9.0.2/bignumber.min.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script>      
    if (self != top) {
        window.parent.API_LoadingStart();
    }
    var WebInfo;
    var mlp;
    var PaymentSerial;
    var OrderNumber;
    var c = new common();
    var p;
    var v = "<%:Version%>";

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        lang = window.parent.API_GetLang();
        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            PaymentSerial = c.getParameter("PS");

            if (PaymentSerial) {
                p = window.parent.API_GetPaymentAPI();
                getPaymentByPaymentSerial(PaymentSerial);
            } else {
                window.parent.API_ShowMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("???????????????"), function () {
                     window.parent.API_Reload();
                });
            }

            window.parent.API_LoadingEnd();
        },"PaymentAPI");
    }

    function cancelPayment() {
        p.CancelPayment(WebInfo.SID, Math.uuid(), PaymentSerial, OrderNumber, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("???????????????"), function () {
                          window.parent.API_Reload();
                    });
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {
                          window.parent.API_Reload();
                    });
                }
            } else {
                window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("???????????????, ????????????????????????"), function () {
                    windowz.parent.API_Home();
                });
            }
        });
    }

    function GetWalletChain(walletType) {
        if (walletType == 0) {
            return "ETH";
        } else if (walletType == 1) {
            return "XRP";
        } else if (walletType == 2) {
            return "BTC";
        } else if (walletType == 3) {
            return "TRX";
        } else {
            return "ETH";
        }
    }

    function getPaymentByPaymentSerial(PaymentSerial) {
        p.GetPaymentByPaymentSerial(WebInfo.SID, Math.uuid(), PaymentSerial, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    var retData = o.Data;

                    //dom??????
                    var paymentDetailDom = document.getElementById("paymentMethodDom");
                    var paymentInfoDom = document.getElementById("paymentInfoDom");
                    //var activityDom = document.getElementById("activityDom");
                    OrderNumber = retData.OrderNumber;
                    c.setClassText(paymentInfoDom, "Paymentserial", null, PaymentSerial);
                    $(paymentInfoDom).find('.inputPaymentSerial').val(PaymentSerial);
                    c.setClassText(paymentInfoDom, "PaymentMethodName", null, retData.PaymentMethodName);
                    //c.setClassText(paymentInfoDom, "PaymentMethodName", null, retData.PaymentMethodName);
               
                    if (retData.BasicType == 1) {
                        var bankData = JSON.parse(retData.ToWalletAddress)

                        $(paymentInfoDom).find('.BankName').parent().show();
                        $(paymentInfoDom).find('.BankCard').parent().show();
                        $(paymentInfoDom).find('.BankCardName').parent().show();

                        c.setClassText(paymentInfoDom, "BankCard", null, bankData.BankCard);
                        c.setClassText(paymentInfoDom, "BankName", null, bankData.BankName);
                        c.setClassText(paymentInfoDom, "BankCardName", null, bankData.BankCardName);
                    } else {
                        $(paymentInfoDom).find('.ToWalletAddress').parent().show();
                        $(paymentInfoDom).find('.EWinCryptoWalletType').parent().show();
                        c.setClassText(paymentInfoDom, "EWinCryptoWalletType", null, GetWalletChain(retData.WalletType));
                        c.setClassText(paymentInfoDom, "ToWalletAddress", null, retData.ToWalletAddress);
                    }
                    

                    if (retData.PaymentCryptoDetailList != null) {
                        var depositdetail = document.getElementsByClassName("Collectionitem")[0];
                        for (var i = 0; i < retData.PaymentCryptoDetailList.length; i++) {

                            var CollectionitemDom = c.getTemplate("templateCollectionitem");
                            CollectionitemDom.querySelector(".icon-logo").classList.add("icon-logo-" + retData.PaymentCryptoDetailList[i]["TokenCurrencyType"].toLowerCase());
                            c.setClassText(CollectionitemDom, "currency", null, retData.PaymentCryptoDetailList[i]["TokenCurrencyType"]);
                            c.setClassText(CollectionitemDom, "val", null, new BigNumber(retData.PaymentCryptoDetailList[i]["ReceiveAmount"]).toFormat());
                            depositdetail.appendChild(CollectionitemDom);
                        }
                    }
                    c.setClassText(paymentDetailDom, "Amount", null, new BigNumber(retData.Amount).toFormat());



                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("?????????????????????"), function () {
                        window.parent.API_Home();
                    });
                }
            } else {
                window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("???????????????, ????????????????????????"), function () {
                    window.parent.API_Home();
                });
            }
        });
    }

    function copyTextPaymentSerial(tag) {
      
        var copyText = $(tag).parent().find('.inputPaymentSerial')[0];

        copyText.select();
        copyText.setSelectionRange(0, 99999);

        navigator.clipboard.writeText(copyText.value).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("????????????")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("????????????")) });
    }

    function copyText(tag) {
        var copyText = document.getElementById(tag);
        copyText.select();
        copyText.setSelectionRange(0, 99999);

        navigator.clipboard.writeText(copyText.value).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("????????????")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("????????????")) });
        //alert("Copied the text: " + copyText.value);
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

    function setEthWalletAddress(EthAddress) {
        $('#idEthAddr').text(EthAddress);
        $('#idEthAddrInput').val(EthAddress);
        $('#cryptoimg').attr("src", `/GetQRCode.aspx?QRCode=${EthAddress}&Download=2`);
    }

    window.onload = init;

</script>
<body>

    <div class="page-container">
        <!-- Heading-Top -->

        <div class="page-content">

            <section class="sec-wrap">
                <!-- ???????????? -->
                <div class="page-title-container">
                    <div class="page-title-wrap">
                        <div class="page-title-inner">
                            <h3 class="title language_replace">????????????</h3>
                        </div>
                    </div>
                </div>

                <!-- ?????? -->

                <div class="text-wrap progress-title" style="display: none">
                    <p data-deposite="step4" class="language_replace">
                        <span class="language_replace">??????</span>
                        <span class="language_replace">USDT</span>
                        <span class="language_replace">??????</span>
                    </p>

                </div>

                <div class="split-layout-container">
                    <div class="crypto-info-coantainer" style="display: none">

                        <h4 class="mt-2 mt-md-4 cryoto-address language_replace">????????????</h4>
                        <div class="img-wrap qrcode-img">
                            <img id="cryptoimg" src="">
                        </div>
                        <div class="crypto-info">
                            <%--<div class="is-hide amount-info">
                                    <div class="amount">
                                        <sup>BTC</sup>
                                        <span class="count" id="cryptoPoint">0.000000</span>
                                    </div>
                                    <button class="btn btn-icon" onclick="copyText('cryptoPoint')">
                                        <i class="icon-copy"></i>
                                    </button>
                                </div>--%>
                            <div class="wallet-code-container">
                                <div class="wallet-code-info">
                                    <i class="icon-wallet"></i>
                                    <span id="idEthAddr"></span>
                                    <input id="idEthAddrInput" class="is-hide" />
                                </div>
                                <button class="btn btn-icon">
                                    <i class="icon-copy" onclick="copyText('idEthAddrInput')"></i>
                                </button>
                            </div>
                        </div>
                        <div class="crypto-info-related">
                            <!-- ???????????????????????? -->
                            <div class="crypto-info-inqury">
                                <div class="content">
                                    <p class="desc">
                                        <span class="language_replace desc-1">?????????</span>
                                        <a href="https://etherscan.io/" target="_blank" class="btn btn-outline-primary btn-etherscan btn-white">Etherscan</a><span class="language_replace desc-2">????????????????????????</span>
                                    </p>
                                    <!-- ????????? -->
                                    <button type="button" class="btn btn-icon" onclick="window.parent.API_LoadPage('instructions-crypto', 'instructions-crypto.html', true)">
                                        <i class="icon-casinoworld-question-outline"></i>
                                    </button>
                                </div>
                            </div>
                            <!-- ???????????? -->
                            <div class="crypto-exchange-rate" style="display: none">
                                <div class="rate">
                                    <p class="crypto RateOutCurrency"><span class="amount">1</span><span class="unit">USDT</span></p>
                                    <span class="sym">=</span>
                                    <p class="currency ExchangeRateOut"><span class="amount">100</span><span class="unit">Ocoin</span></p>
                                </div>
                                <div class="refresh">
                                    <p class="period"><span class="date"></span><span class="time">15:30:02</span></p>
                                    <button type="button" class="btn btn-outline-primary btn-icon btn-refresh  btn-white" onclick="RefreshExchange()">
                                        <i class="icon-casinoworld-refresh" onclick=""></i>
                                        <span class="language_replace">??????</span>
                                    </button>
                                </div>
                            </div>

                        </div>
                    </div>
                    <!-- ???????????? step3 - ???????????????-->
                    <div class="deposit-confirm" data-deposite="step3">
                        <div class="aside-panel">
                            <div class="deposit-calc" id="paymentMethodDom">
                                <div class="deposit-crypto">
                                    <h5 class="subject-title language_replace">????????????</h5>
                                    <ul class="deposit-crypto-list Collectionitem">
                                    </ul>
                                </div>
                                <div class="deposit-total">
                                    <div class="item total">
                                        <div class="title">
                                            <h5 class="name language_replace">????????????</h5>
                                        </div>
                                        <div class="data">
                                            <span class="name">Ocoin</span>
                                            <span class="count Amount"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="main-panel">
                            <div class="deposit-list">
                                <h5 class="subject-title language_replace">????????????</h5>
                                <ul class="deposit-detail" id="paymentInfoDom">
                                    <li class="item">
                                        <h6 class="title language_replace">????????????</h6>
                                        <span class="data Paymentserial"></span>
                                         <i class="icon-copy" onclick="copyTextPaymentSerial(this)" style="display: inline;"></i>     
                                        <input class="inputPaymentSerial is-hide" />
                                    </li>
                                    <li class="item">
                                        <h6 class="title language_replace">????????????</h6>
                                        <span class="data PaymentMethodName"></span>
                                    </li>
                                    <li class="item" style="display:none;">
                                        <h6 class="title language_replace">????????????</h6>
                                        <span class="data EWinCryptoWalletType">ERC</span>
                                    </li>
                                    <%--<li class="item">
                                        <h6 class="title language_replace">??????????????????</h6>
                                        <span class="data text-primary primary">2021/3/1</span>
                                    </li>--%>

                                    <li class="item" style="display:none;">
                                        <h6 class="title language_replace">??????????????????</h6>
                                        <span class="data ToWalletAddress"></span>
                                    </li>
                                     <li class="item" style="display:none;">
                                        <h6 class="title language_replace">????????????</h6>
                                        <span class="data BankName"></span>
                                    </li>
                                     <li class="item" style="display:none;">
                                        <h6 class="title language_replace">???????????????</h6>
                                        <span class="data BankCard"></span>
                                    </li>
                                    <li class="item" style="display:none;">
                                        <h6 class="title language_replace">???????????????</h6>
                                        <span class="data BankCardName"></span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </div>

                <div class="btn-container mt-2">
                    <%--<button class="btn btn-outline-primary" data-deposite="step4" onclick="window.top.API_LoadPage('Home','Home.aspx')">
                        <span class="language_replace">??????</span>
                    </button>
                        <button class="btn btn-primary" data-deposite="step4" data-toggle="modal" data-target="#depositSucc">
                        <span>??????</span>
                    </button>--%>
                           <%-- <button class="btn btn-outline-primary" onclick="cancelPayment()">
            <span class="language_replace">??????</span>
        </button>--%>
                </div>

                <!-- ???????????? -->
                <div class="notice-container" data-deposite="step4">
                    <div class="notice-item">
                        <i class="icon-info_circle_outline"></i>
                        <div class="text-wrap">
                            <p class="title language_replace">????????????</p>
                            <ul class="list-style-decimal">
                                <li><span class="language_replace">OCoin????????????????????????????????????</span></li>
                                <li><span class="language_replace">???????????????????????????????????????????????????????????????????????????</span></li>
                                <li><span class="language_replace">??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????</span></li>
                                <li><span class="language_replace">????????????????????????????????????-????????????????????????????????????</span></li>
                                <li><span class="language_replace">?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????</span></li>
                                <li><span class="language_replace">???ERC20???????????? https://etherscan.io/ ??????????????????????????????</span></li>
                            </ul>
                            <!-- <ul class="list-style-decimal">
                                <li><span class="language_replace">?????????????????????????????????????????????????????????????????????</span><br>
                                    <span class="primary language_replace">???USDT????????????ERC20??????????????????</span></li>
                                <li class="language_replace">???????????????????????????????????????????????????????????????????????????</li>
                            </ul> -->
                        </div>
                    </div>
                </div>
            </section>
        </div>
    </div>

    <!-- Modal ???????????????-->
    <div class="modal fade" tabindex="-1" role="dialog" aria-labelledby="depositSucc" aria-hidden="true" id="depositSucc">
        <div class="modal-dialog modal-dialog-centered" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true"><i class="icon-close-small"></i></span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="modal-body-content">
                        <i class="icon-circle-check green"></i>
                        <div class="text-wrap">
                            <h6 class="language_replace">???????????? !</h6>
                            <p class="language_replace">???????????????????????????????????????????????????????????? Bouns ?????????</p>
                        </div>
                    </div>
                    <div class="modal-body-content">
                        <i class="icon-info_circle_outline"></i>
                        <div class="text-wrap">
                            <h6 class="language_replace">????????????</h6>
                            <p class="language_replace">?????????????????????????????????????????????????????????????????????????????????????????????????????????????????????</p>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                </div>
            </div>
        </div>
    </div>

    <div id="templateActivity" style="display: none">

        <li class="item">
            <div class="custom-control custom-checkbox chkbox-item">
                <input class="custom-control-input-hidden ActivityCheckBox" type="checkbox" name="payment-crypto">
                <label class="custom-control-label">
                    <div class="detail">
                        <h6 class="title language_replace ActivityTitle"></h6>
                        <p class="desc language_replace ActivitySubTitle"></p>
                    </div>
                </label>
            </div>
        </li>
    </div>

    <div id="templateCollectionitem" style="display: none">
        <li class="item">
            <div class="title">
                <i class="icon-logo icon-logo-btc currencyicon"></i>
                <h6 class="name currency"></h6>
            </div>
            <span class="data val"></span>
        </li>
    </div>
    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>
</body>
</html>
