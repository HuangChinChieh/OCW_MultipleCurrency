using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Script.Services;
using System.Web.Services;
using System.Web.UI;
using System.Web.UI.WebControls;

public partial class UserAccount_Add_Casino : System.Web.UI.Page {

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.APIResult CreateUserInfo(string AID, string LoginAccount, EWin.OcwAgent.PropertySet[] UserField) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.APIResult RetValue = new EWin.OcwAgent.APIResult();

        RetValue = api.CreateUserInfo(AID, LoginAccount, UserField);

        return RetValue;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.APIResult CheckAccountExist(string AID, string LoginAccount) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.APIResult RetValue = new EWin.OcwAgent.APIResult();

        RetValue = api.CheckAccountExist(AID, LoginAccount);

        return RetValue;
    }

    [WebMethod]
    [ScriptMethod(ResponseFormat = ResponseFormat.Json)]
    public static EWin.OcwAgent.UserInfoResult QueryCurrentUserInfo(string AID) {
        EWin.OcwAgent.OcwAgent api = new EWin.OcwAgent.OcwAgent();
        EWin.OcwAgent.UserInfoResult RetValue = new EWin.OcwAgent.UserInfoResult();

        RetValue = api.QueryCurrentUserInfo(AID);

        return RetValue;
    }
}