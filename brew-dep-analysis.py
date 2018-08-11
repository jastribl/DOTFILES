import subprocess
from threading import Thread

allDeps = {}

def process(brew):
    allDeps[brew] = subprocess.getoutput("brew deps " + brew).split()

brews = subprocess.getoutput("brew list").split()
threads = [Thread(target=process, kwargs={'brew': brew}) for brew in brews]
[thread.start() for thread in threads]
[thread.join() for thread in threads]

uses = {}
for brew, deps in allDeps.items():
    for dep in deps:
        if dep not in uses:
            uses[dep] = 0
        uses[dep] += 1

for brew in allDeps:
    if brew not in uses:
        print(brew)
