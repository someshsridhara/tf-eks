package test

import (
	"fmt"
	"testing"

	"github.com/gruntwork-io/terratest/modules/aws"
	"github.com/gruntwork-io/terratest/modules/logger"
	"github.com/gruntwork-io/terratest/modules/random"
	"github.com/gruntwork-io/terratest/modules/terraform"
	test_structure "github.com/gruntwork-io/terratest/modules/test-structure"
	"github.com/stretchr/testify/assert"
)

func TestTerraformEks(t *testing.T) {
	t.Parallel()
	testTerraformPath := "../.tmp"
	terraformOptions := configureTerraformOptions(t, testTerraformPath)

	defer test_structure.RunTestStage(t, "teardown", func() {
		msg, err := terraform.DestroyE(t, terraformOptions)
		logger.Log(t, msg)
		if err != nil {
			logger.Log(t, "terraform destroy failed. Cleanup of resoures may be required")
		}
	})

	test_structure.RunTestStage(t, "deploy", func() {
		copyTerraformToTmpDir()
		test_structure.SaveTerraformOptions(t, testTerraformPath, terraformOptions)
		logger.Log(t, "Running InitAndApply steps...")
		terraform.InitAndApply(t, terraformOptions)
	})

	test_structure.RunTestStage(t, "validate", func() {
		logger.Log(t, "Running validation steps...")

		logger.Log(t, "--------------------")
		logger.Log(t, "Before assertions...")
		logger.Log(t, "--------------------")

		clusterVersion := terraform.Output(t, terraformOptions, "eks_cluster_version")
		assert.Equal(t, "1.18", clusterVersion)

		logger.Log(t, "-----------------")
		logger.Log(t, "After assertions.")
		logger.Log(t, "-----------------")
	})
}

func configureTerraformOptions(t *testing.T, path string) *terraform.Options {
	logger.Log(t, "Configuring Terraform options...")

	approvedRegions := []string{"ap-southeast-1"}
	awsRegion := aws.GetRandomRegion(t, approvedRegions, nil)
	clusterName := fmt.Sprintf("terratest-eks-cluster-%s", random.UniqueId())
	prefixName := fmt.Sprintf("terratest-sample-%s", random.UniqueId())
	envTag := fmt.Sprintf("test-%s", random.UniqueId())
	dnsBaseDomain := fmt.Sprintf("terratest%s.someshasridhara.com", random.UniqueId())

	terraformOptions := &terraform.Options{
		// The path to where our Terraform code is located
		TerraformDir: path,

		// Variables to override when running terraform script for testing
		Vars: map[string]interface{}{
			"aws_region":      awsRegion,
			"cluster_name":    clusterName,
			"prefix_name":     prefixName,
			"env_tag":         envTag,
			"dns_base_domain": dnsBaseDomain,
		},

		// Environment variables to set when running Terraform
		EnvVars: map[string]string{
			"AWS_DEFAULT_REGION": awsRegion,
		},
	}
	return terraformOptions
}

func copyTerraformToTmpDir() {
	CopyDir("../", "../.tmp")
}
