<?php
    $name = $_POST['qof-name'];
    $tel = $_POST['qof-tel'];
    $email = $_POST['qof-email'];
    $comment = $_POST['qof-comment'];
    $product_name = $_POST['qof-product_name'];
    $product_info = json_decode($_POST['qof-product_info']);
    $quant = $_POST['qof-quant'];

    if($_POST['qof-agr'] && $name && $tel) {
        $to = "address@mail.ru";
        $message = "Имя: $name<br>";
        $message .= "Телефон: $tel<br>";
        $message .= "Заказ со страницы: <a href='".$_SERVER['HTTP_REFERER']."'>".$_SERVER['HTTP_REFERER']."</a><br>";
        $message .= "Товар (взят из заголовка страницы): $product_name<br>";
        if($email) {
            $message .= "Email: $email<br>";
        }
        if($product_info === "{}") {
            $message .= "Данные о товаре не указаны.<br>";
        } else {
            $message .= "Информация о товаре:<br>";
            $message .= "<ul>";
            foreach($product_info as $key => $value) {
                $message .= "<li>$key: $value</li>";
            }
            $message .= "</ul>";
        }
        $message .= "Количество: $quant<br>";
        $message .= "Комментарий: ".($comment ? $comment : "Без комментария")."<br>";
        $headers = "Content-type: text/html; charset=\"utf-8\"\r\n";
        $headers .= "From: <QOF@noreply.com>\r\n";

        mail($to, $subject, $message, $headers);
        echo json_encode(array("header" => "Спасибо за заказ!", "body" => "Наш менеджер свяжется с вами в ближайшее время."));
    }
?>