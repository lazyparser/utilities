#!/bin/python

import os

PKG_SHOW_CMD = "apt-cache show"
init_package_name = "ros-desktop-full"

def get_pkg_info(pkg_name):
    # using strip()[0] to avoid "libc (>= xx.yy.zz)"
    command = " ".join([PKG_SHOW_CMD, pkg_name.strip().split(" ")[0]])
    outputs = os.popen(command).readlines()
    return outputs

def get_deps(pkg_name):
    dep_list = []
    pkg_info = get_pkg_info(pkg_name)
    #lines = pkg_info.split("\n")
    #for l in lines:
    for l in pkg_info:
        fields = l.split(":")
        if fields[0] == "Depends":
            dep_list = dep_list + " ".join(fields[1:]).split(",")
    # if you want to print version details, using the command below.
    #dep_list = [ d.strip() for d in dep_list ]
    dep_list = [ d.strip().split(" ")[0] for d in dep_list ]
    #print "[" + ",".join(dep_list) + "]"
    return dep_list

def get_dep_tree(root_pkg):
    processed = []
    pending = [root_pkg,]
    while len(pending) > 0:
        pkg = pending.pop()
        if pkg in processed:
            continue
        deps = get_deps(pkg)
        pending.extend(deps)
        for d in deps:
            print '"%s" -> "%s";' % (pkg, d)
        processed.append(pkg)



get_dep_tree(init_package_name)

