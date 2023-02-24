using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class GetAgentAccountingDetail_Casino : System.Web.UI.Page {
   
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.AgentAccountingDetailResult GetAgentAccountingDetail(string AID, string CurrencyType, int AccountingID) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.AgentAccountingDetailResult RetValue = new EWin.OcwAgent.AgentAccountingDetailResult();

        RetValue = api.GetAgentAccountingDetail(AID, CurrencyType, AccountingID);

        return RetValue;
    }
}