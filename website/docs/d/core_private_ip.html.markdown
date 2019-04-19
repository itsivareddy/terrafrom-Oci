---
layout: "oci"
page_title: "Oracle Cloud Infrastructure: oci_core_private_ip"
sidebar_current: "docs-oci-datasource-core-private_ip"
description: |-
  Provides details about a specific Private Ip in Oracle Cloud Infrastructure Core service
---

# Data Source: oci_core_private_ip
This data source provides details about a specific Private Ip resource in Oracle Cloud Infrastructure Core service.

Gets the specified private IP. You must specify the object's OCID.
Alternatively, you can get the object by using
[ListPrivateIps](https://docs.cloud.oracle.com/iaas/api/#/en/iaas/20160918/PrivateIp/ListPrivateIps)
with the private IP address (for example, 10.0.3.3) and subnet OCID.


## Example Usage

```hcl
data "oci_core_private_ip" "test_private_ip" {
	#Required
	private_ip_id = "${oci_core_private_ip.test_private_ip.id}"
}
```

## Argument Reference

The following arguments are supported:

* `private_ip_id` - (Required) The OCID of the private IP.


## Attributes Reference

The following attributes are exported:

* `availability_domain` - The private IP's availability domain.  Example: `Uocm:PHX-AD-1` 
* `compartment_id` - The OCID of the compartment containing the private IP.
* `defined_tags` - Defined tags for this resource. Each key is predefined and scoped to a namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).  Example: `{"Operations.CostCenter": "42"}` 
* `display_name` - A user-friendly name. Does not have to be unique, and it's changeable. Avoid entering confidential information. 
* `freeform_tags` - Free-form tags for this resource. Each tag is a simple key-value pair with no predefined name, type, or namespace. For more information, see [Resource Tags](https://docs.cloud.oracle.com/iaas/Content/General/Concepts/resourcetags.htm).  Example: `{"Department": "Finance"}` 
* `hostname_label` - The hostname for the private IP. Used for DNS. The value is the hostname portion of the private IP's fully qualified domain name (FQDN) (for example, `bminstance-1` in FQDN `bminstance-1.subnet123.vcn1.oraclevcn.com`). Must be unique across all VNICs in the subnet and comply with [RFC 952](https://tools.ietf.org/html/rfc952) and [RFC 1123](https://tools.ietf.org/html/rfc1123).

	For more information, see [DNS in Your Virtual Cloud Network](https://docs.cloud.oracle.com/iaas/Content/Network/Concepts/dns.htm).

	Example: `bminstance-1` 
* `id` - The private IP's Oracle ID (OCID).
* `ip_address` - The private IP address of the `privateIp` object. The address is within the CIDR of the VNIC's subnet.  Example: `10.0.3.3` 
* `is_primary` - Whether this private IP is the primary one on the VNIC. Primary private IPs are unassigned and deleted automatically when the VNIC is terminated.  Example: `true` 
* `subnet_id` - The OCID of the subnet the VNIC is in.
* `time_created` - The date and time the private IP was created, in the format defined by RFC3339.  Example: `2016-08-25T21:10:29.600Z` 
* `vnic_id` - The OCID of the VNIC the private IP is assigned to. The VNIC and private IP must be in the same subnet. 
