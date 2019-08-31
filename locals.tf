locals {
    secret_data_results = data.external.secret_files.*.result

    # for looping map: https://www.hashicorp.com/blog/hashicorp-terraform-0-12-preview-for-and-for-each
    # inline for loop: https://blog.gruntwork.io/terraform-tips-tricks-loops-if-statements-and-gotchas-f739bbae55f9
    secret_values = join(";", [for index, pairs_map in local.secret_data_results:
        "${join(";", values(pairs_map))}"])
    
    secret_names = join(";", [for index, pairs_map in local.secret_data_results:
        "${join(";", keys(pairs_map))}"])

    merged_secret_names = split(";", local.secret_names)

    merged_secret_values = split(";", local.secret_values)
    
    merged_pairs = zipmap(
        local.merged_secret_names,
        local.merged_secret_values,
    )
}

