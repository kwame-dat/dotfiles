#!/usr/bin/env python

from subprocess import check_output
from re import sub

def get_pass(account):
    data = check_output("/usr/local/bin/pass 2Areas/" + account, shell=True).splitlines()
    password = data[0]
    user = data[1]
    remotehost = data[2]

    return {"password": password, "user": user, "remotehost": remotehost}
