#!/usr/bin/with-contenv bash

if [[ "$DO_IPV6" == "yes" ]]
 then
	UPSTREAM_HOST=${UPSTREAM_HOST:-2a01:3a0:53:53::}
  else
	UPSTREAM_HOST=${UPSTREAM_HOST:-89.233.43.71}
fi

export UPSTREAM_HOST

dockerize -template /app/unbound.conf.tmpl > /etc/unbound/unbound.conf
chown -R unbound:unbound /etc/unbound
s6-setuidgid unbound unbound-control-setup 
s6-setuidgid unbound unbound-anchor -v -a /etc/unbound/root.key; true
