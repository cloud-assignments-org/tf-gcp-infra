resource "google_pubsub_topic" "user-created" {
  name                       = var.pub_sub_topic_name
  message_retention_duration = var.message_retention_duration
}
