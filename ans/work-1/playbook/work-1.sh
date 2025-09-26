docker build -t ans-w1-t3-ubuntu ~/devops/SHDEVOPS-22-HW/ans/work-1/ubuntu/
docker run -dit --name ubuntu ans-w1-t3-ubuntu bash
docker run -dit --name centos7 centos:7 bash
docker run -dit --name fedora pycontribs/fedora:latest bash
ansible-playbook -i inventory/prod.yml site.yml --vault-pass-file ~/.ansible/.vault-pass 
docker stop ubuntu centos7 fedora
