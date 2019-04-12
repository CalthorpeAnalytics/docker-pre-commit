FROM python:3.7.3-stretch

RUN apt-get update && apt-get install -y \
      build-essential \
      curl \
      git \
      libxml2-dev \
      libxslt1-dev \
      nodejs \
      ruby \
      ruby-dev \
      unzip \
      xz-utils \
      zlib1g-dev && \
    apt-get clean && \
    rm -rf /var/lib/apt

# Use specific version of shellcheck. It's useful to keep
# this in sync with the version in Homebrew so macOS developer
# workstations have the same version as this Docker image.
ARG SHELLCHECK_VERSION=0.6.0
RUN mkdir /tmp/shellcheck && \
    cd /tmp/shellcheck && \
    curl -# -O "https://storage.googleapis.com/shellcheck/shellcheck-v${SHELLCHECK_VERSION}.linux.x86_64.tar.xz" && \
    tar --xz -xvf shellcheck-v"${SHELLCHECK_VERSION}".linux.x86_64.tar.xz && \
    cp shellcheck-v"${SHELLCHECK_VERSION}"/shellcheck /usr/bin/ && \
    rm -rf /tmp/shellcheck

RUN mkdir -p /tmp/terraform && \
    cd /tmp/terraform && \
    curl -# -o terraform.zip https://releases.hashicorp.com/terraform/0.9.11/terraform_0.9.11_linux_amd64.zip && \
    unzip terraform.zip && \
    mv terraform /usr/local/bin && \
    rm -rf /tmp/terraform

RUN pip install pre-commit==1.15.1

ENTRYPOINT ["pre-commit"]
