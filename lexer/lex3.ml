(* 编缉能运行的方式: 
   bytes => string
   Bytes => String
*)

type expr =
  | Val of int
  | Plus of expr * expr
  | Minus of expr * expr
  | Times of expr * expr

type token =
  | Int of int
  | Plus
  | Minus
  | Times
  | OParen
  | CParen

type token_stream = token list

(* lex "1 +  (2 * 3) " -> [Int 1; Plus; OParen; Int 2; Times; Int 3; CParen] *)
let lex (input : string) : token_stream =
  (* 尾递归处理: 反序单字符,含空格:  "10 + 201 * 302" -> [2; 0; 3;  ; *;  ; 1; 0; 2;  ; +;  ; 0; 1]*)
  let rec text_to_char_list (t : string) (acc : char list) : char list =
    match t with
    | "" -> acc
    | _ ->
      let len = String.length t in
      text_to_char_list (String.sub t 1 (len - 1)) (String.get t 0 :: acc)
  in

  (* raw token, 正序含类型，无空格: "10+201*302" -> [Int 1; Int 0; Plus; Int 2; Int 0; Int 1; Times; Int 3; Int 0; Int 2] *)
  let char_list_to_token_list (s : char list) : token list =
    let rec fold_helper l c =
      match c with
      | ' ' -> l
      | '(' -> OParen :: l
      | ')' -> CParen :: l
      | '+' -> Plus :: l
      | '-' -> Minus :: l
      | '*' -> Times :: l
      | x -> Int (int_of_string (String.make 1 x)) :: l
    in
    List.fold_left fold_helper [] s
  in

  (* token, 数字结合: "10+201*302" -> [Int 10; Plus; Int 201; Times; Int 302]  *)
  let rec fix_ints (s : token list) : token list =
    match s with
    | [] -> []
    | Int a :: Int b :: tl -> fix_ints (Int ((10 * a) + b) :: tl)
    | hd :: tl -> hd :: fix_ints tl
  in
  fix_ints (char_list_to_token_list (text_to_char_list input []));;

(* 自己手工增加的token打印 *)
let res = "1+2*3" |> lex;;
let rec print_tokens res = 
match res with 
  |Int(v) :: token_stream -> Printf.printf "%d " v; print_tokens token_stream
  |Plus   :: token_stream -> print_string "+ ";     print_tokens token_stream
  |Times  :: token_stream -> print_string "* ";     print_tokens token_stream
  |_      :: token_stream -> print_tokens token_stream
  |[] -> print_endline "";;

print_tokens res;;