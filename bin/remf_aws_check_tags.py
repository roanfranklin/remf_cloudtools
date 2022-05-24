#!/usr/bin/python3

import json
import subprocess
import sys
import argparse

# RDS = []

def get_all_regions():
   OUTPUT = subprocess.check_output("aws ec2 describe-regions --region us-east-1 --output text | cut -f4", shell=True)
   OUT = OUTPUT.decode("utf-8")
   return OUT.split()
   #return ['us-east-1','sa-east-1']

def check_ec2_region(REGION):
   CMD = 'aws ec2 describe-instances --region {0}'.format(REGION)
   OUTPUT = subprocess.check_output(CMD, shell=True)
   DATA = json.loads(OUTPUT.decode('utf-8'))
   if len(DATA['Reservations']) > 0:
      for ii in DATA['Reservations']:
          for i in ii['Instances']:
              print('\n    Region: {0}'.format(REGION))
              print('InstanceId: {0}'.format(i['InstanceId']))
              print('      Tags:')
              for tag in i['Tags']:
                  print('           {0}={1}'.format(tag['Key'], tag['Value']))

# def check_rds_region(REGION):
#    CMD = 'aws rds describe-db-instances --region {0}'.format(REGION)
#    OUTPUT = subprocess.check_output(CMD, shell=True)
#    DATA = json.loads(OUTPUT.decode('utf-8'))
#    if len(DATA['DBInstances']) > 0:
#       print('*', end='', flush=True)
#       RDS.append({ 'region': REGION, 'total': len(DATA['DBInstances'])})



def main(argv):
    global args

    parser = argparse.ArgumentParser(description='AWS Check TAGs.')

    parser.add_argument('-r', dest='regions', nargs='?', type=str, default='all', help='Region [ default: all | ex.: us-east-1,sa-south-1 ]')
        
    args = parser.parse_args()

    REGIONS = args.regions

    if REGIONS == 'all':
        print('[ INFOR ] Analisando todas as regiões !')
        for REGION in get_all_regions():
            check_ec2_region(REGION)
    else:
        print('[ INFOR ] Analisando regiões ( {0} ) !'.format(REGIONS))
        _REGION = REGIONS.split(',')
        for i in _REGION:
            check_ec2_region(i)

if __name__ == '__main__':
    sys.exit(main(sys.argv))