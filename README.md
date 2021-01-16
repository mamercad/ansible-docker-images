# Ansible / Python Docker Images

Playing around with various Ansible and Python combination images.

There's a `Makefile` to make things easier, check out the variables at the top.

Build the image:

```bash
❯ make build
docker build -t mamercad/python3.9.1-ansible2.10.5 .
Sending build context to Docker daemon  65.02kB
Step 1/7 : FROM python:3.9.1-buster
 ---> da24d18bf4bf
Step 2/7 : COPY requirements.txt ./
 ---> Using cache
 ---> b2136b40e565
Step 3/7 : RUN pip install --no-cache-dir -r requirements.txt
 ---> Using cache
 ---> 2ad943afa53b
Step 4/7 : RUN mkdir /etc/ansible
 ---> Using cache
 ---> 01f12c297bef
Step 5/7 : COPY ansible.cfg /etc/ansible/ansible.cfg
 ---> Using cache
 ---> d85d511a5326
Step 6/7 : COPY inventory.yml /etc/ansible/inventory.yml
 ---> Using cache
 ---> 4dd4f97050c0
Step 7/7 : CMD ["/usr/local/bin/ansible", "--version"]
 ---> Using cache
 ---> 65fdccce9943
Successfully built 65fdccce9943
Successfully tagged mamercad/python3.9.1-ansible2.10.5:latest
```

Use the image (this handles SSH agent-forwarding for MacOS):

```bash
❯ make run
docker run --rm \
                -v /Users/mark/Code/github.com/mamercad/ansible-docker-images/ansible.cfg:/etc/ansible/ansible.cfg \
                -v /Users/mark/Code/github.com/mamercad/ansible-docker-images/inventory.yml:/etc/ansible/inventory.yml \
                -v /run/host-services/ssh-auth.sock:/run/host-services/ssh-auth.sock \
                -e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock" \
                mamercad/python3.9.1-ansible2.10.5 \
                ansible -i /etc/ansible/inventory.yml -m ping localhost
localhost | SUCCESS => {
    "changed": false,
    "ping": "pong"
}
```

Push the image:

```bash
❯ make push
docker image push mamercad/python3.9.1-ansible2.10.5
Using default tag: latest
The push refers to repository [docker.io/mamercad/python3.9.1-ansible2.10.5]
5b746c1d43aa: Layer already exists
7520130dd795: Layer already exists
fdfece337e0a: Layer already exists
4fed8e5bf302: Pushed
78919566f564: Layer already exists
394ec6c8d61d: Layer already exists
c5e393b8a19a: Layer already exists
b3f4557ae183: Layer already exists
9f5b4cdea532: Layer already exists
cd702377e4e5: Layer already exists
aa7af8a465c6: Layer already exists
ef9a7b8862f4: Layer already exists
a1f2f42922b1: Layer already exists
4762552ad7d8: Layer already exists
latest: digest: sha256:3ed2e4b5a55dc4f62161cf2de2707ab6fb2619469e86494caca079cbc7b05266 size: 3258
```
