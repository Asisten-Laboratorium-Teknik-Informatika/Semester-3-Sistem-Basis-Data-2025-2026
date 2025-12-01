<!DOCTYPE html>
<html>
<head>
    <title>Donor Blood System</title>
    <link rel="stylesheet" href="style.css">
</head>
<body>

<div class="container">
    <h1>Blood Donor Dashboard</h1>
    
    <form method="GET">
        <label>Pilih Query:</label>
        <select name="query">
        <option value="">-- Pilih Jenis Analisis --</option>

        <?php
        $files = glob("queries/*.php");

        foreach ($files as $file) {
            $filename = basename($file);

            $content = file_get_contents($file);

            preg_match('/\$query_title\s*=\s*"(.*)"/', $content, $matches);

            $title = isset($matches[1]) ? $matches[1] : $filename;

            $selected = (isset($_GET['query']) && $_GET['query'] == $filename) ? "selected" : "";

            echo "<option value='$filename' $selected>$title</option>";
        }
        ?>
    </select>


        <button type="submit">Tampilkan</button>
    </form>

    <div class="result">
        <?php
        if (isset($_GET['query'])) {
    $query = $_GET['query'];

    $path = "queries/" . $query;

    if (file_exists($path)) {
        include $path;
    } else {
        echo "Query tidak ditemukan";
    }
}
        ?>
    </div>
</div>

</body>
</html>
