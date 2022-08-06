#!/bin/bash

kubectl version | grep Client | cut -d : -f 5