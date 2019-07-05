#!/usr/bin/env python

from subprocess import check_output
from re import sub

def get_pass(account):
    data = check_output("/usr/bin/pass email/" + account, shell=True).splitlines()
    password = data[0]
    tmp = [x for x in data if x.startswith('address:')]
    user = ""
    if len(tmp) > 0:
        user = tmp[0].split(":", 1)[1]

    return {"password": password, "user": user}
