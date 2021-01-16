FROM python:3.9.1-buster
COPY requirements.txt ./
RUN pip install --no-cache-dir -r requirements.txt
RUN mkdir /etc/ansible
COPY ansible.cfg /etc/ansible/ansible.cfg
COPY inventory.yml /etc/ansible/inventory.yml
CMD ["/usr/local/bin/ansible", "--version"]
