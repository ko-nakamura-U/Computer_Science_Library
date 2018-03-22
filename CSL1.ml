
(*4.1*)
let baito_kyuyo x y = ((850 + (100 * y)) * x);;
print_int(baito_kyuyo 20 1); print_newline()

(*4.2*)
let jikoshokai x = "My name is " ^ x;;
print_string(jikoshokai "Tom"); print_newline()

(*4.3*)
let hyojun_taiju m = (m ** 2.0) *. 22.0;;
print_float(hyojun_taiju 170.0); print_newline()

(*4.4*)
let bmi m kg = kg /. (m ** 2.0);;
print_float(bmi 170.0 60.0); print_newline()






(*4.6*)
(* (1) *)
(* 目的：鶴の数 x (int型) に対する足の本数を計算する *)

(* (2) *)
(* let tsuru_no_ashi : int -> int *)

(* (3) *)
(* テスト *)
let tsuru_no_ashi x : int = x * 2(* intはxでなくtsuru_no_ashiに対するintになる *)
let test1 = tsuru_no_ashi 1 = 2
let test2 = tsuru_no_ashi 2 = 4
let test3 = tsuru_no_ashi 10 = 20;;
print_string(string_of_bool(test1));;
print_string(string_of_bool(test2));;
print_string(string_of_bool(test3));;

(* (4)(5) *)
print_int(tsuru_no_ashi 4); print_newline();;

(* (6) *)
(* #use "CSL1.ml" ;; *)
val tsuru_no_ashi : int -> int = <fun>
val test1 : bool = true
val test2 : bool = true
val test3 : bool = true
true- : unit = ()
true- : unit = ()
true- : unit = ()

(* (7) *)
print_int(tsuru_no_ashi 4); print_newline();;




(*4.7*)
(* (1) *)
(* 目的：鶴の数 x (int型)と亀の数 y (int型) を合わせた足の合計を計算する *)

(* (2) *)
(* tsurukame_no_ashi : (int -> int -> int *)

(* (3)(4)(7) *)
let tsurukame_no_ashi x y = (x * 2) + (y * 4)
let test1 = tsurukame_no_ashi 1 1 = 6
let test2 = tsurukame_no_ashi 2 2 = 12
let test3 = tsurukame_no_ashi 1 3 = 14;;
print_string(string_of_bool(test1)); print_newline();;
print_string(string_of_bool(test2)); print_newline();;
print_string(string_of_bool(test3)); print_newline();;

(* (5) *)
let tsuru_no_ashi x : int = x * 2
let tsurukame_no_ashi x y = (tsuru_no_ashi x) + (y * 4);;
print_int(tsurukame_no_ashi 2 2); print_newline();;

(* (6) *)
(* #use "CSL1.ml";; *)
(* # #use "CSL1.ml";;
val tsurukame_no_ashi : int -> int -> int = <fun>
val test1 : bool = true
val test2 : bool = true
val test3 : bool = true
true
- : unit = ()
true
- : unit = ()
true
- : unit = () *)




(*4.8*)
(* (1) *)
(* 目的：鶴と亀を合わせた数 x (int型)と鶴と亀を合わせた足の本数 y (int型)から鶴の数を計算する *)

(* (2) *)
(* tsurukame : (int -> int) -> int *)

(* (3)(4)(7) *)
let kame_no_ashi x = (x * 4)
let tsurukame x y = ((kame_no_ashi x)-y)/2;;

let test1 = tsurukame 2 6 = 1
let test2 = tsurukame 3 8 = 2
let test3 = tsurukame 3 10 = 1;;
print_string(string_of_bool(test1)); print_newline();;
print_string(string_of_bool(test2)); print_newline();;
print_string(string_of_bool(test3)); print_newline();;

(* (5) *)
let kame_no_ashi x = (x * 4)
let tsurukame x y = ((kame_no_ashi x)-y)/2;;
print_int(tsurukame 2 6); print_newline();;

(* (6) *)
(* #use "CSL1.ml";; *)
(* val kame_no_ashi : int -> int = <fun>
val tsurukame : int -> int -> int = <fun>
val test1 : bool = true
val test2 : bool = true
val test3 : bool = true
true
- : unit = ()
true
- : unit = ()
true
- : unit = () *)
