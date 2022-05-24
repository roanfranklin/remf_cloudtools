#!/usr/bin/python3

import json
import subprocess
import os

ITEMS = {}
S3 = []
ROUTE53 = []
CLOUDFRONT = []
EC2 = []
RDS = []
API = []
LAMBDA = []
CODECOMMIT = []

def get_all_regions():
   OUTPUT = subprocess.check_output("aws ec2 describe-regions --region us-east-1 --output text | cut -f4", shell=True)
   OUT = OUTPUT.decode("utf-8")
   return OUT.split()
   #return ['us-east-1','sa-east-1']

def check_s3():
   CMD = 'aws s3 ls | cut -f3 -d" "'
   OUTPUT = subprocess.check_output(CMD, shell=True)
   print('Checking [ S3 ]: All:', end='', flush=True)
   if str(OUTPUT.decode('utf-8')) == '':
      S3.append({ 'total': 0 })
      return 0
   DATA = str(OUTPUT.decode('utf-8')).split()
   if len(DATA) > 0:
      for i in DATA:
         print('*', end='', flush=True)
      S3.append({ 'total': len(DATA) })

def check_route53():
   CMD = 'aws route53 list-hosted-zones'
   OUTPUT = subprocess.check_output(CMD, shell=True)
   print('\nChecking [ Route53 ]: All:', end='', flush=True)   
   if str(OUTPUT.decode('utf-8')) == '':
      ROUTE53.append({ 'total': 0 })
      return 0
   DATA = json.loads(OUTPUT.decode('utf-8'))
   if len(DATA['HostedZones']) > 0:
      for i in DATA['HostedZones']:
         print('*', end='', flush=True)
      ROUTE53.append({ 'total': len(DATA['HostedZones'])})    

def check_cloudfront():
   CMD = 'aws cloudfront list-distributions'
   OUTPUT = subprocess.check_output(CMD, shell=True)
   print('\nChecking [ CloudFront ]: All:', end='', flush=True)
   if str(OUTPUT.decode('utf-8')) == '':
      CLOUDFRONT.append({ 'total': 0 })
      return 0
   DATA = json.loads(OUTPUT.decode('utf-8'))
   if len(DATA['DistributionList']['Items']) > 0:
      for i in DATA['DistributionList']['Items']:
         print('*', end='', flush=True)
      CLOUDFRONT.append({ 'total': len(DATA['DistributionList']['Items'])})      

def check_ec2_region(REGION):
   CMD = 'aws ec2 describe-instances --region {0}'.format(REGION)
   OUTPUT = subprocess.check_output(CMD, shell=True)
   DATA = json.loads(OUTPUT.decode('utf-8'))
   if len(DATA['Reservations']) > 0:
      print('*', end='', flush=True)
      EC2.append({ 'region': REGION, 'total': len(DATA['Reservations'])})

def check_rds_region(REGION):
   CMD = 'aws rds describe-db-instances --region {0}'.format(REGION)
   OUTPUT = subprocess.check_output(CMD, shell=True)
   DATA = json.loads(OUTPUT.decode('utf-8'))
   if len(DATA['DBInstances']) > 0:
      print('*', end='', flush=True)
      RDS.append({ 'region': REGION, 'total': len(DATA['DBInstances'])})

def check_api_region(REGION):
   CMD = 'aws apigateway get-rest-apis --region {0}'.format(REGION)
   OUTPUT = subprocess.check_output(CMD, shell=True)
   DATA = json.loads(OUTPUT.decode('utf-8'))
   if len(DATA['items']) > 0:
      print('*', end='', flush=True)
      API.append({ 'region': REGION, 'total': len(DATA['items'])})

def check_lambda_region(REGION):
   CMD = 'aws lambda list-functions --region {0}'.format(REGION)
   OUTPUT = subprocess.check_output(CMD, shell=True)
   DATA = json.loads(OUTPUT.decode('utf-8'))
   if len(DATA['Functions']) > 0:
      print('*', end='', flush=True)
      LAMBDA.append({ 'region': REGION, 'total': len(DATA['Functions'])})

def check_codecommit_region(REGION):
   CMD = 'aws codecommit list-repositories --region {0}'.format(REGION)
   OUTPUT = subprocess.check_output(CMD, shell=True)
   DATA = json.loads(OUTPUT.decode('utf-8'))
   if len(DATA['repositories']) > 0:
      print('*', end='', flush=True)
      CODECOMMIT.append({ 'region': REGION, 'total': len(DATA['repositories'])})

def mount_items():
    ITEMS['s3'] = S3
    ITEMS['route53'] = ROUTE53
    ITEMS['cloudfront'] = CLOUDFRONT
    ITEMS['ec2'] = EC2
    ITEMS['rds'] = RDS
    ITEMS['api'] = API
    ITEMS['lambda'] = LAMBDA
    ITEMS['codecommit'] = CODECOMMIT
    print('')

check_s3()
check_route53()
check_cloudfront()
print('\nChecking [ Ec2 | RDS | API | Lambda | CodeCommit ]', end=':', flush=True)
for REGION in get_all_regions():
    print(' {0}'.format(REGION), end=':', flush=True)
    check_ec2_region(REGION)
    check_rds_region(REGION)
    check_api_region(REGION)
    check_lambda_region(REGION)
    check_codecommit_region(REGION)

mount_items()

print(' + S3: {0} bucket(s)'.format(ITEMS['s3'][0]['total']))
print(' + Route53: {0} host(s)'.format(ITEMS['route53'][0]['total']))
print(' + CloudFront: {0} distribution(s)'.format(ITEMS['cloudfront'][0]['total']))

if len(ITEMS['ec2']) > 0:
   print(' + Ec2:')
   for ec2_items in ITEMS['ec2']:
      for ec2_item in [ec2_items]:
         print('   # {0} : {1} instance(s)'.format(ec2_item['region'], ec2_item['total']))

if len(ITEMS['rds']) > 0:
   print(' + RDS:')
   for rds_items in ITEMS['rds']:
      for rds_item in [rds_items]:
         print('   # {0} : {1} instance(s)'.format(rds_item['region'], rds_item['total']))

if len(ITEMS['api']) > 0:
   print(' + API Gateway:')
   for api_items in ITEMS['api']:
      for api_item in [api_items]:
         print('   # {0} : {1} api(s)'.format(api_item['region'], api_item['total']))

if len(ITEMS['lambda']) > 0:
   print(' + Lambda:')
   for lambda_items in ITEMS['lambda']:
      for lambda_item in [lambda_items]:
         print('   # {0} : {1} function(s) lambda'.format(lambda_item['region'], lambda_item['total']))

if len(ITEMS['codecommit']) > 0:
   print(' + CodeCommit:')
   for codecommit_items in ITEMS['codecommit']:
      for codecommit_item in [codecommit_items]:
         print('   # {0} : {1} repositories'.format(codecommit_item['region'], codecommit_item['total']))
    
# gravar um arquivo txt com os dados!
# DATA = json.loads(output)
#with open('data_file.json', 'w', encoding='utf-8') as f:
#    json.dump(DATA, f, ensure_ascii=False, indent=4)
