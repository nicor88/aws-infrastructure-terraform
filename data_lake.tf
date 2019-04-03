variable "data_catalog_location_event_example_1" {
  description = "S3 location of the example_1 event"
  default     = "event=example_1"
}

resource "aws_glue_catalog_table" "event_example_1" {
  name          = "${replace(var.data_catalog_location_event_example_1,"=","_",)}" # transform Hive Metastore location, into snake case definition
  database_name = "example"
  description   = "Table definition for example event"

  table_type    = "EXTERNAL_TABLE"

  partition_keys = [
      {name = "year", type="string", comment=""},
      {name = "month", type="string", comment=""},
      {name = "day", type="string", comment=""},
      {name = "hour", type="string", comment=""},
      {name = "minute", type="string", comment=""},
    ]

  storage_descriptor {
    location      = "s3://nicola-corda-data-lake/${var.data_catalog_location_event_example_1}/"
    input_format  = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetInputFormat"
    output_format = "org.apache.hadoop.hive.ql.io.parquet.MapredParquetOutputFormat"
    compressed    = "True"
    columns       = [
      {name = "device_id", type="string", comment="Unique device identifier"},
      {name = "timestamp", type="string", comment="Event timestamp"},
      {name = "measure_name", type="string", comment="Name of the measure, e.g. temperature"},
      {name = "measure_value", type="string", comment="Value of the measure, in case of temperature e.g. 23"},
      {name = "createdat", type="string", comment="Another example for timestamp"},
    ]
    ser_de_info {
        name = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
        serialization_library = "org.apache.hadoop.hive.ql.io.parquet.serde.ParquetHiveSerDe"
        parameters = "${map(
            "serialization.format", "1",
            "parquet.compress", "SNAPPY",
            "has_encrypted_data", "true"
        )}"
    }
  }
}