#!/usr/bin/env python3

import os
import re
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

expected_brews = [re.sub(r' *#.*', '', line.rstrip('\n')) for line in open(BREW_LIST_FILE)]
expected_brews = list(filter(None, expected_brews)) # remove empty lines (commented out brews)
threads = [Thread(target=process, kwargs={'brew': brew}) for brew in expected_brews]
[thread.start() for thread in threads]
[thread.join() for thread in threads]

all_brews = []
for brew, deps in all_deps.items():
    all_brews = all_brews + [brew] + deps

actual_brews = subprocess.getoutput('brew list --formula').split()
extra_brews = [brew for brew in actual_brews if brew not in all_brews]
missing_brews = [brew for brew in expected_brews if brew not in actual_brews]

expected_casks = [re.sub(r' *#.*', '', line.rstrip('\n')) for line in open(CASK_LIST_FILE)]
expected_casks = list(filter(None, expected_casks)) # remove empty lines (commented out casks)
actual_casks = subprocess.getoutput('brew list --cask').split()
missing_casks = [cask for cask in expected_casks if cask not in actual_casks]
extra_casks = [cask for cask in actual_casks if cask not in expected_casks]
outdated_brews = subprocess.getoutput('brew outdated  -q').split()
outdated_casks = subprocess.getoutput('brew outdated --cask --quiet').split()

has_checked_dirs = False

def run_brew_command(command):
    global has_checked_dirs
    if not has_checked_dirs:
        has_checked_dirs = True
        subprocess.getoutput('./update-scripts/fix-brew-dirs-on-devserver.sh')

    print('\n>', command)
    p = subprocess.Popen(command, shell=True, stdout=subprocess.PIPE, stderr=subprocess.STDOUT)
    while True:
        try:
            out = str(p.stdout.read(1), 'utf-8')
            if out == '' and p.poll() != None:
                break
            if out != '':
                sys.stdout.write(out)
                sys.stdout.flush()
        except UnicodeDecodeError:
            pass

def run_brew_command_set(command, s):
    if len(s) == 0: return
    run_brew_command(command.format(' '.join(s)))

if len(extra_brews) + len(missing_brews) + len(extra_casks) + len(missing_casks) > 0:
    print('Brew Dep Analysis:\n')

def print_pre(message, things):
    if len(things) == 0: return
    print('{}: {}'.format(message, ' '.join(things)))

print_pre('Extra brews', extra_brews)
brews_to_uninstall = set()
for extra_brew in extra_brews:
    while True:
        choice = input('Extra brew: {}\nAdd to list (a), Uninstall (u), Skip (s) or Quit (q):\n> '.format(extra_brew))
        if choice == 'a':
            subprocess.getoutput("echo '{}' >> {}".format(extra_brew, BREW_LIST_FILE))
        elif choice == 'u':
            brews_to_uninstall.add(extra_brew)
        elif choice == 's':
            break
        elif choice == 'q':
            sys.exit(0)
        elif choice == '':
            break
        else:
            continue
        break
run_brew_command_set('brew uninstall {}', brews_to_uninstall)

print_pre('Missing brews', missing_brews)
brews_to_install = set()
for missing_brew in missing_brews:
    while True:
        choice = input('Missing brew: {}\nInstall (i), Remove from list (r), Skip (s) or Quit (q):\n> '.format(missing_brew))
        if choice == 'i':
            brews_to_install.add(missing_brew)
        elif choice == 'r':
            subprocess.getoutput("sed --follow-symlinks -i '/{}/d' {}".format(missing_brew, BREW_LIST_FILE))
        elif choice == 's':
            break
        elif choice == 'q':
            sys.exit(0)
        elif choice == '':
            break
        else:
            continue
        break
run_brew_command_set('brew install {}', brews_to_install)

print_pre('Extra casks', extra_casks)
casks_to_uninstall = set()
for extra_cask in extra_casks:
    while True:
        choice = input('Extra cask: {}\nAdd to list (a), Uninstall (u), Skip (s) or Quit (q):\n> '.format(extra_cask))
        if choice == 'a':
            subprocess.getoutput("echo '{}' >> {}".format(extra_cask, CASK_LIST_FILE))
        elif choice == 'u':
            casks_to_uninstall.add(extra_cask)
        elif choice == 's':
            break
        elif choice == 'q':
            sys.exit(0)
        elif choice == '':
            break
        else:
            continue
        break
run_brew_command_set('brew uninstall --cask {}', casks_to_uninstall)

print_pre('Missing casks', missing_casks)
casks_to_install = set()
for missing_cask in missing_casks:
    while True:
        choice = input('Missing cask: {}\nInstall (i), Remove from list (r), Skip (s) or Quit (q):\n> '.format(missing_cask))
        if choice == 'i':
            casks_to_install.add(missing_cask)
        elif choice == 'r':
            subprocess.getoutput("sed --follow-symlinks -i '/{}/d' {}".format(missing_cask, CASK_LIST_FILE))
        elif choice == 's':
            break
        elif choice == 'q':
            sys.exit(0)
        elif choice == '':
            break
        else:
            continue
        break
run_brew_command_set('brew install --cask {}', casks_to_install)

print_pre('Outdated brews', outdated_brews)
upgrade_all_brews = True
brews_to_update = set()
should_loop = True
# TODO: refactor this file to move these various loops into a helper function with params, can make more complex looping logic possible taht way without the need for so many flags
for outdated_brew in outdated_brews:
    while should_loop:
        choice = input("Outdated brew '{}'. Would you like to Upgrade (u), Upgrade All (a), Skip (s) or Quit (q):\n> ".format(outdated_brew))
        if choice == 'u':
            brews_to_update.add(outdated_brew)
        elif choice == 's':
            # Only mark false if we find a brew that doesn't want updating.
            # If all are upgraded, we use the `brew upgrade` command which seems to succeed more often.
            upgrade_all_brews = False
            break
        elif choice == 'q':
            sys.exit()
        elif choice == 'a':
            # This means we want to upgrade everything, so override the variable and break
            upgrade_all_brews = True
            should_loop = False
            break
        else:
            continue
        break
if upgrade_all_brews:
    run_brew_command('brew upgrade')
else:
    run_brew_command_set('brew upgrade {}', brews_to_update)

print_pre('Outdated casks', outdated_casks)
casks_to_update = set()
for outdated_cask in outdated_casks:
    while True:
        choice = input("Outdated cask '{}'. Would you like to upgrade (u), Skip (s) or Quit (q):\n> ".format(outdated_cask))
        if choice == 'u':
            casks_to_update.add(outdated_cask)
        elif choice == 's':
            break
        elif choice == 'q':
            sys.exit()
        else:
            continue
        break
run_brew_command_set('brew upgrade --cask {}', casks_to_update)


run_brew_command('brew cleanup')
