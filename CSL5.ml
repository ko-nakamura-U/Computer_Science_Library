(* 再起関数の中で再起関数を使う時は、この関数には何を与えたら何が帰ってくるかというのを１つ１つ考えればよい *)

(* #use "CSL5.ml";; *)
(* exit 0;; *)


(*10.1*)
(* 目的：すでに昇順に並んだリストに数値を受け取ったら、リストが昇順となる位置に要素を追加したリストを返す *)
(* insert : int list -> int -> int list *)
let rec insert l n = match l with
    [] -> n :: []
  | first :: rest -> if n >= first then first :: insert rest n
                                   else n :: l;;

(* テスト *)
let test1 = insert [] 1 = [1]
let test2 = insert [1; 3; 4] 2 = [1; 2; 3; 4]
let test3 = insert [5; 7; 8] 2 = [2; 5; 7; 8]
let test4 = insert [1; 3; 4] 3 = [1; 3; 3; 4]
let test4 = insert [1; 2; 3] 10 = [1; 2; 3; 10];;



(*10.2*)
(* 目的：整数のリストを受け取ったら、それを昇順に整列したリストを返す *)
(* ins_sort : list -> list *)
let rec insert l n = match l with
    [] -> n :: []
  | first :: rest -> if n >= first then first :: insert rest n
                                   else n :: l;;

let rec ins_sort l = match l with
    [] -> []
  | first :: rest -> insert (ins_sort rest) first;;

(* テスト *)
let test1 = ins_sort [] = []
let test2 = ins_sort [1; 2; 3] = [1; 2; 3]
let test3 = ins_sort [1; 3; 2] = [1; 2; 3]
let test4 = ins_sort [1; 3; 2; 3] = [1; 2; 3; 3]
let test5 = ins_sort [7; 3; 2; 4; 5; 8; 6; 1] = [1; 2; 3; 4; 5; 6; 7; 8];;

(*
  バブルソート
  [4; 1; 3; 2]  左から前後を比較して右が一番大きい数字にする
  [1; 4; 3; 2]
  [1; 3; 4; 2]
  [1; 3; 2; 4]
  [1; 3; 2; 4]

  [1; 3; 2; 4]  4以外を比較で同じことを行う
  [1; 2; 3; 4]
*)



(*10.3*)
(* 各人（名前, 点数, 成績）を表す型 *)
type gakusei_t = {
  name : string;     (* 名前 *)
  tensuu : int;      (* 点数 *)
  seiseki : string;  (* 成績 *)
};;
(* テスト *)
let gakusei_t1 = {name="a-san"; tensuu=10; seiseki="A"}
let gakusei_t2 = {name="b-san"; tensuu=22; seiseki="B"}
let gakusei_t3 = {name="c-san"; tensuu=75; seiseki="C"}
let gakusei_t4 = {name="d-san"; tensuu=80; seiseki="D"}
let gakusei_t5 = {name="e-san"; tensuu=100; seiseki="E"};;

(* 目的：gakusei_tのリストとgakusei_tの要素を受け取ったら、成績の昇順となる位置に要素を追加したgakusei_tのリストを返す *)
(* insert : gakusei_t list -> gakusei_t -> gakusei_t list *)
let rec gakusei_insert l e = match l with
  [] -> e :: []
    | first :: rest -> if e.seiseki >= first.seiseki then first :: gakusei_insert rest e
                                                    else e :: l;;

(* 目的：gakusei_t型のリストを受け取ったら点数を昇順に整列したリストを返す *)
(* gakusei_sort : gakusei_t list -> gakusei_t list *)

let rec gakusei_sort l = match l with
    [] -> []
  | first :: rest -> gakusei_insert (gakusei_sort rest) first;;

let test1 = gakusei_sort [] = []
let test2 = gakusei_sort [gakusei_t1] = [gakusei_t1]
let test3 = gakusei_sort [gakusei_t1; gakusei_t2; gakusei_t3] = [gakusei_t1; gakusei_t2; gakusei_t3]
let test4 = gakusei_sort [gakusei_t4; gakusei_t3; gakusei_t2; gakusei_t1] = [gakusei_t1; gakusei_t2; gakusei_t3; gakusei_t4]
let test5 = gakusei_sort [gakusei_t3; gakusei_t1; gakusei_t2; gakusei_t4; gakusei_t5] = [gakusei_t1; gakusei_t2; gakusei_t3; gakusei_t4; gakusei_t5];;



(*10.4*)
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

(* 目的：person_t型のリストperson_t型の値を受け取ったら、リストの名前順となるような位置に要素を追加したperson_t型のリストを返す *)
(* person_insert : person_insert list -> person_insert list -> person_t list *)
let rec person_insert l e = match l with
    [] -> e :: []
  | first :: rest -> if e.name > first.name then first :: person_insert rest e
                                            else e :: l;;

(* 目的：person_t型のリストを受け取ったら、名前を整列したperson_t型のリストを返す *)
(* person_sort : person_t list -> person_t list *)
let rec person_sort l = match l with
    [] -> []
  | first :: rest -> person_insert (person_sort rest) first;;

(* テスト *)
let test1 = person_sort [] = []
let test2 = person_sort [person_t1] = [person_t1]
let test3 = person_sort [person_t1; person_t2] = [person_t1; person_t2]
let test4 = person_sort [person_t4; person_t2; person_t3; person_t1] = [person_t1; person_t2; person_t3; person_t4]
let test5 = person_sort [person_t2; person_t1; person_t5; person_t4; person_t3] = [person_t1; person_t2; person_t3; person_t4; person_t5];;
