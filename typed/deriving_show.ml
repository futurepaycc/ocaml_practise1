#require "ppx_deriving.std";; (* 运行@@deriving所必须的 *)

type t = C  [@@deriving show { with_path = false }];;

print_endline (show C);;