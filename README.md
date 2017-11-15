## docker-testing-ansible-role
Docker image for testing ansible roles

## Supported environment
* python 2.6,2.7,3.5,3.6
* ansible 2.2,2.3,2.4
* tox
* molecule 2 (driver: docker, delegated)

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
           -w /code \
           gzm55/testing-ansible-role molecule test
```
