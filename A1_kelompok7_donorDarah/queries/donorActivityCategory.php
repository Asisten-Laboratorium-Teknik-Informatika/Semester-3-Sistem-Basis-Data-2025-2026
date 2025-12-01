<?php
include __DIR__ . "/../config/db.php";
$query_title = "Kategori Aktivitas Donor Berdasarkan Total Donasi";
echo "<h3>$query_title</h3>";

$sql = "
    SELECT 
        dr.donor_id,
        p.full_name,
        dr.total_donations,

        CASE
            WHEN dr.total_donations >= 6 THEN 'Aktif Tinggi'
            WHEN dr.total_donations >= 3 THEN 'Aktif Sedang'
            ELSE 'Aktif Rendah'
        END AS kategori_aktivitas

    FROM donation_records dr
    JOIN pendonor p ON dr.donor_id = p.donor_id
    ORDER BY dr.total_donations DESC
";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<table border='1' cellpadding='8' cellspacing='0'>";
    echo "<tr>
            <th>Donor ID</th>
            <th>Nama Donor</th>
            <th>Total Donasi</th>
            <th>Kategori Aktivitas</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['donor_id']}</td>
                <td>{$row['full_name']}</td>
                <td>{$row['total_donations']}</td>
                <td>{$row['kategori_aktivitas']}</td>
              </tr>";
    }

    echo "</table>";
} else {
    echo "Tidak ada data donor.";
}
?>
