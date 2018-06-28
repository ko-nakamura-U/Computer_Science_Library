(* #use "MetroNetwork.ml";; *)
(* exit 0;; *)

(* 駅名リスト *)
type ekimei_t = {
  kanji   : string; (* 駅名 *)
  kana    : string; (* 読み *)
  romaji  : string; (* ローマ字 *)
  shozoku : string; (* 所属線名 *)
}

(* 駅間リスト *)
type ekikan_t = {
  kiten  : string; (* 起点 *)
  shuten : string; (* 終点 *)
  keiyu  : string; (* 経由線名 *)
  kyori  : float;  (* 距離 *)
  jikan  : int;    (* 時間 *)
}

let global_ekimei_list = [
{kanji="代々木上原"; kana="よよぎうえはら"; romaji="yoyogiuehara"; shozoku="千代田線"};
{kanji="代々木公園"; kana="よよぎこうえん"; romaji="yoyogikouen"; shozoku="千代田線"};
{kanji="明治神宮前"; kana="めいじじんぐうまえ"; romaji="meijijinguumae"; shozoku="千代田線"};
{kanji="表参道"; kana="おもてさんどう"; romaji="omotesandou"; shozoku="千代田線"};
{kanji="乃木坂"; kana="のぎざか"; romaji="nogizaka"; shozoku="千代田線"};
{kanji="赤坂"; kana="あかさか"; romaji="akasaka"; shozoku="千代田線"};
{kanji="国会議事堂前"; kana="こっかいぎじどうまえ"; romaji="kokkaigijidoumae"; shozoku="千代田線"};
{kanji="霞ヶ関"; kana="かすみがせき"; romaji="kasumigaseki"; shozoku="千代田線"};
{kanji="日比谷"; kana="ひびや"; romaji="hibiya"; shozoku="千代田線"};
{kanji="二重橋前"; kana="にじゅうばしまえ"; romaji="nijuubasimae"; shozoku="千代田線"};
{kanji="大手町"; kana="おおてまち"; romaji="otemachi"; shozoku="千代田線"};
{kanji="新御茶ノ水"; kana="しんおちゃのみず"; romaji="shin-ochanomizu"; shozoku="千代田線"};
{kanji="湯島"; kana="ゆしま"; romaji="yushima"; shozoku="千代田線"};
{kanji="根津"; kana="ねづ"; romaji="nedu"; shozoku="千代田線"};
{kanji="千駄木"; kana="せんだぎ"; romaji="sendagi"; shozoku="千代田線"};
{kanji="西日暮里"; kana="にしにっぽり"; romaji="nishinippori"; shozoku="千代田線"};
{kanji="町屋"; kana="まちや"; romaji="machiya"; shozoku="千代田線"};
{kanji="北千住"; kana="きたせんじゅ"; romaji="kitasenjyu"; shozoku="千代田線"};
{kanji="綾瀬"; kana="あやせ"; romaji="ayase"; shozoku="千代田線"};
{kanji="北綾瀬"; kana="きたあやせ"; romaji="kitaayase"; shozoku="千代田線"};
{kanji="浅草"; kana="あさくさ"; romaji="asakusa"; shozoku="銀座線"};
{kanji="田原町"; kana="たわらまち"; romaji="tawaramachi"; shozoku="銀座線"};
{kanji="稲荷町"; kana="いなりちょう"; romaji="inaricho"; shozoku="銀座線"};
{kanji="上野"; kana="うえの"; romaji="ueno"; shozoku="銀座線"};
{kanji="上野広小路"; kana="うえのひろこうじ"; romaji="uenohirokoji"; shozoku="銀座線"};
{kanji="末広町"; kana="すえひろちょう"; romaji="suehirocho"; shozoku="銀座線"};
{kanji="神田"; kana="かんだ"; romaji="kanda"; shozoku="銀座線"};
{kanji="三越前"; kana="みつこしまえ"; romaji="mitsukoshimae"; shozoku="銀座線"};
{kanji="日本橋"; kana="にほんばし"; romaji="nihonbashi"; shozoku="銀座線"};
{kanji="京橋"; kana="きょうばし"; romaji="kyobashi"; shozoku="銀座線"};
{kanji="銀座"; kana="ぎんざ"; romaji="ginza"; shozoku="銀座線"};
{kanji="新橋"; kana="しんばし"; romaji="shinbashi"; shozoku="銀座線"};
{kanji="虎ノ門"; kana="とらのもん"; romaji="toranomon"; shozoku="銀座線"};
{kanji="溜池山王"; kana="ためいけさんのう"; romaji="tameikesannou"; shozoku="銀座線"};
{kanji="赤坂見附"; kana="あかさかみつけ"; romaji="akasakamitsuke"; shozoku="銀座線"};
{kanji="青山一丁目"; kana="あおやまいっちょうめ"; romaji="aoyamaicchome"; shozoku="銀座線"};
{kanji="外苑前"; kana="がいえんまえ"; romaji="gaienmae"; shozoku="銀座線"};
{kanji="表参道"; kana="おもてさんどう"; romaji="omotesando"; shozoku="銀座線"};
{kanji="渋谷"; kana="しぶや"; romaji="shibuya"; shozoku="銀座線"};
{kanji="渋谷"; kana="しぶや"; romaji="shibuya"; shozoku="半蔵門線"};
{kanji="表参道"; kana="おもてさんどう"; romaji="omotesandou"; shozoku="半蔵門線"};
{kanji="青山一丁目"; kana="あおやまいっちょうめ"; romaji="aoyama-itchome"; shozoku="半蔵門線"};
{kanji="永田町"; kana="ながたちょう"; romaji="nagatacho"; shozoku="半蔵門線"};
{kanji="半蔵門"; kana="はんぞうもん"; romaji="hanzomon"; shozoku="半蔵門線"};
{kanji="九段下"; kana="くだんした"; romaji="kudanshita"; shozoku="半蔵門線"};
{kanji="神保町"; kana="じんぼうちょう"; romaji="jinbocho"; shozoku="半蔵門線"};
{kanji="大手町"; kana="おおてまち"; romaji="otemachi"; shozoku="半蔵門線"};
{kanji="三越前"; kana="みつこしまえ"; romaji="mitsukoshimae"; shozoku="半蔵門線"};
{kanji="水天宮前"; kana="すいてんぐうまえ"; romaji="suitengumae"; shozoku="半蔵門線"};
{kanji="清澄白河"; kana="きよすみしらかわ"; romaji="kiyosumi-shirakawa"; shozoku="半蔵門線"};
{kanji="住吉"; kana="すみよし"; romaji="sumiyoshi"; shozoku="半蔵門線"};
{kanji="錦糸町"; kana="きんしちょう"; romaji="kinshicho"; shozoku="半蔵門線"};
{kanji="押上"; kana="おしあげ"; romaji="oshiage"; shozoku="半蔵門線"};
{kanji="中目黒"; kana="なかめぐろ"; romaji="nakameguro"; shozoku="日比谷線"};
{kanji="恵比寿"; kana="えびす"; romaji="ebisu"; shozoku="日比谷線"};
{kanji="広尾"; kana="ひろお"; romaji="hiro"; shozoku="日比谷線"};
{kanji="六本木"; kana="ろっぽんぎ"; romaji="roppongi"; shozoku="日比谷線"};
{kanji="神谷町"; kana="かみやちょう"; romaji="kamiyacho"; shozoku="日比谷線"};
{kanji="霞ヶ関"; kana="かすみがせき"; romaji="kasumigaseki"; shozoku="日比谷線"};
{kanji="日比谷"; kana="ひびや"; romaji="hibiya"; shozoku="日比谷線"};
{kanji="銀座"; kana="ぎんざ"; romaji="ginza"; shozoku="日比谷線"};
{kanji="東銀座"; kana="ひがしぎんざ"; romaji="higashiginza"; shozoku="日比谷線"};
{kanji="築地"; kana="つきじ"; romaji="tsukiji"; shozoku="日比谷線"};
{kanji="八丁堀"; kana="はっちょうぼり"; romaji="hacchobori"; shozoku="日比谷線"};
{kanji="茅場町"; kana="かやばちょう"; romaji="kayabacho"; shozoku="日比谷線"};
{kanji="人形町"; kana="にんぎょうちょう"; romaji="ningyomachi"; shozoku="日比谷線"};
{kanji="小伝馬町"; kana="こでんまちょう"; romaji="kodemmacho"; shozoku="日比谷線"};
{kanji="秋葉原"; kana="あきはばら"; romaji="akihabara"; shozoku="日比谷線"};
{kanji="仲御徒町"; kana="なかおかちまち"; romaji="nakaokachimachi"; shozoku="日比谷線"};
{kanji="上野"; kana="うえの"; romaji="ueno"; shozoku="日比谷線"};
{kanji="入谷"; kana="いりや"; romaji="iriya"; shozoku="日比谷線"};
{kanji="三ノ輪"; kana="みのわ"; romaji="minowa"; shozoku="日比谷線"};
{kanji="南千住"; kana="みなみせんじゅ"; romaji="minamisenju"; shozoku="日比谷線"};
{kanji="北千住"; kana="きたせんじゅ"; romaji="kitasenju"; shozoku="日比谷線"};
{kanji="池袋"; kana="いけぶくろ"; romaji="ikebukuro"; shozoku="丸ノ内線"};
{kanji="新大塚"; kana="しんおおつか"; romaji="shinotsuka"; shozoku="丸ノ内線"};
{kanji="茗荷谷"; kana="みょうがだに"; romaji="myogadani"; shozoku="丸ノ内線"};
{kanji="後楽園"; kana="こうらくえん"; romaji="korakuen"; shozoku="丸ノ内線"};
{kanji="本郷三丁目"; kana="ほんごうさんちょうめ"; romaji="hongosanchome"; shozoku="丸ノ内線"};
{kanji="御茶ノ水"; kana="おちゃのみず"; romaji="ochanomizu"; shozoku="丸ノ内線"};
{kanji="淡路町"; kana="あわじちょう"; romaji="awajicho"; shozoku="丸ノ内線"};
{kanji="大手町"; kana="おおてまち"; romaji="otemachi"; shozoku="丸ノ内線"};
{kanji="東京"; kana="とうきょう"; romaji="tokyo"; shozoku="丸ノ内線"};
{kanji="銀座"; kana="ぎんざ"; romaji="ginza"; shozoku="丸ノ内線"};
{kanji="霞ヶ関"; kana="かすみがせき"; romaji="kasumigaseki"; shozoku="丸ノ内線"};
{kanji="国会議事堂前"; kana="こっかいぎじどうまえ"; romaji="kokkaigijidomae"; shozoku="丸ノ内線"};
{kanji="赤坂見附"; kana="あかさかみつけ"; romaji="akasakamitsuke"; shozoku="丸ノ内線"};
{kanji="四ツ谷"; kana="よつや"; romaji="yotsuya"; shozoku="丸ノ内線"};
{kanji="四谷三丁目"; kana="よつやさんちょうめ"; romaji="yotsuyasanchome"; shozoku="丸ノ内線"};
{kanji="新宿御苑前"; kana="しんじゅくぎょえんまえ"; romaji="shinjuku-gyoemmae"; shozoku="丸ノ内線"};
{kanji="新宿三丁目"; kana="しんじゅくさんちょうめ"; romaji="shinjuku-sanchome"; shozoku="丸ノ内線"};
{kanji="新宿"; kana="しんじゅく"; romaji="shinjuku"; shozoku="丸ノ内線"};
{kanji="西新宿"; kana="にししんじゅく"; romaji="nishi-shinjuku"; shozoku="丸ノ内線"};
{kanji="中野坂上"; kana="なかのさかうえ"; romaji="nakano-sakaue"; shozoku="丸ノ内線"};
{kanji="新中野"; kana="しんなかの"; romaji="shin-nakano"; shozoku="丸ノ内線"};
{kanji="東高円寺"; kana="ひがしこうえんじ"; romaji="higashi-koenji"; shozoku="丸ノ内線"};
{kanji="新高円寺"; kana="しんこうえんじ"; romaji="shin-koenji"; shozoku="丸ノ内線"};
{kanji="南阿佐ヶ谷"; kana="みなみあさがや"; romaji="minami-asagaya"; shozoku="丸ノ内線"};
{kanji="荻窪"; kana="おぎくぼ"; romaji="ogikubo"; shozoku="丸ノ内線"};
{kanji="中野新橋"; kana="なかのしんばし"; romaji="nakano-shimbashi"; shozoku="丸ノ内線"};
{kanji="中野富士見町"; kana="なかのふじみちょう"; romaji="nakano-fujimicho"; shozoku="丸ノ内線"};
{kanji="方南町"; kana="ほうなんちょう"; romaji="honancho"; shozoku="丸ノ内線"};
{kanji="四ツ谷"; kana="よつや"; romaji="yotsuya"; shozoku="南北線"};
{kanji="永田町"; kana="ながたちょう"; romaji="nagatacho"; shozoku="南北線"};
{kanji="溜池山王"; kana="ためいけさんのう"; romaji="tameikesanno"; shozoku="南北線"};
{kanji="六本木一丁目"; kana="ろっぽんぎいっちょうめ"; romaji="roppongiitchome"; shozoku="南北線"};
{kanji="麻布十番"; kana="あざぶじゅうばん"; romaji="azabujuban"; shozoku="南北線"};
{kanji="白金高輪"; kana="しろかねたかなわ"; romaji="shirokanetakanawa"; shozoku="南北線"};
{kanji="白金台"; kana="しろかねだい"; romaji="shirokanedai"; shozoku="南北線"};
{kanji="目黒"; kana="めぐろ"; romaji="meguro"; shozoku="南北線"};
{kanji="市ヶ谷"; kana="いちがや"; romaji="ichigaya"; shozoku="南北線"};
{kanji="飯田橋"; kana="いいだばし"; romaji="idabashi"; shozoku="南北線"};
{kanji="後楽園"; kana="こうらくえん"; romaji="korakuen"; shozoku="南北線"};
{kanji="東大前"; kana="とうだいまえ"; romaji="todaimae"; shozoku="南北線"};
{kanji="本駒込"; kana="ほんこまごめ"; romaji="honkomagome"; shozoku="南北線"};
{kanji="駒込"; kana="こまごめ"; romaji="komagome"; shozoku="南北線"};
{kanji="西ヶ原"; kana="にしがはら"; romaji="nishigahara"; shozoku="南北線"};
{kanji="王子"; kana="おうじ"; romaji="oji"; shozoku="南北線"};
{kanji="王子神谷"; kana="おうじかみや"; romaji="ojikamiya"; shozoku="南北線"};
{kanji="志茂"; kana="しも"; romaji="shimo"; shozoku="南北線"};
{kanji="赤羽岩淵"; kana="あかばねいわぶち"; romaji="akabaneiwabuchi"; shozoku="南北線"};
{kanji="西船橋"; kana="にしふなばし"; romaji="nishi-funabashi"; shozoku="東西線"};
{kanji="原木中山"; kana="ばらきなかやま"; romaji="baraki-nakayama"; shozoku="東西線"};
{kanji="妙典"; kana="みょうでん"; romaji="myoden"; shozoku="東西線"};
{kanji="行徳"; kana="ぎょうとく"; romaji="gyotoku"; shozoku="東西線"};
{kanji="南行徳"; kana="みなみぎょうとく"; romaji="minami-gyotoku"; shozoku="東西線"};
{kanji="浦安"; kana="うらやす"; romaji="urayasu"; shozoku="東西線"};
{kanji="葛西"; kana="かさい"; romaji="kasai"; shozoku="東西線"};
{kanji="西葛西"; kana="にしかさい"; romaji="nishi-kasai"; shozoku="東西線"};
{kanji="南砂町"; kana="みなみすなまち"; romaji="minami-sunamachi"; shozoku="東西線"};
{kanji="東陽町"; kana="とうようちょう"; romaji="touyoucho"; shozoku="東西線"};
{kanji="木場"; kana="きば"; romaji="kiba"; shozoku="東西線"};
{kanji="門前仲町"; kana="もんぜんなかちょう"; romaji="monzen-nakacho"; shozoku="東西線"};
{kanji="茅場町"; kana="かやばちょう"; romaji="kayabacho"; shozoku="東西線"};
{kanji="日本橋"; kana="にほんばし"; romaji="nihonbashi"; shozoku="東西線"};
{kanji="大手町"; kana="おおてまち"; romaji="otemachi"; shozoku="東西線"};
{kanji="竹橋"; kana="たけばし"; romaji="takebashi"; shozoku="東西線"};
{kanji="九段下"; kana="くだんした"; romaji="kudanshita"; shozoku="東西線"};
{kanji="飯田橋"; kana="いいだばし"; romaji="iidabashi"; shozoku="東西線"};
{kanji="神楽坂"; kana="かぐらざか"; romaji="kagurazaka"; shozoku="東西線"};
{kanji="早稲田"; kana="わせだ"; romaji="waseda"; shozoku="東西線"};
{kanji="高田馬場"; kana="たかだのばば"; romaji="takadanobaba"; shozoku="東西線"};
{kanji="落合"; kana="おちあい"; romaji="ochiai"; shozoku="東西線"};
{kanji="中野"; kana="なかの"; romaji="nakano"; shozoku="東西線"};
{romaji="shinkiba"; kana="しんきば"; kanji="新木場"; shozoku="有楽町線"};
{romaji="tatsumi"; kana="たつみ"; kanji="辰巳"; shozoku="有楽町線"};
{romaji="toyosu"; kana="とよす"; kanji="豊洲"; shozoku="有楽町線"};
{romaji="tsukishima"; kana="つきしま"; kanji="月島"; shozoku="有楽町線"};
{romaji="shintomityou"; kana="しんとみちょう"; kanji="新富町"; shozoku="有楽町線"};
{romaji="ginzaittyoume"; kana="ぎんざいっちょうめ"; kanji="銀座一丁目"; shozoku="有楽町線"};
{romaji="yuurakutyou"; kana="ゆうらくちょう"; kanji="有楽町"; shozoku="有楽町線"};
{romaji="sakuradamon"; kana="さくらだもん"; kanji="桜田門"; shozoku="有楽町線"};
{romaji="nagatacho"; kana="ながたちょう"; kanji="永田町"; shozoku="有楽町線"};
{romaji="koujimachi"; kana="こうじまち"; kanji="麹町"; shozoku="有楽町線"};
{romaji="ichigaya"; kana="いちがや"; kanji="市ヶ谷"; shozoku="有楽町線"};
{romaji="iidabashi"; kana="いいだばし"; kanji="飯田橋"; shozoku="有楽町線"};
{kanji="江戸川橋"; kana="えどがわばし"; romaji="edogawabasi"; shozoku="有楽町線"};
{kanji="護国寺"; kana="ごこくじ"; romaji="gokokuji"; shozoku="有楽町線"};
{kanji="東池袋"; kana="ひがしいけぶくろ"; romaji="higasiikebukuro"; shozoku="有楽町線"};
{kanji="池袋"; kana="いけぶくろ"; romaji="ikebukuro"; shozoku="有楽町線"};
{kanji="要町"; kana="かなめちょう"; romaji="kanametyou"; shozoku="有楽町線"};
{kanji="千川"; kana="せんかわ"; romaji="senkawa"; shozoku="有楽町線"};
{kanji="小竹向原"; kana="こたけむかいはら"; romaji="kotakemukaihara"; shozoku="有楽町線"};
{kanji="氷川台"; kana="ひかわだい"; romaji="hikawadai"; shozoku="有楽町線"};
{kanji="平和台"; kana="へいわだい"; romaji="heiwadai"; shozoku="有楽町線"};
{kanji="営団赤塚"; kana="えいだんあかつか"; romaji="eidanakakuka"; shozoku="有楽町線"};
{kanji="営団成増"; kana="えいだんなります"; romaji="eidannarimasu"; shozoku="有楽町線"};
{kanji="和光市"; kana="わこうし"; romaji="wakousi"; shozoku="有楽町線"};
]
let global_ekikan_list = [
{kiten="代々木上原"; shuten="代々木公園"; keiyu="千代田線"; kyori=1.0; jikan=2};
{kiten="代々木公園"; shuten="明治神宮前"; keiyu="千代田線"; kyori=1.2; jikan=2};
{kiten="明治神宮前"; shuten="表参道"; keiyu="千代田線"; kyori=0.9; jikan=2};
{kiten="表参道"; shuten="乃木坂"; keiyu="千代田線"; kyori=1.4; jikan=3};
{kiten="乃木坂"; shuten="赤坂"; keiyu="千代田線"; kyori=1.1; jikan=2};
{kiten="赤坂"; shuten="国会議事堂前"; keiyu="千代田線"; kyori=0.8; jikan=1};
{kiten="国会議事堂前"; shuten="霞ヶ関"; keiyu="千代田線"; kyori=0.7; jikan=1};
{kiten="霞ヶ関"; shuten="日比谷"; keiyu="千代田線"; kyori=1.2; jikan=2};
{kiten="日比谷"; shuten="二重橋前"; keiyu="千代田線"; kyori=0.7; jikan=1};
{kiten="二重橋前"; shuten="大手町"; keiyu="千代田線"; kyori=0.7; jikan=1};
{kiten="大手町"; shuten="新御茶ノ水"; keiyu="千代田線"; kyori=1.3; jikan=2};
{kiten="新御茶ノ水"; shuten="湯島"; keiyu="千代田線"; kyori=1.2; jikan=2};
{kiten="湯島"; shuten="根津"; keiyu="千代田線"; kyori=1.2; jikan=2};
{kiten="根津"; shuten="千駄木"; keiyu="千代田線"; kyori=1.0; jikan=2};
{kiten="千駄木"; shuten="西日暮里"; keiyu="千代田線"; kyori=0.9; jikan=1};
{kiten="西日暮里"; shuten="町屋"; keiyu="千代田線"; kyori=1.7; jikan=2};
{kiten="町屋"; shuten="北千住"; keiyu="千代田線"; kyori=2.6; jikan=3};
{kiten="北千住"; shuten="綾瀬"; keiyu="千代田線"; kyori=2.5; jikan=3};
{kiten="綾瀬"; shuten="北綾瀬"; keiyu="千代田線"; kyori=2.1; jikan=4};
{kiten="浅草"; shuten="田原町"; keiyu="銀座線"; kyori=0.8; jikan=2};
{kiten="田原町"; shuten="稲荷町"; keiyu="銀座線"; kyori=0.7; jikan=1};
{kiten="稲荷町"; shuten="上野"; keiyu="銀座線"; kyori=0.7; jikan=2};
{kiten="上野"; shuten="上野広小路"; keiyu="銀座線"; kyori=0.5; jikan=2};
{kiten="上野広小路"; shuten="末広町"; keiyu="銀座線"; kyori=0.6; jikan=1};
{kiten="末広町"; shuten="神田"; keiyu="銀座線"; kyori=1.1; jikan=2};
{kiten="神田"; shuten="三越前"; keiyu="銀座線"; kyori=0.7; jikan=1};
{kiten="三越前"; shuten="日本橋"; keiyu="銀座線"; kyori=0.6; jikan=2};
{kiten="日本橋"; shuten="京橋"; keiyu="銀座線"; kyori=0.7; jikan=2};
{kiten="京橋"; shuten="銀座"; keiyu="銀座線"; kyori=0.7; jikan=1};
{kiten="銀座"; shuten="新橋"; keiyu="銀座線"; kyori=0.9; jikan=2};
{kiten="新橋"; shuten="虎ノ門"; keiyu="銀座線"; kyori=0.8; jikan=2};
{kiten="虎ノ門"; shuten="溜池山王"; keiyu="銀座線"; kyori=0.6; jikan=2};
{kiten="溜池山王"; shuten="赤坂見附"; keiyu="銀座線"; kyori=0.9; jikan=2};
{kiten="赤坂見附"; shuten="青山一丁目"; keiyu="銀座線"; kyori=1.3; jikan=2};
{kiten="青山一丁目"; shuten="外苑前"; keiyu="銀座線"; kyori=0.7; jikan=2};
{kiten="外苑前"; shuten="表参道"; keiyu="銀座線"; kyori=0.7; jikan=1};
{kiten="表参道"; shuten="渋谷"; keiyu="銀座線"; kyori=1.3; jikan=1};
{kiten="渋谷"; shuten="表参道"; keiyu="半蔵門線"; kyori=1.3; jikan=2};
{kiten="表参道"; shuten="青山一丁目"; keiyu="半蔵門線"; kyori=1.4; jikan=2};
{kiten="青山一丁目"; shuten="永田町"; keiyu="半蔵門線"; kyori=1.3; jikan=2};
{kiten="永田町"; shuten="半蔵門"; keiyu="半蔵門線"; kyori=1.0; jikan=2};
{kiten="半蔵門"; shuten="九段下"; keiyu="半蔵門線"; kyori=1.6; jikan=2};
{kiten="九段下"; shuten="神保町"; keiyu="半蔵門線"; kyori=0.4; jikan=1};
{kiten="神保町"; shuten="大手町"; keiyu="半蔵門線"; kyori=1.7; jikan=3};
{kiten="大手町"; shuten="三越前"; keiyu="半蔵門線"; kyori=0.7; jikan=1};
{kiten="三越前"; shuten="水天宮前"; keiyu="半蔵門線"; kyori=1.3; jikan=2};
{kiten="水天宮前"; shuten="清澄白河"; keiyu="半蔵門線"; kyori=1.7; jikan=3};
{kiten="清澄白河"; shuten="住吉"; keiyu="半蔵門線"; kyori=1.9; jikan=3};
{kiten="住吉"; shuten="錦糸町"; keiyu="半蔵門線"; kyori=1.; jikan=2};
{kiten="錦糸町"; shuten="押上"; keiyu="半蔵門線"; kyori=1.4; jikan=2};
{kiten="中目黒"; shuten="恵比寿"; keiyu="日比谷線"; kyori=1.; jikan=2};
{kiten="恵比寿"; shuten="広尾"; keiyu="日比谷線"; kyori=1.5; jikan=3};
{kiten="広尾"; shuten="六本木"; keiyu="日比谷線"; kyori=1.7; jikan=3};
{kiten="六本木"; shuten="神谷町"; keiyu="日比谷線"; kyori=1.5; jikan=3};
{kiten="神谷町"; shuten="霞ヶ関"; keiyu="日比谷線"; kyori=1.3; jikan=2};
{kiten="霞ヶ関"; shuten="日比谷"; keiyu="日比谷線"; kyori=1.2; jikan=2};
{kiten="日比谷"; shuten="銀座"; keiyu="日比谷線"; kyori=0.4; jikan=1};
{kiten="銀座"; shuten="東銀座"; keiyu="日比谷線"; kyori=0.4; jikan=1};
{kiten="東銀座"; shuten="築地"; keiyu="日比谷線"; kyori=0.6; jikan=2};
{kiten="築地"; shuten="八丁堀"; keiyu="日比谷線"; kyori=1.; jikan=2};
{kiten="八丁堀"; shuten="茅場町"; keiyu="日比谷線"; kyori=0.5; jikan=1};
{kiten="茅場町"; shuten="人形町"; keiyu="日比谷線"; kyori=0.9; jikan=2};
{kiten="人形町"; shuten="小伝馬町"; keiyu="日比谷線"; kyori=0.6; jikan=1};
{kiten="小伝馬町"; shuten="秋葉原"; keiyu="日比谷線"; kyori=0.9; jikan=2};
{kiten="秋葉原"; shuten="仲御徒町"; keiyu="日比谷線"; kyori=1.; jikan=1};
{kiten="仲御徒町"; shuten="上野"; keiyu="日比谷線"; kyori=0.5; jikan=1};
{kiten="上野"; shuten="入谷"; keiyu="日比谷線"; kyori=1.2; jikan=2};
{kiten="入谷"; shuten="三ノ輪"; keiyu="日比谷線"; kyori=1.2; jikan=2};
{kiten="三ノ輪"; shuten="南千住"; keiyu="日比谷線"; kyori=0.8; jikan=2};
{kiten="南千住"; shuten="北千住"; keiyu="日比谷線"; kyori=1.8; jikan=3};
{kiten="池袋"; shuten="新大塚"; keiyu="丸ノ内線"; kyori=1.8; jikan=3};
{kiten="新大塚"; shuten="茗荷谷"; keiyu="丸ノ内線"; kyori=1.2; jikan=2};
{kiten="茗荷谷"; shuten="後楽園"; keiyu="丸ノ内線"; kyori=1.8; jikan=2};
{kiten="後楽園"; shuten="本郷三丁目"; keiyu="丸ノ内線"; kyori=0.8; jikan=1};
{kiten="本郷三丁目"; shuten="御茶ノ水"; keiyu="丸ノ内線"; kyori=0.8; jikan=1};
{kiten="御茶ノ水"; shuten="淡路町"; keiyu="丸ノ内線"; kyori=0.8; jikan=1};
{kiten="淡路町"; shuten="大手町"; keiyu="丸ノ内線"; kyori=0.9; jikan=2};
{kiten="大手町"; shuten="東京"; keiyu="丸ノ内線"; kyori=0.6; jikan=1};
{kiten="東京"; shuten="銀座"; keiyu="丸ノ内線"; kyori=1.1; jikan=2};
{kiten="銀座"; shuten="霞ヶ関"; keiyu="丸ノ内線"; kyori=1.0; jikan=2};
{kiten="霞ヶ関"; shuten="国会議事堂前"; keiyu="丸ノ内線"; kyori=0.7; jikan=1};
{kiten="国会議事堂前"; shuten="赤坂見附"; keiyu="丸ノ内線"; kyori=0.9; jikan=2};
{kiten="赤坂見附"; shuten="四ツ谷"; keiyu="丸ノ内線"; kyori=1.3; jikan=2};
{kiten="四ツ谷"; shuten="四谷三丁目"; keiyu="丸ノ内線"; kyori=1.0; jikan=2};
{kiten="四谷三丁目"; shuten="新宿御苑前"; keiyu="丸ノ内線"; kyori=0.9; jikan=1};
{kiten="新宿御苑前"; shuten="新宿三丁目"; keiyu="丸ノ内線"; kyori=0.7; jikan=1};
{kiten="新宿三丁目"; shuten="新宿"; keiyu="丸ノ内線"; kyori=0.3; jikan=1};
{kiten="新宿"; shuten="西新宿"; keiyu="丸ノ内線"; kyori=0.8; jikan=1};
{kiten="西新宿"; shuten="中野坂上"; keiyu="丸ノ内線"; kyori=1.1; jikan=2};
{kiten="中野坂上"; shuten="新中野"; keiyu="丸ノ内線"; kyori=1.1; jikan=2};
{kiten="新中野"; shuten="東高円寺"; keiyu="丸ノ内線"; kyori=1.0; jikan=1};
{kiten="東高円寺"; shuten="新高円寺"; keiyu="丸ノ内線"; kyori=0.9; jikan=1};
{kiten="新高円寺"; shuten="南阿佐ヶ谷"; keiyu="丸ノ内線"; kyori=1.2; jikan=2};
{kiten="南阿佐ヶ谷"; shuten="荻窪"; keiyu="丸ノ内線"; kyori=1.5; jikan=2};
{kiten="中野坂上"; shuten="中野新橋"; keiyu="丸ノ内線"; kyori=1.3; jikan=2};
{kiten="中野新橋"; shuten="中野富士見町"; keiyu="丸ノ内線"; kyori=0.6; jikan=1};
{kiten="中野富士見町"; shuten="方南町"; keiyu="丸ノ内線"; kyori=1.3; jikan=2};
{kiten="市ヶ谷"; shuten="四ツ谷"; keiyu="南北線"; kyori=1.0; jikan=2};
{kiten="四ツ谷"; shuten="永田町"; keiyu="南北線"; kyori=1.3; jikan=3};
{kiten="永田町"; shuten="溜池山王"; keiyu="南北線"; kyori=0.9; jikan=1};
{kiten="溜池山王"; shuten="六本木一丁目"; keiyu="南北線"; kyori=0.9; jikan=2};
{kiten="六本木一丁目"; shuten="麻布十番"; keiyu="南北線"; kyori=1.2; jikan=2};
{kiten="麻布十番"; shuten="白金高輪"; keiyu="南北線"; kyori=1.3; jikan=2};
{kiten="白金高輪"; shuten="白金台"; keiyu="南北線"; kyori=1.0; jikan=2};
{kiten="白金台"; shuten="目黒"; keiyu="南北線"; kyori=1.3; jikan=2};
{kiten="市ヶ谷"; shuten="飯田橋"; keiyu="南北線"; kyori=1.1 ; jikan=2};
{kiten="飯田橋"; shuten="後楽園"; keiyu="南北線"; kyori=1.4 ; jikan=2};
{kiten="後楽園"; shuten="東大前"; keiyu="南北線"; kyori=1.3 ; jikan=3};
{kiten="東大前"; shuten="本駒込"; keiyu="南北線"; kyori=0.9 ; jikan=2};
{kiten="本駒込"; shuten="駒込"; keiyu="南北線"; kyori=1.4; jikan=2};
{kiten="駒込"; shuten="西ヶ原"; keiyu="南北線"; kyori=1.4; jikan=2};
{kiten="西ヶ原"; shuten="王子"; keiyu="南北線"; kyori=1.0; jikan=2};
{kiten="王子"; shuten="王子神谷"; keiyu="南北線"; kyori=1.2; jikan=2};
{kiten="王子神谷"; shuten="志茂"; keiyu="南北線"; kyori=1.6; jikan=3};
{kiten="志茂"; shuten="赤羽岩淵"; keiyu="南北線"; kyori=1.1; jikan=2};
{kiten="西船橋" ; shuten="原木中山"; keiyu="東西線"; kyori=1.9; jikan=3};
{kiten="原木中山"; shuten="妙典"; keiyu="東西線"; kyori=2.1 ; jikan=2};
{kiten="妙典"; shuten="行徳"; keiyu="東西線"; kyori=1.3 ; jikan=2};
{kiten="行徳"; shuten="南行徳"; keiyu="東西線"; kyori=1.5 ; jikan=2};
{kiten="南行徳"; shuten="浦安" ; keiyu="東西線"; kyori=1.2 ; jikan=2};
{kiten="浦安" ; shuten="葛西"; keiyu="東西線"; kyori=1.9 ; jikan=2};
{kiten="葛西"; shuten="西葛西"; keiyu="東西線"; kyori=1.2 ; jikan=2};
{kiten="西葛西"; shuten="南砂町"; keiyu="東西線"; kyori=2.7 ; jikan=2};
{kiten="南砂町"; shuten="東陽町"; keiyu="東西線"; kyori=1.2 ; jikan=2};
{kiten="東陽町"; shuten="木場" ; keiyu="東西線"; kyori=0.9 ; jikan=1};
{kiten="木場"; shuten="門前仲町"; keiyu="東西線"; kyori=1.1 ; jikan=1};
{kiten="門前仲町"; shuten="茅場町"; keiyu="東西線"; kyori=1.8 ; jikan=2};
{kiten="茅場町"; shuten="日本橋"; keiyu="東西線"; kyori=0.5 ; jikan=1};
{kiten="日本橋"; shuten="大手町"; keiyu="東西線"; kyori=0.8 ; jikan=1};
{kiten="大手町"; shuten="竹橋"; keiyu="東西線"; kyori=1.0; jikan=2};
{kiten="竹橋"; shuten="九段下"; keiyu="東西線"; kyori=1.0; jikan=1};
{kiten="九段下"; shuten="飯田橋"; keiyu="東西線"; kyori=0.7; jikan=1};
{kiten="飯田橋"; shuten="神楽坂"; keiyu="東西線"; kyori=1.2; jikan=2};
{kiten="神楽坂"; shuten="早稲田"; keiyu="東西線"; kyori=1.2; jikan=2};
{kiten="早稲田"; shuten="高田馬場"; keiyu="東西線"; kyori=1.7; jikan=3};
{kiten="高田馬場"; shuten="落合"; keiyu="東西線"; kyori=1.9; jikan=3};
{kiten="落合"; shuten="中野"; keiyu="東西線"; kyori=2.0; jikan=3};
{kiten="新木場"; shuten="辰巳"; keiyu="有楽町線"; kyori=1.5; jikan=2};
{kiten="辰巳"; shuten="豊洲"; keiyu="有楽町線"; kyori=1.7; jikan=2};
{kiten="豊洲"; shuten="月島"; keiyu="有楽町線"; kyori=1.4; jikan=2};
{kiten="月島"; shuten="新富町"; keiyu="有楽町線"; kyori=1.3; jikan=2};
{kiten="新富町"; shuten="銀座一丁目"; keiyu="有楽町線"; kyori=0.7; jikan=1};
{kiten="銀座一丁目"; shuten="有楽町"; keiyu="有楽町線"; kyori=0.5; jikan=1};
{kiten="有楽町"; shuten="桜田門"; keiyu="有楽町線"; kyori=1.0; jikan=1};
{kiten="桜田門"; shuten="永田町"; keiyu="有楽町線"; kyori=0.9; jikan=2};
{kiten="永田町"; shuten="麹町"; keiyu="有楽町線"; kyori=0.9; jikan=1};
{kiten="麹町"; shuten="市ヶ谷"; keiyu="有楽町線"; kyori=0.9; jikan=1};
{kiten="市ヶ谷"; shuten="飯田橋"; keiyu="有楽町線"; kyori=1.1; jikan=2};
{kiten="飯田橋"; shuten="江戸川橋"; keiyu="有楽町線"; kyori=1.6; jikan=3};
{kiten="江戸川橋"; shuten="護国寺"; keiyu="有楽町線"; kyori=1.3; jikan=2};
{kiten="護国寺"; shuten="東池袋"; keiyu="有楽町線"; kyori=1.1; jikan=2};
{kiten="東池袋"; shuten="池袋"; keiyu="有楽町線"; kyori=2.0; jikan=2};
{kiten="池袋"; shuten="要町"; keiyu="有楽町線"; kyori=1.2; jikan=2};
{kiten="要町"; shuten="千川"; keiyu="有楽町線"; kyori=1.0; jikan=1};
{kiten="千川"; shuten="小竹向原"; keiyu="有楽町線"; kyori=1.0; jikan=2};
{kiten="小竹向原"; shuten="氷川台"; keiyu="有楽町線"; kyori=1.5; jikan=2};
{kiten="氷川台"; shuten="平和台"; keiyu="有楽町線"; kyori=1.4; jikan=2};
{kiten="平和台"; shuten="営団赤塚"; keiyu="有楽町線"; kyori=1.8; jikan=2};
{kiten="営団赤塚"; shuten="営団成増"; keiyu="有楽町線"; kyori=1.5; jikan=2};
{kiten="営団成増"; shuten="和光市"; keiyu="有楽町線"; kyori=2.1; jikan=3};
]



(* 10.10 *)
(* ローマ字の駅名と駅名リスト(ekimei_t list型)を受け取ったら、その駅の漢字表記を文字列で返す *)
(* romaji_to_kanji : string -> string list -> string *)
let rec romaji_to_kanji s l = match l with
    | [] -> ""
  | {kanji = kj; kana = kn; romaji = rmj; shozoku = szk} :: rest -> if s = rmj then kj
                                                                               else romaji_to_kanji s rest;;

(* 10.10 tests *)
let test_10_10_1 = romaji_to_kanji "" global_ekimei_list = ""
let test_10_10_2 = romaji_to_kanji "myogadani" global_ekimei_list = "茗荷谷";;



(* 10.11 *)
(* 目的：２つの駅名と駅間リストを受け取ったら、駅間リストの中から2駅間の距離を返す *)
(* get_ekikan_kyori : string -> string -> global_ekikan_list list -> float *)
let rec get_ekikan_kyori s1 s2 l = match l with
  | [] -> infinity
    | {kiten = ki; shuten = shu; keiyu = ke; kyori = ky; jikan = ji} :: rest ->
          if (s1 = ki && s2 = shu) || (s2 = ki && s1 = shu) then ky
                                                            else get_ekikan_kyori s1 s2 rest;;

(* 10.11 tests *)
let test_10_11_1 = get_ekikan_kyori "" "" [] = infinity
let test_10_11_2 = get_ekikan_kyori "新大塚" "茗荷谷" global_ekikan_list = 1.2
let test_10_11_3 = get_ekikan_kyori "池袋" "新大塚" global_ekikan_list = 1.8
let test_10_11_4 = get_ekikan_kyori "茗荷谷" "新大塚" global_ekikan_list = 1.2
let test_10_11_5 = get_ekikan_kyori "営団成増" "和光市" global_ekikan_list = 2.1;;



(* 10.12 *)
(* 目的：
ローマ字の駅名をふたつ受け取ったら、その間の距離を調べ、
直接繋がっている場合は「A駅からB駅までは ~km です」という文字列を返し、
繋がってない場合は、「A駅とB駅はつながっていません」と言う文字列を返す *)
(* kyori_wo_hyoji : string -> string -> string *)
let kyori_wo_hyoji s1 s2 =
  let _s1 = romaji_to_kanji s1 global_ekimei_list in
  let _s2 = romaji_to_kanji s2 global_ekimei_list in
  let _kyori = get_ekikan_kyori _s1 _s2 global_ekikan_list in
  if _s1 = "" then s1^"という駅は存在しません"
  else if _s2 = "" then s2^"という駅は存在しません"
  else if _kyori = infinity then _s1^"駅と"^_s2^"駅はつながっていません"
  else _s1^"駅から"^_s2^"駅までは"^(string_of_float _kyori)^"kmです";;

(* 10.12 tests *)
let test_10_12_1 = kyori_wo_hyoji "" "" = "という駅は存在しません"
let test_10_12_2 = kyori_wo_hyoji "yoyogikouen" "" = "という駅は存在しません"
let test_10_12_3 = kyori_wo_hyoji "" "meijijinguumae" = "という駅は存在しません"
let test_10_12_4 = kyori_wo_hyoji "yoyoyo" "meijijinguumae" = "yoyoyoという駅は存在しません"
let test_10_12_5 = kyori_wo_hyoji "yoyogikouen" "mememe" = "mememeという駅は存在しません"
let test_10_12_6 = kyori_wo_hyoji "yoyoyo" "mememe" = "yoyoyoという駅は存在しません"
let test_10_12_7 = kyori_wo_hyoji "yoyogikouen" "meijijinguumae" = "代々木公園駅から明治神宮前駅までは1.2kmです"
let test_10_12_8 = kyori_wo_hyoji "meijijinguumae" "yoyogikouen" = "明治神宮前駅から代々木公園駅までは1.2kmです"
let test_10_12_9 = kyori_wo_hyoji "meijijinguumae" "asakusa" = "明治神宮前駅と浅草駅はつながっていません"
let test_10_12_10 = kyori_wo_hyoji "asakusa" "meijijinguumae" = "浅草駅と明治神宮前駅はつながっていません"
let test_10_12_11 = kyori_wo_hyoji "yoyogikouen" "ikebukuro" = "代々木公園駅と池袋駅はつながっていません"
let test_10_12_12 = kyori_wo_hyoji "ikebukuro" "shinotsuka" = "池袋駅から新大塚駅までは1.8kmです";;



(* 12.1 *)
(* 目的：駅名(漢字の文字列)、最短距離(実数)、駅名(漢字の文字列) のリストを表す型 *)
type eki_t = {
  namae        : string;       (* 駅名 *)
  saitan_kyori : float;        (* 最短距離 *)
  temae_list   : string list;  (* 駅名リスト *)
};;
(* eki_t tests *)
let eki_t1 = [{namae = "代々木上原"; saitan_kyori = 1.0; temae_list = ["代々木上原"; "代々木公園"]}]
let eki_t2 = [{namae = "代々木公園"; saitan_kyori = 1.2; temae_list = ["代々木公園"; "明治神宮前"]}]
let eki_t3 = [{namae = "明治神宮前"; saitan_kyori = 0.9; temae_list = ["明治神宮前"; "表参道"]}]
let eki_t4 = [{namae = "表参道"; saitan_kyori = 0.9; temae_list = ["表参道"; "明治神宮前"]}];;



(* 12.2 *)
(* 目的：ekimei_t型のリストを受け取ったら、その駅名を使って eki_t型のリストを作る *)
(* make_eki_list : ekimei_t list -> eki_t list *)
let rec make_eki_list (l: ekimei_t list) = match l with
  | [] -> []
    | {kanji = kj; kana = kn; romaji = r; shozoku = s} :: rest ->
        {namae = kj; saitan_kyori = infinity; temae_list = []} :: make_eki_list rest;;

(* ekimei_t test data *)
let ekimei_t1 = {kanji = "代々木上原"; kana = "よよぎうえはら"; romaji = "yoyogiuehara"; shozoku = "千代田線"}
let ekimei_t2 = {kanji = "代々木公園"; kana = "よよぎこうえん"; romaji = "yoyogikouen"; shozoku = "千代田線"}
let ekimei_t3 = {kanji = "明治神宮前"; kana = "めいじじんぐうまえ"; romaji = "meijijinguumae"; shozoku = "千代田線"}
let ekimei_t4 = {kanji = "表参道"; kana = "おもてさんどう"; romaji = "omotesandou"; shozoku = "千代田線"};;

(* 12.2 tests *)
let test_12_2_1 = make_eki_list [] = []

let test_12_2_2 = make_eki_list [ekimei_t1] = [
    {namae = "代々木上原"; saitan_kyori = infinity; temae_list = []}
]
let test_12_2_3 = make_eki_list [ekimei_t1; ekimei_t2] = [
    {namae = "代々木上原"; saitan_kyori = infinity; temae_list = []};
    {namae = "代々木公園"; saitan_kyori = infinity; temae_list = []}
];;
let test_12_2_4 = make_eki_list [ekimei_t1; ekimei_t2; ekimei_t3; ekimei_t4] = [
    {namae = "代々木上原"; saitan_kyori = infinity; temae_list = []};
    {namae = "代々木公園"; saitan_kyori = infinity; temae_list = []};
    {namae = "明治神宮前"; saitan_kyori = infinity; temae_list = []};
    {namae = "表参道"; saitan_kyori = infinity; temae_list = []}
];;



(* 12.3 *)
(* 目的：
eki_t型のリストと起点(漢字の文字列)を受け取ったら、起点のみ
- saitan_kyori は 0
- temae_list は始点の駅名のみからなるリスト
になっている eki_t型のリストを返す *)
(* shokika : eki_t list -> string -> eki_t list *)
let rec shokika (l: eki_t list) s = match l with
  | [] -> []
    | {namae = n; saitan_kyori = sk; temae_list = tl} :: rest ->
        if n = s then {namae = n; saitan_kyori = 0.0; temae_list = n :: tl} :: rest
                 else {namae = n; saitan_kyori = sk; temae_list = tl} :: shokika rest n;;

(* 12.3 tests *)
let global_ekimei_list_mini = [ekimei_t1; ekimei_t2; ekimei_t3; ekimei_t4];;
let eki_list_mini = make_eki_list global_ekimei_list_mini;;
let test_12_3_1 = shokika [] "" = [];;
let test_12_3_2 = shokika eki_list_mini "代々木上原" = [
    {namae = "代々木上原"; saitan_kyori = 0.0; temae_list = ["代々木上原"]};
    {namae = "代々木公園"; saitan_kyori = infinity; temae_list = []};
    {namae = "明治神宮前"; saitan_kyori = infinity; temae_list = []};
    {namae = "表参道"; saitan_kyori = infinity; temae_list = []}
];;



(* 12.4 *)

(* 目的：ekimei_t型のリストとekimei_t型の駅を受け取ったらひらがな順に整列させたリストを返す *)
(* ins_seiretsu : ekimei_t list -> ekimei_t -> ekimei_t list *)
let rec insert (l: ekimei_t list) (s: ekimei_t) = match l with
  | [] -> [s]
    | {kanji = kj; kana = kn; romaji = ro; shozoku = sh} :: rest ->
      match s with {kanji = skj; kana = skn; romaji = sro; shozoku = ssh} ->
        if kn < skn then {kanji = kj; kana = kn; romaji = ro; shozoku = sh} :: insert rest s
        else if kn = skj then insert rest s
        else s :: l;;

(* 目的：
ekimei_t型のリストを受け取ったら、それをひらがなの順に整列して、
駅の重複を取り除いたekimei_t型のリストを返す *)
(* seiretsu : list ekimei_t -> list ekimei_t *)
let rec seiretsu (l: ekimei_t list) = match l with
  | [] -> []
    | first :: rest -> insert (seiretsu rest) first;;

(* 12.4 tests *)
let test_12_4_1 = seiretsu [] = [];;
let test_12_4_2 = seiretsu [ekimei_t1] = [ekimei_t1];;
let test_12_4_3 = seiretsu [ekimei_t1; ekimei_t2] = [ekimei_t1; ekimei_t2];;
let test_12_4_4 = seiretsu [ekimei_t2; ekimei_t1] = [ekimei_t1; ekimei_t2];;
let test_12_4_5 = seiretsu [ekimei_t1; ekimei_t2; ekimei_t3] = [ekimei_t3; ekimei_t1; ekimei_t2];;
let test_12_4_6 = seiretsu [ekimei_t1; ekimei_t2; ekimei_t3; ekimei_t4] = [ekimei_t4; ekimei_t3; ekimei_t1; ekimei_t2];;



(* 13.6 *)
(* 目的：
直前に確定した駅p(eki_t型)と未確定の駅q(eki_t型)を受け取ったら、直接繋がっているかどうかを調べ、
繋がっていたら未確定の最短距離と手前リストを必要に応じて更新したもの、
繋がっていなかったら直前に確定した駅をそのまま返す *)
(* koushin1 : eki_t -> eki_t -> eki_t *)
let koushin1 (p: eki_t) (q: eki_t) =
  match p with {namae = pn; saitan_kyori = ps; temae_list = pt} ->
  match q with {namae = qn; saitan_kyori = qs; temae_list = qt} ->
  let total = get_ekikan_kyori pn qn global_ekikan_list +. ps in
    if total < qs then {namae = qn; saitan_kyori = total; temae_list = qn :: pt}
                  else q;;

(* 13.6 tests *)
let test_13_6_1 = koushin1 { namae = "代々木上原"; saitan_kyori = 0.0; temae_list = ["代々木上原"] }
                           { namae = "代々木公園"; saitan_kyori = infinity; temae_list = [] }
                           = { namae = "代々木公園"; saitan_kyori = 1.0; temae_list = ["代々木公園"; "代々木上原"] }

let test_13_6_2 = koushin1 { namae = "明治神宮前"; saitan_kyori = 0.0; temae_list = ["明治神宮前"] }
                           { namae = "代々木公園"; saitan_kyori = infinity; temae_list = [] }
                           = { namae = "代々木公園"; saitan_kyori = 1.2; temae_list = ["代々木公園"; "明治神宮前"]}

let test_13_6_3 = koushin1 { namae = "代々木公園"; saitan_kyori = 0.0; temae_list = ["代々木公園"] }
                           { namae = "池袋"; saitan_kyori = infinity; temae_list = [] }
                           = { namae = "池袋"; saitan_kyori = infinity; temae_list = []}

let test_13_6_4 = koushin1 { namae = "代々木公園"; saitan_kyori = 1.2; temae_list = ["代々木公園"; "明治神宮前"] }
                          { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] }
                          = { namae = "代々木上原"; saitan_kyori = 2.2; temae_list = ["代々木上原"; "代々木公園"; "明治神宮前"]};;



(* 13.7 *)
(* 目的：
直前に確定した駅p(eki_t型)と未確定の駅のリストv(eki_t list型)を受け取ったら、
必要な更新処理を行なったあとの未確定の駅のリストを返す *)
(* koushin : eki_t -> eki_t list -> eki_t list *)
let koushin (p: eki_t) (v: eki_t list) = List.map (koushin1 p) v;;

(* 13.7 tests *)
let test_13_7_1 = koushin { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] } [] = []
let test_13_7_2 = koushin { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] } [
    { namae = "明治神宮前"; saitan_kyori = infinity; temae_list = [] }
] = [
    { namae = "明治神宮前"; saitan_kyori = infinity; temae_list = [] }
]
let test_13_7_3 = koushin { namae = "代々木公園"; saitan_kyori = 2.1; temae_list = ["代々木公園"; "明治神宮前"; "表参道"]} [
    { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] };
] = [
    { namae = "代々木上原"; saitan_kyori = 3.1; temae_list = ["代々木上原"; "代々木公園"; "明治神宮前"; "表参道"] }
];;



(* 14.7 *)
(* 目的：
直前に確定した駅p(eki_t型)と未確定の駅のリストv(eki_t list型)を受け取ったら、
必要な更新処理を行なったあとの未確定の駅のリストを返す *)
(* koushin : eki_t -> eki_t list -> eki_t list *)
let koushin (p: eki_t) (v: eki_t list) =
  let koushin1 (p: eki_t) (q: eki_t) =
    match p with {namae = pn; saitan_kyori = ps; temae_list = pt} ->
    match q with {namae = qn; saitan_kyori = qs; temae_list = qt} ->
    let total = get_ekikan_kyori pn qn global_ekikan_list +. ps in
      if total < qs then {namae = qn; saitan_kyori = total; temae_list = qn :: pt}
                    else q in List.map (koushin1 p) v;;

(* 14.7 tests *)
let test_14_7_1 = koushin { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] } [] = []
let test_14_7_2 = koushin { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] } [
    { namae = "明治神宮前"; saitan_kyori = infinity; temae_list = [] }
] = [
    { namae = "明治神宮前"; saitan_kyori = infinity; temae_list = [] }
]
let test_14_7_3 = koushin { namae = "代々木公園"; saitan_kyori = 2.1; temae_list = ["代々木公園"; "明治神宮前"; "表参道"]} [
    { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] }
] = [
    { namae = "代々木上原"; saitan_kyori = 3.1; temae_list = ["代々木上原"; "代々木公園"; "明治神宮前"; "表参道"] }
];;



(* 14.11 *)

(* 12.2 *)
(* 目的：ekimei_t型のリストを受け取ったら、その駅名を使って eki_t型のリストを作る *)
(* make_eki_list : ekimei_t list -> eki_t list *)
let rec make_eki_list (l: ekimei_t list) =
  List.map (fun (e: ekimei_t) -> match e with
    {kanji = kj; kana = kn; romaji = r; shozoku = s} ->
      {namae = kj; saitan_kyori = infinity; temae_list = []}) l;;

(* 12.2 tests *)
let test_12_2_1 = make_eki_list [] = []

let test_12_2_2 = make_eki_list [ekimei_t1] = [
    {namae = "代々木上原"; saitan_kyori = infinity; temae_list = []}
]
let test_12_2_3 = make_eki_list [ekimei_t1; ekimei_t2] = [
    {namae = "代々木上原"; saitan_kyori = infinity; temae_list = []};
    {namae = "代々木公園"; saitan_kyori = infinity; temae_list = []}
];;
let test_12_2_4 = make_eki_list [ekimei_t1; ekimei_t2; ekimei_t3; ekimei_t4] = [
    {namae = "代々木上原"; saitan_kyori = infinity; temae_list = []};
    {namae = "代々木公園"; saitan_kyori = infinity; temae_list = []};
    {namae = "明治神宮前"; saitan_kyori = infinity; temae_list = []};
    {namae = "表参道"; saitan_kyori = infinity; temae_list = []}
];;

(* 12.3 *)
(* 目的：
eki_t型のリストと起点(漢字の文字列)を受け取ったら、起点のみ
- saitan_kyori は 0
- temae_list は始点の駅名のみからなるリスト
になっている eki_t型のリストを返す *)
(* shokika : eki_t list -> string -> eki_t list *)
let rec shokika (l: eki_t list) (s: string) =
  List.map (fun (e: eki_t) -> match e with
    {namae = n; saitan_kyori = sk; temae_list = tl} ->
      if n = s then {namae = n; saitan_kyori = 0.0; temae_list = n :: tl} else e) l;;

(* 12.3 tests *)
let test_12_3_1 = shokika [] "" = [];;
let test_12_3_2 = shokika eki_list_mini "代々木上原" = [
    {namae = "代々木上原"; saitan_kyori = 0.0; temae_list = ["代々木上原"]};
    {namae = "代々木公園"; saitan_kyori = infinity; temae_list = []};
    {namae = "明治神宮前"; saitan_kyori = infinity; temae_list = []};
    {namae = "表参道"; saitan_kyori = infinity; temae_list = []}
];;



(* 14.12 *)
(* 目的：
　　ekimei_t型のリストを受け取ったら、その駅名を使って eki_t型のリストを作り、
　　起点(漢字の文字列)を受け取ったら、起点のみ
　　  - saitan_kyori は 0
　　  - temae_list は始点の駅名のみからなるリスト
　　になっている eki_t型のリストを返す *)
(* make_initial_eki_list : ekimei_t list -> string -> eki_t list *)
let rec make_initial_eki_list (l: ekimei_t list) (s: string) =
  List.map (fun (et: eki_t) -> match et with
    {namae = n; saitan_kyori = sk; temae_list = tl} ->
      if n = s then {namae = n; saitan_kyori = 0.0; temae_list = n :: tl} else et)
  (List.map (fun (el: ekimei_t) -> match el with
    {kanji = kj; kana = kn; romaji = ro; shozoku = sh} ->
      {namae = kj; saitan_kyori = infinity; temae_list = []}) l);;

(* 14.12 tests *)
let test_14_12_1 = make_initial_eki_list [] "" = [];;
let test_14_12_2 = make_initial_eki_list global_ekimei_list_mini "代々木上原" = [
    {namae = "代々木上原"; saitan_kyori = 0.0; temae_list = ["代々木上原"]};
    {namae = "代々木公園"; saitan_kyori = infinity; temae_list = []};
    {namae = "明治神宮前"; saitan_kyori = infinity; temae_list = []};
    {namae = "表参道"; saitan_kyori = infinity; temae_list = []}
];;



(* 14.13 *)
(* 目的：
直前に確定した駅p(eki_t型)と未確定の駅のリストv(eki_t list型)を受け取ったら、
必要な更新処理を行なったあとの未確定の駅のリストを返す *)
(* koushin : eki_t -> eki_t list -> eki_t list *)
let koushin (p: eki_t) (v: eki_t list) =
  List.map ((fun (p1: eki_t) (q1: eki_t) ->
    match p1 with {namae = pn; saitan_kyori = ps; temae_list = pt} ->
    match q1 with {namae = qn; saitan_kyori = qs; temae_list = qt} ->
    let total = get_ekikan_kyori pn qn global_ekikan_list +. ps in
      if total < qs then {namae = qn; saitan_kyori = total; temae_list = qn :: pt} else q1) p) v;;

(* 14.13 tests *)
let test_14_13_1 = koushin { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] } [] = []
let test_14_13_2 = koushin { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] } [
    { namae = "明治神宮前"; saitan_kyori = infinity; temae_list = [] }
] = [
    { namae = "明治神宮前"; saitan_kyori = infinity; temae_list = [] }
]
let test_14_13_3 = koushin { namae = "代々木公園"; saitan_kyori = 2.1; temae_list = ["代々木公園"; "明治神宮前"; "表参道"]} [
    { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] }
] = [
    { namae = "代々木上原"; saitan_kyori = 3.1; temae_list = ["代々木上原"; "代々木公園"; "明治神宮前"; "表参道"] }
];;



(* 15.4 *)
(* 目的：
eki_t list型のリストを受け取ったら、
最短距離最小の駅 と 最短距離最小の駅以外からなるリスト の組を返す

ポイント：パターンマッチして出た最小の数を fold_right の初期値として扱う
*)
(* saitan_wo_bunri : eki_t list -> eki_t1 * eki_t1 list *)
let saitan_wo_bunri (l: eki_t list) = match l with
    [] -> ({namae = ""; saitan_kyori = infinity; temae_list = []}, [])
  | first :: rest -> List.fold_right (fun s (p, v) ->
    match s with { namae = sn; saitan_kyori = ss; temae_list = st} ->
    match p with { namae = pn; saitan_kyori = ps; temae_list = pt} ->
      if ss < ps then (s, p::v) else (p, s::v))
      rest
      (first, []);;



(* 16.3 *)
(* 目的：
直前に確定した駅p(eki_t型)と未確定の駅のリストv(eki_t list型)を受け取ったら、
必要な更新処理を行なったあとの未確定の駅のリストを返す *)
(* koushin : eki_t -> eki_t list -> ekikan_t list -> eki_t list *)
let koushin (p: eki_t) (v: eki_t list) (e: ekikan_t list) =
  List.map ((fun (p1: eki_t) (q1: eki_t) ->
    match p1 with {namae = pn; saitan_kyori = ps; temae_list = pt} ->
    match q1 with {namae = qn; saitan_kyori = qs; temae_list = qt} ->
    let total = get_ekikan_kyori pn qn e +. ps in
      if total < qs then {namae = qn; saitan_kyori = total; temae_list = qn :: pt} else q1) p) v;;

(* 16.3 tests *)
let test_16_3_1 = koushin { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] } [] global_ekikan_list = []
let test_16_3_2 = koushin { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] } [
    { namae = "明治神宮前"; saitan_kyori = infinity; temae_list = [] }
] global_ekikan_list = [
    { namae = "明治神宮前"; saitan_kyori = infinity; temae_list = [] }
]
let test_16_3_3 = koushin { namae = "代々木公園"; saitan_kyori = 2.1; temae_list = ["代々木公園"; "明治神宮前"; "表参道"]} [
    { namae = "代々木上原"; saitan_kyori = infinity; temae_list = [] }
] global_ekikan_list = [
    { namae = "代々木上原"; saitan_kyori = 3.1; temae_list = ["代々木上原"; "代々木公園"; "明治神宮前"; "表参道"] }
];;



(* 16.4 *)
(* 目的：
eki_t list型の未確定の駅リストと ekikan_t list型の駅間のリストを受け取ったら、
ダイクストラのアルゴリズムにしたがって各駅について最短距離と最短経路が正しく入った
eki_t list型のリストを返す
*)
(* dijkstra_main : eki_t list -> ekikan_t list -> eki_t list *)
let rec dijkstra_main (v: eki_t list) (e: ekikan_t list) = match v with
    [] -> []
  | first :: rest ->
      let (saitan, nokori) = saitan_wo_bunri (first :: rest) in
      let (v2: eki_t list) = koushin saitan nokori e in
      saitan :: dijkstra_main v2 e

(* 16.4 tests *)
let test_data_16_4 = [
  {namae="池袋"; saitan_kyori = infinity; temae_list = []};
  {namae="新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]};
  {namae="茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]};
  {namae="後楽園"; saitan_kyori = infinity; temae_list = []}
]

let test_16_4_1 = dijkstra_main [] global_ekikan_list = []
let test_16_4_2 = dijkstra_main test_data_16_4 global_ekikan_list = [
  {namae = "茗荷谷"; saitan_kyori = 0.; temae_list = ["茗荷谷"]};
  {namae = "新大塚"; saitan_kyori = 1.2; temae_list = ["新大塚"; "茗荷谷"]};
  {namae = "後楽園"; saitan_kyori = 1.8; temae_list = ["後楽園"; "茗荷谷"]};
  {namae = "池袋"; saitan_kyori = 3.; temae_list = ["池袋"; "新大塚"; "茗荷谷"]}
]



(* 16.5 *)
(* 目的：
始点と終点の駅名(ローマ字の文字列)を受け取ったら、
（seiretsu を使って global_ekimei_list の重複を取り除き、
 romaji_to_kanji を使って始点と終点の漢字表記を求め、
 make_initial_eki_list を使って駅のリスト (eki_t list 型) を作り、
 dijkstra_main を使って各駅までの最短路を確定し、
 その中から）終点の駅のレコード (eki_t 型) を返す
*)
(* dijkstra : string -> string -> eki_t *)
let dijkstra romaji_kiten romaji_shuten =
  let seiretsuzumi_ekimei_list = seiretsu global_ekimei_list in
  let kanji_kiten = romaji_to_kanji romaji_kiten seiretsuzumi_ekimei_list in
  let kanji_shuten = romaji_to_kanji romaji_shuten seiretsuzumi_ekimei_list in
  let initialized_eki_list = make_initial_eki_list seiretsuzumi_ekimei_list kanji_kiten in
  let eki_list = dijkstra_main initialized_eki_list global_ekikan_list in
  (* 目的：eki_t list型のリストから終点のレコード(eki_t)を返す *)
  (* get_shuten : string -> eki_t list -> eki_t *)
  let rec get_shuten (e: string) (l: eki_t list) = match l with
      [] -> {namae = ""; saitan_kyori = infinity; temae_list = []}
    | ({namae = n; saitan_kyori = s; temae_list = t} as first) :: rest ->
        if n = e then first
                 else get_shuten e rest in
    get_shuten kanji_shuten eki_list;;

let test_16_5_1 = dijkstra "ikebukuro" "meguro";;
