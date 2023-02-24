<%@ Page Language="C#" %>

<% 
    string Version = EWinWeb.Version;
    string needShowRegister = "0";

    if (string.IsNullOrEmpty(Request["needShowRegister"]) == false) {
        needShowRegister = Request["needShowRegister"];
    }

%>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Maharaja</title>

    <%--    <link rel="stylesheet" href="Scripts/OutSrc/lib/bootstrap/css/bootstrap.min.css" type="text/css" />
    <link rel="stylesheet" href="Scripts/OutSrc/lib/swiper/css/swiper-bundle.min.css" type="text/css" />

    <link rel="stylesheet" href="css/icons.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/global.css?<%:Version%>" type="text/css" />
    <link rel="stylesheet" href="css/member.css" type="text/css" />
    --%>


    <link href="Scripts/vendor/swiper/css/swiper-bundle.min.css" rel="stylesheet" />
    <link href="css/basic.min.css" rel="stylesheet" />
    <link href="css/main.css" rel="stylesheet" />
    <link href="css/member.css" rel="stylesheet" />
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
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/UIControl.js"></script>
<script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bignumber.js/9.0.2/bignumber.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
<script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.7.1/swiper-bundle.min.js"></script>
<script src="Scripts/OutSrc/js/script.js"></script>
<script type="text/javascript" src="/Scripts/libphonenumber.js"></script>
<script>

    if (self != top) {
        window.parent.API_LoadingStart();
    }

    var WebInfo;
    var p;
    var lang;
    var BackCardInfo = null;
    var PhoneNumberUtil = libphonenumber.PhoneNumberUtil.getInstance();
    var v = "<%:Version%>";
    var needShowRegister = "<%:needShowRegister%>";
    var swiper;
    var isSent_Phone = false;

    function copyText(tag) {
        var copyText = document.getElementById(tag);
        copyText.select();
        copyText.setSelectionRange(0, 99999);

        copyToClipboard(copyText.textContent)
            .then(() => window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功")))
            .catch(() => window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗")));
    }

    function copyToClipboard(textToCopy) {
        // navigator clipboard api needs a secure context (https)
        if (navigator.clipboard && window.isSecureContext) {
            // navigator clipboard api method'
            return navigator.clipboard.writeText(textToCopy);
        } else {
            // text area method
            let textArea = document.createElement("textarea");
            textArea.value = textToCopy;
            // make the textarea out of viewport
            textArea.style.position = "fixed";
            textArea.style.left = "-999999px";
            textArea.style.top = "-999999px";
            document.body.appendChild(textArea);
            textArea.focus();
            textArea.select();
            return new Promise((res, rej) => {
                // here the magic happens
                document.execCommand('copy') ? res() : rej();
                textArea.remove();
            });
        }
    }

    function updateBaseInfo() {
        $("#RealName").val(WebInfo.UserInfo.RealName);
        $("#Email").val(WebInfo.UserInfo.EMail == undefined ? "" : WebInfo.UserInfo.EMail);
        $("#PhoneNumber").val(WebInfo.UserInfo.ContactPhonePrefix + " " + WebInfo.UserInfo.ContactPhoneNumber);
        let IsFullRegistration = 0;
        if (WebInfo.UserInfo.ExtraData) {
            var ExtraData = JSON.parse(WebInfo.UserInfo.ExtraData);
            for (var i = 0; i < ExtraData.length; i++) {
                if (ExtraData[i].Name == "Birthday") {
                    var Birthdays = ExtraData[i].Value.split('/');
                    $("#idBornYear").val(Birthdays[0]);
                    $("#idBornMonth").val(Birthdays[1]);
                    $("#idBornDay").val(Birthdays[2]);
                }

                if (ExtraData[i].Name == "UserGetMail") {
                    $("#check_UserGetMail").prop("checked", ExtraData[i].Value);
                }

                if (ExtraData[i].Name == "IsFullRegistration") {
                    IsFullRegistration = ExtraData[i].Value;
                }
            }
        }
        // var Birthdays = ExtraData[i].Value.split('/');
        if (WebInfo.UserInfo.Birthday != undefined && WebInfo.UserInfo.Birthday != "") {
            var Birthdays = WebInfo.UserInfo.Birthday.split('-');
            $("#idBornYear").val(Birthdays[0]);
            $("#idBornMonth").val(Birthdays[1]);
            $("#idBornDay").val(Birthdays[2]);
        }

        $("#Address").val(WebInfo.UserInfo.ContactAddress == undefined ? "" : WebInfo.UserInfo.ContactAddress);
        //$("#idAmount").text(new BigNumber(WebInfo.UserInfo.WalletList.find(x => x.CurrencyType == window.parent.API_GetCurrency()).PointValue).toFormat());

        let wallet = WebInfo.UserInfo.WalletList.find(x => x.CurrencyType.toLocaleUpperCase() == WebInfo.MainCurrencyType);
        $("#idAmount").text(new BigNumber(parseInt(wallet.PointValue)).toFormat());
        $("#PersonCode").text(WebInfo.UserInfo.PersonCode);
        $("#idCopyPersonCode").text(WebInfo.UserInfo.PersonCode);
        $('#QRCodeimg').attr("src", `/GetQRCode.aspx?QRCode=${"<%=EWinWeb.CasinoWorldUrl %>"}/registerForQrCode.aspx?P=${WebInfo.UserInfo.PersonCode}&Download=2`);

        var ThresholdInfos = WebInfo.UserInfo.ThresholdInfo;
        if (ThresholdInfos && ThresholdInfos.length > 0) {
            let thresholdInfo = ThresholdInfos.find(x => x.CurrencyType.toLocaleUpperCase() == WebInfo.MainCurrencyType);
            if (thresholdInfo) {

                if (new BigNumber(thresholdInfo.ThresholdValue).toFormat() == "0") {
                    $("#divThrehold").addClass("enough");
                    $("#divThrehold").removeClass("lacking");
                } else {
                    $("#divThrehold").removeClass("enough");
                    $("#divThrehold").addClass("lacking");
                }

                $("#idThrehold").text(new BigNumber(thresholdInfo.ThresholdValue).toFixed(2));
            } else {
                $("#idThrehold").text("0");
                $("#divThrehold").addClass("enough");
                $("#divThrehold").removeClass("lacking");
            }
        } else {
            $("#idThrehold").text("0");
            $("#divThrehold").addClass("enough");
            $("#divThrehold").removeClass("lacking");
        }

        if (IsFullRegistration == 0) {
            $("#IsFullRegistration0").show();
            $("#IsFullRegistration1").hide();
        } else {
            $("#IsFullRegistration0").hide();
            $("#IsFullRegistration1").show();
        }
    }

    function memberInit() {

    }

    function updateUserAccountRemoveReadOnly() {
        $('.password-fake').addClass('is-hide');
        $('#idOldPasswordGroup').removeClass('is-hide');
        $('#idNewPasswordGroup').removeClass('is-hide');
        $('#updateUserAccountRemoveReadOnlyBtn').addClass('is-hide');
        $('#updateUserAccountCancelBtn').removeClass('is-hide');
        $('#updateUserAccountBtn').removeClass('is-hide');

        //$('#idNewPasswordSuccessIcon').addClass('is-hide');
        $('#NewPasswordErrorMessage').addClass('is-hide');
        //$('#idNewPasswordErrorIcon').addClass('is-hide');
        $('#NewPasswordErrorMessage').text('');

        $('#OldPasswordErrorMessage').addClass('is-hide');
        //$('#idOldPasswordSuccessIcon').addClass('is-hide');
        //$('#idOldPasswordErrorIcon').addClass('is-hide');
        $('#OldPasswordErrorMessage').text('');

    }

    function updateUserAccountReadOnly() {
        $('#idOldPasswordGroup').addClass('is-hide');
        $('#idNewPasswordGroup').addClass('is-hide');
        $('.password-fake').removeClass('is-hide');
        $('#updateUserAccountRemoveReadOnlyBtn').removeClass('is-hide');
        $('#updateUserAccountCancelBtn').addClass('is-hide');
        $('#updateUserAccountBtn').addClass('is-hide');
        $('#idNewPassword').val('');
        $('#idOldPassword').val('');
    }

    function updateUserAccount() {

        var idNewPassword = $("#idNewPassword").val().trim();
        var idOldPassword = $("#idOldPassword").val().trim();
        var rules = new RegExp('^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,12}$')

        if (idOldPassword == "") {
            $('#OldPasswordErrorMessage').text(mlp.getLanguageKey("尚未輸入舊密碼"));
            $('#OldPasswordErrorMessage').removeClass('is-hide');
            //$('#idOldPasswordSuccessIcon').addClass('is-hide');
            //$('#idOldPasswordErrorIcon').removeClass('is-hide');
            return false;
        } else {
            $('#OldPasswordErrorMessage').text('');
            $('#OldPasswordErrorMessage').addClass('is-hide');
            //$('#idOldPasswordSuccessIcon').removeClass('is-hide');
            //$('#idOldPasswordErrorIcon').addClass('is-hide');
        }

        if (idNewPassword == "") {
            $('#NewPasswordErrorMessage').text(mlp.getLanguageKey("尚未輸入新密碼"));
            $('#NewPasswordErrorMessage').removeClass('is-hide');
            //$('#idNewPasswordSuccessIcon').addClass('is-hide');
            //$('#idNewPasswordErrorIcon').removeClass('is-hide');
            return false;
        } else if (idNewPassword.length < 6) {
            $('#NewPasswordErrorMessage').text(mlp.getLanguageKey("新密碼需大於6位"));
            $('#NewPasswordErrorMessage').removeClass('is-hide');
            //$('#idNewPasswordSuccessIcon').addClass('is-hide');
            //$('#idNewPasswordErrorIcon').removeClass('is-hide');
            return false;
        } else if (!rules.test(idNewPassword)) {
            $('#NewPasswordErrorMessage').text(mlp.getLanguageKey("請輸入半形的英文大小寫/數字，至少要有一個英文大寫與英文小寫與數字"));
            $('#NewPasswordErrorMessage').removeClass('is-hide');
            //$('#idNewPasswordSuccessIcon').addClass('is-hide');
            //$('#idNewPasswordErrorIcon').removeClass('is-hide');
            return false;
        } else {
            $('#NewPasswordErrorMessage').text('');
            $('#NewPasswordErrorMessage').addClass('is-hide');
            //$('#idNewPasswordSuccessIcon').removeClass('is-hide');
            //$('#idNewPasswordErrorIcon').addClass('is-hide');
        }

        p.SetUserPassword(WebInfo.SID, Math.uuid(), idOldPassword, idNewPassword, function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    updateUserAccountReadOnly();
                    window.parent.showMessageOK(mlp.getLanguageKey("成功"), mlp.getLanguageKey("成功"), function () {

                        window.top.API_RefreshUserInfo(function () {
                        });
                    });
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(o.Message));
                }
            } else {
                if (o == "Timeout") {
                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路異常, 請重新嘗試"));
                } else {
                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), o);
                }
            }
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

    function setUserThisWeekLogined(UserThisWeekTotalValidBetValueData) {
        if (UserThisWeekTotalValidBetValueData) {
            let k = 0;
            for (var i = 0; i < UserThisWeekTotalValidBetValueData.length; i++) {
                if (UserThisWeekTotalValidBetValueData[i].Status == 1) {
                    k++;
                    $(".bouns-item").eq(i).addClass("got");
                }
            }

            if (k == 7) {
                $(".bouns-amount").text(10000);
            } else {
                $(".bouns-amount").text(k * 1000);
            }
        }
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
            window.parent.API_LoadingEnd();

            if (p != null) {
                updateBaseInfo();
                window.top.API_GetUserThisWeekTotalValidBetValue(function (e) {
                    setUserThisWeekLogined(e);
                });

                if (needShowRegister == "1") {
                    $("#ModalRegisterComplete").modal('show');
                }
            }
            else {
                window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                    window.parent.location.href = "index.aspx";
                });
            }
        });

        AdjustDate();
        memberInit();
        //changeAvatar(getCookie("selectAvatar"));

        $("#activityURL").attr("href", "https://casino-maharaja.com/Activity/MemberCenter/01/index.aspx?PCode=" + WebInfo.UserInfo.PersonCode);
        $("#activityURL1").attr("href", "https://casino-maharaja.com/Activity/MemberCenter/02/index.aspx?PCode=" + WebInfo.UserInfo.PersonCode);

        if (!WebInfo.UserInfo.IsWalletPasswordSet) {
            //document.getElementById('idWalletPasswordUnSet').style.display = "block";
        }
    }

    function copyActivityUrl() {

        navigator.clipboard.writeText("https://casino-maharaja.com/Activity/MemberCenter/01/index.aspx?PCode=" + WebInfo.UserInfo.PersonCode).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗")) });
        //alert("Copied the text: " + copyText.value);
    }

    function copyActivityUrl1() {

        navigator.clipboard.writeText("https://casino-maharaja.com/Activity/MemberCenter/02/index.aspx?PCode=" + WebInfo.UserInfo.PersonCode).then(
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製成功")) },
            () => { window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("複製失敗")) });
        //alert("Copied the text: " + copyText.value);
    }

    function AdjustDate() {
        var idBornYear = document.getElementById("idBornYear1");
        var idBornMonth = document.getElementById("idBornMonth1");
        var idBornDate = document.getElementById("idBornDate");
        idBornDate.options.length = 0;

        var year = idBornYear.value;
        var month = parseInt(idBornMonth.value);

        //get the last day, so the number of days in that month
        var days = new Date(year, month, 0).getDate();

        //lets create the days of that month
        for (var d = 1; d <= days; d++) {
            var dayElem = document.createElement("option");
            dayElem.value = d;
            dayElem.textContent = d;

            if (d == 1) {
                dayElem.selected = true;
            }

            idBornDate.append(dayElem);
        }
    }

    function Certification() {

        if ($("#idValidateCode_Phone").val() == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入驗證碼"));
        } else {
            p.CheckValidateCode(Math.uuid(), 1, "", $("#idPhonePrefix").val(), $("#idPhoneNumber").val(), $("#idValidateCode_Phone").val(), function (success, o) {
                if (success) {
                    if (o.Result != 0) {
                        window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確驗證碼"));
                    } else {
                        var idBornYear = document.getElementById("idBornYear1");
                        var idBornMonth = document.getElementById("idBornMonth1");
                        var idBornDate = document.getElementById("idBornDate");
                        var PhonePrefix = document.getElementById("idPhonePrefix").value;
                        var PhoneNumber = document.getElementById("idPhoneNumber").value;
                        var Name1 = document.getElementById("Name1").value;
                        var Name2 = document.getElementById("Name2").value;

                        var year = idBornYear.value;
                        var month = parseInt(idBornMonth.value);
                        var date = parseInt(idBornDate.value);
                        let nowYear = new Date().getFullYear();
                        let strExtraData = "";

                        if (year.length != 4) {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確年分"));
                            return;
                        } else if (parseInt(year) < 1900) {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確年分"));
                            return;
                        } else if (parseInt(year) > nowYear) {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確年分"));
                            return;
                        } else if (Name1 == "") {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入姓"));
                            return;
                        } else if (Name2 == "") {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入名"));
                            return;
                        } else if (PhonePrefix == "") {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入國碼"));
                            return;
                        } else if (PhoneNumber == "") {
                            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入電話"));
                            return;
                        }

                        let ExtraData = [];

                        if (WebInfo.UserInfo.ExtraData) {
                            ExtraData = JSON.parse(WebInfo.UserInfo.ExtraData);

                            if (WebInfo.UserInfo.ExtraData.indexOf("IsFullRegistration") > 0) {
                                for (var i = 0; i < ExtraData.length; i++) {
                                    if (ExtraData[i].Name == "IsFullRegistration") {
                                        ExtraData[i].Value = 1;
                                    }
                                }
                            } else {
                                ExtraData.push({
                                    Name: 'IsFullRegistration', Value: 1
                                });
                            }
                        } else {
                            ExtraData.push({
                                Name: 'IsFullRegistration', Value: 1
                            });
                        }

                        strExtraData = JSON.stringify(ExtraData);

                        var data = {
                            "OldPassword": "",
                            "ContactPhonePrefix": PhonePrefix,
                            "ContactPhoneNumber": PhoneNumber,
                            "RealName": Name1 + Name2,
                            "Birthday": year + "/" + month + "/" + date,
                            "ExtraData": strExtraData
                        }
                        window.parent.API_LoadingStart();
                        p.RegistrationUserAccount(WebInfo.SID, Math.uuid(), data, WebInfo.UserInfo.LoginAccount, function (success, o) {
                            if (success) {
                                if (o.Result == 0) {
                                    window.top.API_RefreshUserInfo(function () {
                                        window.parent.API_LoadPage('MemberCenter', 'MemberCenter.aspx', true);
                                    });
                                } else {
                                    $("#CertificationForm").hide();
                                    $("#CertificationFail").show();
                                }
                            } else {
                                if (o == "Timeout") {
                                    window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路異常, 請重新嘗試"));
                                } else {
                                    $("#CertificationForm").hide();
                                    $("#CertificationFail").show();
                                }
                            }
                        });
                    }
                } else {
                    window.parent.showMessageOK("", mlp.getLanguageKey("驗證碼錯誤"));
                }
            });
        }
    }

    function closeCertification() {
        updateBaseInfo();
        $("#btn_PupLangClose1").click();
    }

    function onBtnSendValidateCode_Phone() {
        if (isSent_Phone == false) {
            CheckPhoneExist(function (check) {
                if (check) {
                    window.top.API_LoadingStart();
                    p.SetUserMail(Math.uuid(), 1, 0, "", $("#idPhonePrefix").val(), $("#idPhoneNumber").val(), "", function (success, o) {
                        window.top.API_LoadingEnd(1);
                        if (success) {
                            if (o.Result != 0) {
                                window.parent.showMessageOK("", mlp.getLanguageKey("發送驗證碼失敗"));
                            } else {
                                window.parent.showMessageOK("", mlp.getLanguageKey("發送驗證碼成功"));

                                startCountDown_Phone(120);
                            }
                        }
                    });
                } else {

                }
            });
        } else {
            window.parent.showMessageOK("", mlp.getLanguageKey("已發送驗證碼，短時間內請勿重複發送"));
        }
    }

    function startCountDown_Phone(duration) {
        isSent_Phone = true;
        let secondsRemaining = duration;

        let countInterval = setInterval(function () {
            let BtnSend = document.getElementById("divSendValidateCodeBtn_Phone");
            
            BtnSend.querySelector("span").innerText = secondsRemaining + "s"

            secondsRemaining = secondsRemaining - 1;
            if (secondsRemaining < 0) {
                clearInterval(countInterval);
                SetBtnSend();
            };

        }, 1000);
    }

    function SetBtnSend() {
        let BtnSend = document.getElementById("divSendValidateCodeBtn_Phone");
        BtnSend.querySelector("span").innerText = mlp.getLanguageKey("傳送簡訊驗證碼");
        isSent_Phone = false;
    }

    function CheckPhoneExist(cb) {
        var PhonePrefix = document.getElementById("idPhonePrefix").value;
        var PhoneNumber = document.getElementById("idPhoneNumber").value;

        if (PhonePrefix.value == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入國碼"));
            cb(false);
            return;
        } else if (PhoneNumber.value == "") {
            window.parent.showMessageOK("", mlp.getLanguageKey("請輸入正確電話"));
            cb(false);
            return;
        } else {
            var phoneValue = idPhonePrefix.value + idPhoneNumber.value;
            var phoneObj;

            try {
                phoneObj = PhoneNumberUtil.parse(phoneValue);

                var type = PhoneNumberUtil.getNumberType(phoneObj);

                if (type != libphonenumber.PhoneNumberType.MOBILE && type != libphonenumber.PhoneNumberType.FIXED_LINE_OR_MOBILE) {
                    window.parent.showMessageOK("", mlp.getLanguageKey("電話格式有誤"));
                    cb(false);
                    return;
                }
            } catch (e) {

                window.parent.showMessageOK("", mlp.getLanguageKey("電話格式有誤"));

                cb(false);
                return;
            }
        }

        if (WebInfo.UserInfo.ContactPhoneNumber == "" || WebInfo.UserInfo.ContactPhonePrefix == "") {
            p.CheckAccountExistEx(Math.uuid(), "", idPhonePrefix.value, idPhoneNumber.value, "", function (success, o) {
                if (success) {
                    if (o.Result != 0) {
                        cb(true);
                    } else {
                        cb(false);
                        window.parent.showMessageOK("", mlp.getLanguageKey("電話已存在"));
                    }
                }

            });
        } else {
            cb(true);
        }
    }

    function onChangePhonePrefix() {
        var value = event.currentTarget.value;
        if (value && typeof (value) == "string" && value.length > 0) {
            if (value[0] != "+") {
                event.currentTarget.value = "+" + value;
            }
        }
    }

    window.onload = init;
</script>
<body class="innerBody">
    <main class="innerMain">
        <div class="page-content">
            <div class="container">
                <article class="article-member-center">
                    <!-- 個人資料 -->
                    <section class="section-member-profile">
                        <div class="member-profile-avater-wrapper">
                            <span class="avater">
                                <span class="avater-img">
                                    <img src="images/avatar/avater-2.png" alt="">
                                </span>
                                <%--<button type="button" class="btn btn-round btn-full-main btn-exchange-avater" data-toggle="modal" data-target="#ModalAvatar">
                                    <i class="icon icon-mask icon-camera "></i>
                                </button>--%>
                            </span>
                        </div>
                        <div class="member-profile-data-wrapper dataList">
                            <fieldset class="dataFieldset">
                                <legend class="sec-title-container sec-col-2 sec-title-member ">
                                    <div class="sec-title-wrapper">
                                        <h1 class="sec-title title-deco"><span class="language_replace">會員中心</span></h1>
                                    </div>
                                    <!-- 資料更新 Button-->
                                    <!-- <button id="updateUserAccountRemoveReadOnlyBtn" type="button" class="btn btn-edit btn-full-main" onclick="updateUserAccountRemoveReadOnly()"><i class="icon icon-mask icon-pencile"></i></button> -->
                                </legend>

                                <!-- 當點擊 資料更新 Button時 text input可編輯的項目 會移除 readonly-->
                                <div class="dataFieldset-content row no-gutters">
                                    <div class="data-item name" style="width: 50%">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-people"></i>
                                                <span class="title-name language_replace">姓名</span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="text" class="custom-input-edit" id="RealName" value="" readonly>
                                        </div>
                                    </div>
                                    <div class="data-item birth" style="width: 50%">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-gift"></i>
                                                <span class="title-name language_replace">出生年月日</span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="number" min="1920" max="2300" class="custom-input-edit year" id="idBornYear" value="" readonly>
                                            / 
                                            <input type="number" min="1" max="12" class="custom-input-edit month" id="idBornMonth" value="" readonly>
                                            / 
                                            <input type="number" min="1" max="31" class="custom-input-edit day" id="idBornDay" value="" readonly>
                                        </div>
                                    </div>

                                    <%--<div class="data-item password" style="display: none;">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-lock-closed"></i>
                                                <span class="title-name language_replace">舊密碼</span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="password" class="custom-input-edit" id="idOldPassword" value="">
                                        </div>
                                    </div>--%>
                                    <div class="data-item password">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-lock-closed"></i>
                                                <span class="title-name language_replace">密碼</span>
                                                <!-- 資料更新 Button-->
                                                <button id="updateUserAccountRemoveReadOnlyBtn" type="button" class="ChangePassword" onclick="updateUserAccountRemoveReadOnly()"><i class="icon icon-mask icon-pencile"></i></button>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <div class="password-fake">
                                                <p class="password">**************</p>
                                            </div>
                                            <div class="password-real">
                                                <div id="idOldPasswordGroup" class="data-item-form-group is-hide">
                                                    <input type="password" class="form-control" id="idOldPassword" value="" language_replace="placeholder" placeholder="請輸入舊密碼">
                                                    <label for="" class="form-label"><span class="language_replace">請輸入舊密碼</span></label>
                                                    <span id="idOldPasswordSuccessIcon" class="label success is-hide"><i class="icon icon-mask icon-check"></i></span>
                                                    <span id="idOldPasswordErrorIcon" class="label fail is-hide"><i class="icon icon-mask icon-error"></i></span>
                                                    <p class="notice is-hide" id="OldPasswordErrorMessage"></p>
                                                </div>
                                                <div id="idNewPasswordGroup" class="data-item-form-group is-hide">
                                                    <input type="password" class="form-control" id="idNewPassword" value="" language_replace="placeholder" placeholder="請輸入新密碼">
                                                    <label for="" class="form-label"><span class="language_replace">請輸入新密碼</span></label>
                                                    <span id="idNewPasswordSuccessIcon" class="label success is-hide"><i class="icon icon-mask icon-check"></i></span>
                                                    <span id="idNewPasswordErrorIcon" class="label fail is-hide"><i class="icon icon-mask icon-error"></i></span>
                                                    <p class="notice is-hide" id="NewPasswordErrorMessage"></p>
                                                </div>
                                            </div>
                                            <div class="wrapper_center">
                                                <button id="updateUserAccountCancelBtn" onclick="updateUserAccountReadOnly()" type="button" class="btn btn-confirm btn-gray is-hide"><span class="language_replace">取消</span></button>
                                                <button id="updateUserAccountBtn" onclick="updateUserAccount()" type="button" class="btn btn-confirm btn-full-main is-hide"><span class="language_replace">確認</span></button>
                                            </div>
                                        </div>
                                    </div>
                                    <!-- 手機認證狀態 -->
                                    <div class="data-item verify">
                                        <div class="data-item-title">
                                            <label class="title mb-3">
                                                <i class="icon icon-mask icon-verify2"></i>
                                                <span class="title-name language_replace">手機認證狀態</span>
                                                <span class="btn btn-Q-mark btn-round btn-sm" data-toggle="modal" data-target="#ModalVerify"><i class="icon icon-mask icon-question"></i></span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <div class="verify-item">
                                                <!-- 尚未認證 -->
                                                <span class="verify-result fail" id="IsFullRegistration0" style="display: none">
                                                    <span class="label fail"><i class="icon icon-mask icon-error"></i></span>
                                                    <span class="verify-desc language_replace">尚未認證</span>
                                                    <button type="button" class="btn btn-verify" data-toggle="modal" data-target="#ModalRegisterComplete">
                                                        <span class="title language_replace">進行認證</span>
                                                        <i class="icon icon-mask icon-pencile"></i>
                                                    </button>
                                                    <p class="notice language_replace mt-2 text-primary">*完成會員認證可領取 1000gift</p>
                                                </span>

                                                <!-- 認證完成 -->
                                                <span class="verify-result success" id="IsFullRegistration1" style="display: none">
                                                    <span class="label success"><i class="icon icon-mask icon-check"></i></span>
                                                    <span class="verify-desc language_replace">認證完成</span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>

                                    <!-- 實名認證狀態 -->
                                    <%--<div class="data-item verify">
                                        <div class="data-item-title">
                                            <label class="title mb-3">
                                                <i class="icon icon-mask icon-verify2"></i>
                                                <span class="title-name language_replace">實名認證狀態</span>
                                                <span class="btn btn-Q-mark btn-round btn-sm" onclick="window.parent.API_LoadPage('MemberCenter','/Guide/verified.html?form=MemberCenter', true)"><i class="icon icon-mask icon-question"></i></span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <div class="verify-item">
                                                <!-- 尚未認證 -->
                                                <span class="verify-result fail" id="IsKYCRegistration0">
                                                    <span class="label fail"><i class="icon icon-mask icon-error"></i></span>
                                                    <span class="verify-desc language_replace">尚未認證</span>
                                                    <button type="button" class="btn btn-verify" data-toggle="modal" data-target="#ModalKYCComplete">
                                                        <span class="title language_replace">進行認證</span>
                                                        <i class="icon icon-mask icon-pencile"></i>
                                                    </button>
                                                </span>

                                                <!-- 認證完成 -->
                                                <span class="verify-result success" id="IsKYCRegistration1" style="display: none">
                                                    <span class="label success"><i class="icon icon-mask icon-check"></i></span>
                                                    <span class="verify-desc language_replace">認證完成</span>
                                                </span>
                                            </div>
                                        </div>
                                    </div>--%>

                                    <div class="data-item mobile">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-mobile"></i>
                                                <span class="title-name language_replace">手機號碼</span>
                                            </label>
                                            <%--<div class="labels labels-status">
                                                <span class="label language_replace update">更新</span>
                                                <span class="label language_replace validated">認証</span>
                                                <span class="label language_replace unvalidated">認証済み</span>
                                            </div>--%>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="text" class="custom-input-edit" id="PhoneNumber" value="" readonly>
                                        </div>
                                    </div>
                                    <div class="data-item email" style="width: 100%">
                                        <div class="data-item-title">
                                            <label class="title">
                                                <i class="icon icon-mask icon-mail"></i>
                                                <span class="title-name language_replace">E-mail</span>
                                            </label>
                                        </div>
                                        <div class="data-item-content">
                                            <input type="text" class="custom-input-edit" id="Email" value="" readonly>
                                        </div>
                                    </div>

                                    <div class="data-item-group">
                                        <%--
                                        <div class="data-item home" id="divAddress">
                                            <div class="data-item-title">
                                                <label class="title">
                                                    <i class="icon icon-mask icon-location"></i>
                                                    <span class="title-name language_replace">地址</span>
                                                </label>
                                            </div>
                                            <div class="data-item-content">
                                                <input type="text" class="custom-input-edit" id="Address" value="" readonly>
                                            </div>
                                        </div>
                                        <div class="data-item news">
                                            <div class="data-item-title">
                                                <label class="title">
                                                    <i class="icon icon-mask icon-flag"></i>
                                                    <span class="title-name language_replace">訊息通知</span>
                                                </label>
                                            </div>
                                            <div class="data-item-content">
                                                <div class="custom-control custom-checkboxValue custom-control-inline">
                                                    <label class="custom-label">
                                                        <input type="checkbox" class="custom-control-input-hidden" checked="checked" id="check_UserGetMail">
                                                        <div class="custom-input checkbox"><span class="language_replace">接收最新資訊</span></div>
                                                    </label>
                                                </div>

                                            </div>
                                        </div>
                                        --%>

                                        <!-- <div class="wrapper_center">
                                            <button id="updateUserAccountCancelBtn" onclick="updateUserAccountReadOnly()" type="button" class="btn btn-confirm btn-gray is-hide"><span class="language_replace">取消</span></button>
                                            <button id="updateUserAccountBtn" onclick="updateUserAccount()" type="button" class="btn btn-confirm btn-full-main is-hide"><span class="language_replace">確認</span></button>
                                        </div> -->
                                        <div class="data-item qrcode">
                                            <div class="data-item-title">
                                                <label class="title">
                                                    <i class="icon icon-mask icon-qrocde"></i>
                                                    <span class="title-name language_replace">推廣碼</span>
                                                </label>
                                            </div>
                                            <div class="data-item-content">
                                                <div class="member-profile-QRcode">
                                                    <div class="qrcode-img">
                                                        <span class="img">
                                                            <img id="QRCodeimg" src="" alt="">
                                                        </span>
                                                    </div>
                                                    <div class="qrcode-number">
                                                        <span class="number" id="PersonCode"></span>
                                                        <input id="idCopyPersonCode" class="is-hide">

                                                        <button type="button" class="btn btn-transparent btn-exchange-avater">
                                                            <i class="icon icon-mask icon-copy" onclick="copyText('idCopyPersonCode')"></i>

                                                        </button>

                                                    </div>

                                                </div>


                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </fieldset>
                        </div>
                    </section>
                    <section class="section-member-setting">
                        <!-- 會員錢包中心 - 入金 + 履歷紀錄 / 出金 -->
                        <section class="section-member-wallet-transaction">
                            <div class="member-wallet-deposit-wrapper">
                                <!-- 錢包中心 -->
                                <div class="member-wallet-wrapper">
                                    <div class="member-wallet-inner">
                                        <div class="member-wallet-contnet" onclick="window.top.API_LoadPage('Deposit','Deposit.aspx', true)">
                                            <div class="member-wallet-detail">
                                                <h3 class="member-wallet-title language_replace">錢包</h3>
                                                <div class="member-wallet-amount">
                                                    <span class="unit">OCoin</span>
                                                    <div class="member-deposit">
                                                        <span class="amount" id="idAmount">999,999,999</span>
                                                        <!-- 入金 Button -->
                                                        <span class="btn btn-deposit btn-full-stress btn-round"><i class="icon icon-add"></i></span>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                        <!-- 履歷紀錄 -->
                                        <div class="member-record-wrapper">
                                            <div class="btn" onclick="window.top.API_LoadPage('record','record.aspx', true)">
                                                <div class="member-record-title">
                                                    <i class="icon icon-mask icon-list-time"></i>
                                                    <h3 class="title language_replace">履歷紀錄</h3>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 出金門檻--新版: class判斷=> 不足:lacking  足夠:enough-->
                            <div class="member-withdraw-wrapper lacking" id="divThrehold">
                                <div class="member-withdraw-limit-inner ">
                                    <div class="member-withdraw-limit-content">
                                        <div class="member-withdraw-limit-hint"></div>
                                        <div class="member-withdraw-limit-detail">
                                            <div class="limit-wrapper">
                                                <div class="limit-status">
                                                    <span class="title language_replace">錢包</span>
                                                    <div>
                                                        <span class="value lacking language_replace">不可出金</span>
                                                        <span class="value enough language_replace">可出金</span>
                                                        <!-- 出金說明 -->
                                                        <span class="btn btn-QA-transaction btn-full-stress btn-round" onclick="window.parent.API_LoadPage('guide_Rolling','/Article/guide_Rolling.html')"><i class="icon icon-mask icon-question"></i></span>
                                                    </div>
                                                </div>
                                                <div class="limit-amount">
                                                    <span class="title language_replace">出金限制</span>
                                                    <span class="value" id="idThrehold"></span>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <!-- 出金門檻--舊版: class判斷=> 不足:lacking  足夠:enough-->
                            <div class="member-withdraw-wrapper lacking" id="divThrehold" style="display: none;">
                                <div class="member-withdraw-limit-wrapper">
                                    <div class="member-withdraw-limit-inner ">
                                        <i class="icon icon-mask icon-lock"></i>
                                        <span class="member-withdraw-limit-content">
                                            <!-- 出金門檻 不足-->
                                            <span class="title lacking language_replace">不可出金</span>
                                            <!-- 出金門檻 足夠-->
                                            <span class="title enough language_replace">可出金</span>
                                            <!-- 出入金說明 -->
                                            <span class="btn btn-QA-transaction btn-full-stress btn-round"><i class="icon icon-mask icon-question"></i></span>
                                            <!-- 出金門檻 -->
                                            <span class="limit-amount" id="idThrehold"></span>
                                        </span>
                                    </div>
                                </div>
                            </div>

                        </section>

                        <!-- 會員簽到進度顯示 + 活動中心 + 獎金中心 -->
                        <section class="section-member-activity">
                            <!-- 活動中心 + 獎金中心 -->
                            <div class="activity-record-wrapper">
                                <!-- 活動中心 -->
                                <div class="activity-center-wrapper" onclick="window.top.API_LoadPage('ActivityCenter','ActivityCenter.aspx')">
                                    <div class="activity-center-inner">
                                        <div class="activity-center-content">
                                            <div class="title language_replace">活動中心</div>
                                            <div class="btn btn-activity-in"><span class="language_replace">參加</span></div>
                                        </div>
                                    </div>
                                </div>

                                <!-- 獎金中心 -->
                                <div class="prize-center-wrapper" onclick="window.top.API_LoadPage('prize','/Guide/prize.html')">
                                    <div class="prize-center-inner">
                                        <div class="title language_replace">禮物盒說明</div>
                                    </div>
                                </div>

                            </div>

                            <!-- 會員簽到進度顯示 -->
                            <div class="activity-dailylogin-wrapper">
                                <div class="dailylogin-bouns-wrapper" onclick="window.parent.API_LoadPage('ActivityCenter','ActivityCenter.aspx?type=3')">
                                    <div class="dailylogin-bouns-inner">
                                        <div class="dailylogin-bouns-content">
                                            <div class="sec-title">
                                                <h3 class="title">
                                                    <span class="name language_replace">金曜日の<span>プレゼント</span></span></h3>
                                                    <span class="dailylogin-bouns-QA sec-title-intro-link">
                                                    <span class="btn btn-QA-dailylogin-bouns btn-full-stress btn-round"><i class="icon icon-mask icon-question"></i></span><span class="language_replace">説明</span></span>
                                            </div>   

                                            <ul class="dailylogin-bouns-list">
                                                <!-- 已領取 bouns => got-->
                                                <li class="bouns-item ">
                                                    <span class="day"><span class="language_replace">五</span></span></li>
                                                <li class="bouns-item saturday">
                                                    <span class="day"><span class="language_replace">六</span></span>
                                                </li>
                                                <li class="bouns-item sunday">
                                                    <span class="day"><span class="language_replace">日</span></span></li>
                                                <li class="bouns-item">
                                                    <span class="day"><span class="language_replace">一</span></span>
                                                </li>
                                                <li class="bouns-item">
                                                    <span class="day"><span class="language_replace">二</span></span></li>
                                                <li class="bouns-item">
                                                    <span class="day"><span class="language_replace">三</span></span>
                                                </li>
                                                <li class="bouns-item">
                                                    <span class="day"><span class="language_replace">四</span></span>
                                                </li>
                                            </ul>
                                            <div class="dailylogin-bouns-amount">
                                                <span class="amount-title language_replace">累積獎金</span>
                                                <span class="bouns-amount">0</span>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </section>
                    </section>

                    <!-- 熱門活動 -->
                    <div class="activity-promo-wrapper">
                        <div class="activity-promo-inner">
                            <div class="sec-title-container sec-title-member ">
                                <div class="sec-title-wrapper">
                                    <h3 class="sec-title title-deco"><span class="language_replace">熱門活動</span></h3>
                                </div>
                            </div>
                            <div class="activity-promo-content">
                                <ul class="activity-promo-list">
                                    <li class="promo-item">
                                        <div class="promo-inner">
                                            <div class="promo-img">
                                                <a id="activityURL1" href="https://www.casino-maharaja.net/lp/02/N00000000"
                                                    target="_blank">
                                                    <div class="img-crop">
                                                        <img src="images/activity/promo-02.jpg?1"
                                                            alt="パチンコって何？それっておいしいの？">
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="promo-content">
                                                <h4 class="title language_replace">顧客活用的介紹推廣頁②（柏青哥愛好者）</h4>
                                                <button type="button" class="btn btn-full-main" onclick="copyActivityUrl1()">
                                                    <i class="icon icon-mask icon-copy"></i><span class="language_replace">複製活動連結</span>
                                                </button>
                                            </div>
                                        </div>
                                    </li>
                                    <li class="promo-item">
                                        <div class="promo-inner">
                                            <div class="promo-img">
                                                <a id="activityURL" href="https://casino-maharaja.net/lp/01/N00000000"
                                                    target="_blank">
                                                    <div class="img-crop">
                                                        <img src="images/activity/promo-01.jpg?1"
                                                            alt="とりあえず、当社のドメインで紹介用LPをアップしてみました。">
                                                    </div>
                                                </a>
                                            </div>
                                            <div class="promo-content">
                                                <h4 class="title language_replace">お客様活用、紹介ランディングページその①（主婦）</h4>
                                                <button type="button" class="btn btn-full-main" onclick="copyActivityUrl()">
                                                    <i class="icon icon-mask icon-copy"></i>
                                                    <span class="language_replace">複製活動連結</span>
                                                </button>
                                            </div>
                                        </div>
                                    </li>
                                </ul>
                            </div>
                        </div>
                    </div>
                </article>
            </div>
        </div>
    </main>
    <!-- Modal - Game Info for Mobile Device-->
    <div class="modal fade no-footer popupGameInfo " id="popupGameInfo" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-xl modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="game-info-mobile-wrapper gameinfo-pack-bg">
                        <div class="game-item">
                            <div class="game-item-inner">
                                <div class="game-item-focus">
                                    <div class="game-item-img">
                                        <span class="game-item-link"></span>
                                        <div class="img-wrap">
                                            <img src="">
                                        </div>
                                    </div>
                                    <div class="game-item-info-detail open">
                                        <div class="game-item-info-detail-wrapper">
                                            <div class="game-item-info-detail-moreInfo">
                                                <ul class="moreInfo-item-wrapper">
                                                    <li class="moreInfo-item brand">
                                                        <span class="title language_replace">廠牌</span>
                                                        <span class="value">PG</span>
                                                    </li>
                                                    <li class="moreInfo-item RTP">
                                                        <span class="title">RTP</span>
                                                        <span class="value number">96.66</span>
                                                    </li>
                                                    <li class="moreInfo-item gamecode">
                                                        <span class="title">NO.</span>
                                                        <span class="value number">00976</span>
                                                    </li>
                                                </ul>
                                            </div>
                                            <div class="game-item-info-detail-indicator">
                                                <div class="game-item-info-detail-indicator-inner">
                                                    <div class="info">
                                                        <h3 class="game-item-name language_replace">蝶戀花</h3>
                                                    </div>
                                                    <div class="action">
                                                        <div class="btn-s-wrapper">
                                                            <button type="button" class="btn-thumbUp btn btn-round">
                                                                <i class="icon icon-m-thumup"></i>
                                                            </button>
                                                            <button type="button" class="btn-like btn btn-round">
                                                                <i class="icon icon-m-favorite"></i>
                                                            </button>
                                                            <button type="button" class="btn-more btn btn-round">
                                                                <i class="arrow arrow-down"></i>
                                                            </button>
                                                        </div>
                                                        <button type="button" class="btn btn-play">
                                                            <span class="language_replace">プレイ</span><i class="triangle"></i></button>
                                                    </div>
                                                </div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                            </div>
                        </div>
                    </div>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-secondary" data-dismiss="modal">Close</button>
                    <button type="button" class="btn btn-primary">Save</button>
                </div>
            </div>
        </div>
    </div>


    <!-- Modal Complete Register -->
    <div class="modal fade footer-center" id="ModalRegisterComplete" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="sec-title-container">
                        <h5 class="modal-title language_replace">進行資料認證</h5>
                        <span class="btn btn-Q-mark btn-round ml-2" data-toggle="modal" data-target="#ModalVerify"><i class="icon icon-mask icon-question"></i></span>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_PupLangClose1">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="registerComplete-popup-wrapper">
                        <form id="CertificationForm">
                            <div class="registerComplete-popup-inner">
                                <div class="form-row">
                                    <div class="form-group col phonePrefix">
                                        <label class="form-title language_replace">國碼</label>
                                        <div class="input-group">
                                            <input id="idPhonePrefix" type="text" class="form-control custom-style" placeholder="+81" inputmode="decimal" value="+81" onchange="onChangePhonePrefix()">
                                            <div class="invalid-feedback language_replace">請輸入國碼</div>
                                        </div>                                        
                                    </div>
                                    <div class="form-group col">
                                        <label class="form-title language_replace">手機電話號碼</label>
                                        <div class="input-group">
                                            <input id="idPhoneNumber" type="text" class="form-control custom-style" language_replace="placeholder" placeholder="000-0000-0000 (最前面的00請勿輸入)" inputmode="decimal">
                                            <div class="invalid-feedback language_replace">請輸入正確電話</div>
                                        </div>
                                    </div>
                                </div>
                                <div class="wrapper_center mt-1 mb-3" id="divSendValidateCodeBtn_Phone">
                                    <button type="button" class="btn btn-outline-main btn-roundcorner" onclick="onBtnSendValidateCode_Phone()" id="btnSendValidateCode_Phone" style="max-width: 200px;">
                                        <span class="language_replace">傳送簡訊驗證碼</span>
                                    </button>
                                </div>
                                <div class="form-group">
                                    <label class="form-title language_replace">驗證碼</label>
                                    <div class="input-group">
                                        <input id="idValidateCode_Phone" name="ValidateCode_Phone" type="text" class="form-control custom-style">
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col-md form-input-focus-tip">
                                        <label class="form-title language_replace">姓</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control custom-style" id="Name1" name="Name1" language_replace="placeholder" placeholder="姓1">
                                            <div class="invalid-feedback language_replace">提示</div>
                                            <div class="custom-input-focus-tip">
                                                <div class="notice align-items-start">
                                                    <span class="icon-warn"></span>
                                                    <span class="text language_replace">請填寫真實姓名供後續身份認證時驗證</span></div>
                                            </div>
                                        </div>
                                    </div>
                                    <div class="form-group col-md form-input-focus-tip">
                                        <label class="form-title language_replace">名</label>
                                        <div class="input-group">
                                            <input type="text" class="form-control custom-style" id="Name2" name="Name2" language_replace="placeholder" placeholder="名1">
                                            <div class="invalid-feedback language_replace">提示</div>
                                            <div class="custom-input-focus-tip">
                                                <div class="notice align-items-start">
                                                    <span class="icon-warn"></span>
                                                    <span class="text language_replace">請填寫真實姓名供後續身份認證時驗證</span></div>
                                            </div>
                                        </div>
                                    </div>
                                </div>
                                <div class="form-row">
                                    <div class="form-group col">
                                        <label class="form-title language_replace">出生年</label>
                                        <div class="input-group">
                                            <input id="idBornYear1" type="text" class="form-control custom-style" placeholder="1900" inputmode="numeric" name="BornYear" onchange="AdjustDate()" value="1990">
                                        </div>
                                    </div>
                                    <div class="form-group col">
                                        <label class="form-title language_replace">月</label>
                                        <div class="input-group">
                                            <select id="idBornMonth1" class="form-control custom-style" name="BornMonth" onchange="AdjustDate()">
                                                <option value="1" selected>1</option>
                                                <option value="2">2</option>
                                                <option value="3">3</option>
                                                <option value="4">4</option>
                                                <option value="5">5</option>
                                                <option value="6">6</option>
                                                <option value="7">7</option>
                                                <option value="8">8</option>
                                                <option value="9">9</option>
                                                <option value="10">10</option>
                                                <option value="11">11</option>
                                                <option value="12">12</option>
                                            </select>
                                        </div>
                                    </div>
                                    <div class="form-group col">
                                        <label class="form-title language_replace">日</label>
                                        <div class="input-group">
                                            <select id="idBornDate" class="form-control custom-style" name="BornDate">
                                            </select>
                                        </div>
                                    </div>
                                </div>

                            </div>
                            <div class="wrapper_center">
                                <button class="btn btn-full-main btn-roundcorner" type="button" onclick="Certification()">
                                    <span class="language_replace">確認</span>
                                </button>
                            </div>
                        </form>

                        <div class="verifyResult-wrapper">

                            <!-- 認證成功 -->
                            <div class="resultShow success" id="CertificationSucc" style="display: none">
                                <div class="verifyResult-inner">
                                    <div class="verify_resultShow">
                                        <div class="verify_resultDisplay">
                                            <div class="icon-symbol"></div>
                                        </div>
                                        <p class="verify_resultTitle"><span class="language_replace">認證完成</span></p>
                                    </div>
                                </div>
                                <div class="verify_detail">
                                    <div class="item-detail">
                                        <div class="title language_replace">
                                            <%--<span class="memeberNickname">Eddie</span>--%>
                                            <span class="language_replace">升級為完整會員</span>
                                        </div>
                                    </div>
                                </div>
                                <div class="wrapper_center">
                                    <button class="btn btn-full-main btn-roundcorner" type="button" onclick="closeCertification()">
                                        <span class="language_replace">確認</span>
                                    </button>
                                </div>
                            </div>

                            <!-- 認證失敗 -->
                            <div class="resultShow fail" id="CertificationFail" style="display: none">
                                <div class="verifyResult-inner">
                                    <div class="verify_resultShow">
                                        <div class="verify_resultDisplay">
                                            <div class="icon-symbol"></div>
                                        </div>
                                        <p class="verify_resultTitle"><span class="language_replace">認證失敗</span></p>
                                    </div>
                                </div>
                                <div class="verify_detail">
                                    <div class="item-detail">
                                        <div class="title language_replace">
                                            <%--<span class="memeberNickname">Eddie</span>--%>
                                            <span class="language_replace">尚未升級為完整會員</span>
                                        </div>
                                    </div>
                                </div>
                                <%-- <div class="wrapper_center">
                                    <button class="btn btn-gray btn-roundcorner" type="button" onclick="">
                                        <span class="language_replace">取消</span>
                                    </button>
                                    <button class="btn btn-full-main btn-roundcorner" type="button" onclick="">
                                        <span class="language_replace">重新認證</span>
                                    </button>
                                </div>   --%>
                                <div class="wrapper_center">
                                    <button class="btn btn-full-main btn-roundcorner" type="button" onclick="closeCertification()">
                                        <span class="language_replace">確認</span>
                                    </button>
                                </div>
                            </div>
                        </div>

                    </div>
                </div>
                <%--<div class="modal-footer">
                <button type="button" class="btn btn-primary">確定</button>
            </div>--%>
            </div>
        </div>
    </div>


    <!-- KYC 實名認證 -->
    <div class="modal fade footer-center" id="ModalKYCComplete" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable KYCmodal">
            <div class="modal-content">
                <div class="modal-header">
                    <div class="sec-title-container">
                        <h5 class="modal-title language_replace">實名認證</h5>
                    </div>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_PupLangClose1">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="KYCnote">
                        <p>您可以上傳以下文件(擇一)</p>
                        <ul>
                            <li>駕照／駕駛經歷證明書</li>
                            <li>附照片之住民基本台帳卡</li>
                            <li>個人編號卡</li>
                            <li>居留證或特別永住者證明書</li>
                            <li>護照</li>
                        </ul>
                        <ol>
                            <li>請確保證件無編輯、剪裁，清晰且無歪斜。</li>
                            <li>請提出在有效時間內之文件。</li>
                            <li>身份認證會按會員先後順序進行審核，在您提交文件後，我們將盡快完成審查。</li>
                            <li>另外，即使未完成實名認證，您依然可以正常遊玩遊戲。</li>
                        </ol>
                    </div>
                    <nav class="tab-kyc">
                        <div class="tab-scroller tab-2">
                            <div class="tab-scroller__area">
                                <ul class="tab-scroller__content">
                                    <li class="tab-item act-running active" id="li_KYC0" onclick="ChangeKYC(0)">
                                        <span class="tab-item-link">
                                            <span class="title language_replace" langkey="護照以外">護照以外</span>
                                        </span>
                                    </li>
                                    <li class="tab-item act-finish" id="li_KYC1" onclick="ChangeKYC(1)">
                                        <span class="tab-item-link">
                                            <span class="title language_replace" langkey="護照">護照</span>
                                        </span>
                                    </li>
                                    <div class="tab-slide"></div>
                                </ul>
                            </div>
                        </div>
                    </nav>
                    <section id="kyc_other" class="kyc_contentWrap">
                        <div class="photoArea">
                            <img src="images/member/ID_ok.png" alt="">
                            <img src="images/member/ID_error.png" alt="">
                        </div>
                        <div class="uploadArea">
                            <h3>護照以外上傳</h3>
                            <div class="uploadWrap">
                                <section class="SingleUpload">
                                    <h4>正面</h4>
                                    <form class="mb-3 dm-uploader" id="drag-and-drop-zone">
                                        <div class="formRow">
                                            <div class="preview">
                                                <img src="images/member/upload.svg" alt="..." class="img-thumbnail">
                                            </div>
                                            <div class="Upload">
                                                <div class="fromGroup">
                                                <!-- <span>請在此上傳</span> -->
                                                <span>需提供帶有照片的證件</span>
                                                <!-- <input type="text" class="form-control" aria-describedby="fileHelp" placeholder="尚未上傳圖檔..." readonly="readonly"> -->
                                                <div class="progress mb-2 d-none">
                                                    <div class="progress-bar progress-bar-striped progress-bar-animated bg-primary" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="0">
                                                    0%
                                                    </div>
                                                </div>
                                        
                                                </div>
                                                <div class="fromGroup">
                                                <div role="button" class="btn btn-primary">
                                                    <span>選擇檔案</span>
                                                    <input type="file" title="Click to add Files">
                                                </div>
                                                <small class="status text-muted">選擇檔案或將檔案拖拉至此區域</small>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </section>
                                <section class="SingleUpload">
                                    <h4>背面</h4>
                                    <form class="mb-3 dm-uploader" id="drag-and-drop-zone2">
                                        <div class="formRow">
                                            <div class="preview">
                                                <img src="images/member/upload.svg" alt="..." class="img-thumbnail">
                                            </div>
                                            <div class="Upload">
                                                <div class="fromGroup">
                                                <!-- <span>請在此上傳</span> -->
                                                <span>需提供帶有照片的證件</span>
                                                <!-- <input type="text" class="form-control" aria-describedby="fileHelp" placeholder="尚未上傳圖檔..." readonly="readonly"> -->
                                                <div class="progress mb-2 d-none">
                                                    <div class="progress-bar progress-bar-striped progress-bar-animated bg-primary" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="0">
                                                    0%
                                                    </div>
                                                </div>
                                        
                                                </div>
                                                <div class="fromGroup">
                                                <div role="button" class="btn btn-primary">
                                                    <span>選擇檔案</span>
                                                    <input type="file" title="Click to add Files">
                                                </div>
                                                <small class="status text-muted">選擇檔案或將檔案拖拉至此區域</small>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </section>
                            </div>
                        </div>
                    </section>
                    <section id="kyc_passport" class="kyc_contentWrap" style="display:none;">
                        <div class="photoArea">
                            <img src="images/member/passport_ok.png" alt="">
                            <img src="images/member/passport_error.png" alt="">
                        </div>
                        <div class="uploadArea">
                            <h3>護照上傳</h3>
                            <div class="uploadWrap">
                                <section class="SingleUpload">
                                    <h4>正面</h4>
                                    <form class="mb-3 dm-uploader" id="drag-and-drop-zone3">
                                        <div class="formRow">
                                            <div class="preview">
                                                <img src="images/member/upload.svg" alt="..." class="img-thumbnail">
                                            </div>
                                            <div class="Upload">
                                                <div class="fromGroup">
                                                <!-- <span>請在此上傳</span> -->
                                                <span>需提供帶有照片的證件</span>
                                                <!-- <input type="text" class="form-control" aria-describedby="fileHelp" placeholder="尚未上傳圖檔..." readonly="readonly"> -->
                                                <div class="progress mb-2 d-none">
                                                    <div class="progress-bar progress-bar-striped progress-bar-animated bg-primary" role="progressbar" style="width: 0%;" aria-valuenow="0" aria-valuemin="0" aria-valuemax="0">
                                                    0%
                                                    </div>
                                                </div>
                                        
                                                </div>
                                                <div class="fromGroup">
                                                <div role="button" class="btn btn-primary">
                                                    <span>選擇檔案</span>
                                                    <input type="file" title="Click to add Files">
                                                </div>
                                                <small class="status text-muted">選擇檔案或將檔案拖拉至此區域</small>
                                                </div>
                                            </div>
                                        </div>
                                    </form>
                                </section>
                            </div>
                        </div>
                    </section>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-gray">取消</button>
                    <button type="button" class="btn btn-primary">提交</button>
                </div>
            </div>
            </div>
        </div>
    </div>

    <!-- Modal Verify Tip -->
    <div class="modal fade footer-center" id="ModalVerify" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close" id="btn_PupLangClose">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <div class="Verify-popup-wrapper popup-tip">
                        <ul class="Verify-popup-list">
                            <li class="item">
                                <h3 class="title language_replace">為何需要認證?</h3>
                                <p class="desc language_replace">認證需要您填入您實際的姓名，以證明為帳號之所有者，未來於出入金時的證明。因此若為完成認證，則無法使用出入金等部分功能，也無法享有領取獎勵的權益。</p>
                            </li>
                            <li class="item">
                                <h3 class="title language_replace">如何進行認證?</h3>
                                <p class="desc language_replace">於會員中心按下『進行認證』之按鈕，或欲使用被限制之功能時，提供填寫介面以利會員完成認證。</p>
                            </li>
                        </ul>
                    </div>
                </div>
            </div>
        </div>
    </div>
    
    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>
    <script type="text/javascript">
        function ChangeKYC(type) {
            $(".tab-scroller__content").find(".tab-item").removeClass("active");
            $("#li_KYC" + type).addClass("active");

            if (type == 0) {
                $("#kyc_other").show();
                $("#kyc_passport").hide();
            } else {
                $("#kyc_passport").show();
                $("#kyc_other").hide();
            }
        }
    </script>
    <!-- 照片上傳 -->
    <script src="Scripts/jquery.dm-uploader.min.js"></script>
    <script src="Scripts/ui-main.js"></script>
    <script src="Scripts/ui-single.js"></script>
    <script src="Scripts/single-upload.js"></script>
    <!-- 上傳照片 File item template -->
    <script type="text/html" id="files-template">
        <li class="media">
          <div class="media-body mb-1">
            <p class="mb-2">
              <strong>%%filename%%</strong> - Status: <span class="text-muted">Waiting</span>
            </p>
            <div class="progress mb-2">
              <div class="progress-bar progress-bar-striped progress-bar-animated bg-primary" 
                role="progressbar"
                style="width: 0%" 
                aria-valuenow="0" aria-valuemin="0" aria-valuemax="100">
              </div>
            </div>
            <hr class="mt-1 mb-1" />
          </div>
        </li>
      </script>
</body>
</html>
