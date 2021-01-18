#!/bin/bash
 GO_TEST_DIR=${GO_TEST_DIR:-test}

 echo "Switching to test dir [$GO_TEST_DIR]..."
 cd $GO_TEST_DIR

 echo "Running unit tests..."
 go test -v tf_eks_unit_test.go copy.go -timeout=$GO_TEST_TIMEOUT