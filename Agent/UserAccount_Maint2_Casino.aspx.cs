using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class UserAccount_Maint2_Casino : System.Web.UI.Page {
    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.UserAccountSummaryResult GetUserAccountSummary(string AID, string LoginAccount, DateTime QueryBeginDate, DateTime QueryEndDate, string CurrencyType) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.UserAccountSummaryResult RetValue = new EWin.OcwAgent.UserAccountSummaryResult();

        RetValue = api.GetUserAccountSummary(AID, LoginAccount, QueryBeginDate, QueryEndDate, CurrencyType);

        return RetValue;
    }
}