<%@ Page Language="C#" %>

<%
    string Version = EWinWeb.Version;
    string type = Request["type"];
%>

<!doctype html>
<html lang="zh-Hant-TW" class="innerHtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>Maharaja</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/basic.min.css">
    <link rel="stylesheet" href="css/main.css">
    <link rel="stylesheet" href="css/activity.css">
    <link href="https://fonts.googleapis.com/css2?family=Noto+Sans+JP:wght@300;500&display=swap" rel="Prefetch" as="style" onload="this.rel = 'stylesheet'" />

    <script src="https://cdnjs.cloudflare.com/ajax/libs/jquery/3.6.0/jquery.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/bootstrap/4.6.2/js/bootstrap.min.js"></script>
    <script src="https://cdnjs.cloudflare.com/ajax/libs/Swiper/6.7.1/swiper-bundle.min.js"></script>
    <script type="text/javascript" src="/Scripts/Common.js"></script>
    <script type="text/javascript" src="/Scripts/UIControl.js"></script>
    <script type="text/javascript" src="/Scripts/MultiLanguage.js"></script>
    <script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
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
<script type="text/javascript">
    if (self != top) {
        window.parent.API_LoadingStart();
    }

    var c = new common();
    var ui = new uiControl();
    var mlp;
    var lang;
    var WebInfo;
    var LobbyClient;
    var v = "<%:Version%>";
    var t = "<%:type%>";

    function init() {
        if (self == top) {
            window.parent.location.href = "index.aspx";
        }

        WebInfo = window.parent.API_GetWebInfo();
        LobbyClient = window.parent.API_GetLobbyAPI();
        lang = window.parent.API_GetLang();
        getUserAccountEventSummary();
        mlp = new multiLanguage(v);

        mlp.loadLanguage(lang, function () {
            window.parent.API_LoadingEnd();

            if (LobbyClient != null) {
                //window.parent.sleep(500).then(() => {
                //    if (WebInfo.UserLogined) {
                //        document.getElementById("idGoRegBtn").classList.add("is-hide");
                //        $(".register-list").hide();
                //    }
                //})

                if (t) {
                    switch (t) {
                        case "1":
                            GoActivityDetail(1, '/Activity/Act001/CenterPage/index.html');
                            break;
                        case "2":
                            GoActivityDetail(2, '/Activity/Act002/CenterPage/index.html');
                            break;
                        case "3":
                            GoActivityDetail(3, '/Activity/Act003/CenterPage/index.html')
                            break;
                        case "4":
                            GoActivityDetail(4, '/Activity/event/pp-1/index-jp.html');
                            break;
                        case "5":
                            GoActivityDetail(5, '/Activity/event/pp-2/index-jp.html');
                            break;
                        case "6":
                            GoActivityDetail(6, '/Activity/event/bng/bng2207/index.html');
                            break;
                        case "8":
                            GoActivityDetail(8, '/Activity/event/ne-rt/08222022/index-jp.html');
                            break;
                        case "9":
                            GoActivityDetail(9, '/Activity/event/bng/09092022moonfestival/index-jp.html');
                            break;
                        case "10":
                            GoActivityDetail(10, '/Activity/event/bng/bng220919BH/index-jp.html');
                            break;
                        case "11":
                            GoActivityDetail(11, '/Activity/event/pp202209-1/index-jp.html');
                            break;
                        case "12":
                            GoActivityDetail(12, '/Activity/event/pp202209-2/index-jp.html');
                            break;
                        case "13":
                            GoActivityDetail(13, '/Activity/event/bng/bng221003MR/index-jp.html');
                            break;
                        case "14":
                            GoActivityDetail(14, '/Activity/event/ne-rt/202210/index-jp.html');
                            break;
                        case "15":
                            GoActivityDetail(15, '/Activity/event/bng/bng202210GreenChilli/index-jp.html');
                            break;
                        case "16":
                            GoActivityDetail(16, '/Activity/event/bng/bng202210SP/index-jp.html');
                            break;
                        case "17":
                            GoActivityDetail(17, '/Activity/mahaEvent/11month.html');
                            break;
                        case "18":
                            GoActivityDetail(18, '/Activity/mahaEvent/12month.html');
                            break;
                        case "19":
                            GoActivityDetail(19, '/Activity/event/ne-rt/202212/index-jp.html');
                            break;
                        case "20":
                            GoActivityDetail(20, '/Activity/event/ne-rt/202212/index-jp2.html');
                            break;
                        case "21":
                            GoActivityDetail(21, '/Activity/event/bng/bng221225MR/index-jp.html');
                            break;
                        case "22":
                            GoActivityDetail(22, '/Activity/mahaEvent/2301month.html');
                            break;
                        case "23":
                            GoActivityDetail(23, '/Activity/event/pp202301-2/index-jp.html');
                            break;
                        case "24":
                            GoActivityDetail(24, '/Activity/event/pp202301-1/index-jp.html');
                            break;
                        case "25":
                            GoActivityDetail(25, '/Activity/event/bng/bng230119/index-jp.html');
                            break;
                        case "26":
                            GoActivityDetail(26, '/Activity/mahaEvent/2302month.html');
                            break;
                        case "27":
                            GoActivityDetail(27, '/Activity/event/bng/bng230209/index-jp.html');
                            break;
                        case "28":
                            GoActivityDetail(28, '/Activity/event/pp202302-1/index-jp.html');
                            break;
                        case "29":
                            GoActivityDetail(29, '/Activity/event/pp202302-2/index-jp.html');
                            break;
                    }
                }

            } else {
                window.parent.showMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路錯誤"), function () {
                    window.parent.location.href = "index.aspx";
                });
            }
        });
    }

    function getUserAccountEventSummary() {
        LobbyClient.GetUserAccountEventSummary(WebInfo.SID, Math.uuid(), function (success, o) {
            if (success) {
                if (o.Result == 0) {
                    if (o.Datas.length > 0) {
                        for (var i = 0; i < o.Datas.length; i++) {
                            if (o.Datas[i].ActivityName == 'RegisterBouns') {
                                if (o.Datas[i].CollectCount == o.Datas[i].JoinCount) {
                                    $('#ModalRegister .btn-secondary').removeClass('is-hide');
                                } else {
                                    $('#ModalRegister .btn-full-sub').removeClass('is-hide');
                                }
                                $('#ModalRegister .btn-primary').addClass('is-hide');

                            }
                        }
                    } else {
                        window.parent.showMessageOK(mlp.getLanguageKey("提示"), mlp.getLanguageKey("沒有資料"));
                        //document.getElementById('gameTotalValidBetValue').textContent = 0;
                    }
                }
            }
        });
    }

    function GoActivityDetail(type, url) {
        event.stopPropagation();
        //001 入金
        //002 註冊
        //003 7日
        //004 PP-slot
        //005 pp-live
        let title;
        let btnText;
        let popupBtnHide;

        if (url) {
            switch (type) {
                case 1:
                    $('#ModalDeposit .activity-popup-detail-inner').load(url, function () {
                        $('#ModalDeposit').modal('show');
                    });
                    break;
                case 2:
                    $('#ModalRegister .activity-popup-detail-inner').load(url, function () {
                        $('#ModalRegister').modal('show');
                    });
                    break;
                case 3:
                    $('#ModalDailylogin .activity-popup-detail-inner').load(url, function () {
                        $('#ModalDailylogin').modal('show');
                    });
                    break;
                case 4:
                    title = "スロットトーナメントおよび現金配布";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 5:
                    title = "夏のウィークリートーナメント-ライブカジノ";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 6:
                    title = "BNG周年祝い勝利レースプレゼント";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 1;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 8:
                    title = "ボーナス爆弾キャンペーン";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 9:
                    title = "ブンーゴー中秋の名月";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 1;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 10:
                    title = "BNGまほう怪盗トーナメント";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 1;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 11:
                    title = "ライブカジノウィークリー トーナメント";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 12:
                    title = "スロットトーナメントとキャッシュ ドロップ";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 13:
                    title = "ブンーゴー秋がもたらす幸運レース";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 1;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 14:
                    title = "HELLOWIN";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 15:
                    title = "ブンーゴーチリチャレンジ";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 1;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 16:
                    title = "ブーンゴー宝石怪盗チャレンジ";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 1;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 17:
                    title = "方法問わず、当アカウント初入金100％還元!!";
                    $('#ModalDeposit .activity-popup-detail-inner').load(url, function () {
                        $('#ModalDeposit').modal('show');
                    });
                    break;
                case 18:
                    $('#ModalDeposit12 .activity-popup-detail-inner').load(url, function () {
                        $('#ModalDeposit12').modal('show');
                    });
                    break;
                case 19:
                    title = "ワールドカップ";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 20:
                    title = "クリスマスボーナス";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 21:
                    title = "BNGクリスマスと新年二重のお祝い豪華賞金大放出";
                    //btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 1;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 22:
                    $('#ModalDeposit2301 .activity-popup-detail-inner').load(url, function () {
                        $('#ModalDeposit2301').modal('show');
                    });
                    break;
                case 23:
                    title = "ライブカジノウィークリー トーナメント";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 24:
                    title = "ライブカジノウィークリー トーナメント";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 25:
                    title = "BNGおめでと卯ございます新年賞 金ベットレス";
                    //btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 1;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 26:
                    $('#ModalDeposit2302 .activity-popup-detail-inner').load(url, function () {
                        $('#ModalDeposit2302').modal('show');
                    });
                    break;
                case 27:
                    title = "BNG バレンタインレース 倍率賞金を今すぐに";
                    //btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 1;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 28:
                    title = "スロットデーリーキャッシュドロップ＆ウィークリートーナメント";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                case 29:
                    title = "ライブカジノウィークリートーナメント ";
                    btnText = mlp.getLanguageKey("前往遊玩");
                    popupBtnHide = 0;
                    showPopup(type, title, btnText, url, popupBtnHide);
                    break;
                default:
                    break;
            }
        }
    }

    function activityBtnClick(type) {
        event.stopPropagation();

        switch (type) {
            case 1:
                window.parent.API_LoadPage('Casino', 'Casino.aspx', false);
                break;
            case 2:
                window.parent.API_LoadPage('Deposit', 'Deposit.aspx', true);
                break;
            case 3:
                window.parent.API_LoadPage('', 'Prize.aspx');
                break;
            case 4:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["PP"], "Slot");
                break;
            case 5:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["PP"], "Live");
                break;
            case 6:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["BNG"], "Slot");
                break;
            case 8:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["NE", "RT"]);
                break;
            case 11:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["PP"], "Live");
                break;
            case 12:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["PP"], "Slot");
                break;
            case 14:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["NE", "RT"]);
                break;
            case 19:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["NE", "RT"]);
                break;
            case 20:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["NE", "RT"]);
                break;
            case 24:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["PP"], "Slot");
                break;
            case 23:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["PP"], "Live");
                break;
            case 28:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["PP"], "Slot");
                break;
            case 29:
                $('#TempModal').modal('hide');
                window.parent.SearchControll.searchGameByBrandAndGameCategory(["PP"], "Live");
                break;
        }
    }

    function showPopup(type, title, btnText, url, popupBtnHide) {
        $("#TempModal .btnGoActivity").unbind();
        $("#TempModal .btnGoActivity").text(btnText);
        $("#TempModal .modal-title").text(title);

        if (popupBtnHide == 1) {
            $("#TempModal .btnGoActivity").hide();
        } else {
            $("#TempModal .btnGoActivity").show();
            $("#TempModal .btnGoActivity").click(function () {
                event.stopPropagation();
                activityBtnClick(type);
            })
        }

        $('#TempModal .activity-popup-detail-inner').load(url, function () {
            $('#TempModal').modal('show');
        });
    }

    function ChangeActivity(type) {
        $(".tab-scroller__content").find(".tab-item").removeClass("active");
        $("#li_activity" + type).addClass("active");

        if (type == 0) {
            $("#divProcessing").show();
            $("#divFinish").hide();
        } else {
            $("#divFinish").show();
            $("#divProcessing").hide();
        }
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
<body class="innerBody">
    <main class="innerMain">
        <div class="page-content">
            <div class="container">
                <div class="sec-title-container sec-title-activity">
                    <!-- 領獎中心 link-->
                    <a class="btn btn-link btn-prize" onclick="window.parent.API_LoadPage('Prize','Prize.aspx', true)">
                        <span class="title language_replace">前往領獎中心</span><i class="icon icon-mask icon-arrow-right-dot"></i>
                    </a>
                    <div class="sec-title-wrapper">
                        <h1 class="sec-title title-deco"><span class="language_replace">活動</span></h1>
                    </div>
                </div>
                <nav class="tab-activity">
                    <div class="tab-scroller tab-2">
                        <div class="tab-scroller__area">
                            <ul class="tab-scroller__content" id="idTabActivityList">
                                <li class="tab-item act-running active" id="li_activity0" onclick="ChangeActivity(0)">
                                    <span class="tab-item-link">
                                        <span class="title language_replace">進行中</span>
                                    </span>
                                </li>
                                <li class="tab-item act-finish" id="li_activity1" onclick="ChangeActivity(1)">
                                    <span class="tab-item-link">
                                        <span class="title language_replace">已結束</span>
                                    </span>
                                </li>
                                <div class="tab-slide"></div>
                            </ul>
                        </div>
                    </div>
                </nav>

                <section class="section-wrap section-activity">
                    <div class="activity-item-group" id="divProcessing">
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(29,'/Activity/event/pp202302-2/index-jp.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/pp202302-2/img/img-liveJp-act.png">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace" langkey="プラグマティックプレイのライブカジノゲームをプレイし、高スコアを獲得しリーダーボードの上位になれば、最大115,000ギフトマネーがもらえる。">プラグマティックプレイのライブカジノゲームをプレイし、高スコアを獲得しリーダーボードの上位になれば、最大115,000ギフトマネーがもらえる。</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace" langkey="立即確認">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(28,'/Activity/event/pp202302-1/index-jp.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/pp202302-1/img/img-actJp.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace" langkey="プラグマティックプレイの対象ゲームをプレイすれば、最大115,000ギフトマネーがもらえる。さらにベット金額1000倍のサプライス賞もあるよ！">プラグマティックプレイの対象ゲームをプレイすれば、最大115,000ギフトマネーがもらえる。さらにベット金額1000倍のサプライス賞もあるよ！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace" langkey="立即確認">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>

                          <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(26,'/Activity/mahaEvent/2302month.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="Activity/mahaEvent/src/202302-act.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <div class="desc language_replace">アカウント初入金に最大100,000 Ocoin還元</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(3,'/Activity/Act003/CenterPage/index.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="Activity/Act003/CenterPage/img/activity-popup-b-m-01.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">毎日20,000ローリングのミッションを達成し、最大10,000 Ocoin獲得できる！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(1)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(2,'/Activity/Act002/CenterPage/index.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity/activity-register.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">マハラジャ会員限定！新規登録と招待で、最大1,000 Ocoin獲得できる</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(3)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                    </div>
                    <div class="activity-item-group" id="divFinish" style="display: none">
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(27,'/Activity/event/bng/bng230209/index-jp.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/bng/bng230209/img/500X316_end.png">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace" langkey="
                                               BNG バレンタインレース 倍率賞金を今すぐに
                                            ">
                                               BNG バレンタインレース 倍率賞金を今すぐに
                                            </div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace" langkey="立即確認">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                            <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(23,'/Activity/event/pp202301-2/index-jp.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/pp202301-2/img/500x316_end.png">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">プラグマティックプレイのライブカジノゲームをプレイし、高スコアを獲得しリーダーボードの上位になれば、最大115,000ギフトマネーがもらえる。</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                          <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(24,'/Activity/event/pp202301-1/index-jp.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/pp202301-1/img/500x316_end.png">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">プラグマティックプレイのライブカジノゲームをプレイし、高スコアを獲得しリーダーボードの上位になれば、最大115,000ギフトマネーがもらえる。</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                          <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(22,'/Activity/mahaEvent/2301month.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="Activity/mahaEvent/src/202301-end.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <div class="desc language_replace">アカウント初入金に最大100,000 Ocoin還元</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                          <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(25,'/Activity/event/bng/bng230119/index-jp.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/bng/bng230119/img/500X316_end.png" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">
                                               BNG指定のゲームにベットすれば、最大300,000までのギフトマネーがもらえる
                                            </div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                          <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(21,'/Activity/event/bng/bng221225MR/index-jp.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/bng/bng221225MR/img/500X316_end.png" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">
                                               BNG指定のゲームにベットすれば、最大300,000までのギフトマネーがもらえる
                                            </div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(20,'/Activity/event/ne-rt/202212/index-jp2.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/ne-rt/202212/img/JP_500X316_Xmas_end.png" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <div class="desc language_replace">
                                                ネットエント（NE）とレッドタイガー（RT）のゲームをプレイすれば、最大130,000のギフトマネーが貰えるよ！
                                            </div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(18,'/Activity/mahaEvent/12month.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="Activity/mahaEvent/src/12month-act-close.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <div class="desc language_replace">アカウント初入金に最大100,000 Ocoin還元</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                                <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(11,'/Activity/event/pp202209-1/index-jp.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/pp202209-1/img/img-liveJp-act-close.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">プラグマティックプレイのライブカジノゲームをプレイし、高スコアを獲得しリーダーボードの上位になれば、最大115,000ギフトマネーがもらえる。</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(12,'/Activity/event/pp202209-2/index-jp.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/pp202209-2/img/img-actJp-close.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">プラグマティックプレイの対象ゲームをプレイすれば、最大115,000ギフトマネーがもらえる。さらにベット金額1000倍のサプライス賞もあるよ！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(19,'/Activity/event/ne-rt/202212/index-jp.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/ne-rt/202212/img/Jp-img-act-close.jpg" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <div class="desc language_replace">
                                                ネットエント（NE）とレッドタイガー（RT）のゲームをプレイすれば、最大130,000のギフトマネーが貰えるよ！
                                            </div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(17,'/Activity/mahaEvent/11month.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/mahaEvent/src/11month-act-end.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <div class="desc language_replace">アカウント初入金に最大100,000 Ocoin還元</div>
                                        </div>

                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(16,'/Activity/event/bng/bng202210SP/index-jp.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/bng/bng202210SP/img/img-act-close.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <div class="desc language_replace">ブンーゴーの対象ゲーム（スティッキーピギー）をプレイすれば、最大160,000のギフトマネーがもらえる！</div>
                                        </div>                                     
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure> 
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(1,'/Activity/Act001/CenterPage/index.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/Act001/CenterPage/img/deposit-act-close.jpg" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">銀行振込の還元上限は2倍で、最大100,000 Ocoin！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(14,'/Activity/event/ne-rt/202210/index-jp.html')">
                                <!-- 活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/ne-rt/202210/img/Jp-img-act-close.jpg" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">
                                                ネットエント（NE）とレッドタイガー（RT）のゲームをプレイすれば、最大130,000のギフトマネーが貰えるよ！
                                            </div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(15,'/Activity/event/bng/bng202210GreenChilli/index-jp.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/bng/bng202210GreenChilli/img/img-act-end.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <div class="desc language_replace">ブンーゴーの対象ゲーム（グリーンチリ）をプレイすれば、最大160,000のギフトマネーがもらえる！</div>
                                        </div>
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(13,'/Activity/event/bng/bng221003MR/index-jp.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/bng/bng221003MR/img/img-act-end.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">
                                                ブンーゴーの対象ゲームをプレイすれば、最大360,000のギフトマネーがもらえる！
                                            </div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(10,'/Activity/event/bng/bng220919BH/index-jp.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/bng/bng220919BH/img/img-act-close.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">キャンペーン期間中にブン―ゴーの対象ゲームをプレイすれば、最大160,000のギフトマネーがもらえる！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(8,'/Activity/event/ne-rt/08222022/index-jp.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/ne-rt/08222022/img/img-act.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">ネットエント（NE）とレッドタイガー（RT）のゲームをプレイすれば、最大135,000のギフトマネーが貰えるよ！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(9,'/Activity/event/bng/09092022moonfestival/index-jp.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/bng/09092022moonfestival/img/img-act-end.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">ブンーゴーの対象ゲームをプレイすれば、最大360,000のギフトマネーがもらえる！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(2)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(4,'/Activity/event/pp-1/index-jp.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/pp-1/img/img-act.jpg" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">プラグマティックプレイの対象ゲームをプレイし、高いポジションを争い、高額ギフトマネー＆サプライズ賞を獲得！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(4)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(5,'/Activity/event/pp-2/index-jp.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/pp-2/img/img-live-act.jpg" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace"></figcaption> -->
                                            <div class="desc language_replace">プラグマティックプレイの対象ライブカジノをプレイし、高いポジションを争い、高額ギフトマネーを獲得！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(5)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="window.open('/Activity/event/bng/bng2207-2/index.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img class="" src="images/activity/BNG-actionList-act.jpg">
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">マハラジャは出血覚悟で平和祈願ボーナズ！毎回最大100,000 Ocoin</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="activityBtnClick(6)" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                        <figure class="activity-item">
                            <div class="activity-item-inner" onclick="GoActivityDetail(6,'/Activity/event/bng/bng2207/index.html')">
                                <!-- 結束活動連結 -->
                                <div class="activity-item-link" data-toggle="modal">
                                    <div class="img-wrap">
                                        <img src="Activity/event/bng/bng2207/img/actList-img.jpg" />
                                    </div>
                                    <div class="info">
                                        <div class="detail">
                                            <!-- <figcaption class="title language_replace">金熱門！</figcaption> -->
                                            <div class="desc language_replace">この狛犬大吉と一緒にBNGの周年記念キャンペーンに参加するぞ！対象ゲームで100ラウンドベットして、ポイントの高い人はボーナスが多くもらえるぞ！</div>
                                        </div>
                                        <!-- 活動詳情 Popup-->
                                        <!-- <button type="button" onclick="GoActivityDetail(6,'/Activity/event/bng/bng2207/index.html')" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button> -->
                                        <button type="button" class="btn-popup btn btn-full-main"><span class="language_replace">立即確認</span></button>
                                    </div>
                                </div>
                            </div>
                        </figure>
                    </div>
                </section>
            </div>
        </div>
    </main>

    <!-- Modal -->
    <div class="modal fade footer-center" id="ModalTest" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title">我是標題</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub is-hide" onclick="window.parent.API_LoadPage('Prize','Prize.aspx')">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary is-hide" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDailylogin-->
    <div class="modal fade footer-center" id="ModalDailylogin" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">金曜日的禮物</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary language_replace" onclick="window.parent.API_LoadPage('Casino', 'Casino.aspx', false)">開始洗碼</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub is-hide" onclick="window.parent.API_LoadPage('Prize','Prize.aspx')">領取獎勵</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary is-hide" disabled>領取獎勵</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit-->
    <div class="modal fade footer-center" id="ModalDeposit" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">十一月限定入金キャンペーン</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub language_replace" onclick="window.parent.API_LoadPage('Deposit','Deposit.aspx', true)">前往入金</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit12 (December入金活動) -->
    <div class="modal fade footer-center" id="ModalDeposit12" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">十二月限定入金キャンペーン</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub language_replace" onclick="window.parent.API_LoadPage('Deposit','Deposit.aspx', true)">前往入金</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit12 (December入金活動) -->
    <div class="modal fade footer-center" id="ModalDeposit2301" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">一月限定入金キャンペーン</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub language_replace" onclick="window.parent.API_LoadPage('Deposit','Deposit.aspx', true)">前往入金</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit12 (December入金活動) -->
    <div class="modal fade footer-center" id="ModalDeposit2302" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">二月限定入金キャンペーン</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub language_replace" onclick="window.parent.API_LoadPage('Deposit','Deposit.aspx', true)">前往入金</button>
                </div>
            </div>
        </div>
    </div>
    <!-- Modal - ModalDeposit-->
    <div class="modal fade footer-center" id="ModalRegister" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace">MAHARAJA見面禮</h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary language_replace" onclick="window.parent.API_LoadPage('Prize','Prize.aspx')">參加活動</button>

                    <!--獎勵可領取-->
                    <button type="button" class="btn btn-full-sub is-hide language_replace" onclick="window.parent.API_LoadPage('Prize','Prize.aspx')">參加活動</button>

                    <!--獎勵不可領取-->
                    <button type="button" class="btn btn-secondary is-hide language_replace" disabled>參加活動</button>
                </div>
            </div>
        </div>
    </div>

    <div class="modal fade footer-center" id="TempModal" tabindex="-1" aria-hidden="true">
        <div class="modal-dialog modal-lg modal-dialog-centered modal-dialog-scrollable">
            <div class="modal-content">
                <div class="modal-header">
                    <h5 class="modal-title language_replace"></h5>
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close">
                        <span aria-hidden="true">&times;</span>
                    </button>
                </div>
                <div class="modal-body">
                    <article class="activity-popup-detail-wrapper">
                        <div class="activity-popup-detail-inner">
                        </div>
                    </article>
                </div>
                <div class="modal-footer">
                    <button type="button" class="btn btn-primary language_replace btnGoActivity">參加活動</button>
                </div>
            </div>
        </div>
    </div>
    <script type="text/javascript" src="https://rt.gsspat.jp/e/conversion/lp.js?ver=2"></script>
</body>

</html>
