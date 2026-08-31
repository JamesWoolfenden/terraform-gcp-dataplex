locals {
  # Single source of truth for the subnet range: the Dataproc Serverless
  # firewall rule must allow internal traffic across exactly this range.
  subnet_cidr = "10.70.0.0/24"
}
