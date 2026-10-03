# Proxmox Terraform Cloud Init

- https://proxmoxr.com/blog/proxmox-terraform-provider

- Fixes from blog post
    - `pveum role add TerraformRole -privs`
	    - Add additional" permissions"
		    - Pool.Audit 
		    - VM.Audit
		    - VM.GuestAgent.Audit 
		    - VM.GuestAgent.Unrestricted"

	- versions.tf
		-  `version = "~> 3.0"`
			- "set to exact version"
	- main.tf
        - "group cores and socket into cpu"
            ```
            cpu { 
                cores = 2 
                sockets = 1
            }
            ```
 