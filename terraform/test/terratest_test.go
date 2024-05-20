package test

import (
    "fmt"
    "os"
    "path/filepath"
    "os/exec"
    "testing"
    "time"

    "github.com/gruntwork-io/terratest/modules/aws"
    "github.com/gruntwork-io/terratest/modules/terraform"
    "github.com/stretchr/testify/assert"
)

// Example unit test function
func TestAddition(t *testing.T) {
    result := add(2, 3)
    expected := 5
    if result != expected {
        t.Errorf("Expected %d but got %d", expected, result)
    }
}

func add(a int, b int) int {
    return a + b
}

func TestTerraformBasicExample(t *testing.T) {
    verifyTerraformVersion(t)

    cwd, err := os.Getwd()
    if err != nil {
        t.Fatal(err)
    }
    fmt.Println("Current working directory:", cwd)

    terraformOptions := &terraform.Options{
        TerraformDir: "../",
        VarFiles: []string{filepath.Join(cwd, "..", "environments", "dev.tfvars")},
    }

    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)
}

func TestEndToEnd(t *testing.T) {
    verifyTerraformVersion(t)

    cwd, err := os.Getwd()
    if err != nil {
        t.Fatal(err)
    }
    fmt.Println("Current working directory:", cwd)

    terraformOptions := &terraform.Options{
        TerraformDir: "../",
        VarFiles: []string{filepath.Join(cwd, "..", "environments", "dev.tfvars")},
    }

    defer terraform.Destroy(t, terraformOptions)
    terraform.InitAndApply(t, terraformOptions)

    // Example: Validate AWS resources
    instanceID := terraform.Output(t, terraformOptions, "instance_id")
    region := "eu-west-2"

    // Wait for the instance to be in running state
    aws.WaitForInstanceStatus(t, region, instanceID, "running", 5*time.Minute)

    // Example: Add more end-to-end checks
    instance := aws.GetEC2InstanceById(t, region, instanceID)
    assert.Equal(t, "running", *instance.State.Name)
}

func verifyTerraformVersion(t *testing.T) {
    cmd := exec.Command("terraform", "version")
    output, err := cmd.CombinedOutput()
    if err != nil {
        t.Fatalf("Failed to get Terraform version: %v", err)
    }
    fmt.Printf("Terraform version: %s\n", output)
}







