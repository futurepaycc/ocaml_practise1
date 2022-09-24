let max a b = 
  if a > b then 
    a 
  else 
    b
  ;;

let res = max 3 5;;

Printf.printf "%d\n"  res;;