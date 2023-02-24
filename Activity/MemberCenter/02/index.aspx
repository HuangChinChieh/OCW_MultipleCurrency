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
		<h2>パチンコって何？それっておいしいの？</h2>
		<h3>見返りを求める女は<br>
			パチンコをしない。</h3>
	</header>
	<div class="header-con">
		<h2>賢い女性に選ばれたのは<span>オンラインカジノ</span></h2>
	</div>
	<h4 class="btn"><a onclick="regBtnClick();"><img src="image/btn.png" alt=""></a></h4>
	<div class="top">
		<p>私たちにもっとも身近なギャンブルといえば<br>
			パチンコではないでしょうか。<br><br>
			丸一日パチンコ・スロットの<br>
			前に座りっぱなしなんて話も珍しくありません。<br><br>
			ですが、パチンコには<br>
			還元率非公開という法律の抜け穴があるため<br>
			デメリットが大きいのです。
		</p>
		<h2>還元率の比較</h2>
		<h3><img src="image/comparison.png" alt=""></h3>
	</div>
	<div class="reason">
		<ul>
			<li><span class="check"><img src="image/check.png" alt=""></span>公益ギャンブルではない<span class="small">※還元率を公表しなくて良いため、当たるまで時間がかかる</span></li>
			<li><span class="check"><img src="image/check.png" alt=""></span>還元率の計算方法が不透明</li>
			<li><span class="check"><img src="image/check.png" alt=""></span>台は店側が儲けられる設定</li>
		</ul>
	</div>
	<div class="flow">
		<h2>パチンコで掛け金の回収はできません。</h2>
		<h3>これが<span>現実</span>です。</h3>
		<ul>
			<li>
				<h4><img src="image/flow1.png" alt=""></h4>
				<p>1.貯金を崩し始める。</p>
			</li>
			<li>
				<h4><img src="image/flow2.png" alt=""></h4>
				<p>2.必要なお金にも手を出してしまう。</p>
			</li>
			<li>
				<h4><img src="image/flow3.png" alt=""></h4>
				<p>3.消費者金融に手を出してしまう。</p>
			</li>
			<li>
				<h4><img src="image/flow4.png" alt=""></h4>
				<p>4.借金が膨らんでしまう。</p>
			</li>
		</ul>
	</div>
	<div class="recom">
		<h2>でも、その悩み・苦しみ･･･</h2>
		<h3><img src="image/oshimai.png" alt=""></h3>
		<h4><img src="image/merit.png" alt=""></h4>
		<h5><img src="image/osusume.png" alt=""></h5>
		<div>
			<ul>
				<li><span class="check"><img src="image/check2.png" alt=""></span>いつでもどこでも遊べる。</li>
				<li><span class="check"><img src="image/check2.png" alt=""></span>隙間時間にできる。</li>
				<li><span class="check"><img src="image/check2.png" alt=""></span>人気ゲームが1000種類！<span class="small">随時ゲーム増加中！</span></li>
			</ul>
			<h6><img src="image/woman.png" alt=""></h6>
		</div>
	</div>
	<h4 class="btn"><a onclick="regBtnClick();"><img src="image/btn.png" alt=""></a></h4>
	<h2><img src="image/casino-bnr.png" alt=""></h2>
	<div class="voice">
		<h1>経験者の声をお聞きください。</h1>
		<div class="voice_container" style="padding-top:4%;">
			<table border="0" class="voice_block">
				<tbody><tr>
					<td style="display:table-cell; width:30%;">
						<img src="./image/voice_image01.png" class="voice_img">
					</td>
					<td style="display:table-cell; padding-left:3%;">
						<b>40 代女性・会社員</b><br><br>
						離婚を機にパチンコにのめり込んで作った借金が300万円以上あり、誰にも相談できず自己破産視野に。オンカジに出会った今では少しずつですが返済できています。少額で楽しめるので負担がないのがありがたい。マハラジャに出会えていなかったらと思うとゾッとします。
					</td>
				</tr>
			</tbody></table>
		</div>
		<div class="voice_container">
			<table border="0" class="voice_block">
				<tbody><tr>
					<td style="display:table-cell; width:30%;">
						<img src="./image/voice_image02.png" class="voice_img">
					</td>
					<td style="display:table-cell; padding-left:3%;">
						<b>40 代女性・専業主婦</b><br><br>
						旦那に内緒で行っていたパチンコで貯金を相当使い込んでいたことがバレて修羅場に。離婚されたら困るので代わりに少額で遊べるオンラインカジノに鞍替えしました。パチンコとは比べ物にならないくらい安価だし、スマホでで出来るので全然バレません。しかも結構当たる！！お陰で罪悪感なく遊べています。笑
					</td>
				</tr>
			</tbody></table>
		</div>
		<div class="voice_container">
			<table border="0" class="voice_block">
				<tbody><tr>
					<td style="display:table-cell; width:30%;">
						<img src="./image/voice_image03.png" class="voice_img">
					</td>
					<td style="display:table-cell; padding-left:3%;">
						<b>50 代女性・会社員</b><br><br>
						パチンコにハマっていた頃が懐かしいです。オンラインカジノで 130 万円を当てて以来、パチンコがアホらしく思えて、オンラインカジノ一筋に。最近はスロットゲームにハマってます。だって 240 円が 130 万円に化たんですから止められませんよね♪
					</td>
				</tr>
			</tbody></table>
		</div>
		<div class="voice_container" style="padding-bottom:4%; margin-bottom:7%;">
			<table border="0" class="voice_block">
				<tbody><tr>
					<td style="display:table-cell; width:30%;">
						<img src="./image/voice_image04.png" class="voice_img">
					</td>
					<td style="display:table-cell; padding-left:3%;">
						<b>30 代女性・会社員</b><br><br>
						ゲーム好きにはたまらない。スマホだから電車でも家でも場所を選ばずできるし、勝ったときは美味しいもの食べに行ったり、子供の服を買ったり、気になっていたお取寄せも値段を気にせずできて、おうち時間が充実しています。儲けたお金の一部を株に回したりと、将来に向けてコツコツ？準備中です。
					</td>
				</tr>
			</tbody></table>
		</div>
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
		<h1>さぁ！パチンコの毒牙から<br>
抜け出すチャンスは今！！！</h1>
		<h3>まずは、<br>
		お試しプレイしてみよう♪</h3>
		<h2><img src="image/footer.png" alt=""></h2>
		<h4 class="btn"><a onclick="regBtnClick();"><img src="image/btn2.png" alt=""></a></h4>
	</div>
	<footer>
		<h3><img src="image/icon.png" alt=""></h3>
		<h4><img src="image/woman2.png" alt=""></h4>
	</footer>


</body>
</html>
