variable "region" {{
  description = "Default Region"
  type        = string
}}

variable "cidr_env" {{
  description = "Default CIDR VPC"
  type        = string
}}

variable "cidr_2octectos" {{
  description = "Default CIDR 2 2rimeiros octetos of VPC"
  type        = string
}}

variable "subnets_public_total" {{
  description = "Default Total Subnets Public"
  type        = string
}}

variable "subnets_private_total" {{
  description = "Default Total Subnets Private"
  type        = string
}}

variable "eks_worker_nodes_instance_type" {{
  description = "Default Worker Node Instance Type"
  #type        = string
}}

variable "eks_node_scaling_desired_size" {{
  description = "Default Node Scaling Desired Size"
  type        = string
}}

variable "eks_node_scaling_max_size" {{
  description = "Default Node Scaling Max Size"
  type        = string
}}

variable "eks_node_scaling_min_size" {{
  description = "Default Node Scaling Min Size"
  type        = string
}}

variable "eks_encryption_config_resources" {{
  description = "Default Encryption Config Resources"
  #type        = string
}}

variable "eks_encryption_config_deletion_window_in_days" {{
  description = "Default Encryption Config Deletion Window in Days"
  #type        = string
}}

variable "eks_encryption_config_enable_key_rotation" {{
  description = "Default Encryption Config Enable Key Rotation"
  type        = string
}}