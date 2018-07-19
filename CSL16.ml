(* #use "CSL16.ml";; *)
(* exit 0;; *)


(* 木を表す型 *)
type tree_t = Empty                          (* 空の木 *)
            | Leaf of int                    (* 葉 *)
            | Node of tree_t * int * tree_t  (* 節 *)

(* 17.10 *)
(* 目的：木の節に以下のリストを持つ木の型
・駅名(漢字)
・隣接する駅名と距離の組
 *)
(* ekikan_tree_t : ekikan_tree_t *)
type ekikan_tree_t =
    Empty
  | Node of string * (string * float) list * ekikan_tree_t * ekikan_tree_t;;

(* 17.11 *)
(* 目的：「駅名」と「駅名と距離の組みのリスト」を受け取ったら、その駅までの距離を返す *)
(* assoc : string -> (string * float) list -> float *)
let rec assoc_ ekimei lst = match lst with
    [] -> infinity
  | (e, k) :: rest ->
      if e = ekimei then k else assoc_ ekimei rest;;

(* 17.11 tests *)
let test_17_11_1 = assoc_ "後楽園" [] = infinity
let test_17_11_2 = assoc_ "後楽園" [("新大塚", 1.2); ("後楽園", 1.8)] = 1.8
let test_17_11_3 = assoc_ "池袋" [("新大塚", 1.2); ("後楽園", 1.8)] = infinity;;
