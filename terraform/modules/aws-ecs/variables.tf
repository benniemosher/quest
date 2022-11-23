variable "config" {
  description = "The config to create the ECS cluster with."
  type = object({
    # security-groups                = optional(list(string), [])
    subnets                        = list(string)
    vpc                            = string
    assign-public-ip               = optional(bool, true)
    cloud-watch-encryption-enabled = optional(bool, true)
    cloud-watch-log-group-name     = optional(bool, null)
    cluster-name                   = string
    ecs-service-count              = optional(number, 1)
    environment                    = optional(list(any), null)
    image-url                      = string
    kms-key-arn                    = optional(string, null)
    launch-type                    = optional(string, "FARGATE")
    load-balancer-type             = optional(string, "application")
    logging-command-configuration  = optional(string, "OVERRIDE")
    task-definition-container-port = optional(number, 3000)
    task-definition-cpu            = optional(number, 256)
    task-definition-file           = optional(string, null)
    task-definition-host-port      = optional(number, 3000)
    task-definition-memory         = optional(number, 512)
    task-definition-network-mode   = optional(string, "awsvpc")
  })
}
