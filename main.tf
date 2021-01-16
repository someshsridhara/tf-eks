terraform {
  backend "s3" {
    bucket = "tf-infra-demo"
    key = "tf-state.json"
    region = "ap-southeast-2"
    workspace_key_prefix = "env"
  }
}