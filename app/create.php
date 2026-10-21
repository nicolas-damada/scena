<?php require_once __DIR__ . '/../includes/functions.php'; //requere o funtions e o verificador de sessao
require_once __DIR__ . '/../login/verifica.php';
?>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>scena - Cadastrar show</title>
    <link rel="icon" type="image/svg+xml" href="scena/images/favicon-16x16.png">
    <link rel="stylesheet" href="../css/style.css">
</head>

<body>

    <?php include __DIR__ . '/../includes/header.php'; //inclui o header 
    ?>
    <main>
        <h1>Cadastro de Show: </h1>
        <form action="" method="post">
            <label for="titulo">Titulo: </label>
            <input type="text" name="titulo" id="titulo" required><br>
            <label for="banda">Banda: </label>
            <input type="text" name="banda" id="banda" required><br>
            <label for="data">Data: </label>
            <input type="date"
                name="data"
                min="<?= date('Y-m-d') ?>"
                required><br>
            <label for="local">Local: </label>
            <input type="text" name="local" id="local" required><br>
            <input type="submit" value="Postar">
        </form>
        <?php

        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $titulo    = $_POST['titulo'];
            $bandas = explode(',', $_POST['banda']);
            $data_show = $_POST['data'];
            $endereco  = $_POST['local'];
            $sql = "INSERT INTO shows (titulo, data_show, endereco) VALUES(:titulo, :data_show, :endereco) RETURNING id";

            try {        //a variavel conexão é do arquivo "conect.php"
                $stmt = $conexao->prepare($sql); //"->" chama um metodo
                $stmt->bindParam(":titulo", $titulo); //bindvalues troca a informação
                $stmt->bindParam(":data_show", $data_show);
                $stmt->bindParam(":endereco", $endereco);

                $stmt->execute();
                // Pegar o ID do show cadastrado
                $show_id = $stmt->fetchColumn();

                // SQL para cadastrar as bandas
                $sql_bandas = "INSERT INTO shows_bandas
               (show_id, nome_banda)
               VALUES (:show_id, :nome_banda)";

                $stmt_bandas = $conexao->prepare($sql_bandas);

                // Cadastrar cada banda
                foreach (array_unique(array_filter(array_map('trim', $bandas))) as $banda) {

                    $stmt_bandas->execute([
                        ':show_id' => $show_id,
                        ':nome_banda' => $banda
                    ]);
                }
                echo "show inserido com sucesso";
            } catch (PDOException $e) {
                echo "erro:" . $e->getMessage();
            }
        }
        ?>
    </main>
    <?php include  __DIR__ . '/../includes/footer.php'; ?>
</body>

</html>