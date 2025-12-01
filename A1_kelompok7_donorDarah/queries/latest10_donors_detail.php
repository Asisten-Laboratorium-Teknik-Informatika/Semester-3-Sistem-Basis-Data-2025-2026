<?php
include __DIR__ . "/../config/db.php";
$query_title = "10 Donor Terbaru + Kota + Golongan Darah";
echo "<h3>$query_title</h3>";

$sql = "
SELECT 
    p.full_name,
    p.record_created_at,
    c.city_name,
    b.blood_group
FROM pendonor p
JOIN city c 
    ON p.city_id = c.city_id
JOIN bloodgroup b 
    ON p.blood_id = b.blood_id
ORDER BY p.record_created_at DESC
LIMIT 10
";

$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {

    echo "<table>";
    echo "<tr>
            <th>Nama Donor</th>
            <th>Kota</th>
            <th>Gol. Darah</th>
            <th>Tanggal Terdaftar</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['full_name']}</td>
                <td>{$row['city_name']}</td>
                <td>{$row['blood_group']}</td>
                <td>{$row['record_created_at']}</td>
              </tr>";
    }

    echo "</table>";

} else {
    echo "<p>Tidak ada data donor baru ditemukan</p>";
}
?>
