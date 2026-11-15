SELECT
  ROUND(
    COUNTIF(b.guest_id IS NULL) * 100.0 / COUNT(*),
    2
  ) AS percentage_unbooked_guests
FROM `data-analytics-mate.product_analytics.users` AS u
LEFT JOIN (
  SELECT DISTINCT guest_id
  FROM `data-analytics-mate.product_analytics.bookings`
) AS b
  ON u.user_id = b.guest_id
WHERE u.role = 'guest';