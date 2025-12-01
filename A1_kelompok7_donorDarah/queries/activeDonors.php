<?php
include __DIR__ . "/../config/db.php";
$query_title = "Daftar Donor Aktif Berdasarkan Total Donasi";
echo "<h3>$query_title</h3>";

$sql = "
    SELECT 
        p.full_name,
        c.city_name,
        dr.total_donations,
        dr.total_pints_donated
    FROM donation_records dr
    JOIN pendonor p ON dr.donor_id = p.donor_id
    JOIN city c ON p.city_id = c.city_id
    WHERE dr.total_donations > 0
    ORDER BY dr.total_donations DESC
";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<table border='1' cellpadding='8' cellspacing='0'>";
    echo "<tr>
            <th>Nama Donor</th>
            <th>Kota</th>
            <th>Total Donasi</th>
            <th>Total Pints</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['full_name']}</td>
                <td>{$row['city_name']}</td>
                <td>{$row['total_donations']}</td>
                <td>{$row['total_pints_donated']}</td>
              </tr>";
    }

    echo "</table>";
} else {
    echo "Tidak ada donor aktif ditemukan.";
}
?>
