#!/usr/bin/env python

from subprocess import check_output
from re import sub

def get_pass(account):
    data = check_output("/usr/local/bin/pass 2Areas/" + account, shell=True).splitlines()
    password = data[1]
    user = data[2]
    remotehost = data[3]

    return {"password": password, "user": user, "remotehost": remotehost}
