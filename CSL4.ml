(*9.4*)
(* 目的：受け取ったリストの要素の数を返す *)
(* length : int list -> int *)
let rec length l = match l with
    [] -> 0
  | first :: rest -> 1 + length rest;;
(* テスト *)
let test1 = length [] = 0;;
let test2 = length [0] = 1;;
let test3 = length [1; 2; 3; 4; 5] = 5;;


(*9.5*)
(* 目的：整数のリストを受け取ったら偶数の要素のみを含むリストを返す *)
(* even : list -> list *)
let rec even l = match l with
    [] -> []
  | first :: rest -> if first mod 2 = 0 then first :: even rest
                                        else even rest;;
(* テスト *)
let test1 = even [] = []
let test2 = even [1] = []
let test3 = even [2] = [2]
let test4 = even [1; 2; 3; 4; 5] = [2; 4];;


(*9.6*)
(* 目的：文字列のリストを受け取ったら、その要素を前からくっつけた文字列を返す *)
(* concat : list -> string *)
let rec concat l = match l with
    [] -> ""
  | first :: rest -> if first == "" then concat rest
                                    else first^concat rest;;

(* テスト *)
let test1 = concat [] = ""
let test2 = concat ["春"] = "春"
let test2 = concat [""; "春"] = "春"
let test3 = concat ["春"; "夏"; "秋"; "冬"] = "春夏秋冬";;


(*9.7*)
(* #use "CSL4.ml";; *)
(* exit 0;; *)

(* 各人（名前, 身長, 体重, 誕生日(月・日), 血液型）を表す型 *)
type person_t = {
  name : string;       (*名前*)
  m : float;          (*身長*)
  kg : float;         (*体重*)
  birthday_m : int;  (*誕生日 月*)
  birthday_d : int;  (*誕生日 日にち*)
  blood : string;     (*血液型*)
};;

(* 目的：person_t型のデータのリストを受け取ったら、血液型A型の人の数を返す *)
(* count_ketsueki_A : list -> int *)
let rec count_ketsueki_A l = match l with
    [] -> 0
  | {name=n; m=m; kg=kg; birthday_m=bm; birthday_d=bd; blood=b} :: rest
      -> if b = "A" then 1 + count_ketsueki_A rest
                     else count_ketsueki_A rest;;

(* テスト *)
let person_t1 = {name="a-san"; m=180.0; kg=80.0; birthday_m=1; birthday_d=1; blood="A"}
let person_t2 = {name="a-san2"; m=170.0; kg=70.0; birthday_m=2; birthday_d=2; blood="A"}
let person_t3 = {name="b-san"; m=160.0; kg=60.0; birthday_m=3; birthday_d=3; blood="B"}
let person_t4 = {name="o-san"; m=150.0; kg=50.0; birthday_m=4; birthday_d=4; blood="O"}
let person_t5 = {name="a-san3"; m=190.0; kg=90.0; birthday_m=5; birthday_d=5; blood="A"};;

let test1 = count_ketsueki_A [] = 0;;  (**)
let test2 = count_ketsueki_A [person_t1; person_t2; person_t3] = 2;; (*AAB*)
let test3 = count_ketsueki_A [person_t3; person_t4] = 0;; (*BO*)
let test4 = count_ketsueki_A [person_t1; person_t2; person_t3; person_t4; person_t5] = 3;; (*AABOA*)



(*9.8*)
(* 目的：person_t型のデータのリストを受け取ったら、乙女座の人の名前のみからなるリスト返す（乙女座: 8/23~9/22） *)
(* otomeza : list -> list *)
let rec otomeza l = match l with
    [] -> []
  | {name=n; m=m; kg=kg; birthday_m=bm; birthday_d=bd; blood=b} :: rest
      -> if (bm = 8 && ( 1 <= bd && bd <= 23 )) || (bm = 9 && ( 1 <= bd && bd <= 22 )) then n :: otomeza rest
                                                                                       else otomeza rest;;

(* テスト *)
let person_t1 = {name="otome-san"; m=180.0; kg=80.0; birthday_m=8; birthday_d=1; blood="A"}
let person_t2 = {name="otome-san2"; m=170.0; kg=70.0; birthday_m=9; birthday_d=22; blood="A"}
let person_t3 = {name="b-san"; m=160.0; kg=60.0; birthday_m=8; birthday_d=24; blood="B"}
let person_t4 = {name="o-san"; m=150.0; kg=50.0; birthday_m=1; birthday_d=1; blood="O"}
let person_t5 = {name="otome-san3"; m=190.0; kg=90.0; birthday_m=9; birthday_d=1; blood="A"};;

let test1 = otomeza [] = [];;  (**)
let test2 = otomeza [person_t1; person_t2; person_t3] = ["otome-san"; "otome-san2"];; (* o o2 - *)
let test3 = otomeza [person_t3; person_t4] = [];; (* - - *)
let test4 = otomeza [person_t1; person_t2; person_t3; person_t4; person_t5] = ["otome-san"; "otome-san2"; "otome-san3"];; (* o o2 - o3 - *)



(*
  （注）
  ・条件式 = と == は違う
    ・=  は値が一致
    ・== はインスタンスも一致
*)
