<%@ Page Language="C#" %>
<%
    string PCode = string.Empty;
    if (string.IsNullOrEmpty(Request["PCode"]) == false) {
        PCode = Request["PCode"];
    }
%>
<!DOCTYPE html>

<html xmlns="http://www.w3.org/1999/xhtml">
<head runat="server">
<meta http-equiv="Content-Type" content="text/html; charset=utf-8"/>
    <link href="css/destyle.css" rel="stylesheet" />
    <link href="css/style.css" rel="stylesheet" />
    <title></title>
</head>
    <script type="text/javascript">
        var PCode = "<%=PCode%>";

        function regBtnClick() {
            window.location.href = "https://casino-maharaja.com/Index.aspx?PCode=" + PCode + "&c=OCW888&Lang=JPN";
        }

    </script>
<body>
  <header>
    <h1><a href="https://casino-maharaja.com/"><img src="image/header-logo.png" alt=""></a></h1>
    <h2><img src="image/top.png" alt=""></h2>
  </header>
  <h4 class="btn"><a onclick="regBtnClick();"><img src="image/btn.png" alt=""></a></h4>
  <div class="place">
    <h2><img src="image/place.png" alt=""></h2>
    <h3>もし勝っていたら<span>・・・</span></h3>
    <p>
      うちの旦那さんなら<br>
      そうだな?
    </p>
    <h4>たぶん、いろんなところへ<br>
      旅行に行くんだろうな?</h4>
    <h4>たぶん、<br>
      身の回りのものが高級に<br>
      なっていくんだろうな?</h4>
    <h4>
      たぶん、<br>
      趣味のゴルフの<br>
      クラブやウェアを<br>
      たくさん買うだろうな?
    </h4>
    <h4>たぶん、、、<br>
      毎晩飲みに行って<br>
      遊ぶようになるだろうな?
    </h4>
    <h4>たぶん、、、<br>
      高いオートバイとか<br>
      買うんだろうな?
    </h4>
    <h5>たぶん、、、<br>
風俗とかにも行って・・・（自主規制）</h5>
  </div>
  <div class="ansin">
    <h2><img src="image/ansin.png" alt=""></h2>
    <h3>
      あなたの旦那さんは<br>
      そんな悪い人ではありませんよ！
    </h3>
    <p>
      きっと真面目な方ですから<br>
      ご家族へのプレゼントも<br>
      考えていらっしゃいますよ♪
    </p>
    <h4><img src="image/daizyoubu.png" alt=""></h4>
  </div>
  <h2><img src="image/you.png" alt=""></h2>
  <h4 class="btn"><a onclick="regBtnClick();"><img src="image/btn.png" alt=""></a></h4>
  <h2><img src="image/casino-bnr.png" alt=""></h2>
  <div class="voice">
    <h1>経験者の声をお聞きください。</h1>
	<div class="voice_container" style="padding-top:4%;">
		<table border="0" class="voice_block">
			<tbody><tr>
				<td style="display:table-cell; width:30%;">
				<img src="./image/voice_image01.jpeg" class="voice_img">
				</td>
				<td style="display:table-cell; padding-left:3%;">
				<b>50 代男性・会社員　S.A様</b><br>
					マハラジャで、大儲けしました。なんと1日で 200 万円という大当たり。おかげで夢だった海外旅行(グアム)に家族で行くことができ、妻にも喜んでもらえて本当にいい思い出ができました。
				</td>
			</tr>
		</tbody></table>
	</div>
	<div class="voice_container">
		<table border="0" class="voice_block">
			<tbody><tr>
				<td style="display:table-cell; width:30%;">
				<img src="./image/voice_image02.jpeg" class="voice_img">
				</td>
				<td style="display:table-cell; padding-left:3%;">
				<b>40 代男性・会社役員　Y.N様</b><br>
          今までもいろんなオンライカジノをしてきましたが、マハラジャは本当にたくさんゲームがあって
          飽きません。もちろん負けることもありますが、大勝したときの喜びは半端ないですね?。家族にもいろんなものをプレゼントできて良かったです。
				</td>
			</tr>
		</tbody></table>
	</div>
	<div class="voice_container">
		<table border="0" class="voice_block">
			<tbody><tr>
				<td style="display:table-cell; width:30%;">
				<img src="./image/voice_image03.jpeg" class="voice_img">
				</td>
				<td style="display:table-cell; padding-left:3%;">
					<b>20 代男性・会社員　Y.N様</b><br>
					お小遣いの半分はオンラインカジノに消えていってます(涙) でも大きく勝ったときは子どもたちにゲームやおもちゃを買ってあげられるので、いいかな?なんて。許してね(^^)
				</td>
			</tr>
		</tbody></table>
	</div>
	<div class="voice_container" style="padding-bottom:4%; margin-bottom:7%;">
		<table border="0" class="voice_block">
			<tbody><tr>
				<td style="display:table-cell; width:30%;">
				<img src="./image/voice_image04.jpeg" class="voice_img">
				</td>
				<td style="display:table-cell; padding-left:3%;">
					<b>30 代・会社員　Y.N様</b><br>
					ゲームがいっぱいあってすごい楽しい。オンラインだから電車でも休憩中でもできるしね。勝ったときは、当然家族サービスに使ってますよ?? (そうそう、勝ったら家族サービスって言い訳で。。。)
				</td>
			</tr>
		</tbody></table>
	</div>
	<img src="./image/man01.png" style="position:absolute; bottom:0%; left:-3%; width:30%;">
	<img src="./image/man02.png" style="position:absolute; bottom:0%; right:0%; width:35%;">
  </div>
  <div class="present">
    <h1 style="line-height:0.6;">
	
	</h1>
		<div>
            <br />
            <br />
			<h4 style="font-size:60px !important">1,000円分ポイントプレゼント!</h4>
		</div>
    <h2><img src="image/present.png" alt=""></h2>
    <h4 class="btn"><a onclick="regBtnClick();"><img src="image/btn2.png" alt=""></a></h4>
  </div>
  <div class="footer">
    <h1>まずは自ら試してみないと<br>
旦那さんの気持ちは分かりませんよ! </h1>
<h3>まずは、<br>
ノーリスクでお試しを!</h3>
    <h2><img src="image/footer.png" alt=""></h2>
    <h4 class="btn"><a onclick="regBtnClick();"><img src="image/btn2.png" alt=""></a></h4>
  </div>
  <footer>
    <h3><img src="image/icon.png" alt=""></h3>
  </footer>




</body>
</html>
