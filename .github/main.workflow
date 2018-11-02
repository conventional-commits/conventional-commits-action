workflow "Build and Publish" {
  on = "push"
  resolves = "Docker Publish"
}

action "Shell Lint" {
  uses = "actions/bin/shellcheck@master"
  args = "entrypoint.sh"
}

action "Docker Lint" {
  uses = "docker://replicated/dockerfilelint"
  args = ["Dockerfile"]
}

action "Build" {
  needs = ["Shell Lint", "Docker Lint"]
  uses = "actions/docker/cli@master"
  args = "build -t conventional-commits ."
}

action "Docker Tag" {
  needs = ["Build"]
  uses = "actions/docker/tag@master"
  args = "conventional-commits bcoe/conventional-commits --no-latest"
}

action "Publish Filter" {
  needs = ["Build"]
  uses = "actions/bin/filter@master"
  args = "branch master"
}

action "Docker Login" {
  needs = ["Publish Filter"]
  uses = "actions/docker/login@master"
  secrets = ["DOCKER_USERNAME", "DOCKER_PASSWORD"]
}

action "Version" {
  needs = ["Publish Filter"]
  uses = "docker://bcoe/conventional-commits:76ec988"
}

action "Docker Publish" {
  needs = ["Version", "Docker Tag", "Docker Login"]
  uses = "actions/docker/cli@master"
  args = "push bcoe/conventional-commits"
}
