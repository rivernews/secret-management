provider "aws" {
    # index of data depends on the order of values in `secret_pointers`
  region     = data.external.secret_files[index(var.secret_pointers, "provider/aws/iriversland2-15pro")].result["/provider/aws/account/iriversland2-15pro/AWS_REGION"]
  access_key = data.external.secret_files[index(var.secret_pointers, "provider/aws/iriversland2-15pro")].result["/provider/aws/account/iriversland2-15pro/AWS_ACCESS_KEY_ID"]
  secret_key = data.external.secret_files[index(var.secret_pointers, "provider/aws/iriversland2-15pro")].result["/provider/aws/account/iriversland2-15pro/AWS_SECRET_ACCESS_KEY"]
}

# terraform doc: https://www.terraform.io/docs/providers/aws/r/ssm_parameter.html
# aws ssm parameter portal: https://us-east-2.console.aws.amazon.com/systems-manager/parameters/?region=us-east-2
resource "aws_ssm_parameter" "secrets" {
    count = "${length(local.merged_pairs)}"
  name  = "${local.merged_secret_names[count.index]}"
  type  = "String"
  value = "${local.merged_secret_values[count.index]}"

  overwrite = true

  # for each in resource: https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739bbae55f9
#   dynamic "secret_name" {
#       for_each = "${data.external.secret_files[count.index]}"
#   }
}