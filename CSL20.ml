(* #use "CSL20.ml";; *)
(* exit 0;; *)


(* 20.7 *)

module type MySet = sig
    type 'a t

    val empty : 'a t  (* 空の要素 *)

    val singleton : 'a -> 'a t  (* 要素ひとつからなる集合 *)

    val to_set : 'a list -> 'a t  (* 'a list から集合に変換 *)

    val to_list : 'a t -> 'a list  (* 集合からリストに変換 *)

    val union : 'a t -> 'a t -> 'a t  (* 和集合 *)

    val inter : 'a t -> 'a t -> 'a t  (* 共通部分 *)

    val diff : 'a t -> 'a t -> 'a t  (* 差集合 *)

    val mem : 'a -> 'a t -> bool  (* 要素が集合に入っているか *)
end


(* 内部を list で実装した集合 *)
module ListSet: MySet = struct

  type 'a t = Set of 'a list

  let empty = Set([]);;

  let singleton e = Set([e]);;

  let to_set l = Set(List.fold_right (fun x a -> List.mem x a then a else x::a) l []);;
  (* ListSet.to_list [ 1; 2; 2; 3; 4; 4; 5; 7;] => [1; 2; 3; 4; 5; 7] *)

  let to_list s = match s with Set(l) -> l;;
  (* s => Set(l) *)

  let union s1 s2 = match (s1, s2) with
      (Set(l1), Set(l2)) -> Set((List.filter (fun x -> not (List.mem x l2)) l1) @ l2);;

  let union2 s1 s2 = match (s1, s2) with
      (Set(l1), Set(l2)) -> Set((List.fold_right (fun x a -> List.mem x a then a else x::a)) l1@l2 []);;

  let inter s1 s2 = match (s1, s2) with
      (Set(l1), Set(l2)) -> Set(List.filter (fun x -> List.mem x l2) l1);;

  let diff s1 s2 = match (s1, s2) with
      (Set(l1), Set(l2)) -> Set(List.filter (fun x -> not (List.mem x l2)) l1);;

  let mem e s = match s with Set(l) -> List.mem e l;;
end


(* 内部を赤黒木で実装した場合 *)

module TreeSet : MySet = struct
  type color_t = Red | Black

  type ('a, 'b) rb_tree_t = Empty
                          | Node of ('a, 'b) rb_tree_t * 'a * 'b * color_t * ('a, 'b) rb_tree_t


  let balance (tree: ('a, 'b) rb_tree_t) = match tree with
      Node (Node (Node (a, xa, xb, Red, b), ya, yb, Red, c), za, zb, Black, d)
    | Node (Node (a, xa, xb, Red, Node (b, ya, yb, Red, c)), za, zb, Black, d)
    | Node (a, xa, xb, Black, Node (Node (b, ya, yb, Red, c), za, zb, Red, d))
    | Node (a, xa, xb, Black, Node (b, ya, yb, Red, Node (c, za, zb, Red, d)))
        -> Node (Node (a, xa, xb, Black, b), ya, yb, Red, Node (c, za, zb, Black, d))
    | _ -> tree;;

  let insert (tree: ('a, 'b) rb_tree_t) (key: 'a) (value: 'b) =
    let rec insert_t tree = match tree with
        Empty -> Node (Empty, key, value, Red, Empty)
      | Node (l, k, v, c, r) ->
        if key = k then Node (l, key, value, c, r)
        else if key < k then balance (Node (insert_t l, k, v, c, r))
        else balance (Node (l, k, v, c, insert_t r)) in
    match insert_t tree with
        Empty -> assert false
      | Node (l, k, v, c, r) -> Node (l, k, v, Black, r);;

  let rec search value tree = match tree with
      Empty -> false
    | Node (l, v, c, r) ->
        if value = v then true
        else if value < v then search value l
        else search value r;;

  let empty = Empty;;

  let singleton e = insert e Empty;;

  let to_set l = List.fold_right insert l Empty;;

  let to_list s = match s with
    Empty -> []
  | Node (l, v, c, r) -> to_list l @ (v :: to_list r);;

  let union s1 s2 = List.fold_right insert (to_list s2) s1;;

  let inter s1 s2 = List.fold_right (fun x t -> if search x s2 then insert x t else t) (to_list s1) Empty;;

  let diff s1 s2 = List.fold_right (fun x t -> if search x s2 then insert t else xt) (to_list s1) Empty;;

  let mem e s = search e s;;
end
