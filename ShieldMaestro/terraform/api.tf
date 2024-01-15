resource "google_app_engine_application" "app" {
  project     = "${var.project_id}"
  location_id = "${var.region}"
}

resource "google_storage_bucket" "app_source" {
  name     = "${var.project_id}-source-bucket"
  location = "EU"
}

resource "google_storage_bucket_object" "app_source_zip" {
  name   = "api_app.zip"
  bucket = google_storage_bucket.app_source.name
  source = "./api_app.zip"
}

resource "google_app_engine_standard_app_version" "myapp" {
  version_id = "v1"
  service    = "default"
  runtime    = "python39" # Ensure this matches your runtime in app.yaml

  entrypoint {
    shell = "uvicorn main:app --host 0.0.0.0 --port 8080"
  }

  deployment {
    zip {
      source_url = "https://storage.googleapis.com/${google_storage_bucket.app_source.name}/${google_storage_bucket_object.app_source_zip.name}"
    }
  }

  env_variables = {
    PORT = "8080"
  }

  delete_service_on_destroy = true
}
