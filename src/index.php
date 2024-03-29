<?php  session_start();
require_once("Controller/category.php");
require_once("Controller/language.php");
?>
<!DOCTYPE html>

<html lang="fr">

<head>
    <meta charset="utf-8">
    <title>Terminologio</title>
    <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"
        integrity="sha384-T3c6CoIi6uLrA9TneNEoa7RxnatzjcDSCmG1MXxSR1GAsXEV/Dwwykc2MPK8M2HN" crossorigin="anonymous">
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/bootstrap-icons@1.11.2/font/bootstrap-icons.min.css">
    <link rel="stylesheet" href="css/index.css">
    <script src="https://cdn.jsdelivr.net/npm/@popperjs/core@2.11.8/dist/umd/popper.min.js"
        integrity="sha384-I7E8VVD/ismYTF4hNIPjVp/Zjvgyol6VFvRkX/vR+Vc4jQkC+hVqc2pM8ODewa9r"
        crossorigin="anonymous"></script>
    <script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.min.js"
        integrity="sha384-BBtl+eGJRgqQAUMxJ7pMwbEyER4l1g+O15P+16Ep7Q9Q+zqX6gSbd85u4mG4QzX+"
        crossorigin="anonymous"></script>
    <script src="js/ajax.js"></script>
    <script src="js/script.js"></script>
    <script src="js/printLanguagesFromProject.js"></script>
    <script src="js/print.js"></script>
    <script src="js/projects.js"></script>
    <script src="js/caption.js" defer></script>

</head>

<body>
    <?php include_once("navbar.php") ?>
    <div class="container-fluid">
        <div class="row justify-content-md-center">
            <div class="col-md-auto">
                <div class="input-group">
                    <label for="category-selection" class="input-group-text">Sélection de la catégorie</label>
                    <select class="form-select" id="category-selection" onchange="updateProjectSelection();">
                        <?php echo printCategories(true); ?>
                    </select>
                </div>
            </div>
            <div class="col-md-auto">
                <div class="input-group col-auto d-none" id="project-selection-container">
                    <label for="project-selection" class="input-group-text">Sélection du projet</label>
                    <select class="form-select" id="project-selection">
                    <script>
                        var editable = '<?php echo isset($_SESSION["username"]) - isset($_SESSION["is_admin"]);?>';
                        document.getElementById("project-selection").onchange = function() {
                            updateLanguageSelection(editable);
                        }
                    </script>
                    </select>
                </div>
            </div>
            <div class="col-md-auto">
                <div class="input-group col-auto d-none" id="language-selection-container">
                    <label for="language-selection" class="input-group-text">Sélection de langue</label>
                    <select class="form-select" id="language-selection">
                    </select>
                    <script>
                        document.getElementById("language-selection").onchange = function () {
                            printCaptionText(editable);
                        }
                    </script>
                </div>
            </div>
            <div class="col-md-auto">
                <div class="d-none" id="create-project-container">
                    <div class="offcanvas offcanvas-end" data-bs-scroll="true" data-bs-backdrop="true" 
                    tabindex="-1" id="offcanvasScrolling" aria-labelledby="offcanvasScrollingLabel">
                        <div class="offcanvas-header">
                            <h1 class="offcanvas-title" id="offcanvasScrollingLabel">Importation d'une image</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close"></button>
                        </div>
                        <div class="offcanvas-body">
                            <form method="POST" action="Controller/upload.php" enctype="multipart/form-data">
                                <div class="form-group mb-3">
                                    <label for="title">Titre de l'image : </label>
                                    <input type="text" class="form-control" name="title" id="title" placeholder="Titre" required>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="select-language">Langue par défaut : </label>
                                    <select name="select-language" id="select-language" class="form-select">
                                    <?php echo printLanguages(); ?>
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="category-selection">Catégorie : </label>
                                    <select name="category-selection" id="select-category" class="form-select">
                                    <?php echo printCategories(false); ?>
                                    </select>
                                </div>
                                <div class="form-group mb-3">
                                    <label for="pic" class="form-label">Choisissez une image:</label>
                                    <input class="form-control" type="file" id="pic" name="pic" accept="image/png, image/jpeg">
                                </div>
                                <button class="btn btn-primary" type="submit">Importer</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
            <div class="col-md-auto">
                <div class="d-none" id="create-caption-container">
                    <?php if(isset($_SESSION["username"]) && !isset($_SESSION["is_admin"])) { ?>
                    <input type="button" value="Ajouter une terminologie" class="form-control" id="triggerCap"
                    data-bs-toggle="offcanvas" data-bs-target="#offcanvasScrollingCaption" aria-controls="offcanvasScrolling" hidden>
                    <?php } ?>
                    <div class="offcanvas offcanvas-bottom" data-bs-scroll="true" data-bs-backdrop="false"
                    tabindex="-1" aria-labelledby="offcanvasScrollingLabelCaption" id="offcanvasScrollingCaption">
                        <div class="offcanvas-header">
                            <h1 class="offcanvas-title" id="offcanvasScrollingLabelCaption">Ajout d'une terminologie</h1>
                            <button type="button" class="btn-close" data-bs-dismiss="offcanvas" aria-label="Close" id="closeCap"></button>
                        </div>
                        <div class="offcanvas-body">
                            <form method="POST">
                                <div class="form-group mb-3">
                                    <label for="title">Description du composant : </label>
                                    <input type="text" class="form-control" name="title" id="descCap" required>
                                </div>
                                <button class="btn btn-primary" type="button" id="submitCap">Ajouter</button>
                            </form>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <br>
    <br>

    <div id = "show-img" class="text-center"></div> 
    <br>
    <br>
    <div class = "d-none wrap" id="terminologie">
        <fieldset class="border p-2" id="captions">
            <legend  class="w-auto">Terminologies</legend>
        </fieldset>
    </div>
</body>

</html>