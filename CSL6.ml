(* #use "CSL6.ml";; *)
(* exit 0;; *)

(* 10.5 *)
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
let gakusei_t4 = {name="d-san"; tensuu=100; seiseki="D"}
let gakusei_t5 = {name="e-san"; tensuu=80; seiseki="E"};;

(* 目的：gakusei_t型のリストを受け取ったら、その中で最高得点を取った人のレコードを返す *)
(* gakusei_max : gakusei_t list -> gakusei_t *)
let rec gakusei_max l = match l with
    [] -> {name=""; tensuu=min_int; seiseki=""}
  | first :: rest -> if first.tensuu > (gakusei_max rest).tensuu then first
                                                                 else gakusei_max rest;;
(* テスト *)
let test1 = gakusei_max [gakusei_t1] = gakusei_t1
let test2 = gakusei_max [gakusei_t1; gakusei_t2] = gakusei_t2
let test3 = gakusei_max [gakusei_t3; gakusei_t2] = gakusei_t3
let test4 = gakusei_max [gakusei_t1; gakusei_t2; gakusei_t3; gakusei_t4; gakusei_t5] = gakusei_t4;;



(* 10.6 *)
let rec gakusei_max l = match l with
    [] -> {name=""; tensuu=min_int; seiseki=""}
  | first :: rest -> let max_rest = gakusei_max rest in
                     if first.tensuu > max_rest.tensuu
                     then first
                     else max_rest;;
