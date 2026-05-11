# Module: networking

Creates the subnet layout, routing, and DB subnet group needed for an RDS deployment.


## Notes

- Private subnets have no route to the internet gateway, keeping the DB tier isolated.
- At least two AZs (and therefore two private subnets) are recommended to satisfy RDS Multi-AZ requirements.
