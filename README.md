# py-terraform

## コマンド説明

### 各種パッケージのインストール

```sh
$ terraform init
```

### 構築内容の確認

```sh
$ terraform plan
```

### インフラを構築

```sh
$ terraform apply -auto-approve
```

### インフラを破棄

```sh
$ terraform destroy -auto-approve
```

### tf ファイルのフォーマット

```sh
$ terraform fmt -recursive
```

## デプロイ手順

1. apply for `iam`

   ```sh
   $ cd modules/iam
   $ terraform apply -auto-approve
   ```

1. apply for `lambda`

   ```sh
   $ cd ../lambda
   var.lambda_role
   Enter a value:
   ```

1. apply for `api-gateway`

   ```sh
   $ cd ../api-gateway
   $ terraform apply -auto-approve
   var.api_gateway_role
   Enter a value:

   var.lambda_arn
   Enter a value:
   ```
