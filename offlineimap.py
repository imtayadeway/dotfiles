import os, re

def get_authinfo_password(machine, login, port):
    s = "machine %s login %s port %s password ([^ ]*)\n" % (machine, login, port)
    p = re.compile(s)
    authinfo = os.popen("gpg2 -q --no-tty -d ~/.authinfo.gpg").read()
    return p.search(authinfo).group(1)
