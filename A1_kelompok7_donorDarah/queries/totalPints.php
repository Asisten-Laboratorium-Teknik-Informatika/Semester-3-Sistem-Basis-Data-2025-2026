<?php
include __DIR__ . "/../config/db.php";

$query_title = "Total Pints Donasi per Kota";
echo "<h3>$query_title</h3>";


$sql = "
SELECT 
    c.city_name, 
    SUM(dr.total_pints_donated) AS total_pints
FROM donation_records dr
JOIN pendonor p 
    ON dr.donor_id = p.donor_id
JOIN city c 
    ON p.city_id = c.city_id
GROUP BY c.city_name
ORDER BY total_pints DESC
LIMIT 3
";

$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {

    echo "<table>";
    echo "<tr>
            <th>Kota</th>
            <th>Total Pints</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['city_name']}</td>
                <td>{$row['total_pints']}</td>
              </tr>";
    }

    echo "</table>";

} else {
    echo "<p>Tidak ada data ditemukan</p>";
}
?>
