resource "yandex_iam_service_account" "service-account" {
  folder_id = var.folder_id
  name      = "terraform-service"
}

resource "yandex_resourcemanager_folder_iam_member" "service-account-editor" {
  folder_id = var.folder_id
  role      = "editor"
  member    = "serviceAccount:${yandex_iam_service_account.service-account.id}"
}

resource "yandex_iam_service_account_static_access_key" "service-account-static-key" {
  service_account_id = yandex_iam_service_account.service-account.id
}

resource "yandex_kms_symmetric_key" "key" {
  name              = "service-key"
  default_algorithm = "AES_128"
  rotation_period   = "8760h"
}
