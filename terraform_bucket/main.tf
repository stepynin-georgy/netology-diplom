resource "yandex_storage_bucket" "diplom-bucket" {
  access_key = yandex_iam_service_account_static_access_key.service-account-static-key.access_key
  secret_key = yandex_iam_service_account_static_access_key.service-account-static-key.secret_key
  bucket     = "diplom-bucket"
  acl    = "public-read"
  website {
    index_document = "gosling.jpg"
  }
}
