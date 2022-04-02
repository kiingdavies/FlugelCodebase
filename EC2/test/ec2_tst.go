package test

import (
	"fmt"
	"time"
	"testing"
	http_helper "github.com/gruntwork-io/terratest/modules/http-helper"
	"github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformS3Example(t *testing.T) {
	terraformOptions := terraform.WithDefaultRetryableErrors(t, &terraform.Options{
		TerraformDir: "../",

		Vars: map[string]interface{}{	
			"Name": "Flugel",
    		"Environment": "InfraTeam",
		},
	})

	terraform.InitAndApply(t, terraformOptions)
	defer terraform.Destroy(t, terraformOptions)

	// publicIp := terraform.Output(t, terraformOptions, "public_ip")

	// url := fmt.Sprintf("http://%s:8080", publicIp)

	// http_helper.HttpGetWithRetry(t, url, nil, 200, "I made a Terraform S3 Example", 30, 5*time.Second)
}