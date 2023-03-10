<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;
    string InOpenTime = EWinWeb.CheckInWithdrawalTime() ? "Y":"N";
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
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/libphonenumber.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bignumber.js/9.0.2/bignumber.min.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script type="text/javascript" src="/Scripts/PaymentAPI.js"></script>
<script type="text/javascript" src="/Scripts/crypto-address-validator.min.js"></script>
<script type="text/javascript" src="/Scripts/DateExtension.js"></script>
<%--<script src="Scripts/OutSrc/js/wallet.js"></script>--%>
<script>      
    if (self != top) {
        window.parent.API_LoadingStart();
    }
    var WebInfo;
    var mlp;
    var lang;
    var seleCurrency;
    var NomicsExchangeRate;
    var KucoinExchangeRate;
    var PaymentMethod;
    var c = new common();
    var ActivityNames = [];
    var OrderNumber;
    var PaymentClient;
    var lobbyClient;
    var v = "<%:Version%>";
    var CountInterval;
    var IsOpenTime = "<%:InOpenTime%>";
    var IsWithdrawlTemporaryMaintenance = "<%:IsWithdrawlTemporaryMaintenance%>";

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        lang = window.parent.API_GetLang();
        PaymentClient = window.parent.API_GetPaymentAPI();
        lobbyClient = window.parent.API_GetLobbyAPI();
        mlp = new multiLanguage(v);
        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();
            if (IsOpenTime == "N") {
                window.parent.API_NonCloseShowMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("NotInOpenTime"), function () {
                    window.parent.API_Reload();
                });
            } else {
                if (IsWithdrawlTemporaryMaintenance == "Y") {
                    window.parent.API_NonCloseShowMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("WithdrawlTemporaryMaintenance"), function () {
                        window.parent.API_Reload();
                    });
                }
            }
            GetPaymentMethod();
            startCountDown();
            btn_NextStep();
        }, "PaymentAPI");

        var EthWalletAddress = WebInfo.UserInfo.EthWalletAddress;
        var walletList = WebInfo.UserInfo.WalletList;
        var selectedLang = $('.header-tool-item').eq(2).find('a>span').text();
        var HasBitCoin = false;
        for (var i = 0; i < walletList.length; i++) {
            if (walletList[i].ValueType == 2) {
                HasBitCoin = true;
            }
        }

        seleCurrency = $(".crypto-list").children().find("input[type=radio]:checked").data("val");
        //RefreshExchange();

        window.setInterval(function () {


        }, 30000);
    }


    function startCountDown() {
        let secondsRemaining = 30;

        CountInterval = setInterval(function () {
            let idRecClock = document.getElementById("idRecClock");

            //min = parseInt(secondsRemaining / 60);
            //sec = parseInt(secondsRemaining % 60);
            idRecClock.innerText = secondsRemaining;

            secondsRemaining = secondsRemaining - 1;
            if (secondsRemaining < 0) {
                secondsRemaining = 30;
                GetExchangeRateFromNomics(function () {
                    let amountText = document.getElementById("amount").value;

                    if (amountText) {
                        ReSetPaymentAmount(true, Number(amountText));
                    } else {
                        ReSetPaymentAmount(true);
                    }
                });
            };

        }, 1000);
    }

    function btn_NextStep() {
        var Step2 = $('[data-deposite="step2"]');
        var Step3 = $('[data-deposite="step3"]');
        var Step4 = $('[data-deposite="step4"]');


        Step3.hide();
        Step4.hide();

        $('button[data-deposite="step2"]').click(function () {
            //????????????/??????
            CreateCryptoWithdrawal();
        });
        $('button[data-deposite="step3"]').click(function () {
            //?????????????????????
            ConfirmCryptoWithdrawal();
        });
    }

    function copyText(tag) {
        var copyText = document.getElementById(tag);
        copyText.select();
        copyText.setSelectionRange(0, 99999);

        navigator.clipboard.writeText(copyText.value).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("????????????")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("????????????")) });
    }

    function copyTextPaymentSerial(tag) {

        var copyText = $(tag).parent().find('.inputPaymentSerial')[0];

        copyText.select();
        copyText.setSelectionRange(0, 99999);

        navigator.clipboard.writeText(copyText.value).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("????????????")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("????????????")) });
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

    function CurrencyChange(e) {
        seleCurrency = $(e).data("val");
        $(".RateOutCurrency .unit").text(seleCurrency);
    }

    function GetExchangeRateFromNomics(cb) {

        PaymentClient.GetExchangeRateFromKucoin(WebInfo.SID, Math.uuid(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    if (o.Message != "") {
                        KucoinExchangeRate = JSON.parse(o.Message);
                        if (cb) {
                            cb();
                        }
                    } else {
                        window.parent.API_LoadingEnd(1);
                        window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {

                        });
                    }
                } else {
                    window.parent.API_LoadingEnd(1);
                    window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {

                    });
                }
            }
            else {
                window.parent.API_LoadingEnd(1);
                window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {

                });
            }
        })

        //PaymentClient.GetExchangeRateFromNomics(WebInfo.SID, Math.uuid(), function (success, o) {
        //    if (success) {
        //        if (o.Result == 0) {
        //            if (o.Message != "") {
        //                NomicsExchangeRate = JSON.parse(o.Message);
        //                if (cb) {
        //                    cb();
        //                }
        //            } else {
        //                window.parent.API_LoadingEnd(1);
        //                window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {

        //                });
        //            }
        //        } else {
        //            window.parent.API_LoadingEnd(1);
        //            window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {

        //            });
        //        }
        //    }
        //    else {
        //        window.parent.API_LoadingEnd(1);
        //        window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {

        //        });
        //    }
        //})

    }

   function GetRealExchange(currency) {
        var R = 0;
        var price;

        if (KucoinExchangeRate) {
            if (currency == "JKC") {
                price = KucoinExchangeRate["ETH"];
                R = 1 / (price / 3000);
            } else if (currency == "HLN") {
                price = KucoinExchangeRate["USDT"];
                R = 1 / price;
            } else {
                price = KucoinExchangeRate[currency];
                R = 1 / price;
            }
        }

        //if (NomicsExchangeRate && NomicsExchangeRate.length > 0) {
        //    if (currency == "JKC") {
        //        price = NomicsExchangeRate.find(x => x["currency"] == "ETH").price;
        //        R = 1 / (price / 3000);
        //    } else {
        //        price = NomicsExchangeRate.find(x => x["currency"] == currency).price;
        //        R = 1 / price;
        //    }
        //}
        return R;
    }

    function ReSetPaymentAmount(isResetRealRate, Amount) {
        let needResetDom = document.querySelectorAll(".needReset");
        needResetDom.forEach(function (dom) {
            let realRate = 0;
            let HandingFeeAmount = 0;
            let HandingFeeRate = 0
            if (isResetRealRate) {
                let Rate = Number(dom.dataset.rate);
                let Currency = dom.dataset.currency;
                HandingFeeRate = Number(dom.dataset.feerate);
                HandingFeeAmount = Number(dom.dataset.feeamount)
                let RealExChange = GetRealExchange(Currency);
                realRate = 1 * Rate * RealExChange;
                dom.dataset.realrate = realRate.toString();
            } else {
                realRate = Number(dom.dataset.realrate);
                HandingFeeRate = Number(dom.dataset.feerate);
                HandingFeeAmount = Number(dom.dataset.feeamount);
            }

            if (Amount) {
                var calcAmount = ((Amount * (1 - HandingFeeRate)) - HandingFeeAmount) * realRate;
                dom.innerText = new BigNumber(calcAmount.toFixed(6)).toFormat();
            } else {
                dom.innerText = 0;
            }
        });
    }

    function SetPaymentMethodDom() {
        let idPaymentMethod = document.getElementById('idPaymentMethods');
        idPaymentMethod.innerHTML = "";

        for (var i = 0; i < PaymentMethod.length; i++) {

            if (PaymentMethod[i]["MultiCurrencyInfo"]) {
                if (!PaymentMethod[i]["MultiCurrencys"]) {
                    PaymentMethod[i]["MultiCurrencys"] = JSON.parse(PaymentMethod[i]["MultiCurrencyInfo"]);
                }
            }

            let EWinCryptoWalletType = parseInt(PaymentMethod[i]["EWinCryptoWalletType"]);

            switch (EWinCryptoWalletType) {
                case 0:
                    strCryptoWalletType = "ERC";
                    break;
                case 1:
                    strCryptoWalletType = "XRP";
                    break;
                case 2:
                    strCryptoWalletType = "BTC";
                    break;
                case 3:
                    strCryptoWalletType = "TRC";
                    break;
                default:
                    strCryptoWalletType = "ERC";
                    break;
            }

            let PaymentMethodDom = c.getTemplate("templatePaymentMethod");
            let ItemsDom = PaymentMethodDom.querySelector(".amount");
            PaymentMethodDom.classList.add("box_" + i);
            PaymentMethodDom.querySelector(".PaymentCode").dataset.wallettype = PaymentMethod[i]["EWinCryptoWalletType"];
            PaymentMethodDom.querySelector(".PaymentCode").value = PaymentMethod[i]["PaymentMethodID"];
            PaymentMethodDom.querySelector(".PaymentCode").id = "payment-" + i;
            PaymentMethodDom.querySelector(".tab").setAttribute("for", "payment-" + i);
            PaymentMethodDom.querySelector(".icon-logo").classList.add("icon-logo-" + PaymentMethod[i]["CurrencyType"].toLowerCase());
            c.setClassText(PaymentMethodDom, "coinType", null, PaymentMethod[i]["PaymentName"] + " (" + strCryptoWalletType + ")");

            if (PaymentMethod[i]["MultiCurrencys"]) {
                PaymentMethod[i]["MultiCurrencys"].forEach(function (mc) {
                    let item = document.createElement("div");
                    item.classList.add("item");
                    item.innerHTML = '<span class="count needReset" data-rate="' + mc["Rate"] + '" data-feerate="' + PaymentMethod[i]["HandingFeeRate"] + '" data-feeamount="' + PaymentMethod[i]["HandingFeeAmount"] + '" data-currency="' + mc["ShowCurrency"] + '">0</span><sup class="unit">' + mc["ShowCurrency"] + '</sup>';

                    ItemsDom.appendChild(item);
                });
            } else {
                let item = document.createElement("div");
                item.classList.add("item");
                item.innerHTML = '<span class="count needReset" data-rate="1" data-feerate="' + PaymentMethod[i]["HandingFeeRate"] + '" data-feeamount="' + PaymentMethod[i]["HandingFeeAmount"] + '"  data-currency="' + PaymentMethod[i]["CurrencyType"] + '">0</span><sup class="unit">' + PaymentMethod[i]["CurrencyType"] + '</sup>';

                ItemsDom.appendChild(item);
            }

            if (PaymentMethod[i]["HintText"]) {
                PaymentMethodDom.querySelector('.hintText').innerText = PaymentMethod[i]["HintText"];
            } else {
                PaymentMethodDom.querySelector('.box-item-sub').classList.add("is-hide");
            }

            idPaymentMethod.appendChild(PaymentMethodDom);
        }
    }

    function GetPaymentMethod() {
        PaymentClient.GetPaymentMethodByCategory(WebInfo.SID, Math.uuid(), "Crypto", 1, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    if (o.PaymentMethodResults.length > 0) {
                        PaymentMethod = o.PaymentMethodResults;

                        GetExchangeRateFromNomics(function () {
                            SetPaymentMethodDom();
                            ReSetPaymentAmount(true);
                        });
                    } else {
                        window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("?????????????????????"), function () {
                            windwo.parent.API_Home();
                        });
                    }
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("?????????????????????"), function () {
                        windwo.parent.API_Home();
                    });
                }
            }
            else {
                window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("???????????????, ????????????????????????"), function () {
                    windwo.parent.API_Home();
                });
            }

        })
    }

    function setRealExchange() {
        if (PaymentMethod.length > 0 && KucoinExchangeRate.length > 0) {
            let price;
            for (var i = 0; i < PaymentMethod.length; i++) {
                PaymentMethod[i]["RealExchange"] = 0;

                if (PaymentMethod[i]["MultiCurrencyInfo"]) {
                    if (!PaymentMethod[i]["MultiCurrencys"]) {
                        PaymentMethod[i]["MultiCurrencys"] = JSON.parse(PaymentMethod[i]["MultiCurrencyInfo"]);
                    }

                    PaymentMethod[i]["MultiCurrencys"].forEach(function (mc) {
                        mc["RealExchange"] = GetRealExchange(mc["ShowCurrency"]);
                    });
                } else {
                    PaymentMethod[i]["RealExchange"] = GetRealExchange(mc["CurrencyType"]);
                }
            }

            //    if (PaymentMethod.length > 0 && NomicsExchangeRate.length > 0) {
            //        let price;
            //        for (var i = 0; i < PaymentMethod.length; i++) {
            //            PaymentMethod[i]["RealExchange"] = 0;

            //            if (PaymentMethod[i]["MultiCurrencyInfo"]) {
            //                if (!PaymentMethod[i]["MultiCurrencys"]) {
            //                    PaymentMethod[i]["MultiCurrencys"] = JSON.parse(PaymentMethod[i]["MultiCurrencyInfo"]);
            //                }

            //                PaymentMethod[i]["MultiCurrencys"].forEach(function (mc) {
            //                    mc["RealExchange"] = GetRealExchange(mc["ShowCurrency"]);
            //                });
            //            } else {
            //                PaymentMethod[i]["RealExchange"] = GetRealExchange(mc["CurrencyType"]);
            //            }
            //        }
            //    }
        }
    }

    function CoinBtn_Click() {
        let amount = parseInt($(event.currentTarget).data("val"))
        $("#amount").val(amount);
        //$("#ExchangeVal").text(parseInt($(event.target).parent('.btn-radio').find('.OcoinAmount').text()));
        ReSetPaymentAmount(false, amount);
    }

    function setAmount() {
        $("input[name=amount]").prop("checked", false);
        var amount = $("#amount").val().replace(/[^\-?\d.]/g, '')
        $("#amount").val(amount);
        //$("#ExchangeVal").text(amount);
        ReSetPaymentAmount(false, amount);
    }

    function setPaymentAmount() {
        for (var i = 0; i < PaymentMethod.length; i++) {
            let PaymentName = PaymentMethod[i]["PaymentName"];
            let MultiCurrencyInfo = PaymentMethod[i]["MultiCurrencyInfo"];
            let PaymentCode = PaymentMethod[i]["PaymentCode"];
            let RealExchange = PaymentMethod[i]["RealExchange"];
            let ExchangeVal = $("#ExchangeVal").text();
            let JS_MultiCurrencyInfo;

            if ($(`[data-val='${PaymentName}']`).length > 0) {
                if (MultiCurrencyInfo != '') {
                    JS_MultiCurrencyInfo = JSON.parse(MultiCurrencyInfo);
                    for (var j = 0; j < JS_MultiCurrencyInfo.length; j++) {
                        RealExchange = PaymentMethod.find(x => x["PaymentCode"].trim() == JS_MultiCurrencyInfo[j]["ShowCurrency"]).RealExchange;
                        $(`[data-val='${PaymentName}']`).parent().find(".count").eq(j).text(new BigNumber((ExchangeVal * (JS_MultiCurrencyInfo[j]["Rate"]) * RealExchange).toFixed(6)).toFormat());
                        $(`[data-val='${PaymentName}']`).parent().find(".count").eq(j).next().text(JS_MultiCurrencyInfo[j]["ShowCurrency"]);
                    }
                } else {
                    $(`[data-val='${PaymentName}']`).parent().find(".count").eq(0).text(new BigNumber((ExchangeVal * RealExchange).toFixed(6)).toFormat());
                    $(`[data-val='${PaymentName}']`).parent().find(".count").eq(0).next().text(PaymentCode);
                }
            }
        }
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



    //????????????
    function CreateCryptoWithdrawal() {
        if (!$('#CheckAward').prop("checked")) {
            window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("?????????????????????????????????"), function () { });
            window.parent.API_LoadingEnd(1);
            return false;
        }

        if ($("#amount").val() != '') {
            var amount = parseFloat($("#amount").val());
            var selPaymentMethod = $("input[name=payment-crypto]:checked.PaymentCode");

            //var paymentID = PaymentMethod.find(x => x["PaymentName"].trim() == selePaymentName).PaymentMethodID;
            if (selPaymentMethod.length > 0) {
                var selPaymentMethodID = selPaymentMethod.val();
                var selWalletType = Number(selPaymentMethod[0].dataset.wallettype);
                var ToWalletAddress = $("#idToWalletAddress").val();
                if (ToWalletAddress != "") {

                    if (WAValidator.validate(ToWalletAddress, GetWalletChain(selWalletType))) {

                        var wallet = WebInfo.UserInfo.WalletList.find(x => x.CurrencyType.toLocaleUpperCase() == WebInfo.MainCurrencyType);
                        if (wallet.PointValue < amount) {
                            window.parent.API_ShowMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("????????????"));
                            return;
                        }

                        PaymentClient.GetInProgressPaymentByLoginAccount(WebInfo.SID, Math.uuid(), WebInfo.UserInfo.LoginAccount, 1, function (success, o) {
                            if (success) {
                                let UserAccountPayments = o.UserAccountPayments;
                                if (o.Result == 0) {
                                    if (UserAccountPayments.length > 0) {
                                        window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("?????????????????????????????????"), function () {

                                        });
                                    } else {
                                        PaymentClient.CreateCryptoWithdrawal(WebInfo.SID, Math.uuid(), amount, selPaymentMethodID, ToWalletAddress, function (success, o) {
                                            if (success) {
                                                let data = o.Data;

                                                if (o.Result == 0) {
                                                    let strCryptoWalletType;

                                                    switch (data.WalletType) {
                                                        case 0:
                                                            strCryptoWalletType = "ERC";
                                                            break;
                                                        case 1:
                                                            strCryptoWalletType = "XRP";
                                                            break;
                                                        case 2:
                                                            strCryptoWalletType = "BTC";
                                                            break;
                                                        case 3:
                                                            strCryptoWalletType = "TRC";
                                                            break;
                                                        default:
                                                            strCryptoWalletType = "ERC";
                                                            break;
                                                    }
                                                    $("#depositdetail .Amount").text(BigNumber(data.Amount).toFormat());
                                                    //$("#depositdetail .OrderNumber").text(data.OrderNumber);
                                                    $("#depositdetail .PaymentMethodName").text(data.PaymentMethodName);
                                                    $("#depositdetail .ToWalletAddress").text(data.ToWalletAddress);
                                                    $("#depositdetail .EWinCryptoWalletType").text(strCryptoWalletType);

                                                    if (data.PaymentCryptoDetailList != null) {
                                                        var depositdetail = document.getElementsByClassName("Collectionitem")[0];
                                                        for (var i = 0; i < data.PaymentCryptoDetailList.length; i++) {

                                                            var CollectionitemDom = c.getTemplate("templateCollectionitem");
                                                            CollectionitemDom.querySelector(".icon-logo").classList.add("icon-logo-" + data.PaymentCryptoDetailList[i]["TokenCurrencyType"].toLowerCase());
                                                            c.setClassText(CollectionitemDom, "currency", null, data.PaymentCryptoDetailList[i]["TokenCurrencyType"]);
                                                            c.setClassText(CollectionitemDom, "val", null, BigNumber(data.PaymentCryptoDetailList[i]["ReceiveAmount"]).toFormat());
                                                            depositdetail.appendChild(CollectionitemDom);
                                                        }
                                                    }
                                                    OrderNumber = data.OrderNumber;
                                                    GetDepositActivityInfoByOrderNumber(OrderNumber);
                                                } else {
                                                    window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {

                                                    });
                                                }

                                            }
                                            else {
                                                window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("??????????????????"), function () {

                                                });
                                            }
                                        })
                                    }
                                } else {
                                    window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {

                                    });
                                }

                            }
                            else {
                                window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("??????????????????"), function () {

                                });
                            }
                        })
                    } else {
                        window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("????????????????????????????????????????????????"));
                    }
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("?????????????????????"));
                }
            } else {

                window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("?????????????????????"));
            }


        } else {
            window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey("?????????????????????"), function () {

            });
        }
    }
    //???????????????????????????????????????
    function GetDepositActivityInfoByOrderNumber(OrderNum) {
        clearInterval(CountInterval);
        var Step2 = $('[data-deposite="step2"]');
        var Step3 = $('[data-deposite="step3"]');
        Step2.hide();
        Step3.fadeIn();
        $('.progress-step:nth-child(3)').addClass('cur');
    }
    //????????????
    function ConfirmCryptoWithdrawal() {
        PaymentClient.ConfirmCryptoWithdrawal(WebInfo.SID, Math.uuid(), OrderNumber, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    //setEthWalletAddress(o.Message)
                    let Step3 = $('button[data-deposite="step3"]');
                    let Step4 = $('button[data-deposite="step4"]');
                    Step3.hide();
                    Step4.fadeIn();
                    $('.progress-step:nth-child(4)').addClass('cur');
                    $("#depositdetail .OrderNumber").text(o.Message);
                    $("#depositdetail .inputPaymentSerial").val(o.Message);
                    $("#depositdetail .OrderNumber").parent().show();
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {

                    });
                }
            }
            else {
                window.parent.showMessageOK(mlp.getLanguageKey("??????"), mlp.getLanguageKey(o.Message), function () {

                });
            }
        })
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
                    <div class="progress-step cur">
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
                <div class="text-wrap progress-title" style="display: none">
                    <p data-deposite="step2" class="language_replace">???????????????????????????????????????</p>
                    <p data-deposite="step3" class="language_replace">????????????</p>
                    <p data-deposite="step4" class="language_replace">
                        <span class="language_replace">??????</span>
                        <span class="language_replace">USDT</span>
                        <span class="language_replace">??????</span>
                    </p>
                </div>
                <div class="split-layout-container">
                    <%--
                    <div class="aside-panel">
                        <!-- ?????? -->
                        <div class="card-item sd-02">
                            <div class="card-item-inner">
                                <!-- <div class="title">USDT</div> -->
                                <div class="title">
                                    <span class="language_replace">????????????</span>
                                    <!-- <span>Crypto Wallet</span>  -->
                                </div>
                                <div class="amount-info is-hide">
                                    <div class="amount-info-title language_replace">???????????? (USD)</div>
                                    <div class="amount">
                                        <sup>$</sup>
                                        <span class="count">99</span>
                                    </div>
                                </div>
                                <div class="desc transform-result is-hide"><span class="language_replace">??????????????????</span> <b>0</b> <span class="language_replace">???</span></div>
                                <div class="logo">
                                    <i class="icon-logo-usdt"></i>
                                    <!-- <i class="icon-logo-eth-o"></i> -->
                                    <i class="icon-logo-eth"></i>
                                    <i class="icon-logo-btc"></i>
                                    <!-- <i class="icon-logo-doge"></i> -->
                                    <!-- <i class="icon-logo-tron"></i> -->
                                </div>
                            </div>
                            <img src="images/assets/card-surface/card-02.svg" class="card-item-bg">
                        </div>
                        <div class="text-wrap payment-change">
                            <a href="deposit.html" class="text-link c-blk">
                                <i class="icon-transfer"></i>
                                <span>??????</span>
                            </a>
                        </div>                        
                        <div class="form-content" data-deposite="step2">
                            <form>
                                <div class="form-group">
                                    <label class="form-title">??????</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control custom-style" placeholder="??????????????????????????????" inputmode="numeric">
                                        <div class="invalid-feedback">??????</div>
                                    </div>
                                </div>
        
                                <div class="btn-wrap btn-radio-wrap">
                                    <div class="btn-radio">
                                        <input type="radio" name="amount" id="amount1" >
                                        <label class="btn btn-outline-primary" for="amount1">
                                            <span>$25</span>
                                        </label>
                                    </div>
                                    
                                    <div class="btn-radio">
                                        <input type="radio" name="amount" id="amount2" >
                                        <label class="btn btn-outline-primary" for="amount2">
                                            <span>$50</span>
                                        </label>
                                    </div>

                                    <div class="btn-radio">
                                        <input type="radio" name="amount" id="amount3" >
                                        <label class="btn btn-outline-primary" for="amount3">
                                            <span>$100</span>
                                        </label>
                                    </div>
                                </div>
                            </form>
                        </div>
                    </div>
                    --%>

                    <!-- ???????????? step2 -->
                    <div class="aside-panel" data-deposite="step2">
                        <div class="form-content">
                            <h5 class="language_replace">???????????????????????????</h5>
                            <!-- ???????????? -->
                            <div class="form-group text-wrap desc mt-2 mt-md-4">
                                <!-- <h5 class="language_replace">??????????????????</h5> -->
                                <p class="text-s language_replace">???????????????????????????????????????????????????????????????????????????????????????????????????????????????</p>
                            </div>
                            <form>
                                <div class="form-group">
                                    <div class="btn-wrap btn-radio-wrap btn-radio-payment">
                                        <div class="btn-radio btn-radio-coinType">
                                            <input type="radio" name="amount" id="amount1" />
                                            <label class="btn btn-outline-primary" for="amount1" data-val="10000" onclick="CoinBtn_Click()">
                                                <span class="coinType gameCoin">
                                                    <%-- <span class="coinType-title language_replace">?????????</span>--%>
                                                    <span class="coinType-title">Ocoin</span>
                                                    <span class="coinType-amount OcoinAmount">10,000</span>
                                                </span>
                                            </label>
                                        </div>

                                        <div class="btn-radio btn-radio-coinType">
                                            <input type="radio" name="amount" id="amount2" />
                                            <label class="btn btn-outline-primary" for="amount2" data-val="50000" onclick="CoinBtn_Click()">
                                                <span class="coinType gameCoin">
                                                    <span class="coinType-name">Ocoin</span>
                                                    <span class="coinType-amount OcoinAmount">50,000</span>
                                                </span>
                                            </label>
                                        </div>

                                        <div class="btn-radio btn-radio-coinType">
                                            <input type="radio" name="amount" id="amount3" />
                                            <label class="btn btn-outline-primary" for="amount3" data-val="100000" onclick="CoinBtn_Click()">
                                                <span class="coinType gameCoin">
                                                    <%--<span class="coinType-title language_replace">?????????</span>--%>
                                                    <span class="coinType-name">Ocoin</span>
                                                    <span class="coinType-amount OcoinAmount">100,000</span>
                                                </span>
                                            </label>
                                        </div>
                                    </div>
                                </div>

                                <!-- ????????????(??????) -->
                                <div class="form-group language_replace">
                                    <label class="form-title language_replace">????????????</label>
                                    <div class="input-group">
                                        <input type="text" class="form-control custom-style" id="amount" language_replace="placeholder" placeholder="???????????????" onkeyup="setAmount()" />
                                        <div class="form-notice-aside unit" id="OrderCurrencyType">Ocoin</div>
                                        <div class="invalid-feedback language_replace">??????</div>
                                    </div>
                                </div>
                                <div class="form-group cryptoWallet-address">
                                    <label class="form-title language_replace">??????????????????</label>
                                    <div class="input-group">
                                        <div class="input-group-prepend">
                                            <span class="input-group-text"><i class="icon icon-wallet"></i></span>
                                        </div>
                                        <input type="text" class="form-control custom-style" id="idToWalletAddress" language_replace="placeholder" placeholder="??????????????????" />
                                    </div>
                                    <div class="invalid-feedback language_replace">??????</div>
                                </div>
                                <div class="form-group award-take-check">
                                    <div class="form-check">
                                        <label for="CheckAward">
                                            <input class="form-check-input" type="checkbox" name="CheckAward" id="CheckAward">
                                            <span style="color:red" class="language_replace">?????????????????????????????????????????????</span>
                                        </label>
                                    </div>
                                </div>

                                <!-- ????????????(??????) -->
                                <%--<div class="form-group ">
                                    <div class="input-group inputlike-box-group">
                                        <span class="inputlike-box-prepend">???</span>--%>
                                <!-- ????????????(??????)-->
                                <!-- ??????????????? class =>exchanged-->
                                <%--<span class="inputlike-box "><span ></span></span>--%>
                                <%--                                        <span class="inputlike-box-append">
                                            <span class="inputlike-box-append-title" id="ExchangeVal"></span>
                                            <span class="inputlike-box-append-unit">Ocoin</span>
                                        </span>
                                    </div>
                                </div>--%>
                            </form>
                        </div>
                    </div>
                    <div class="main-panel cryptopanel" data-deposite="step2">
                        <h5 class="language_replace">?????????????????????</h5>
                        <div>
                            <span id="idRecClock">30</span><span class="language_replace">???????????????????????????</span>
                        </div>
                        <div class="box-item-container crypto-list">
                            <div id="idPaymentMethods">
                            </div>

                            <!-- ???????????? -->
                            <div class="notice-container mt-3 mb-3">
                                <div class="notice-item">
                                    <i class="icon-info_circle_outline"></i>
                                    <div class="text-wrap">
                                        <p class="title language_replace">????????????</p>
                                          <ul class="list-style-decimal">
                                            <li><span class="language_replace">??????????????????????????????????????????????????????10???OCoin????????????????????????????????????????????????????????????</span></li>
                                            <li><span class="language_replace">??????10???OCoin??????????????????????????????</span></li>
                                            <li><span class="language_replace">???????????????????????????</span></li>
                                            <li><span class="language_replace">1??????????????????????????????100???OCoin???</span></li>
                                            <li><span class="language_replace">??????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????????</span></li>
                                         </ul>  
                                    </div>
                                </div>
                            </div>

                        </div>
                    </div>

                    <!-- ???????????? step3 -->
                    <%--<div class="aside-panel" data-deposite="step3">
                        <div class="deposit-confirm">
                            <h5 class="language_replace">??????????????????</h5>
                            <ul class="deposit-detail">
                                <li class="item">
                                    <h6 class="title language_replace">????????????</h6>
                                    <span class="data">6000</span>
                                </li>
                                <li class="item">
                                    <h6 class="title language_replace">????????????</h6>
                                    <span class="data">USDT</span>
                                </li>
                                <li class="item">
                                    <h6 class="title language_replace">????????????</h6>
                                    <span class="data ThresholdVal">6000</span>
                                </li>
                            </ul>
                        </div>
                    </div>
                    <div class="main-panel" data-deposite="step3">
                        <!-- ???????????? -->
                        <div class="text-wrap award-content">
                            <h6 class="language_replace">??????????????????????????????</h6>
                            <ul class="award-list ActivityMain">
                            </ul>
                        </div>
                    </div>--%>

                    <!-- ???????????? step3 - ???????????????-->
                    <div class="deposit-confirm " data-deposite="step3" id="depositdetail">
                        <div class="aside-panel">
                            <div class="deposit-calc">
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
                                            <span class="name PaymentCode">OCoin</span>
                                            <span class="count Amount"></span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                        <div class="main-panel">
                            <div class="deposit-list">
                                <h5 class="subject-title language_replace">????????????</h5>
                                <ul class="deposit-detail">
                                    <li class="item" style="display: none">
                                        <h6 class="title language_replace">????????????</h6>
                                        <span class="data OrderNumber"></span>
                                         <input class="inputPaymentSerial is-hide" />
                                        <i class="icon-copy" onclick="copyTextPaymentSerial(this)" style="display: inline;"></i>     
                                    </li>
                                    <li class="item">
                                        <h6 class="title language_replace">????????????</h6>
                                        <span class="data PaymentMethodName"></span>
                                    </li>
                                    <li class="item">
                                        <h6 class="title language_replace ">????????????</h6>
                                        <span class="data EWinCryptoWalletType">ERC</span>
                                    </li>
                                    <%-- <li class="item">
                                        <h6 class="title language_replace">????????????</h6><span class="data">ERC</span>
                                    </li>
                                    <li class="item">
                                        <h6 class="title language_replace">??????????????????</h6><span class="data primary">2021/3/1</span>
                                    </li>--%>

                                    <li class="item">
                                        <h6 class="title language_replace">??????????????????</h6>
                                        <span class="data ToWalletAddress"></span>
                                    </li>
                                </ul>
                            </div>
                        </div>
                        <%--                        <div class="activity-container">
                            <div class="activity-item">
                                <h5 class="subject-title language_replace">????????????</h5>
                                <!-- ???????????? -->
                                <div class="text-wrap award-content">
                                    <ul class="deposit-award-list ActivityMain">
                                    </ul>
                                </div>
                            </div>
                        </div>--%>
                    </div>

                    <!-- ???????????? step4 -->
                    <div class="main-panel" data-deposite="step4">

                        <div class="crypto-info-coantainer">
                            <div class="box-item" style="display: none">
                                <!-- ????????? -->
                                <div class="sub-box">
                                    <div class="sub-box-item">
                                        <input type="radio" name="payment-crypto-contract" id="payment-cry-cont1" checked>
                                        <label class="sub-box-item-inner" for="payment-cry-cont1">
                                            <div class="sub-box-item-detail"><i class="icon-check"></i><span class="contract">ERC20</span></div>
                                        </label>
                                    </div>
                                    <div class="sub-box-item" style="display: none">
                                        <input type="radio" name="payment-crypto-contract" id="payment-cry-cont2">
                                        <label class="sub-box-item-inner" for="payment-cry-cont2">
                                            <div class="sub-box-item-detail"><i class="icon-check"></i><span class="contract">TRC20</span></div>
                                        </label>
                                    </div>
                                </div>

                            </div>

                            <h4 class="mt-2 mt-md-4 cryoto-address language_replace">??????????????????</h4>
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
                                    <div class="refresh" style="display: none;">
                                        <p class="period"><span class="date"></span><span class="time" style="display: none">15:30:02</span></p>
                                        <button type="button" class="btn btn-outline-primary btn-icon btn-refresh  btn-white" onclick="RefreshExchange()">
                                            <i class="icon-casinoworld-refresh" onclick=""></i>
                                            <span class="language_replace">??????</span>
                                        </button>
                                    </div>
                                </div>

                            </div>
                        </div>
                    </div>
                </div>

                <div class="btn-container mt-2">
                    <button class="btn btn-primary" data-deposite="step2">
                        <span class="language_replace">?????????</span>
                    </button>
                    <button class="btn btn-primary" data-deposite="step3">
                        <span class="language_replace">?????????</span>
                    </button>
                    <%--     <button class="btn btn-outline-primary" data-deposite="step4" href="index.aspx">
                        <span class="language_replace">??????</span>
                    </button>
                      <button class="btn btn-primary" data-deposite="step4" data-toggle="modal" data-target="#depositSucc">
                        <span>??????</span>
                    </button>--%>
                </div>

                <!-- ???????????? -->
                <div class="notice-container is-hide" data-deposite="step4">
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
                                <li><span class="language_replace">???ETH??????USDT??????ERC20???????????? https://etherscan.io/ ??????????????????????????????</span></li>
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
                            <p class="language_replace">???????????????????????????????????????????????????????????????</p>
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

    <div id="templatePaymentMethod" style="display: none">
        <div class="box-item">
            <input class="PaymentCode" type="radio" name="payment-crypto">
            <label class="box-item-inner tab">
                <div class="box-item-info">
                    <i class="icon-logo"></i>
                    <div class="box-item-detail">
                        <div class="box-item-title">
                            <div class="coinUnit">
                                <span class="coinType">BTC</span>
                            </div>
                            <div class="amount">
                                <%--                                <div class="item">
                                    <span class="count BTCval">0</span><sup class="unit"></sup>
                                </div>
                                <div class="item">
                                    <span class="count ETHval">0</span><sup class="unit"></sup>
                                </div>--%>
                            </div>
                            <%--<span class="box-item-status">1 TRON = 1234567 USD</span>--%>
                        </div>
                    </div>
                </div>
                <div class="box-item-sub">
                    <div class="coinPush">
                        <i class="icon icon-coin"></i>
                        <p class="text hintText language_replace">????????????! Play Open Bouns! ??????100% &10????????????!?????? USDT ????????????100%</p>
                    </div>
                </div>

            </label>
        </div>
    </div>
    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>
</body>
</html>
