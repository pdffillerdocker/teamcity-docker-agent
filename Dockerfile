FROM jetbrains/teamcity-agent:2018.1.2

#  TG-Terragrunt and TF-Terraform version
ENV TG_VERSION=v0.18.7 \
    TF_VERSION=0.11.14

RUN curl https://bootstrap.pypa.io/get-pip.py -o /tmp/get-pip.py && \
    python /tmp/get-pip.py && \
    pip install awscli --upgrade --user && \
    pip install jsonpickle && \
    mv /root/.local/bin/aws /bin/aws && \
    apt-get update -y && \
    apt install software-properties-common -y && \
    apt-add-repository --yes --update ppa:ansible/ansible && \
    apt install ansible -y && \
    curl -sS -L -O https://releases.hashicorp.com/terraform/${TF_VERSION}/terraform_${TF_VERSION}_linux_amd64.zip && \
    unzip terraform_${TF_VERSION}_linux_amd64.zip && \
    mv terraform /usr/bin/terraform && \
    chmod +x /usr/bin/terraform && \
    curl -sS -L -O https://github.com/gruntwork-io/terragrunt/releases/download/${TG_VERSION}/terragrunt_linux_amd64 && \
    mv terragrunt_linux_amd64 /usr/bin/terragrunt && \
    chmod +x /usr/bin/terragrunt



CMD "/run-services.sh"
