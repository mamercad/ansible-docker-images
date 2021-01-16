space := mamercad
pyver := 3.9.1
anver := 2.10.5

.PHONY: build
build:
	docker build -t ${space}/python${pyver}-ansible${anver} .

.PHONY: push
push:
	docker image push ${space}/python${pyver}-ansible${anver}

# MacOS ssh agent-forwarding
.PHONY: run
run:
	docker run --rm \
		-v ${PWD}/ansible.cfg:/etc/ansible/ansible.cfg \
		-v ${PWD}/inventory.yml:/etc/ansible/inventory.yml \
		-v /run/host-services/ssh-auth.sock:/run/host-services/ssh-auth.sock \
		-e SSH_AUTH_SOCK="/run/host-services/ssh-auth.sock" \
		${space}/python${pyver}-ansible${anver} \
		ansible -i /etc/ansible/inventory.yml -m ping localhost
