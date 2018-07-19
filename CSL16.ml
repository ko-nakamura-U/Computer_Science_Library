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
