(* #use "CSL17.ml";; *)
(* exit 0;; *)


(* 18.1 *)

(* 各人（名前, 身長, 体重, 誕生日, 血液型）を表す型 *)
type person_t = {
  name : string;      (*名前*)
  m : float;          (*身長*)
  kg : float;         (*体重*)
  birthday : string;  (*誕生日*)
  blood : string;     (*血液型*)
};;

let person_t1 = {name="a-san"; m=180.0; kg=80.0; birthday="1月1日"; blood="A"}
let person_t2 = {name="b-san"; m=170.0; kg=70.0; birthday="2月2日"; blood="B"}
let person_t3 = {name="o-san"; m=160.0; kg=60.0; birthday="3月3日"; blood="O"}
let person_t4 = {name="a2-san"; m=180.0; kg=80.0; birthday="12月12日"; blood="A"}
let person_t_list_1 = [person_t1; person_t2; person_t3; person_t4]
let person_t_list_2 = [person_t2; person_t3; person_t4];;


(* 目的：person_t型のリストを受け取ったら、その中からA型の人をレコードオプション型で返す *)
(* first_A : person_t list -> (string * float * float * string * string) list -> person_t option *)
let rec first_A (person: person_t list) = match person with
    [] -> None
  | ({name = name; m = m; kg = kg; birthday = birthday; blood = blood} as first) :: rest ->
    if blood = "A" then Some (first)
                   else first_A rest;;

(* test_18_1_1 *)
let test_18_1_1 = first_A person_t_list_1 = Some (person_t1);;
let test_18_1_2 = first_A person_t_list_2 = Some (person_t4);;



(* 18.2 *)

let rec price item yaoya_list = match yaoya_list with
    [] -> None
  | (yasai, nedan) :: rest -> if item = yasai then Some (nedan)
                                              else price item rest;;

let yasai_list = [("トマト", 300); ("たまねぎ", 200); ("にんじん", 150); ("キャベツ", 250); ("ほうれん草", 200)]
let yasai_list_2 = [("トマト", 300); ("レタス", 200); ("にんじん", 150); ("キャベツ", 250); ("白菜", 200)]
let yasai_list_empty = []
let yaoya_list = [("トマト", 300); ("たまねぎ", 200); ("にんじん", 150); ("ほうれん草", 200)];;


(* 目的：野菜リストと八百屋リストを受け取ったら、野菜リストのうち八百屋にはおいていない野菜の数を返す *)
(* count_urikire_yasai -> (string * int) list -> (string * int) list -> int *)
let rec count_urikire_yasai (yasai_list: (string * int) list) (yaoya_list: (string * int) list) = match yasai_list with
    [] -> 0
  | ((yasai, nedan) as first) :: rest -> match price yasai yaoya_list with
      None -> 1 + count_urikire_yasai rest yaoya_list
    | Some (n) -> count_urikire_yasai rest yaoya_list;;

(* 18.2 tests *)
let test_18_2_1 = count_urikire_yasai yasai_list yaoya_list = 1
let test_18_2_2 = count_urikire_yasai yasai_list_2 yaoya_list = 3
let test_18_2_3 = count_urikire_yasai yasai_list_empty yaoya_list = 0;;



(* 18.3 *)

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


let rec assoc ekimei lst = match lst with
    [] -> raise Not_found
  | (e, k) :: rest ->
      if e = ekimei then k else assoc ekimei rest;;

(* 18.3 tests *)
let test_18_3_1 = try assoc "後楽園" [] with Not_found -> true;;
