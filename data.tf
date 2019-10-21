# # based on https://stackoverflow.com/questions/46371424/decoding-json-string-to-terraform-map

variable "secret_pointers" {
  description = "maps name to its full path (formal name), which would be used to organize secrets and aws parameter store."
  type        = list(string)
  default = [
    "provider/aws/iriversland2-15pro",
    "provider/digitalocean/shaungc-do",
    "provider/dockerhub/shaungc",

    "app/iriversland2",
    "app/appl-tracky",

    "database/kubernetes_iriversland2",
    # "database/heroku_iriversland2", # deprecated, using `kubernetes_appl-tracky` instead now
    "database/kubernetes_appl-tracky",
    #   "database/heroku_appl-tracky", # deprecated, using `kubernetes_appl-tracky` instead now
    "database/postgres_cluster_kubernetes",

    "service/gmail",
    "service/google-social-auth",
  ]
}

data "external" "secret_files" {
  count   = "${length(var.secret_pointers)}"
  program = ["echo", "${file("secrets/${var.secret_pointers[count.index]}.secrets.json")}"]
}
