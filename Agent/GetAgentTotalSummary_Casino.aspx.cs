using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class GetAgentTotalSummary_Casino : System.Web.UI.Page {
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.TotalSummaryResult GetAgentTotalOrderSummary(string AID, string LoginAccount, DateTime QueryBeginDate, DateTime QueryEndDate, string CurrencyType) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.TotalSummaryResult RetValue = new EWin.OcwAgent.TotalSummaryResult();

        RetValue = api.GetAgentTotalOrderSummary(AID, LoginAccount, QueryBeginDate, QueryEndDate, CurrencyType);

        return RetValue;
    }
}