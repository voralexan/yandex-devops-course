# Momo Store aka Пельменная №2

<img width="900" alt="image" src="https://user-images.githubusercontent.com/9394918/167876466-2c530828-d658-4efe-9064-825626cc6db5.png">

## Frontend

```bash
npm install
NODE_ENV=production VUE_APP_API_URL=http://localhost:8081 npm run serve
```

## Backend

```bash
go run ./cmd/api
go test -v ./... 
```
## [Momo-store](https://momo-store.yc.cloudns.ph/) 
## К сожалению Let's Encrypt больше не выдает сертификаты для cloudns, поэтому не получилось сделать валидные сертификаты для приложения.
The certificate request has failed to complete and will be retried: Failed to wait for order resource "letsencrypt-hd5f4-4119308568" to become ready: order is in "errored" state: Failed to create Order: 429 urn:ietf:params:acme:error:rateLimited: Error creating new order :: too many certificates already issued for "cloudns.ph". Retry after 2023-05-29T02:00:00Z: see https://letsencrypt.org/docs/rate-limits/

## CI/CD

- используется единый [репозиторий](https://gitlab.praktikum-services.ru/a.voronin/momo-store)
- развертывание приложение осуществляется с использованием [Downstream pipeline](https://docs.gitlab.com/ee/ci/pipelines/downstream_pipelines.html#parent-child-pipelines) 
- при изменениях в соответствующих директориях триггерятся pipeline для backend, frontend и helm

## Versioning

- [SemVer 2.0.0](https://semver.org/lang/ru/)
- мажорные и минорные версии приложения изменяются вручную в файлах `backend/.gitlab-ci.yaml` и `frontend/.gitlab-ci.yaml` в переменной `VERSION`
- патч-версии изменяются автоматически на основе переменной `CI_PIPELINE_ID`
- для инфраструктуры версия приложения изменяется вручную в чарте `helm/Chart.yaml`

## Infrastructure

- код ---> [Gitlab](https://gitlab.praktikum-services.ru/)
- helm-charts ---> [Nexus](https://nexus.praktikum-services.ru/)
- анализ кода ---> [SonarQube](https://sonarqube.praktikum-services.ru/)
- docker-images ---> [Gitlab Container Registry](https://gitlab.praktikum-services.ru/a.voronin/momo-store/container_registry)
- терраформ бэкэнд ---> [Yandex Object Storage](https://cloud.yandex.ru/services/storage)
- продакшн ---> [Yandex Managed Service for Kubernetes](https://cloud.yandex.ru/services/managed-kubernetes)

## Init kubernetes

- клонировать репозиторий на машину с установленным terraform
- через консоль Yandex Cloud создать сервисный аккаунт с ролью `editor`, получить статический ключ доступа, сохранить секретный ключ в файле `infrastructure/terraform/backend.tfvars`
- получить [iam-token](https://cloud.yandex.ru/docs/iam/operations/iam-token/create), сохранить в файле `infrastructure/terraform/secret.tfvars`
- через консоль Yandex Cloud создать Object Storage, внести параметры подключения в файл `infrastructure/terraform/provider.tf`
- выполнить следующие комманды:

```
cd infrastructure/terraform
terraform init
terraform apply
```

## Init production

```
# создаем базовый namespace
kubectl create namespace momo-store

# устанавливаем cert-manager и ингресс контролер согласно инструкции
https://cloud.yandex.ru/docs/managed-kubernetes/tutorials/ingress-cert-manager?from=int-console-help-center-or-nav

# сохраняем креды для docker-registry
kubectl create secret generic -n momo-store docker-config-secret --from-file=.dockerconfigjson="/home/user/.docker/config.json" --type=kubernetes.io/dockerconfigjson 
# устанавливаем приложение, указав версии backend и frontend
helm dependency build
helm upgrade --install --atomic -n momo-store momo-store . --set backend.image.tag=latest --set frontend.image.tag=latest

# смотрим IP load balancer, прописываем А-записи для приложения и мониторинга
kubectl get svc
```

## [Monitoring](https://fana.yc.cloudns.ph/)

- admin / prom-operator
- включен в состав helm-chart приложения, зависимости прописаны в `helm/Chart.yaml`

- [infrastructure](https://fana.yc.cloudns.ph/d/CgCw8jKZz3/golang-metrics-for-prometheus-operator)
- [frontend](https://fana.yc.cloudns.ph/d/MsjffzSZz/nginx-exporter)
- [backend](https://fana.yc.cloudns.ph/d/Of2_XfQVz/backend-metrics)
- [logs](https://fana.yc.cloudns.ph/d/6Mn_QfQ4z/momo-store-logs)



## Possible improvements

- Отдельный куб кластер для дев окружения
- Отдельный мониторинг на весь кластер
- Vault для секретов
- CI/CD для Terraform
- Больше тестов, метрик, зависимотей :)