<?php require_once  __DIR__ . '/../includes/functions.php';
require_once __DIR__ . '/../login/verifica.php';
?>
<!DOCTYPE html>
<html lang="pt-br">

<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Scena</title>
    <link rel="icon" type="image/svg+xml" href="../images/favicon-16x16.png">
    <link rel="stylesheet" href="../css/style.css">
</head>

<body>
    <?php include __DIR__ . '/../includes/header.php' ?>
    <main>
        <h1>pesquise pelo titulo</h1>
        <form action="" method="post">
            <label for="pesquisa"></label>
            <input type="text" name="pesquisa" id="pesquisa">
        </form>
        <?php
        $shows = [];
        if ($_SERVER['REQUEST_METHOD'] === 'POST') {
            $termo    = $_POST['pesquisa'];
            // Busca os shows pelo título e reúne as bandas de cada show em um único resultado.
            $sql = "SELECT
            -- Seleciona os dados do show; s é o apelido da tabela shows.
            s.id,
            s.titulo,
            s.data_show,
            s.endereco,
            -- string_agg junta os nomes das bandas, separados por vírgula.
            -- COALESCE usa o texto abaixo quando a agregação retorna NULL (sem nomes de bandas).
            COALESCE(string_agg(sb.nome_banda, ', '), 'Sem banda cadastrada') AS bandas
        FROM shows s
        -- LEFT JOIN mantém o show no resultado mesmo quando ele não tem bandas cadastradas.
        -- sb é o apelido de shows_bandas; o vínculo entre as tabelas é o ID do show.
        LEFT JOIN shows_bandas sb
            ON s.id = sb.show_id
        -- ILIKE procura no título sem diferenciar maiúsculas de minúsculas.
        -- :termo é o parâmetro que receberá o texto pesquisado com os curingas %.
        WHERE s.titulo ILIKE :termo
        -- Agrupa as bandas por show, gerando uma linha para cada s.id.
        GROUP BY s.id
        -- Ordena pela data do show, da mais antiga para a mais recente.
        ORDER BY s.data_show ASC";
            // Prepara a consulta para enviar o valor pesquisado separado do código SQL.
            $stmt = $conexao->prepare($sql);
            // Os curingas % permitem encontrar o termo em qualquer posição do título.
            $termoBusca = "%$termo%";
            // Associa o valor da pesquisa ao parâmetro :termo da consulta.
            $stmt->bindParam(":termo", $termoBusca);
            // Executa a consulta e obtém os resultados em arrays com os nomes das colunas como chaves.
            $stmt->execute();
            $shows = $stmt->fetchAll(PDO::FETCH_ASSOC);
        }
        ?>



        <?php
        if ($_SERVER['REQUEST_METHOD'] === 'POST')://verifica se algo foi enviado via POST, caso sim, verifica se $shows NÂO está vazio, caso sim, executa o foreach
            if (!empty($shows)): ?>

                <?php foreach ($shows as $show): ?>
                    <p>
                        <strong><?php echo htmlspecialchars($show['titulo']); ?></strong>:
                        <?php echo htmlspecialchars($show['bandas']); ?>
                        em <?php echo htmlspecialchars($show['endereco']); ?>
                        (<?php echo date('d/m/Y', strtotime($show['data_show'])); ?>)
                    </p>
                <?php endforeach; ?>
            <?php else: ?>
                <p>Não há registro</p>
            <?php endif; ?>
        <?php endif;?>
    </main>
    <?php include __DIR__ . '/../includes/footer.php'; //inclui o footer ?>
</body>

</html>
