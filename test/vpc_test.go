package test

import (
	"testing"

	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestVPC(t *testing.T) {
	opts := &terraform.Options{
		TerraformDir: "../examples/",
	}

	terraform.InitAndApply(t, opts)
	defer terraform.Destroy(t, opts)
}
