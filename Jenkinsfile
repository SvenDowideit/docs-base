
// Only run on Linux atm
wrappedNode(label: 'linux && x86_64') {
  deleteDir()
  stage "checkout"
  checkout scm
  stage "test"
  sh "make test"
}
