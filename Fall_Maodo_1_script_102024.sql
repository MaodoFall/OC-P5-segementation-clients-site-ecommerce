---------------------------------------------------- Script des réquêtes SQL pour le Dasboard ------------------------------------------------------------

-- 1. En excluant les commandes annulées, quelles sont les commandes récentes de moins de 3 mois que les clients ont reçues avec au moins 3 jours de retard ?

SELECT * FROM orders
WHERE order_status != "canceled"
AND order_purchase_timestamp >= (
    SELECT DATE(MAX(order_purchase_timestamp), "-90 day")
    FROM orders
    WHERE order_status != "canceled"
)
AND julianday(order_delivered_customer_date) - julianday(order_estimated_delivery_date) > 3; 


--- 2. Qui sont les vendeurs ayant généré un chiffre d'affaires de plus de 100 000 Real sur des commandes livrées via Olist ?

SELECT order_items.seller_id AS seller,SUM(order_items.price + order_items.freight_value) AS total_income
FROM order_items
INNER JOIN orders ON order_items.order_id = orders.order_id
WHERE orders.order_status = "delivered"
GROUP BY seller
HAVING total_income > 100000;


--- 3. Qui sont les nouveaux vendeurs (moins de 3 mois d'ancienneté) qui sont déjà très engagés avec la plateforme (ayant déjà vendu plus de 30 produits) ?

WITH seller_activity AS (
SELECT seller_id,MIN(shipping_limit_date) AS first_order_date
FROM order_items
GROUP BY seller_id
),
Max_order_date AS (
SELECT MAX(first_order_date) AS max_order_date FROM seller_activity
)
SELECT seller_activity.seller_id,seller_activity.first_order_date,COUNT(order_items.order_item_id) AS total_sells,
CAST(JULIANDAY(Max_order_date.max_order_date) - JULIANDAY(seller_activity.first_order_date) AS INTEGER) AS active_days
FROM seller_activity
INNER JOIN order_items ON seller_activity.seller_id = order_items.seller_id
INNER JOIN max_order_date ON 1=1
WHERE seller_activity.first_order_date >= DATE(Max_order_date.max_order_date, "-3 months")
GROUP BY seller_activity.seller_id, seller_activity.first_order_date
HAVING total_sells > 30;


-- 4.  Question : Quels sont les 5 codes postaux, enregistrant plus de 30 reviews, avec le pire review score moyen sur les 12 derniers mois ?

SELECT sellers.seller_zip_code_prefix AS zip_code,COUNT(order_items.order_id) AS nb_orders,AVG(CAST(order_reviews.review_score AS FLOAT)) AS review_score_avg
FROM order_items
INNER JOIN sellers ON order_items.seller_id = sellers.seller_id
INNER JOIN order_reviews ON order_items.order_id = order_reviews.order_id
WHERE order_reviews.review_creation_date >= DATE((SELECT MAX(review_creation_date) FROM order_reviews),"-12 months")
GROUP BY zip_code
HAVING nb_orders > 30
ORDER BY review_score_avg
LIMIT 5;















