# infrastructure

## Created database indexes
-  CREATE INDEX idx_prd_id ON product(id);
- CREATE INDEX idx_ord_id ON orders(id);
- CREATE INDEX idx_ord ON order_product(order_id);
- CREATE INDEX idx_prd ON order_product(product_id);

