<?php
include __DIR__ . "/../config/db.php";

$query_title ="Donor yang Didaftarkan dalam 1 Tahun Terakhir (2024)" ;

echo "<h3>$query_title</h3>";


$sql = "
SELECT 
    donor_id,
    full_name,
    record_created_at
FROM pendonor
WHERE record_created_at >= '2024-01-01'
ORDER BY record_created_at DESC
LIMIT 3
";

$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {

    echo "<table>";
    echo "<tr>
            <th>ID Donor</th>
            <th>Nama Lengkap</th>
            <th>Tanggal Terdaftar</th>
          </tr>";

    while($row = $result->fetch_assoc()){
        echo "<tr>
                <td>{$row['donor_id']}</td>
                <td>{$row['full_name']}</td>
                <td>{$row['record_created_at']}</td>
              </tr>";
    }

    echo "</table>";

} else {
    echo "<p>Tidak ada donor yang terdaftar dalam 1 tahun terakhir</p>";
}
?>
