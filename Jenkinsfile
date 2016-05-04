
// Only run on Linux atm
wrappedNode(label: 'linux && x86_64') {
  deleteDir()
  stage "checkout"
  checkout scm
  stage "test"
  sh "docker run --rm docs/base:latest"
}
