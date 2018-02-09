## docker-testing-ansible-role
Docker image for testing ansible roles

## Supported environment
* python 2.6 2.7,3.5,3.6
* ansible 2.2,2.3,2.4
* tox
* molecule 2 (driver: docker, delegated)

Note: python 2.6 is __deprecated__ and not supported by many packages, such as molecule.

## Usage
```Bash
# for project tested via tox
cd /path/to/project/
docker run -it \
           --rm \
           -v `pwd`:/code \
           -w /code \
           gzm55/testing-ansible-role tox

# for project tested via molecule
cd /path/to/project/
docker run -it \
           --rm \
           -v `pwd`:/code \
           -v /var/run/docker.sock:/var/run/docker.sock:ro \
           -w /code \
           gzm55/testing-ansible-role molecule test
```

See `example-enter.sh` for a more detail example.

## Python 3

Python 3 support of Ansible (controller or controlee) is preview from ansible 2.2.
When developping an ansible role, py{35,36} test matrix of the role E2E test or
the module UT could only contain the latest ansible,
i.e., ansible 2.4 right now.

testinfra's support begins from ansible 2.3.

molecule doesn't support python 3 right now, when testing in tox with py{35,36},
`molecule` entry cli _may_ be treat as an external commmand,
see the test case of `molecule/01-test-docker-driver-role`.

## Python 2.6

__DEPRECATED__ for controller machines.

On controller machine (running the playbook), it is very easy to get a python2.7 environment,
such as from a docker or from a RPM source (https://ius.io/GettingStarted/).

If a role does not bundle python codes, just E2E test it (via molecule or other test framework) for py27 is enough,
ansible will make the role compatible for py26.

If a role has python module/filter codes, and we _really_ can and need to keep support py26,
first run some UT on these codes for py26,
then when E2E test python modules, also select docker images only with python 2.6.

## TODO

- re-produce the kernel api call of localtime() for musl
- set TZ=:/etc/localtime if needed
- add cmd for print-entering-script
- entering-script support linux and mac
- pathenv PATHON* from https://docs.python.org/2.6/using/cmdline.html
