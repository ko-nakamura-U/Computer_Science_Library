(* #use "CSL10.ml";; *)
(* exit 0;; *)

(* 14.1 *)
(* 目的：整数のリストを受け取ったら、偶数の要素のみを含むリストを返す *)
(* even : int list -> int list *)
let is_even n = n mod 2 = 0;;
let even l = List.filter is_even l;;

(* 14.1 tests *)
let test_14_1_1 = even [] = []
let test_14_1_2 = even [1] = []
let test_14_1_3 = even [2] = [2]
let test_14_1_4 = even [2; 1; 6; 4; 7] = [2; 6; 4];;



(* 14.2 *)
(* 学生1人分の 名前, 点数, 成績 を表す型 *)
type gakusei_t = {
  name : string;     (* 名前 *)
  tensuu : int;      (* 点数 *)
  seiseki : string;  (* 成績 *)
};;
(* test data *)
let gakusei_t1 = {name="a-san"; tensuu=10; seiseki="A"}
let gakusei_t2 = {name="b-san"; tensuu=22; seiseki="B"}
let gakusei_t3 = {name="c-san"; tensuu=75; seiseki="C"}
let gakusei_t4 = {name="d-san"; tensuu=80; seiseki="D"}
let gakusei_t5 = {name="e-san"; tensuu=100; seiseki="E"};;

(* 目的：学生リスト 1st のうち成績が A の人の数を返す *)
(* is_A : gakusei_t -> bool *)
let is_A (g: gakusei_t) = match g with
  {name=n; tensuu=t; seiseki=s} -> s = "A";;

(* count_A : gakusei_t list -> int *)
let count_A (l: gakusei_t list) = List.length (List.filter is_A l);;

(* 14.2 tests *)
let test_14_2_1 = count_A [] = 0
let test_14_2_2 = count_A [gakusei_t1] = 1
let test_14_2_3 = count_A [gakusei_t1; gakusei_t2; gakusei_t3] = 1
let test_14_2_4 = count_A [gakusei_t1; gakusei_t1; gakusei_t3] = 2;;



(* 14.3 *)
(* 目的：文字列のリストを受け取ったら、その要素を前からくっつけた文字列を返す *)
(* count_A : string list -> string *)
let append first rest = first^rest;;
let concat l = List.fold_right append l "";;

(* 14.3 tests *)
let test_14_3_1 = concat [] = ""
let test_14_3_2 = concat ["春"] = "春"
let test_14_3_3 = concat [""; "春"] = "春"
let test_14_3_4 = concat ["春"; "夏"; "秋"; "冬"] = "春夏秋冬";;



(* 14.4 *)
(* 目的：gakusei_t型のリストを受け取ったら、全員の得点の合計を返す *)

(* sum : gakusei_t list -> int -> int *)
let sum (g1: gakusei_t) n =
  match g1 with {name = n1; tensuu = t1; seiseki = s1} -> t1 + n;;

(* gakusei_sum : gakusei_t list -> int *)
let gakusei_sum (l: gakusei_t list) = List.fold_right sum l 0;;

(* 14.4 tests *)
let test_14_4_1 = gakusei_sum [] = 0
let test_14_4_2 = gakusei_sum [gakusei_t1] = 10
let test_14_4_3 = gakusei_sum [gakusei_t1; gakusei_t2; gakusei_t3;] = 107
let test_14_4_4 = gakusei_sum [gakusei_t1; gakusei_t2; gakusei_t3; gakusei_t4; gakusei_t5] = 287;;



(* 14.5 *)

(* 14.1 *)
let even l =
  let is_even n = n mod 2 = 0 in
      List.filter is_even l;;

(* 14.2 *)
let count_A (l: gakusei_t list) =
  let is_A (g: gakusei_t) = match g with
    {name=n; tensuu=t; seiseki=s} -> s = "A" in
        List.length (List.filter is_A l);;

(* 14.3 *)
let concat l =
  let append first rest = first^rest in
      List.fold_right append l "";;

(* 14.4 *)
let gakusei_sum (l: gakusei_t list) =
  let sum (g1: gakusei_t) n =
    match g1 with {name = n1; tensuu = t1; seiseki = s1} -> t1 + n in
        List.fold_right sum l 0;;

(* 14.5 tests *)
let test_14_5_1 = even [] = []
let test_14_5_2 = even [1] = []
let test_14_5_3 = even [2] = [2]
let test_14_5_4 = even [2; 1; 6; 4; 7] = [2; 6; 4];;

let test_14_5_5 = count_A [] = 0
let test_14_5_6 = count_A [gakusei_t1] = 1
let test_14_5_7 = count_A [gakusei_t1; gakusei_t2; gakusei_t3] = 1
let test_14_5_8 = count_A [gakusei_t1; gakusei_t1; gakusei_t3] = 2;;

let test_14_5_9 = concat [] = ""
let test_14_5_10 = concat ["春"] = "春"
let test_14_5_11 = concat [""; "春"] = "春"
let test_14_5_12 = concat ["春"; "夏"; "秋"; "冬"] = "春夏秋冬";;

let test_14_5_13 = gakusei_sum [] = 0
let test_14_5_14 = gakusei_sum [gakusei_t1] = 10
let test_14_5_15 = gakusei_sum [gakusei_t1; gakusei_t2; gakusei_t3;] = 107
let test_14_5_16 = gakusei_sum [gakusei_t1; gakusei_t2; gakusei_t3; gakusei_t4; gakusei_t5] = 287;;



(* 14.6 *)
(* 目的：学生リスト 1st のうち成績が seiseki0 の人の数を返す *)
(* count : gakusei_t list -> string -> int *)
(* is_seiseki0 : gakusei_t -> bool *)
let count (l: gakusei_t list) (s: string) =
  let is_seiseki0 (s0: gakusei_t) = match s0 with
      {name = name; tensuu = tensuu; seiseki = seiseki} -> s = seiseki in
          List.length (List.filter is_seiseki0 l);;

(* 14.6 tests *)
let test_14_6_1 = count [gakusei_t1] "A" = 1
let test_14_6_2 = count [gakusei_t1; gakusei_t2] "A" = 1
let test_14_6_3 = count [gakusei_t1; gakusei_t1; gakusei_t2] "A" = 2;;



(* 14.8 *)
(* 目的：整数を受け取ったら、その2乗から1を引いた数を返す *)
fun i -> (i * i) - 1;;

(* 14.9 *)
(* 各人（名前, 身長, 体重, 誕生日, 血液型）を表す型 *)
type person_t = {
  name : string;       (*名前*)
  m : float;          (*身長*)
  kg : float;         (*体重*)
  birthday : string;  (*誕生日*)
  blood : string;     (*血液型*)
};;

(* 目的：person_t型のデータを受け取ったら、その名前のフィールドを返す *)
fun (pt: person_t) -> match pt with
  {name=n; m=m; kg=kg; birthday=bd; blood=b} -> n;;



(* 14.10 *)

(* 14.1 *)
let even (l: int list) = List.filter (fun n -> n mod 2 = 0) l;;

(* 14.2 *)
let count_A (l: gakusei_t list) =
  List.length (List.filter (fun (gt: gakusei_t) -> match gt with {name=n; tensuu=t; seiseki=s} -> s = "A") l);;

(* 14.3 *)
let concat (l: string list) = List.fold_right (fun s1 s2 -> s1^s2) l "";;

(* 14.4 *)
let gakusei_sum (l: gakusei_t list) =
  List.fold_right (fun (g1: gakusei_t) n ->
    match g1 with {name = n1; tensuu = t1; seiseki = s1} -> t1 + n) l 0;;
