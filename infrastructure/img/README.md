## Запросы которые использовал, прошу дополнить, если есть замечания, улучшения)

### Business
* rate(sausage_orders_total{type="$sausage_type"}[1m])

### App

* 1st - 

        quantile(0.99, http_server_requests_seconds_sum{method="POST",uri="/api/orders"} / http_server_requests_seconds_count{method="POST",uri="/api/orders"})

* 2nd -

        rate(http_server_requests_seconds_count{uri!~"/actuator/health|/actuator/prometheus"}[5m])

* 3rd -

        sum (rate(http_server_requests_seconds_count{status="404"}[1m]))

* 4th -

        (sum(jvm_memory_used_bytes{area="heap"}) + sum(jvm_memory_committed_bytes{area="heap"})) / sum(jvm_memory_max_bytes{ area="heap"})

        (sum(jvm_memory_used_bytes{area="nonheap"}) + sum(jvm_memory_committed_bytes{area="nonheap"})) / sum(jvm_memory_max_bytes{ area="nonheap"})