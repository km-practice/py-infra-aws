package test

import (
    "testing"
    "github.com/gruntwork-io/terratest/modules/terraform"
)

// TestTerraformBasicExample uses Terratest to test a basic Terraform configuration.
func TestTerraformBasicExample(t *testing.T) {
    t.Parallel()

    // The path to where your Terraform configuration files are located
    terraformOptions := &terraform.Options{
        // Set the path to the Terraform code that will be tested.
        TerraformDir: "../", // Adjust this path to the correct folder if necessary

        // Variables to pass to our Terraform code using -var options
        Vars: map[string]interface{}{
            "region": "eu-west-2",
        },

        // Disable colors in Terraform commands so output isn't muddled
        NoColor: true,
    }

    // Clean up resources with "terraform destroy" at the end of the test.
    defer terraform.Destroy(t, terraformOptions)

    // Initialize and apply the Terraform code in the directory
    if _, err := terraform.InitAndApplyE(t, terraformOptions); err != nil {
        t.Fatalf("Failed to apply Terraform: %v", err)
    }
}
