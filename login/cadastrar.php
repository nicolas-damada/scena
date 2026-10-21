<?php require_once __DIR__ . '/../database/conect.php';?>
<?php require_once __DIR__ . '/../includes/functions.php';?>
<?php
        if ($_SERVER['REQUEST_METHOD'] == "POST") {
            cadastrar_user($conexao, $_POST['nome'], $_POST['email'],$_POST['senha']);
            header("location: /scena/index.php");
            exit();
            
        }
        ?>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Cadastre-se</title>
    <link rel="stylesheet" href="../css/style.css">
</head>

<body>
    <?php include __DIR__ . '/../includes/header.php'; ?>
    <main>
        <h1>Cadastre-se</h1>
        <form action="" method="post">
            <label for="nome">Nome: </label>
            <input type="text" name="nome" id="nome" required><br>

            <label for="email">E-mail: </label>
            <input type="email" name="email" id="email" required><br>

            <label for="turma">Senha: </label>
            <input type="password" name="senha" id="senha" required><br>

            <!-- enviar e limpar -->
            <input type="submit" value="Cadastrar">
            <input type="reset" value="Limpar">

        </form>
        
    </main>
    <?php include __DIR__ . '/../includes/footer.php'; ?>
</body>

</html>