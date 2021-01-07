#!/bin/bash
set -e
#set -x

# cd to the _root_ of the repo.
CDPATH=''
cd "$(dirname "${BASH_SOURCE[0]}")"

PREFIX=$(readlink -f ..)

if [ ! -x env/bin/python3 ]; then
    python3 -m venv env
fi

. env/bin/activate

pip install wheel
pip install -r requirements.txt

export ANSIBLE_DISPLAY_OK_HOSTS="no"
export ANSIBLE_DISPLAY_SKIPPED_HOSTS="no"
export ANSIBLE_STDOUT_CALLBACK="unixy"
export ANSIBLE_STRATEGY_PLUGINS="$(find $(pwd)/env/lib/ -iname ansible_mitogen )/plugins/strategy"

ansible-playbook -i hosts kubernetes.yml

exit;
