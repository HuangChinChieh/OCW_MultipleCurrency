<%@ Page Language="C#" AutoEventWireup="true" CodeFile="GetAgentRebateHistory.aspx.cs" Inherits="Agent_GetAgentRebateHistory" %>

<%
    string ASID = Request["ASID"];
    string DefaultCompany = "";
    string DefaultCurrencyType = "";
    int UserAccountID = 0;
    string AgentVersion = EWinWeb.AgentVersion;
    EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
    EWin.OcwAgent.AgentSessionResult ASR = null;
    EWin.OcwAgent.AgentSessionInfo ASI = null;

    ASR = api.GetAgentSessionByID(ASID);

    if (ASR.Result != EWin.OcwAgent.enumResult.OK) {
        if (string.IsNullOrEmpty(DefaultCompany) == false) {
            Response.Redirect("login.aspx?C=" + DefaultCompany);
        } else {
            Response.Redirect("login.aspx");
        }
    } else {
        ASI = ASR.AgentSessionInfo;
        DefaultCompany = EWinWeb.CompanyCode;
        DefaultCurrencyType = EWinWeb.MainCurrencyType;
        UserAccountID = ASI.UserAccountID;
    }

%>
<!doctype html>
<html lang="zh-Hant-TW" class="innerHtml">
<head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="ie=edge">
    <title>投注記錄</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="css/basic.min.css?<%=AgentVersion %>">
    <link rel="stylesheet" href="css/main2.css?<%=AgentVersion %>">
</head>
<!-- <script type="text/javascript" src="js/AgentCommon.js"></script> -->
<script type="text/javascript" src="js/AgentCommon.js"></script>
<script type="text/javascript" src="/Scripts/Common.js"></script>
<script type="text/javascript" src="/Scripts/bignumber.min.js"></script>
<script type="text/javascript" src="/Scripts/Math.uuid.js"></script>
<script type="text/javascript" src="Scripts/MultiLanguage.js"></script>
<script type="text/javascript" src="js/date.js"></script>
<script src="js/jquery-3.3.1.min.js"></script>
<script>
    var ApiUrl = "GetAgentRebateHistory.aspx";
    var c = new common();
    var ac = new AgentCommon();
    var mlp;
    var EWinInfo;
    var api;
    var lang;
    var qYear;
    var qMon;
    var SearchCurrencyType = "<%=DefaultCurrencyType%>";
    var UserAccountID = "<%=UserAccountID%>";
    var TotalLineRebate = 0;

    function queryData() {
        var CurrencyType = $("input[name='chkCurrencyType']").val();
        var startDate = $('#startDate').val();
        var endDate = $('#endDate').val();
        var postData = {
            AID: EWinInfo.ASID,
            CurrencyType: CurrencyType,
            QueryBeginDate: startDate,
            QueryEndDate: endDate
        };
        
        window.parent.API_ShowLoading();
        c.callService(ApiUrl + "/GetOrderSummary", postData, function (success, o) {
            if (success) {
                var obj = c.getJSON(o);

                if (obj.Result == 0) {
                    updateList(obj);
                } else {
                    window.parent.API_ShowMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey(obj.Message));
                }
            } else {
                if (o == "Timeout") {
                    window.parent.API_ShowMessageOK(mlp.getLanguageKey("錯誤"), mlp.getLanguageKey("網路異常, 請稍後重新嘗試"));
                } else {
                    window.parent.API_ShowMessageOK(mlp.getLanguageKey("錯誤"), o);
                }
            }

            window.parent.API_CloseLoading();
        });

    }

    function updateList(o) {
        $('#idList').empty();
        $('#idList').removeClass('tbody__hasNoData');

        if (o != null) {
            if (o.AgentItemList != null && o.AgentItemList.length > 0) {
                //只顯示個人投注
                for (var i = 0; i < o.AgentItemList.length; i++) {
                    var item = o.AgentItemList[i];

                    createitem(item.Summary, item.ParentLoginAccount);
                }
            } else {
                $('#idList').append('<div class="td__content td__hasNoData">' + mlp.getLanguageKey("無數據") + '</div>');
                $('#idList').addClass('tbody__hasNoData');
            }
        } else {
            $('#idList').append('<div class="td__content td__hasNoData">' + mlp.getLanguageKey("無數據") + '</div>');
            $('#idList').addClass('tbody__hasNoData');
        }
    }

    function createitem(item, ParentLoginAccount) {
        var idList = document.getElementById("idList");
        var t = c.getTemplate("templateTableItem");
        var childitems = item.ChildUser;

        c.setClassText(t, "LoginAccount", null, item.LoginAccount);
        c.setClassText(t, "ParentLoginAccount", null, ParentLoginAccount);
        c.setClassText(t, "InsideLevelBySelf", null, item.UserAccountInsideLevel);

        switch (item.UserAccountType) {
            case 0:
                c.setClassText(t, "UserAccountType", null, mlp.getLanguageKey("一般帳戶"));
                break;
            case 1:
                c.setClassText(t, "UserAccountType", null, mlp.getLanguageKey("代理"));
                break;
            case 2:
                c.setClassText(t, "UserAccountType", null, mlp.getLanguageKey("股東"));
                break;
        }

        c.setClassText(t, "UserRate", null, item.UserRate + "%");
        if ((item.BuyChipRateExt != null) && (item.BuyChipRateExt != 0)) {
            c.setClassText(t, "BuyChipRate", null, item.BuyChipRate + "%+" + item.BuyChipRateExt + "%");
        } else {
            c.setClassText(t, "BuyChipRate", null, item.BuyChipRate + "%");
        }

        if (item.TotalRewardValue != undefined) {
            if (parseFloat(item.TotalRewardValue) < 0) {
                t.getElementsByClassName("TotalRewardValue")[0].classList.add("num-negative");
            }
            c.setClassText(t, "TotalRewardValue", null, c.toCurrency(parseInt(item.TotalRewardValue)));
        } else {
            c.setClassText(t, "TotalRewardValue", null, 0);
        }

        if (item.TotalValidBetValue != undefined) {
            if (parseFloat(item.TotalValidBetValue) < 0) {
                t.getElementsByClassName("TotalValidBetValue")[0].classList.add("num-negative");
            }
            c.setClassText(t, "TotalValidBetValue", null, c.toCurrency(parseInt(item.TotalValidBetValue)));
        } else {
            c.setClassText(t, "TotalValidBetValue", null, 0);
        }

        if (item.CommissionValue != undefined) {
            if (parseFloat(item.CommissionValue) < 0) {
                t.getElementsByClassName("TotalCommissionValue")[0].classList.add("num-negative");
            }
            c.setClassText(t, "TotalCommissionValue", null, c.toCurrency(parseInt(item.CommissionValue)));
        } else {
            c.setClassText(t, "TotalCommissionValue", null, 0);
        }

        if (item.UplineCommissionUserRateValue != undefined) {
            if (parseFloat(item.UplineCommissionUserRateValue) < 0) {
                t.getElementsByClassName("UpLineCommissionUserRateValue")[0].classList.add("num-negative");
            }
            c.setClassText(t, "UpLineCommissionUserRateValue", null, c.toCurrency(parseInt(item.UplineCommissionUserRateValue)));
        } else {
            c.setClassText(t, "UpLineCommissionUserRateValue", null, 0);
        }

        if (item.BonusPointValue != undefined) {
            if (parseFloat(item.BonusPointValue) < 0) {
                t.getElementsByClassName("TotalBonusPointValue")[0].classList.add("num-negative");
            }
            c.setClassText(t, "TotalBonusPointValue", null, c.toCurrency(parseInt(item.BonusPointValue)));
        } else {
            c.setClassText(t, "TotalBonusPointValue", null, 0);
        }

        if (item.CostValue != undefined) {
            if (parseFloat(item.CostValue) < 0) {
                t.getElementsByClassName("TotalCostValue")[0].classList.add("num-negative");
            }
            c.setClassText(t, "TotalCostValue", null, c.toCurrency(parseInt(item.CostValue)));
        } else {
            c.setClassText(t, "TotalCostValue", null, 0);
        }

        if (item.TotalNGR != undefined) {
            if (parseFloat(item.TotalNGR) < 0) {
                t.getElementsByClassName("TotalNGR")[0].classList.add("num-negative");
            }
            c.setClassText(t, "TotalNGR", null, c.toCurrency(parseInt(item.TotalNGR)));
        } else {
            c.setClassText(t, "TotalNGR", null, 0);
        }

        if (item.TotalLineRebate != undefined) {
            if (parseFloat(item.TotalLineRebate) < 0) {
                t.getElementsByClassName("TotalLineRebate")[0].classList.add("num-negative");
            }
            c.setClassText(t, "TotalLineRebate", null, c.toCurrency(parseInt(item.TotalLineRebate)));
        } else {
            c.setClassText(t, "TotalLineRebate", null, 0);
            TotalLineRebate = 0;
        }

        if (item.UserCommissionProfit != undefined) {
            if (parseFloat(item.UserCommissionProfit) < 0) {
                t.getElementsByClassName("UserCommissionProfit")[0].classList.add("num-negative");
            }
            c.setClassText(t, "UserCommissionProfit", null, c.toCurrency(parseInt(item.UserCommissionProfit)));
        } else {
            c.setClassText(t, "UserCommissionProfit", null, 0);
        }

        if (item.PaidOPValue != undefined) {
            if (parseFloat(item.PaidOPValue) < 0) {
                t.getElementsByClassName("UserOPValue")[0].classList.add("num-negative");
            }
            c.setClassText(t, "UserOPValue", null, c.toCurrency(parseInt(item.PaidOPValue)));
        } else {
            c.setClassText(t, "UserOPValue", null, 0);
        }

        if (item.UserRebate != undefined) {
            if (parseFloat(item.UserRebate - item.PaidOPValue) < 0) {
                t.getElementsByClassName("UserRebate")[0].classList.add("num-negative");
            }
            c.setClassText(t, "UserRebate", null, c.toCurrency(parseInt(item.UserRebate - item.PaidOPValue)));

            //TotalLineRebate = parseFloat(TotalLineRebate) + parseFloat(item.UserRebate - item.PaidOPValue);
            //document.getElementById("totalCommission").innerText = TotalLineRebate;
        } else {
            c.setClassText(t, "UserRebate", null, 0);
        }

        t.style.display = "";
        idList.appendChild(t);

        if (childitems) {
            if (childitems.length > 0) {
                createChilditem(childitems, item.LoginAccount);
            }
        }
    }

    function createChilditem(items, parentLoginAccount) {
        var type = 0;
        var typeDoms = document.getElementsByName("type");

        if (typeDoms) {
            if (typeDoms.length > 0) {
                for (i = 0; i < typeDoms.length; i++) {
                    if (typeDoms[i].checked == true) {
                        type = typeDoms[i].value;

                        break;
                    }
                }
            }
        }


        for (var i = 0; i < items.length; i++) {
            var item = items[i];
            var t = c.getTemplate("templateTableItem");
            var childitems = item.ChildDetail;

            var idList = document.getElementById("idList");
            var t = c.getTemplate("templateTableItem");
            var childitems = item.ChildUser;

            c.setClassText(t, "LoginAccount", null, item.LoginAccount);
            c.setClassText(t, "ParentLoginAccount", null, parentLoginAccount);
            c.setClassText(t, "InsideLevelBySelf", null, item.UserAccountInsideLevel);

            switch (item.UserAccountType) {
                case 0:
                    c.setClassText(t, "UserAccountType", null, mlp.getLanguageKey("一般帳戶"));
                    break;
                case 1:
                    c.setClassText(t, "UserAccountType", null, mlp.getLanguageKey("代理"));
                    break;
                case 2:
                    c.setClassText(t, "UserAccountType", null, mlp.getLanguageKey("股東"));
                    break;
            }

            c.setClassText(t, "UserRate", null, item.UserRate + "%");

            if ((item.BuyChipRateExt != null) && (item.BuyChipRateExt != 0)) {
                c.setClassText(t, "BuyChipRate", null, item.BuyChipRate + "%+" + item.BuyChipRateExt + "%");
            } else {
                c.setClassText(t, "BuyChipRate", null, item.BuyChipRate + "%");
            }

            if (item.TotalRewardValue != undefined) {
                if (parseFloat(item.TotalRewardValue) < 0) {
                    t.getElementsByClassName("TotalRewardValue")[0].classList.add("num-negative");
                }
                c.setClassText(t, "TotalRewardValue", null, c.toCurrency(parseInt(item.TotalRewardValue)));
            } else {
                c.setClassText(t, "TotalRewardValue", null, 0);
            }

            if (item.TotalValidBetValue != undefined) {
                if (parseFloat(item.TotalValidBetValue) < 0) {
                    t.getElementsByClassName("TotalValidBetValue")[0].classList.add("num-negative");
                }
                c.setClassText(t, "TotalValidBetValue", null, c.toCurrency(parseInt(item.TotalValidBetValue)));
            } else {
                c.setClassText(t, "TotalValidBetValue", null, 0);
            }

            if (item.CommissionValue != undefined) {
                if (parseFloat(item.CommissionValue) < 0) {
                    t.getElementsByClassName("TotalCommissionValue")[0].classList.add("num-negative");
                }
                c.setClassText(t, "TotalCommissionValue", null, c.toCurrency(parseInt(item.CommissionValue)));
            } else {
                c.setClassText(t, "TotalCommissionValue", null, 0);
            }

            if (item.UplineCommissionUserRateValue != undefined) {
                if (parseFloat(item.UplineCommissionUserRateValue) < 0) {
                    t.getElementsByClassName("UpLineCommissionUserRateValue")[0].classList.add("num-negative");
                }
                c.setClassText(t, "UpLineCommissionUserRateValue", null, c.toCurrency(parseInt(item.UplineCommissionUserRateValue)));
            } else {
                c.setClassText(t, "UpLineCommissionUserRateValue", null, 0);
            }

            if (item.BonusPointValue != undefined) {
                if (parseFloat(item.BonusPointValue) < 0) {
                    t.getElementsByClassName("TotalBonusPointValue")[0].classList.add("num-negative");
                }
                c.setClassText(t, "TotalBonusPointValue", null, c.toCurrency(parseInt(item.BonusPointValue)));
            } else {
                c.setClassText(t, "TotalBonusPointValue", null, 0);
            }

            if (item.CostValue != undefined) {
                if (parseFloat(item.CostValue) < 0) {
                    t.getElementsByClassName("TotalCostValue")[0].classList.add("num-negative");
                }
                c.setClassText(t, "TotalCostValue", null, c.toCurrency(parseInt(item.CostValue)));
            } else {
                c.setClassText(t, "TotalCostValue", null, 0);
            }

            if (item.TotalNGR != undefined) {
                if (parseFloat(item.TotalNGR) < 0) {
                    t.getElementsByClassName("TotalNGR")[0].classList.add("num-negative");
                }
                c.setClassText(t, "TotalNGR", null, c.toCurrency(parseInt(item.TotalNGR)));
            } else {
                c.setClassText(t, "TotalNGR", null, 0);
            }

            if (item.TotalLineRebate != undefined) {
                if (parseFloat(item.TotalLineRebate) < 0) {
                    t.getElementsByClassName("TotalLineRebate")[0].classList.add("num-negative");
                }
                c.setClassText(t, "TotalLineRebate", null, c.toCurrency(parseInt(item.TotalLineRebate)));
            } else {
                c.setClassText(t, "TotalLineRebate", null, 0);
            }

            if (item.UserCommissionProfit != undefined) {
                if (parseFloat(item.UserCommissionProfit) < 0) {
                    t.getElementsByClassName("UserCommissionProfit")[0].classList.add("num-negative");
                }
                c.setClassText(t, "UserCommissionProfit", null, c.toCurrency(parseInt(item.UserCommissionProfit)));
            } else {
                c.setClassText(t, "UserCommissionProfit", null, 0);
            }

            if (item.PaidOPValue != undefined) {
                if (parseFloat(item.PaidOPValue) < 0) {
                    t.getElementsByClassName("UserOPValue")[0].classList.add("num-negative");
                }
                c.setClassText(t, "UserOPValue", null, c.toCurrency(parseInt(item.PaidOPValue)));
            } else {
                c.setClassText(t, "UserOPValue", null, 0);
            }

            if (item.UserRebate != undefined) {
                if (parseFloat(item.UserRebate - item.PaidOPValue) < 0) {
                    t.getElementsByClassName("UserRebate")[0].classList.add("num-negative");
                }
                c.setClassText(t, "UserRebate", null, c.toCurrency(parseInt(item.UserRebate - item.PaidOPValue)));
            } else {
                c.setClassText(t, "UserRebate", null, 0);
            }

            t.style.display = "";
            idList.appendChild(t);

            if (type != 0) {
                if (childitems) {
                    if (childitems.length > 0) {
                        createChilditem(childitems, item.LoginAccount);
                    }
                }
            }
        }
    }
    
    function setSearchFrame() {
        var pi = null;
        var templateDiv;
        var CurrencyTypeDiv = document.getElementById("CurrencyTypeDiv");
        var tempCurrencyRadio;
        var tempCurrencyName;


        document.getElementById("startDate").value = getFirstDayOfWeek(Date.today()).toString("yyyy-MM-dd");
        document.getElementById("endDate").value = getLastDayOfWeek(Date.today()).toString("yyyy-MM-dd");

        if (EWinInfo.UserInfo != null) {
            if (EWinInfo.UserInfo.WalletList != null) {
                pi = EWinInfo.UserInfo.WalletList;
                if (pi.length > 0) {
                    for (var i = 0; i < pi.length; i++) {
                        templateDiv = c.getTemplate("templateDiv");

                        tempCurrencyRadio = c.getFirstClassElement(templateDiv, "tempRadio");
                        tempCurrencyName = c.getFirstClassElement(templateDiv, "tempName");
                        tempCurrencyRadio.value = pi[i].CurrencyType;
                        tempCurrencyRadio.name = "chkCurrencyType";
                        tempCurrencyName.innerText = pi[i].CurrencyType;

                        if (i == 0) {
                            tempCurrencyRadio.checked = true;
                        }

                        tempCurrencyRadio.classList.remove("tempRadio");
                        tempCurrencyName.classList.remove("tempName");

                        CurrencyTypeDiv.appendChild(templateDiv);
                    }
                }
            }
        }

        queryData();
    }

    function changeDateTab(e, type) {
        window.event.stopPropagation();
        window.event.preventDefault();

        var tabMainContent = document.getElementById("idTabMainContent");
        var tabItem = tabMainContent.getElementsByClassName("nav-link");
        for (var i = 0; i < tabItem.length; i++) {
            tabItem[i].classList.remove('active');
            tabItem[i].parentNode.classList.remove('active');

            tabItem[i].setAttribute("aria-selected", "false");

        }

        e.parentNode.classList.add('active');
        e.classList.add('active');
        e.setAttribute("aria-selected", "true");
        switch (type) {
            case 0:
                startDate = Date.today().toString("yyyy-MM-dd");
                endDate = Date.today().toString("yyyy-MM-dd");
                document.getElementById("startDate").value = startDate;
                document.getElementById("endDate").value = endDate;
                break;
            case 1:
                startDate = Date.today().addDays(-1).toString("yyyy-MM-dd");
                endDate = Date.today().addDays(-1).toString("yyyy-MM-dd");
                document.getElementById("startDate").value = startDate;
                document.getElementById("endDate").value = endDate;
                break;
            case 2:
                startDate = getFirstDayOfWeek(Date.today()).toString("yyyy-MM-dd");
                endDate = getLastDayOfWeek(Date.today()).toString("yyyy-MM-dd");
                document.getElementById("startDate").value = startDate;
                document.getElementById("endDate").value = endDate;
                break;
            case 3:
                startDate = getFirstDayOfWeek(Date.today().addDays(-7)).toString("yyyy-MM-dd");
                endDate = getLastDayOfWeek(Date.today().addDays(-7)).toString("yyyy-MM-dd");
                document.getElementById("startDate").value = startDate;
                document.getElementById("endDate").value = endDate;
                break;
            case 4:
                startDate = Date.today().moveToFirstDayOfMonth().toString("yyyy-MM-dd");
                endDate = Date.today().moveToLastDayOfMonth().toString("yyyy-MM-dd");
                document.getElementById("startDate").value = startDate;
                document.getElementById("endDate").value = endDate;
                break;
            case 5:
                startDate = Date.today().addMonths(-1).moveToFirstDayOfMonth().toString("yyyy-MM-dd");
                endDate = Date.today().addMonths(-1).moveToLastDayOfMonth().toString("yyyy-MM-dd");
                document.getElementById("startDate").value = startDate;
                document.getElementById("endDate").value = endDate;
                break;
        }
    }

    function getFirstDayOfWeek(d) {
        let date = new Date(d);
        let day = date.getDay();

        let diff = date.getDate() - day + (day === 0 ? -6 : 1);

        return new Date(date.setDate(diff));
    }

    function getLastDayOfWeek(d) {
        let firstDay = getFirstDayOfWeek(d);
        let lastDay = new Date(firstDay);

        return new Date(lastDay.setDate(lastDay.getDate() + 6));
    }

    function init() {

        EWinInfo = window.parent.EWinInfo;
        api = window.parent.API_GetAgentAPI();
        setSearchFrame();

        lang = window.localStorage.getItem("agent_lang");
        mlp = new multiLanguage();
        mlp.loadLanguage(lang, function () {
            window.parent.API_CloseLoading();
        });
    }

    window.onload = init;
</script>
<body class="innerBody">
    <main>
        <div class="dataList dataList-box fixed top real-fixed">
            <div class="container-fluid">
                <div class="collapse-box">
                    <h2 class="collapse-header has-arrow zIndex_overMask_SafariFix" onclick="ac.dataToggleCollapse(this)" data-toggle="collapse" data-target="#searchList" aria-controls="searchList" aria-expanded="true" aria-label="searchList">
                        <span class="language_replace">即時佣金報表</span>
                        <i class="arrow"></i>
                    </h2>
                    <!-- collapse內容 由此開始 ========== -->
                    <div id="searchList" class="collapse-content collapse show">
                        <div id="divSearchContent" class="row searchListContent">
                            <div class="col-12 col-md-6 col-lg-4 col-xl-auto">
                                <!-- 起始日期 / 結束日期 -->
                                <div class="form-group search_date">
                                    <div class="starDate">
                                        <div class="title"><span class="language_replace">起始日期</span></div>

                                        <div class="form-control-default">
                                            <input id="startDate" type="date" class="form-control custom-date">
                                            <label for="" class="form-label"><i class="icon icon2020-calendar-o"></i></label>
                                            <%--<input id="startDateChk" type="checkbox" style="position:relative;opacity:0.5;width:50px;height:50px;top:-30px">--%>
                                        </div>

                                    </div>
                                    <div class="endDate">
                                        <div class="title"><span class="language_replace">結束日期</span></div>
                                        <div class="form-control-default">
                                            <input id="endDate" type="date" class="form-control custom-date">
                                            <label for="" class="form-label"><i class="icon icon2020-calendar-o"></i></label>
                                        </div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 col-md-6 col-lg-4 col-xl-4">
                                <div id="idTabMainContent">
                                    <ul class="nav-tabs-block nav nav-tabs tab-items-6" role="tablist">
                                        <li class="nav-item active">
                                            <a onclick="changeDateTab(this,0)" class="nav-link active language_replace" data-toggle="tab" href="" role="tab" aria-selected="true">本日</a>
                                        </li>
                                        <li class="nav-item">
                                            <a onclick="changeDateTab(this,1)" class="nav-link language_replace" data-toggle="tab" href="" role="tab" aria-selected="true">昨天</a>
                                        </li>
                                        <li class="nav-item">
                                            <a onclick="changeDateTab(this,2)" class="nav-link language_replace" data-toggle="tab" href="" role="tab" aria-selected="true">本週</a>
                                        </li>
                                        <li class="nav-item">
                                            <a onclick="changeDateTab(this,3)" class="nav-link language_replace" data-toggle="tab" href="" role="tab" aria-selected="true">上週</a>
                                        </li>
                                        <li class="nav-item">
                                            <a onclick="changeDateTab(this,4)" class="nav-link language_replace" data-toggle="tab" href="" role="tab" aria-selected="true">本月</a>
                                        </li>
                                        <li class="nav-item">
                                            <a onclick="changeDateTab(this,5)" class="nav-link language_replace" data-toggle="tab" href="" role="tab" aria-selected="true">上月</a>
                                        </li>
                                        <li class="tab-slide"></li>
                                    </ul>
                                </div>
                            </div>

                            <div class="col-12 col-md-6 col-lg-4 col-xl-auto" style="display: none">
                                <!-- 幣別 -->
                                <div class="form-group form-group-s2 ">
                                    <div class="title"><span class="language_replace">幣別</span></div>
                                    <div id="CurrencyTypeDiv" class="content">
                                    </div>
                                </div>

                                <div id="templateDiv" style="display: none">
                                    <div class="custom-control custom-checkboxValue custom-control-inline check-bg">
                                        <label class="custom-label">
                                            <input type="radio" class="custom-control-input-hidden tempRadio">
                                            <div class="custom-input checkbox"><span class="language_replace tempName">Non</span></div>
                                        </label>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12 col-md-6 col-lg-4 col-xl-auto" style="display:none">
                                <!-- 模式 -->
                                <div class="form-group form-group-s2 ">
                                    <div class="title"><span class="language_replace">總應得佣金</span></div>
                                    <div class="content">
                                        <div><span class="language_replace" id="totalCommission">0</span></div>
                                    </div>
                                </div>
                            </div>

                            <div class="col-12">
                                <div class="form-group wrapper_center dataList-process">
                                    <%--<button class="btn btn-outline-main" onclick="MaskPopUp(this)">取消</button>--%>
                                    <button class="btn btn-full-main btn-roundcorner " onclick="queryData()"><i class="icon icon-before icon-ewin-input-submit"></i><span class="language_replace">確認</span></button>
                                </div>
                            </div>
                            <!-- iOS Safari Virtual Keyboard Fix--------------->
                            <div id="div_MaskSafariFix" class="mask_Input_Safari" onclick="clickMask()"></div>
                        </div>
                    </div>
                </div>
            </div>
        </div>


        <!-- 表格 由此開始 ========== -->
        <div class="container-fluid wrapper__TopCollapse orderHistory_userAccount">
            <div class="MT__tableDiv" id="idResultTable">
                <!-- 自訂表格 -->
                <div class="MT__table table-col-8 w-200">
                    <div id="templateTableItem" style="display: none">
                        <div class="tbody__tr td-non-underline-last-2">
                            <div class="tbody__td date td-100 nonTitle">
                                <span class="td__title"><span class="language_replace">帳號</span></span>
                                <span class="td__content"><span class="LoginAccount">CON5</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">上線帳號</span></span>
                                <span class="td__content"><span class="ParentLoginAccount">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">層級</span></span>
                                <span class="td__content"><span class="InsideLevelBySelf">CON4</span></span>
                            </div>
                            <div class="tbody__td td-3 nonTitle">
                                <span class="td__title"><span class="language_replace">帳戶類型</span></span>
                                <span class="td__content"><i class="icon icon-ewin-default-currencyType icon-s icon-before"></i><span class="UserAccountType">CON3</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-totalWinLose icon-s icon-before"></i><span class="language_replace">帳戶佔成率</span></span>
                                <span class="td__content"><span class="UserRate">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-totalWinLose icon-s icon-before"></i><span class="language_replace">帳戶洗碼率</span></span>
                                <span class="td__content"><span class="BuyChipRate">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">總上下數</span></span>
                                <span class="td__content"><span class="TotalRewardValue">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">總洗碼數</span></span>
                                <span class="td__content"><span class="TotalValidBetValue">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">總洗碼佣金</span></span>
                                <span class="td__content"><span class="TotalCommissionValue">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical" style="display: none">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">上線洗碼佣金提供</span></span>
                                <span class="td__content"><span class="UpLineCommissionUserRateValue">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">總紅利</span></span>
                                <span class="td__content"><span class="TotalBonusPointValue">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">總費用</span></span>
                                <span class="td__content"><span class="TotalCostValue">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">總 NGR</span></span>
                                <span class="td__content"><span class="TotalNGR">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">總線佣金</span></span>
                                <span class="td__content"><span class="TotalLineRebate">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">個人洗碼佣金利潤</span></span>
                                <span class="td__content"><span class="UserCommissionProfit">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">個人已付佣金</span></span>
                                <span class="td__content"><span class="UserOPValue">CON4</span></span>
                            </div>
                            <div class="tbody__td td-number td-3 td-vertical">
                                <span class="td__title"><i class="icon icon-ewin-default-accountWinLose icon-s icon-before"></i><span class="language_replace">代理個人佣金</span></span>
                                <span class="td__content"><span class="UserRebate">CON4</span></span>
                            </div>

                        </div>
                    </div>
                    <!-- 標題項目  -->
                    <div class="thead">
                        <!--標題項目單行 -->
                        <div class="thead__tr">
                            <div class="thead__th"><span class="language_replace">帳號</span></div>
                            <div class="thead__th"><span class="language_replace">上線帳號</span></div>
                            <div class="thead__th"><span class="language_replace">層級</span></div>
                            <div class="thead__th"><span class="language_replace">帳戶類型</span></div>
                            <div class="thead__th"><span class="language_replace">帳戶佔成率</span></div>
                            <div class="thead__th"><span class="language_replace">帳戶洗碼率</span></div>
                            <div class="thead__th"><span class="language_replace">總上下數</span></div>
                            <div class="thead__th"><span class="language_replace">總洗碼數</span></div>
                            <div class="thead__th"><span class="language_replace">總洗碼佣金</span></div>
                            <div class="thead__th" style="display: none"><span class="language_replace">上線洗碼佣金提供</span></div>
                            <div class="thead__th"><span class="language_replace">總紅利</span></div>
                            <div class="thead__th"><span class="language_replace">總費用</span></div>
                            <div class="thead__th"><span class="language_replace">總 NGR</span></div>
                            <div class="thead__th"><span class="language_replace">總線佣金</span></div>
                            <div class="thead__th"><span class="language_replace">個人洗碼佣金利潤</span></div>
                            <div class="thead__th"><span class="language_replace">個人已付佣金</span></div>
                            <div class="thead__th"><span class="language_replace">代理個人佣金</span></div>
                        </div>
                    </div>
                    <!-- 表格上下滑動框 -->
                    <div class="tbody" id="idList">
                    </div>
                </div>
            </div>
        </div>
    </main>
</body>
<script type="text/javascript">
    ac.listenScreenMove();

    function clickMask() {
        // document.getElementById("div_MaskSafariFix").style.display = "none";
        document.getElementById("div_MaskSafariFix").classList.remove("show");
    }
</script>
</html>
