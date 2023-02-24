using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class GetAgentAccounting_Casino : System.Web.UI.Page {
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.AccountingResult GetAccountingItem(string AID, string StartDate,string EndDate,string CurrencyType) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.AccountingResult RetValue = new EWin.OcwAgent.AccountingResult();

        RetValue = api.GetAccountingItem(AID, StartDate, EndDate, CurrencyType);

        return RetValue;
    }
}