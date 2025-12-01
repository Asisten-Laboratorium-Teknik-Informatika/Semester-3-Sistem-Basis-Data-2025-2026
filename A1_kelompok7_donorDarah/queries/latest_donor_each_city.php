<?php
$query_title = "Donor Terbaru dari Tiap Kota";
include __DIR__ . "/../config/db.php";
echo "<h3>$query_title</h3>";


$sql = "
SELECT 
    p.city_id,
    c.city_name,
    p.donor_id,
    p.full_name,
    p.record_created_at
FROM pendonor p
JOIN city c 
    ON p.city_id = c.city_id
WHERE p.record_created_at = (
    SELECT MAX(p2.record_created_at)
    FROM pendonor p2
    WHERE p2.city_id = p.city_id
)
ORDER BY p.record_created_at DESC
";

$result = $conn->query($sql);

if ($result && $result->num_rows > 0) {

    echo '<table>';
    echo '<tr>
            <th>Kota</th>
            <th>ID Donor</th>
            <th>Nama Donor</th>
            <th>Tanggal Terdaftar</th>
          </tr>';

    while ($row = $result->fetch_assoc()) {
        echo '<tr>
                <td>'.$row['city_name'].'</td>
                <td>'.$row['donor_id'].'</td>
                <td>'.$row['full_name'].'</td>
                <td>'.$row['record_created_at'].'</td>
              </tr>';
    }

    echo '</table>';

} else {
    echo '<p>Tidak ada data ditemukan</p>';
}
?>
