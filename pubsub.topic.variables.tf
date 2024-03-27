variable "pub_sub_topic_name" {
  type        = string
  description = "Name of the topic"
}

variable "message_retention_duration" {
  type        = string
  description = " Indicates the minimum duration to retain a message after it is published to the topic. If this field is set, messages published to the topic in the last messageRetentionDuration are always available to subscribers. For instance, it allows any attached subscription to seek to a timestamp that is up to messageRetentionDuration in the past. If this field is not set, message retention is controlled by settings on individual subscriptions. The rotation period has the format of a decimal number, followed by the letter s (seconds). Cannot be more than 31 days or less than 10 minutes."
}
