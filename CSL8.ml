(* #use "CSL8.ml";; *)
(* exit 0;; *)

(* 13.1 (下準備) *)
(* 各人（名前, 身長, 体重, 誕生日(月・日), 血液型）を表す型 *)
type person_t = {
  name : string;       (*名前*)
  m : float;          (*身長*)
  kg : float;         (*体重*)
  birthday_m : int;  (*誕生日 月*)
  birthday_d : int;  (*誕生日 日にち*)
  blood : string;     (*血液型*)
};;

let person_t1 = {name="a-san"; m=180.0; kg=80.0; birthday_m=1; birthday_d=1; blood="A"}
let person_t2 = {name="b-san"; m=170.0; kg=70.0; birthday_m=2; birthday_d=2; blood="A"}
let person_t3 = {name="c-san"; m=160.0; kg=60.0; birthday_m=3; birthday_d=3; blood="B"}
let person_t4 = {name="d-san"; m=150.0; kg=50.0; birthday_m=4; birthday_d=4; blood="O"}
let person_t5 = {name="e-san"; m=190.0; kg=90.0; birthday_m=5; birthday_d=5; blood="A"};;

(* 目的：person_t型のリストを受け取ったら、Aの血液型の人の数を返す *)
(* count_ketsueki : list -> string *)
let rec count_ketsueki_a l = match l with
  | [] -> 0
    | {name=n; m=m; kg=k; birthday_m=bm; birthday_d=bd; blood=b} :: rest ->
        if b = "A" then 1 + count_ketsueki_a rest
                    else count_ketsueki_a rest;;

(* テスト *)
let test1 = count_ketsueki_a [] = 0
let test2 = count_ketsueki_a [person_t1] = 1
let test3 = count_ketsueki_a [person_t2] = 1
let test4 = count_ketsueki_a [person_t3] = 0
let test5 = count_ketsueki_a [person_t1; person_t2; person_t3; person_t4; person_t5] = 3;;


(* 13.1 (本題) *)
(* 目的：person_t型のリストを受け取ったら、指定された血液型の人の数を返す *)
(* count_ketsueki : list string -> string *)
let rec count_ketsueki_a l blood = match l with
  | [] -> 0
    | {name=n; m=m; kg=k; birthday_m=bm; birthday_d=bd; blood=b} :: rest ->
        if b = blood then 1 + count_ketsueki_a rest blood
                     else count_ketsueki_a rest blood;;

(* テスト *)
let test1 = count_ketsueki_a [] "A" = 0
let test2 = count_ketsueki_a [person_t1] "A" = 1
let test3 = count_ketsueki_a [person_t2] "A" = 1
let test4 = count_ketsueki_a [person_t3] "A" = 0
let test5 = count_ketsueki_a [person_t1; person_t2; person_t3; person_t4; person_t5] "A" = 3;;


(*
高階関数：その関数の引数に関数を受けたり、結果を関数でできたりする関数のこと。

関数を実数と同じように引数に適応したり、結果を関数で返したり、
変数として持ったりできる関数のこと。このことを 関数がfirst-classの値である という言い方をする。
*)

(* map関数：全ての要素に対して関数の処理を加えれる関数。List.mapとして定義されている。 *)



(* 13.2 *)
(* List.mapなし *)
(* let rec person_namae l = match l with
  | [] -> []
    | {name=n; m=m; kg=k; birthday_m=bm; birthday_d=bd; blood=b} :: rest -> n :: person_namae rest;; *)

(* List.mapあり *)
(* 目的：person_t型の値を受け取ったら、その中の人の名前を返す *)
(* get_person : person_t -> string *)
let get_person e = match e with
    {name=n; m=m; kg=k; birthday_m=bm; birthday_d=bd; blood=b} -> n;;

(* 目的：person_t型のリストを受け取ったら、その中の人の名前のリストを返す *)
(* person_namae : person_t list -> string list *)
let person_namae l = List.map get_person l;;

(* テスト *)
let test1 = person_namae [] = []
let test2 = person_namae [person_t1] = ["a-san"]
let test3 = person_namae [person_t1; person_t2] = ["a-san"; "b-san"]
let test4 = person_namae [person_t1; person_t2; person_t3; person_t4; person_t5] = ["a-san"; "b-san"; "c-san"; "d-san"; "e-san"];;
