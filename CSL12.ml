(* #use "CSL12.ml";; *)
(* exit 0;; *)

(* 15.2 *)
(* ユークリッドの互除法 *)
(* gcd : int -> int -> int *)
let rec gcd m n =
  if n = 0 then m else gcd n (m mod n);;

(* 15.2 tests *)
let test_15_2_1 = gcd 1 0 = 1
let test_15_2_2 = gcd 1 1 = 1
let test_15_2_3 = gcd 10 5 = 5
let test_15_2_4 = gcd 20 6 = 2
let test_15_2_5 = gcd 30 10 = 10;;



(* 15.3 *)
(* エラトステネスのふるい *)
(* prime : int -> int *)
let rec sieve l = match l with
  | [] -> []
    | first :: rest -> first :: sieve (List.filter (fun n -> n mod first <> 0) rest)

let rec range m n =
  if m <= n then m :: range (m + 1) n else []

let prime n = sieve (range 2 n)

(* 15.3 tests *)
let test_15_3_1 = prime 0 = []
let test_15_3_2 = prime 2 = [2]
let test_15_3_3 = prime 3 = [2; 3]
let test_15_3_4 = prime 10 = [2; 3; 5; 7]
let test_15_3_5 = prime 20 = [2; 3; 5; 7; 11; 13; 17; 19];;
