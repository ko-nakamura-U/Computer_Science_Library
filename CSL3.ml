(*8.1*)
(* 本のデータ（タイトル, 著者, 出版社, 値段, ISBN）を表す型 *)
type book_t = {
  title : string;      (*タイトル*)
  author : string;     (*著者*)
  publisher : string;  (*出版社*)
  price : int;         (*値段*)
  isbn : int;          (*ISBN*)
};;

let book_t1 = {title = "Abook is good"; author = "a-san"; publisher = "AbookNext"; price = 100; isbn = 12345};;
let book_t2 = {title = "Bbook is good"; author = "b-san"; publisher = "BbookNext"; price = 200; isbn = 678910};;
let book_t3 = {title = "Cbook is good"; author = "c-san"; publisher = "CbookNext"; price = 300; isbn = 111213};;


(*8.3*)
(* 各人（名前, 身長, 体重, 誕生日, 血液型）を表す型 *)
type person_t = {
  name : string;       (*名前*)
  m : float;          (*身長*)
  kg : float;         (*体重*)
  birthday : string;  (*誕生日*)
  blood : string;     (*血液型*)
};;

let person_t1 = {name="a-san"; m=180.0; kg=80.0; birthday="1月1日"; blood="A"};;
let person_t2 = {name="b-san"; m=170.0; kg=70.0; birthday="2月2日"; blood="B"};;
let person_t3 = {name="o-san"; m=160.0; kg=60.0; birthday="3月3日"; blood="O"};;


(*8.4*)
(* 各人（名前, 身長, 体重, 誕生日, 血液型）を表す型 *)
type person_t = {
  name : string;       (*名前*)
  m : float;          (*身長*)
  kg : float;         (*体重*)
  birthday : string;  (*誕生日*)
  blood : string;     (*血液型*)
};;

(* 目的：person_t型のデータを受け取り、"◯◯さんの血液型は△型です"という文字列を返す *)
(* ketsueki_hyoji : person_t -> string *)
let ketsueki_hyoji person_t1 = match person_t1 with
  person_t1 -> person_t1.name^"さんの血液型は"^person_t1.blood^"型です";;

print_string(ketsueki_hyoji {name="a-san"; m=180.0; kg=80.0; birthday="1月1日"; blood="A"});;


(*8.5*)(*8.6*)
(* 駅名（漢字の駅名, ひらがなの駅名, ローマ字の駅名, その駅が所属する路線名）を表す型 *)
type ekimei_t = {
  kanji : string;    (*名前*)
  kana : string;     (*身長*)
  romaji : string;   (*体重*)
  shozoku : string;  (*誕生日*)
};;
let eki = {kanji="目黒"; kana="めぐろ"; romaji="meguro"; shozoku="山手線"};;

(* 目的：ekimei_t型のデータを受け取り、路線名、駅名（かな）の形式で文字列を返す *)
(* hyoji : person_t -> string *)
let hyoji eki = match eki with
  ekimei_t -> eki.shozoku^", "^eki.kana;;
print_string(hyoji eki);;



(*9.1*)
"春" :: "夏" :: "秋" :: "冬" :: []

(*9.3*)
["春"; "夏"; "秋"; "冬"];;
