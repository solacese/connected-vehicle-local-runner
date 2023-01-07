#!/bin/bash

log() {
   echo "$(date +'%Y-%m-%d %H:%M:%S'): $1"
}

wait_for_service_ready() {
   local is_started=false
   while [ "$is_started" == false ] ; do
      local response=$(curl --write-out '%{http_code}' --silent ${solace_rest_url}/try-me -d "Hello World REST" -H "content-type: text")
      if [ "$response" == "200" ] ; then
         is_started=ture
         log "Solace service is ready!"
      else
         log "${solace_rest_url}/try-me -> ${response}"
         sleep 3
      fi
   done
}

if [ -z ${solace_rest_url+x} ]; then 
  solace_rest_url="http://localhost:9000"
fi

wait_for_service_ready