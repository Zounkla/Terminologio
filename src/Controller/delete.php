<?php

require_once("../Model/Category.php");

require_once("../Model/Picture.php");

$category = new Category($_GET["cat"]);
$pic = new Picture($_GET["title"], "fr", $category);
$list = $pic -> getProjectsFromTitleAndCategory($pic -> getTitle(), $category -> getName());
$result = "";
if (count($list) != 0) {
    $img = $list[0]["title"];
    $path = "../res/" . $category->getName() . "/" . $img;
    $pic->removePicture($_GET["title"], $_GET["cat"]);
    unlink($path);
}
echo null;