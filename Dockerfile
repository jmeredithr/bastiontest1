FROM quay.io/ansible/creator-ee

ENV HOME /home/runner

# nodejs 16 + VSCODE_NODEJS_RUNTIME_DIR are required on ubi9 based images
# until we fix https://github.com/eclipse/che/issues/21778
# When fixed, we won't need this Dockerfile anymore.
# c.f. https://github.com/che-incubator/che-code/pull/120
RUN \
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.3/install.sh | bash && \
export NVM_DIR="$HOME/.nvm" && \
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh" && \
nvm install 16.20.0
ENV VSCODE_NODEJS_RUNTIME_DIR="$HOME/.nvm/versions/node/v16.20.0/bin/"

RUN microdnf install -y vim \
git \
jq \
skopeo \
unzip \
setools \
bind-utils \
openscap-scanner \
httpd-tools \
wget \
&& wget https://releases.hashicorp.com/terraform/1.5.3/terraform_1.5.3_linux_amd64.zip \
&& unzip terraform_1.5.3_linux_amd64.zip \
&& mv terraform /usr/bin/terraform
