#!/usr/bin/python3
#
# https://infraascode.com.br/ferramentas-validacao-de-arquivos-yaml/
#

import yaml
import sys
import glob
from os.path import exists

def check_file(_FILE):
  with open((_FILE), 'r') as stream:
    try:
      yaml.safe_load(stream)
      print("[ OK ] - File (%s) validate with success! " % _FILE)
    except yaml.YAMLError as exc:
      print("[ ERROR ] - File (%s) not valid!" %  _FILE)
      print(exc)
      input('\n\tPressione [ENTER] para Continuar...\n')

if len(sys.argv) > 1:
  _FILE = sys.argv[1]
  if not exists(_FILE):
    print ("[ ERROR ] File '{0}' not exists!".format(_FILE))
    sys.exit(1)

  check_file(_FILE)
else:  
  _FILES = glob.glob("./*.yaml")
  if not _FILES:
    print ("[ ERROR ] No file manifest YAML")
    sys.exit(1)

  for _FILE in _FILES:
    check_file(_FILE)

# #EOF