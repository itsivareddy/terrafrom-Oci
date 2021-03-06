// Copyright (c) 2016, 2018, 2019, Oracle and/or its affiliates. All rights reserved.
// Code generated. DO NOT EDIT.

// DNS API
//
// API for the DNS service. Use this API to manage DNS zones, records, and other DNS resources.
// For more information, see Overview of the DNS Service (https://docs.cloud.oracle.com/iaas/Content/DNS/Concepts/dnszonemanagement.htm).
//

package dns

import (
	"github.com/oracle/oci-go-sdk/common"
)

// DynectMigrationDetails Details specific to performing a DynECT zone migration.
type DynectMigrationDetails struct {

	// DynECT customer name the zone belongs to.
	CustomerName *string `mandatory:"true" json:"customerName"`

	// DynECT API username to perform the migration with.
	Username *string `mandatory:"true" json:"username"`

	// DynECT API password for the provided username.
	Password *string `mandatory:"true" json:"password"`
}

func (m DynectMigrationDetails) String() string {
	return common.PointerString(m)
}
