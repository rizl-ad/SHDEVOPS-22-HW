module "symmetric_key" {
  source = "./kms/symmetric/key"
  name = var.symmetric_key_name
  default_algorithm = "AES_256"
  deletion_protection = true
  rotation_period = "2160h"
}
