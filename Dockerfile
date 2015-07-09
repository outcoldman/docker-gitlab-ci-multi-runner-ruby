FROM sameersbn/gitlab-ci-multi-runner:latest
MAINTAINER Denis Gladkikh <docker@denis.gladkikh.email>

RUN apt-get update

# install build essentials
RUN apt-get install -y --no-install-recommends \
        git-core \
        curl \
		autoconf \
		automake \
		bzip2 \
		file \
		g++ \
		gcc \
		imagemagick \
		libbz2-dev \
		libc6-dev \
		libcurl4-openssl-dev \
		libevent-dev \
		libffi-dev \
		libglib2.0-dev \
		libjpeg-dev \
		liblzma-dev \
		libmagickcore-dev \
		libmagickwand-dev \
		libmysqlclient-dev \
		libncurses-dev \
		libpq-dev \
		libreadline-dev \
		libsqlite3-dev \
		libssl-dev \
		libtool \
		libxml2-dev \
		libxslt-dev \
		libyaml-dev \
		make \
		patch \
		xz-utils \
		zlib1g-dev

RUN git clone https://github.com/sstephenson/rbenv.git ${GITLAB_CI_MULTI_RUNNER_HOME_DIR}/.rbenv
RUN git clone https://github.com/sstephenson/ruby-build.git ${GITLAB_CI_MULTI_RUNNER_HOME_DIR}/.rbenv/plugins/ruby-build

RUN echo 'export PATH="$HOME/.rbenv/bin:$PATH"\neval "$(rbenv init -)"' > ${GITLAB_CI_MULTI_RUNNER_HOME_DIR}/.bashrc

RUN chown -R ${GITLAB_CI_MULTI_RUNNER_USER}:${GITLAB_CI_MULTI_RUNNER_USER} ${GITLAB_CI_MULTI_RUNNER_HOME_DIR}

RUN locale-gen en_US.UTF-8

ENV LC_ALL en_US.UTF-8
ENV LANG en_US.UTF-8

ENV RUNNER_DESCRIPTION=ruby
ENV RUNNER_DESCRIPTION=shell
ENV RUNNER_TAG_LIST=ruby
ENV RUNNER_LIMIT=1

ENV RUNNER_TOKEN=
ENV CI_SERVER_URL=
