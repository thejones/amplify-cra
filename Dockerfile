FROM amazonlinux:2

ENV VERSION_NODE=12.16.2

# Install Curl, Git, OpenSSL (AWS Amplify requirements) and tar (required to install hugo)
RUN curl --silent --location https://dl.yarnpkg.com/rpm/yarn.repo | sudo tee /etc/yum.repos.d/yarn.repo
RUN touch ~/.bashrc
RUN yum -y update && \
    yum -y install \
    curl \
    git \
    openssl \
    yar n\
    tar \
    yum clean all && \
    rm -rf /var/cache/yum

# Install Node (AWS Amplify requirement)
RUN curl -o- https://raw.githubusercontent.com/creationix/nvm/v0.33.11/install.sh | bash
RUN /bin/bash -c ". ~/.nvm/nvm.sh && \
    nvm install $VERSION_NODE && nvm use $VERSION_NODE && \
    nvm alias default node && nvm cache clear"

# Configure environment
RUN echo export PATH="\
    /root/.nvm/versions/node/${VERSION_NODE}/bin:\
    $PATH" >> ~/.bashrc && \
    echo "nvm use ${VERSION_NODE} 1> /dev/null" >> ~/.bashrc

ENTRYPOINT [ "bash", "-c" ]
