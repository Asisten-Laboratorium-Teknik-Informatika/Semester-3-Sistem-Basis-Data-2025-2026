<?php
include __DIR__ . "/../config/db.php";
$query_title = "Kategori Risiko Donor Berdasarkan Total Pints";
echo "<h3>$query_title</h3>";

$sql = "
    SELECT 
        dr.donor_id,
        p.full_name,
        dr.total_donations,
        dr.total_pints_donated,
        CASE 
            WHEN dr.total_pints_donated >= 100 THEN 'High Risk (Investigate)'
            WHEN dr.total_pints_donated >= 50 THEN 'Heavy Donor'
            ELSE 'Normal Donor'
        END AS risk_level
    FROM donation_records dr
    JOIN pendonor p ON dr.donor_id = p.donor_id
    ORDER BY dr.total_pints_donated DESC
";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    echo "<table border='1' cellpadding='8' cellspacing='0'>";
    echo "<tr>
            <th>Donor ID</th>
            <th>Nama Donor</th>
            <th>Total Donasi</th>
            <th>Total Pints</th>
            <th>Kategori Risiko</th>
          </tr>";

    while ($row = $result->fetch_assoc()) {
        echo "<tr>
                <td>{$row['donor_id']}</td>
                <td>{$row['full_name']}</td>
                <td>{$row['total_donations']}</td>
                <td>{$row['total_pints_donated']}</td>
                <td>{$row['risk_level']}</td>
              </tr>";
    }

    echo "</table>";
} else {
    echo "Tidak ada data risiko donor.";
}
?>
