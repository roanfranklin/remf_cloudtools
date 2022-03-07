#!/usr/bin/env python3

import atexit
import json
import requests
import subprocess
import sys

namespace = sys.argv[1]

proxy_process = subprocess.Popen(['kubectl', 'proxy'])
atexit.register(proxy_process.kill)

p = subprocess.Popen(['kubectl', 'get', 'namespace', namespace, '-o', 'json'], stdout=subprocess.PIPE)
p.wait()

data = json.load(p.stdout)

data['spec']['finalizers'] = []

requests.put('http://127.0.0.1:8001/api/v1/namespaces/{0}/finalize'.format(namespace), json=data).raise_for_status()

# kubectl get ns
# kubectl get ns cattle-system -o json > ns.json
# 
# curl -k -H "Content-Type: application/json" -X PUT --data-binary @ns.json http://127.0.0.1:8001/api/v1/namespaces/cattle-system/finalize
