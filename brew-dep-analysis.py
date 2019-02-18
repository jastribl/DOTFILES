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
extra_brews = [brew for brew in actual_brews if brew not in all_brews]
missing_brews = [brew for brew in expected_brews if brew not in actual_brews]


expected_casks = [line.rstrip('\n') for line in open('./brew/cask-list')]
actual_casks = subprocess.getoutput("brew cask list").split()
missing_casks = [cask for cask in expected_casks if cask not in actual_casks]
extra_casks = [cask for cask in actual_casks if cask not in expected_casks]

print("Brew Dep Analysis:")

if len(extra_brews) + len(missing_brews) + len(extra_casks) + len(missing_casks) > 0:
    if len(extra_brews) > 0:
        print("Extra brews:", ' '.join(extra_brews))

    if len(missing_brews) > 0:
        print("Missing brews:", ' '.join(missing_brews))

    if len(extra_casks) > 0:
        print("Extra casks:", ' '.join(extra_casks))

    if len(missing_casks) > 0:
        print("Missing casks:", ' '.join(missing_casks))

    sys.exit(1)

print("All good!")
