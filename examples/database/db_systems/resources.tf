// Copyright (c) 2017, 2019, Oracle and/or its affiliates. All rights reserved.

resource "oci_database_db_system" "test_db_system" {
  availability_domain = "${data.oci_identity_availability_domain.ad.name}"
  compartment_id      = "${var.compartment_ocid}"
  cpu_core_count      = "${lookup(data.oci_database_db_system_shapes.test_db_system_shapes.db_system_shapes[0], "minimum_core_count")}"
  database_edition    = "${var.db_edition}"

  db_home {
    database {
      admin_password = "${var.db_admin_password}"
      db_name        = "${var.db_name}"
      character_set  = "${var.character_set}"
      ncharacter_set = "${var.n_character_set}"
      db_workload    = "${var.db_workload}"
      pdb_name       = "${var.pdb_name}"

      db_backup_config {
        auto_backup_enabled     = true
        recovery_window_in_days = 10

        backup_destination_details {
          id   = "${oci_database_backup_destination.test_backup_destination_nfs1.id}"
          type = "NFS"
        }
      }

      freeform_tags = {
        "Department" = "Finance"
      }
    }

    db_version   = "${var.db_version}"
    display_name = "${var.db_home_display_name}"
  }

  disk_redundancy = "${var.db_disk_redundancy}"
  shape           = "${var.db_system_shape}"
  subnet_id       = "${oci_core_subnet.subnet.id}"
  ssh_public_keys = ["${var.ssh_public_key}"]
  display_name    = "${var.db_system_display_name}"

  hostname                = "${var.hostname}"
  data_storage_percentage = "${var.data_storage_percentage}"
  data_storage_size_in_gb = "${var.data_storage_size_in_gb}"
  license_model           = "${var.license_model}"
  node_count              = "${lookup(data.oci_database_db_system_shapes.test_db_system_shapes.db_system_shapes[0], "minimum_node_count")}"
  nsg_ids                 = ["${oci_core_network_security_group.test_network_security_group.id}"]

  #To use defined_tags, set the values below to an existing tag namespace, refer to the identity example on how to create tag namespaces
  #defined_tags = "${map("example-tag-namespace-all.example-tag", "originalValue")}"

  freeform_tags = {
    "Department" = "Finance"
  }
}

resource "oci_database_backup_destination" "test_backup_destination_nfs1" {
  #Required
  compartment_id = "${var.compartment_ocid}"
  display_name   = "testBackupDestinationNFS"
  type           = "NFS"

  #Optional
  connection_string = "connectionString"

  freeform_tags = {
    "Department" = "Finance"
  }

  local_mount_point_path = "local_mount_point_path"
}

// The creation of an oci_database_db_system requires that it be created with exactly one oci_database_db_home. Therefore the first db home will have to be a property of the db system resource and any further db homes to be added to the db system will have to be added as first class resources using "oci_database_db_home".
resource "oci_database_db_home" "test_db_home" {
  db_system_id = "${oci_database_db_system.test_db_system.id}"

  database {
    admin_password = "${var.db_admin_password}"
    db_name        = "${var.db_home_db_name}3"
    character_set  = "${var.character_set}"
    ncharacter_set = "${var.n_character_set}"
    db_workload    = "${var.db_workload}"
    pdb_name       = "${var.pdb_name}"

    freeform_tags = {
      "Department" = "Finance"
    }

    db_backup_config {
      auto_backup_enabled = true

      backup_destination_details {
        id   = "${oci_database_backup_destination.test_backup_destination_nfs2.id}"
        type = "NFS"
      }
    }
  }

  db_version   = "${var.db_version}"
  display_name = "${var.db_home_display_name}"
}

resource "oci_database_backup_destination" "test_backup_destination_nfs2" {
  #Required
  compartment_id = "${var.compartment_ocid}"
  display_name   = "testBackupDestinationNFS"
  type           = "NFS"

  #Optional
  connection_string = "connectionString"

  freeform_tags = {
    "Department" = "Finance"
  }

  local_mount_point_path = "local_mount_point_path"
}

resource "oci_database_backup" "test_backup" {
  depends_on   = ["oci_database_db_system.test_db_system"]
  database_id  = "${oci_database_db_system.test_db_system.db_home.0.database.0.id}"
  display_name = "FirstBackup"
}
