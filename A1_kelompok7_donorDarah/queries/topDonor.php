<?php
include __DIR__ . "/../config/db.php";
$query_title = "Top Donor Berdasarkan Total Pints Didonasikan";
echo "<h3>$query_title</h3>";

$sql = "
SELECT 
    p.full_name,
    dr.total_pints_donated
FROM donation_records dr
JOIN pendonor p 
    ON dr.donor_id = p.donor_id
ORDER BY dr.total_pints_donated DESC
LIMIT 3
";

$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {

    echo "<table>";
    echo "<tr>
            <th>Nama Pendonor</th>
            <th>Total Pints Didonasikan</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['full_name']}</td>
                <td>{$row['total_pints_donated']}</td>
              </tr>";
    }

    echo "</table>";

} else {
    echo "<p>Tidak ada data ditemukan</p>";
}
?>
