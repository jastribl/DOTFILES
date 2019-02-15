#!/usr/bin/env python3

import subprocess
import sys
from threading import Thread

all_deps = {}

def process(brew):
    output = subprocess.getoutput("brew deps " + brew)
    if "No available formula with the name" not in output and "Error:" not in output:
        all_deps[brew] = output.split()

expected_brews = [line.rstrip('\n') for line in open('./brew/brew-list')]
threads = [Thread(target=process, kwargs={'brew': brew}) for brew in expected_brews]
[thread.start() for thread in threads]
[thread.join() for thread in threads]

all_brews = []
for brew, deps in all_deps.items():
    all_brews = all_brews + [brew] + deps

actual_brews = subprocess.getoutput("brew list").split()
unused = [brew for brew in actual_brews if brew not in all_brews]

missing = [brew for brew in expected_brews if brew not in all_brews]

if len(unused) > 0 or len(missing) > 0:
    if len(unused) > 0:
        print("Extra brews:", ' '.join(unused))

    if len(missing) > 0:
        print("Missing brews:", ' '.join(missing))

    sys.exit(1)

print("All good!")
