-- Step 1: 7 ta 0 qiymatni tayyorlaymiz
WITH ZeroShipments AS (
    SELECT 0 AS Num
    FROM (SELECT 1 UNION ALL SELECT 2 UNION ALL SELECT 3
          UNION ALL SELECT 4 UNION ALL SELECT 5 UNION ALL SELECT 6
          UNION ALL SELECT 7)
),

-- Step 2: Barcha 40 ta kunlik ma’lumotni birlashtiramiz
AllShipments AS (
    SELECT Num FROM Shipments
    UNION ALL
    SELECT Num FROM ZeroShipments
),

-- Step 3: Har bir qatorga tartib raqami beramiz (1 dan 40 gacha)
Ordered AS (
    SELECT Num, ROW_NUMBER() OVER (ORDER BY Num) AS rn
    FROM AllShipments
)

-- Step 4: 20-chi va 21-chi elementni tanlab, ularning o‘rtachasini hisoblaymiz
SELECT AVG(Num * 1.0) AS Median
FROM Ordered
WHERE rn IN (20, 21);

