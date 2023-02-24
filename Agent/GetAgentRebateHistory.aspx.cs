using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class Agent_GetAgentRebateHistory : System.Web.UI.Page {
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.OrderSummaryResult GetOrderSummary(string AID, string QueryBeginDate, string QueryEndDate, string CurrencyType) {
        EWin.OcwAgent.OrderSummaryResult RetValue = null;
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();

        RetValue = api.GetOrderSummary(AID, QueryBeginDate, QueryEndDate, CurrencyType);

        return RetValue;
    }
}