resource "google_cloud_tasks_queue" "default" {
  name     = "${var.project_id}-task_queque"
  location = "${var.region}"
}