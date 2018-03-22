(*5.1*)
(* (1) *)
(* print_int(if 2 < 1 then 3 else 4); print_newline();; *)
(* -> 4が返る *)

(* (2) *)
(* print_float(if "true" then 3.14 else 2.72); print_newline();; *)
(* -> trueがstringでないのでエラーが返る *)

(* (3) *)
(* print_string(string_of_bool(if "a" = "b" then false else true)); print_newline();; *)
(* trueが返る *)

(* (4) *)
(* print_int(if true < false then 1 else "2"); print_newline();; *)
(* -> 2がstringなのでエラーが返る *)

(* (5) *)
(* print_string(string_of_bool(if not (3 = 4) then 1 < 2 else 1 > 2)); print_newline();; *)
(* -> trueが返る *)



(*5.7*)
let bmi m kg = kg /. (m ** 2.0)
let taikei m kg = if bmi m kg < 18.5 then "やせ"
                                     else if bmi m kg < 25.0 then "標準"
                                     else if bmi m kg < 30.0 then "肥満"
                                     else "高度肥満";;
print_string(taikei 1.7 60.0); print_newline();;
print_string(taikei 1.0 6000.0); print_newline();;



(*7.1*)
(* let goukei_to_heikin a b c d e = ((a +. b +. c +. d +. e), (a +. b +. c +. d +. e) /. 5.0);; *)
(* ラーミナルから ocamlコマンドを押して #use "CSL2.ml";; で結果を見れる *)

(*7.2*)
let seiseki pair = match pair with
  (a, b) -> a^"さんの評価は"^string_of_int(b)^"です";;
print_string(seiseki ("Tom", 5));;

(*7.3*)
(* 目的：x軸とy軸の組 pair を受け取りx軸に対について対称な点の座標を返す *)
let taisho_x pair = match pair with
  (x, y) -> if x > 0 && y > 0 then (-x, -y)
                              else if x > 0 && y < 0 then (-x, y)
                              else if x < 0 && y > 0 then (x, -y)
                              else (x, y);;
(* print(taisho_x (2, 5));; *)

(*7.4*)
(* 目的：x軸とy軸の組 pair を２つ受け取り、その中点の座標を返す *)
let chuten pair1 pair2 = match pair with
  (x1, y2) (x2, y2) -> ((x1+.x2)/.2.0, (y1+.y2)/.2.0);;
(* print(seiseki (5.0, 10.0) (-10.0, 20.0));; *)
