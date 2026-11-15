WITH first_booking AS (
  SELECT
    guest_id,
    MIN(DATE(booked_at)) AS first_booking_date
  FROM `data-analytics-mate.product_analytics.bookings`
  GROUP BY guest_id
)

SELECT
  COUNT(*) AS guests_with_booking,
  COUNTIF(
    DATE_DIFF(fb.first_booking_date, DATE(u.registered_at), DAY) < 7
  ) AS activated_guests,
  ROUND(
    COUNTIF(
      DATE_DIFF(fb.first_booking_date, DATE(u.registered_at), DAY) < 7
    ) * 100.0 / COUNT(*),
    2
  ) AS activation_rate_pct
FROM `data-analytics-mate.product_analytics.users` AS u
INNER JOIN first_booking AS fb
  ON u.user_id = fb.guest_id
WHERE u.role IN ('guest', 'both');
