#!/bin/bash

USER="admin:admin"

log() {
   echo "$(date +'%Y-%m-%d %H:%M:%S'): $1"
}

enable_obo() {
  local clientUrl="${solace_admin_url}/SEMP/v2/config/msgVpns/default/clientUsernames/default"
  local response=$(curl -X PUT --write-out '%{http_code}' --silent --output /dev/null -u ${USER} ${clientUrl} -H 'content-type: application/json' -d '{"clientUsername":"default","enabled":true,"subscriptionManagerEnabled":true}')
  if [ "$response" == "200" ] ; then
    log "Enable subscription management capability of the client successfully"
  else
    log "${clientUrl} -> ${response}"
  fi
}

if [ -z ${solace_admin_url+x} ]; then 
  solace_admin_url="http://localhost:8080"
fi

enable_obo