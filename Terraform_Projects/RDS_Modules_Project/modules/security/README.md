# Module: security

Creates two security groups that enforce network-level separation between the application tier and the RDS database.

The RDS security group has no inbound rule for `0.0.0.0/0` — the only allowed source is the app security group ID. This ensures the database is never publicly reachable even if a subnet is misconfigured.
