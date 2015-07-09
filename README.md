# Docker image with gitlab-ci-multi-runner to run builds with ruby

Docker image with gitlab-ci-multi-runner, which can run ruby builds. It uses [rbenv](https://github.com/sstephenson/rbenv) to manage ruby versions.

## How to use

Example of [Docker Compose](https://docs.docker.com/compose/) file (`docker-compose.yml`)

```
vrunner:
  image: busybox
    volumes:
        - /home/gitlab_ci_multi_runner/data

runner:
    image: outcoldman/gitlab-ci-multi-runner-ruby:latest
    volumes_from:
        - vrunner
    environment:
        - CI_SERVER_URL=https://gitlabci.example.com
        - RUNNER_TOKEN=YOUR_TOKEN_FROM_GITLABCI
    restart: always
```

Replace `CI_SERVER_URL` and `RUNNER_TOKEN`.

Run it

```
docker-compose up -d
```

Or using docker command line

```
docker run -d --env "CI_SERVER_URL=https://gitlabci.example.com" \
              --env "RUNNER_TOKEN=YOUR_TOKEN_FROM_GITLABCI" \
              --restart="always" \
              --name=ruby_runner \
              outcoldman/gitlab-ci-multi-runner-ruby:latest
```

In your project add `.gitlab-ci.yml`

```
before_script:
    - RBENV_VERSION=2.0.0-p645 rbenv install -s
    - RBENV_VERSION=2.0.0-p645 rbenv exec gem install bundle
    - RBENV_VERSION=2.0.0-p645 rbenv exec bundle install

build:
    script:
        - RBENV_VERSION=2.0.0-p645 rbenv ruby --version
    tags:
        - ruby
```

`before_script` will install required ruby version specified with `RBENV_VERSION`, install `bundle` and `gems` from your `Gemfile`.

`build` will invoke ruby and ask ruby version.

## More information

* Read about [gitlab-ci-multi-runner](https://gitlab.com/gitlab-org/gitlab-ci-multi-runner/) to learn how integration works with GitLab CI.
* This image is using [rbenv](https://github.com/sstephenson/rbenv) to maintain multilpe ruby versions. You can find other way how you can control ruby version, like instead of `RBENV_VERSION` you can use `.ruby-version` file.
* This image is using [ruby-build](https://github.com/sstephenson/ruby-build) to build ruby versions.
* This image is based on [docker-gitlab-ci-multi-runner](https://github.com/sameersbn/docker-gitlab-ci-multi-runner), which handles registration and startup.
