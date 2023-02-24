using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;
using System.Data;

public partial class home_Casino : System.Web.UI.Page { 

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.ChidUserData GetChildUserData(string AID) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.ChidUserData RetValue = new EWin.OcwAgent.ChidUserData();

        RetValue = api.GetChildUserData(AID);

        return RetValue;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.OrderSummaryResult GetOrderSummary(string AID, string QueryBeginDate, string QueryEndDate, string CurrencyType) {
        EWin.OcwAgent.OrderSummaryResult RetValue = null;
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();

        RetValue = api.GetOrderSummary(AID, QueryBeginDate, QueryEndDate, CurrencyType);

        return RetValue;
    }
}