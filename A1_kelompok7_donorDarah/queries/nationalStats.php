<?php
include __DIR__ . "/../config/db.php";
$query_title = "Statistik Nasional Donasi";
echo "<h3>$query_title</h3>";

$sql = "
    SELECT 
        SUM(total_donations) AS total_semua_donasi,
        SUM(total_pints_donated) AS total_semua_pints,
        AVG(total_donations) AS rata2_donasi,
        AVG(total_pints_donated) AS rata2_pints,
        MAX(total_donations) AS max_donasi,
        MAX(total_pints_donated) AS max_pints
    FROM donation_records
";

$result = $conn->query($sql);

if ($result->num_rows > 0) {
    $row = $result->fetch_assoc();

    echo "<table border='1' cellpadding='8' cellspacing='0'>";
    echo "
        <tr>
            <th>Total Semua Donasi</th>
            <th>Total Semua Pints</th>
            <th>Rata-rata Donasi</th>
            <th>Rata-rata Pints</th>
            <th>Max Donasi</th>
            <th>Max Pints</th>
        </tr>
        <tr>
            <td>{$row['total_semua_donasi']}</td>
            <td>{$row['total_semua_pints']}</td>
            <td>".number_format($row['rata2_donasi'], 2)."</td>
            <td>".number_format($row['rata2_pints'], 2)."</td>
            <td>{$row['max_donasi']}</td>
            <td>{$row['max_pints']}</td>
        </tr>
    ";
    echo "</table>";
} else {
    echo "Data statistik tidak tersedia.";
}
?>
