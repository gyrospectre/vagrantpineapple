#!/bin/bash
sudo route delete -net 172.16.42.0 -netmask 255.255.255.0
vagrant destroy --force

