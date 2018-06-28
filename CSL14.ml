(* #use "CSL14.ml";; *)
(* exit 0;; *)

(* 17.1 *)
type nengou_t = Meiji of int   (* 明治 *)
              | Taisho of int  (* 大正 *)
              | Showa of int   (* 昭和 *)
              | Heisei of int  (* 平成 *)

let to_seireki nengou = match nengou with
    Meiji (n) -> n + 1867
  | Taisho (n) -> n + 1911
  | Showa (n) -> n + 1925
  | Heisei (n) -> n + 1988;;

(* 目的： 誕生年と現在の年を nengou_t 型の値を受け取ったら、年齢を返す *)
(* nenrei : nengou_t -> nengou_t -> int *)
let nenrei born now = to_seireki now - to_seireki born;;

(* 17.1 tests *)
let test_17_1_1 = nenrei (Heisei (6)) (Heisei (30)) = 24
let test_17_1_2 = nenrei (Taisho (6)) (Taisho (30)) = 24
let test_17_1_3 = nenrei (Showa (63)) (Heisei (0)) = 0;;



(* 17.2 *)
(* 月を表す型 *)
type year_t = January of int   (* 1月 *)
            | February of int  (* 2月 *)
            | March of int     (* 3月 *)
            | April of int     (* 4月 *)
            | May of int       (* 5月 *)
            | June of int      (* 6月 *)
            | July of int      (* 7月 *)
            | August of int    (* 8月 *)
            | September of int (* 9月 *)
            | October of int   (* 10月 *)
            | November of int  (* 11月 *)
            | December of int  (* 12月 *)



(* 17.3 *)
(* 星座を表す型 *)
type seiza_t = Capricorus   (* 山羊座 *)
             | Aquarius     (* 水瓶座 *)
             | Pisces       (* 魚座 *)
             | Aries        (* 牡羊座 *)
             | Taurus       (* 牡牛座 *)
             | Gemini       (* 双子座 *)
             | Cancer       (* 蟹座 *)
             | Leo          (* 獅子座 *)
             | Virgo        (* 乙女座 *)
             | Libra        (* 天秤座 *)
             | Scorpius     (* 蠍座 *)
             | Sagittarius  (* 射手座 *)



(* 17.4 *)
(* 目的：日付けを受け取ってきたら星座を返す *)
(* seiza : year_t -> seiza_t *)
let seiza (year: year_t) = match year with
   January (day) -> if day <= 19 then Capricorus else Aquarius
 | February (day) -> if day <= 18 then Aquarius else Pisces
 | March (day) -> if day <= 20 then Pisces else Aries
 | April (day) -> if day <= 19 then Aries else Taurus
 | May (day) -> if day <= 20 then Taurus else Gemini
 | June (day) -> if day <= 21 then Gemini else Cancer
 | July (day) -> if day <= 22 then Cancer else Leo
 | August (day) -> if day <= 22 then Leo else Virgo
 | September (day) -> if day <= 22 then Virgo else Libra
 | October (day) -> if day <= 23 then Libra else Scorpius
 | November (day) -> if day <= 21 then Scorpius else Sagittarius
 | December (day) -> if day <= 21 then Sagittarius else Capricorus;;

(* 17.4 tests *)
let test_17_4_1 = seiza (October (28)) = Scorpius
let test_17_4_2 = seiza (January (1)) = Capricorus
let test_17_4_3 = seiza (December (21)) = Sagittarius;;
