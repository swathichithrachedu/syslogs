#!/bin/sh

#touch ~/testfile

find /tmp/*.log -exec sudo rm -rf {} \;
