using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;
using System.Text.RegularExpressions;

public partial class Agent_UserAccount_Search_Casino : System.Web.UI.Page {

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.ChildUserInfoResult QueryChildUserInfo(string AID) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.ChildUserInfoResult RetValue = new EWin.OcwAgent.ChildUserInfoResult();

        RetValue = api.QueryChildUserInfo(AID);

        return RetValue;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.ChildUserInfoResult QueryCurrentUserInfo(string AID, string LoginAccount) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.ChildUserInfoResult RetValue = new EWin.OcwAgent.ChildUserInfoResult();

        RetValue = api.QueryCurrentUserInfoForSearchPage(AID, LoginAccount);

        return RetValue;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.APIResult UpdateUserAccountNote(string AID, int UserAccountID, string UserAccountNote) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.APIResult RetValue = new EWin.OcwAgent.APIResult();

        RetValue = api.UpdateUserAccountNote(AID, UserAccountID, UserAccountNote);

        return RetValue;
    }
}