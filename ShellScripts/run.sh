#!/bin/bash

if [[ ${GET_HOSTS_FROM:-dns} == "env" ]]; then
	redis-server --slaveof ${REDIS_MASTER_SERVICE_HOST} 63779
else
	redis-server --slaveof redis-master 6379
fi