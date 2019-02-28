#!/usr/bin/env python3

import os
import subprocess
import sys

from threading import Thread


THIS_FILE_PATH = os.path.dirname(os.path.realpath(__file__))
BREW_LIST_FILE = os.path.join(THIS_FILE_PATH, 'brew', 'brew-list')
CASK_LIST_FILE = os.path.join(THIS_FILE_PATH, 'brew', 'cask-list')

all_deps = {}

def process(brew):
    output = subprocess.getoutput('brew deps ' + brew)
    if 'No available formula with the name' not in output and 'Error:' not in output:
        all_deps[brew] = output.split()

expected_brews = [line.rstrip('\n') for line in open(BREW_LIST_FILE)]
threads = [Thread(target=process, kwargs={'brew': brew}) for brew in expected_brews]
[thread.start() for thread in threads]
[thread.join() for thread in threads]

all_brews = []
for brew, deps in all_deps.items():
    all_brews = all_brews + [brew] + deps

actual_brews = subprocess.getoutput('brew list').split()
extra_brews = [brew for brew in actual_brews if brew not in all_brews]
missing_brews = [brew for brew in expected_brews if brew not in actual_brews]


expected_casks = [line.rstrip('\n') for line in open(CASK_LIST_FILE)]
actual_casks = subprocess.getoutput('brew cask list').split()
missing_casks = [cask for cask in expected_casks if cask not in actual_casks]
extra_casks = [cask for cask in actual_casks if cask not in expected_casks]

def run_brew_command(command):
    output = subprocess.getoutput(command)
    print(output)

if len(extra_brews) + len(missing_brews) + len(extra_casks) + len(missing_casks) > 0:
    print("Brew Dep Analysis:\n")

def print_pre(message, things):
    if len(things) > 0:
        print("{}: {}".format(message, ' '.join(things)))

print_pre("Extra brews", extra_brews)
for extra_brew in extra_brews:
    while True:
        choice = input('Extra brew: {}\nAdd to list (a), Uninstall (u) or Quit (q):\n> '.format(extra_brew))
        if choice is 'a':
            subprocess.getoutput("echo '{}' >> {}".format(extra_brew, BREW_LIST_FILE))
        elif choice is 'u':
            run_brew_command('brew uninstall {}'.format(extra_brew))
        elif choice is 'q':
            sys.exit(0)
        elif choice is '':
            break
        else:
            continue
        break

print_pre("Missing brews", missing_brews)
for missing_brew in missing_brews:
    while True:
        choice = input('Missing brew: {}\nInstall (i), Remove from list (r) or Quit (q):\n> '.format(missing_brew))
        if choice is 'i':
            run_brew_command('brew install {}'.format(missing_brew))
        elif choice is 'r':
            subprocess.getoutput("sed -i '' '/{}/d' {}".format(missing_brew, BREW_LIST_FILE))
        elif choice is 'q':
            sys.exit(0)
        elif choice is '':
            break
        else:
            continue
        break

print_pre("Extra casks", extra_casks)
for extra_cask in extra_casks:
    while True:
        choice = input('Extra cask: {}\nAdd to list (a), Uninstall (u) or Quit (q):\n> '.format(extra_cask))
        if choice is 'a':
            subprocess.getoutput("echo '{}' >> {}".format(extra_cask, CASK_LIST_FILE))
        elif choice is 'u':
            run_brew_command('brew cask uninstall {}'.format(extra_cask))
        elif choice is 'q':
            sys.exit(0)
        elif choice is '':
            break
        else:
            continue
        break

print_pre("Missing casks", missing_casks)
for missing_cask in missing_casks:
    while True:
        choice = input('Missing cask: {}\nInstall (i), Remove from list (r) or Quit (q):\n> '.format(missing_cask))
        if choice is 'i':
            run_brew_command('brew cask install {}'.format(missing_cask))
        elif choice is 'r':
            subprocess.getoutput("sed -i '' '/{}/d' {}".format(missing_cask, CASK_LIST_FILE))
        elif choice is 'q':
            sys.exit(0)
        elif choice is '':
            break
        else:
            continue
        break

outdated_brews=subprocess.getoutput('brew outdated  -q').split()
for outdated_brew in outdated_brews:
    while True:
        choice = input("Outdated brew '{}'. Would you like to upgrade (u), Skip (s) or Quit (q):\n> ".format(outdated_brew))
        if choice is 'u':
            run_brew_command('brew upgrade {}'.format(outdated_brew))
        elif choice is 's':
            break;
        elif choice is 'q':
            sys.exit()
        else:
            continue
        break;

run_brew_command('brew cleanup')
