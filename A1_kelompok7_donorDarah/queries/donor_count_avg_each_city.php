<?php
include __DIR__ . "/../config/db.php";
$query_title = "Jumlah Donor & Rata-rata Donasi per Kota";
echo "<h3>$query_title</h3>";

$sql = "
SELECT 
    c.city_name,
    COUNT(p.donor_id) AS jumlah_donor,
    AVG(dr.total_donations) AS rata2_donasi
FROM pendonor p
JOIN city c 
    ON p.city_id = c.city_id
JOIN donation_records dr 
    ON dr.donor_id = p.donor_id
GROUP BY c.city_name
ORDER BY jumlah_donor DESC
LIMIT 3
";

$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {

    echo "<table>";
    echo "<tr>
            <th>Kota</th>
            <th>Jumlah Donor</th>
            <th>Rata-rata Donasi</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['city_name']}</td>
                <td>{$row['jumlah_donor']}</td>
                <td>".round($row['rata2_donasi'],2)."</td>
              </tr>";
    }

    echo "</table>";

} else {
    echo "<p>Data tidak ditemukan</p>";
}
?>
