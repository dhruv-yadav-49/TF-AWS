terraform {}

locals {
    value = "Hello World"
}

variable "string_list" {
    type = list(string)
    default = [ "serv1","serv2", "serv3"]
}

output "results" {
    value = {
        # String Functions
        lower      = lower(local.value)
        upper      = upper(local.value)
        startswith = startswith(local.value, "Hello")
        split      = split(" ", local.value)
        join       = join(" | ", var.string_list)
        replace    = replace(local.value, "World", "Terraform")
        trim       = trimspace("   too much space   ")

        # Collection Functions
        list_length = length(var.string_list)
        has_serv1   = contains(var.string_list, "serv1")
        first_serv  = element(var.string_list, 0)

        # Numeric Functions
        min   = min(1, 2, 3, 4, 5)
        max   = max(1, 2, 3, 4)
        abs   = abs(-15.5)
        ceil  = ceil(10.1)
        floor = floor(10.9)
    }
}