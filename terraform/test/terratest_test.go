package test

import (
    "fmt"
    "os"
    "path/filepath"
    "testing"

    "github.com/gruntwork-io/terratest/modules/terraform"
)

func TestTerraformBasicExample(t *testing.T) {
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



