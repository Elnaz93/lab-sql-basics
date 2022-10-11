#Query 1
SELECT client_id from client WHERE district_id = 1 LIMIT 5;
#Query 2
SELECT max(client_id) FROM client WHERE district_id = 72;
#Query 3
SELECT amount FROM loan ORDER BY amount ASC LIMIT 3;
#Query 4
SELECT DISTINCT(STATUS) FROM loan ORDER BY STATUS ASC;
#Query 5
SELECT loan_id, payments FROM loan ORDER BY payments ASC;
#Query 6
SELECT account_id, amount FROM loan ORDER BY account_id ASC LIMIT 5;
#Query 7
SELECT account_id FROM loan WHERE duration = 60 ORDER BY amount ASC LIMIT 5;
#Query 8
SELECT DISTINCT k_symbol FROM `order` ORDER BY k_symbol ASC;
#Query 9
SELECT order_id FROM `order` WHERE account_id = 34
#Query 10
SELECT distinct account_id from bank.order where order_id between 29540 and 29560;
#Query 11
SELECT amount FROM `order` WHERE account_to = 30067122;
#Query 12
SELECT trans_id, date, TYPE, amount FROM trans WHERE account_id =(793) ORDER BY date DESC LIMIT 10;
#Query 13
SELECT district_id, count(client_id) FROM client WHERE district_id < 10 GROUP BY district_id;
#Query 14
SELECT TYPE, count(card_id) AS card_quantity FROM card GROUP BY `type`;
#Query 15
SELECT account_id, sum(amount) AS 'total loan amount' FROM loan GROUP BY account_id ORDER BY amount DESC LIMIT 10;
#Query 16
SELECT `date`, count(loan_id) FROM loan WHERE `date` < 930907 GROUP BY `date` ORDER BY `date` DESC;
#Query 17
SELECT `date`, duration, count(loan_id) AS number_of_loans FROM loan WHERE date LIKE '9712%' GROUP BY `date`, duration ORDER BY `date`, duration;
#Query 18
SELECT account_id, TYPE, sum(amount) AS 'total_amount' FROM trans WHERE account_id = 396 GROUP BY TYPE ORDER BY TYPE;
#Query 19
SELECT
    account_id,
    CASE
        WHEN `TYPE` = 'PRIJEM' THEN 'Incoming'
        ELSE 'Outgoing'
    END AS transaction_type,
    floor(sum(amount)) AS 'total_amount'
FROM trans WHERE account_id = 396 GROUP BY 1, 2;

#Query 20

SELECT
    account_id,
    (
        SELECT
            floor(
                sum(
                    CASE
                        WHEN `TYPE` = 'PRIJEM' THEN amount
                    END
                )
            )
    ) AS incoming,
    (
        SELECT
            floor(
                sum(
                    CASE
                        WHEN `TYPE` = 'VYDAJ' THEN amount
                    END
                )
            )
    ) AS outgoing,
    (
        SELECT
            floor(
                sum(
                    CASE
                        WHEN `TYPE` = 'PRIJEM' THEN amount
                    END
                )
            ) - floor(
                sum(
                    CASE
                        WHEN `TYPE` = 'VYDAJ' THEN amount
                    END
                )
            )
    ) AS balance
FROM
    trans
WHERE
    account_id = 396;
    #Query 21

SELECT
    account_id,
    (
        SELECT
            floor(
                sum(
                    CASE
                        WHEN `TYPE` = 'PRIJEM' THEN amount
                    END
                )
            ) - floor(
                sum(
                    CASE
                        WHEN `TYPE` = 'VYDAJ' THEN amount
                    END
                )
            )
    ) AS balance
FROM
    trans
GROUP BY
    account_id
ORDER BY
    2 DESC
LIMIT
    10;