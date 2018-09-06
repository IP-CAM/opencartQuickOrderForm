<div class="box">
  <div class='qof_modal'>
      <div class='qof_modal_content success'>
          <div class='qof_content_header'>
            <div class='modal_title'>Спасибо за заказ!</div>
            <span class='modal_close'>&times;</span>
          </div>
          <div class='qof_content_body'><p>Наш менеджер свяжется с вами в ближайшее время.</p></div>
      </div>
  </div>
  <div class="box-heading">
    <?php echo $heading_title; ?>
  </div>
  <div class="box-content">
    <form class="qof" method="post">
        <div class="qof-product">
          <?php
            if (!empty(json_decode(str_replace('&quot;', '"', $settings_per_page), true)[$_SERVER['REQUEST_URI']])) {
              $page_settings = json_decode(str_replace('&quot;', '"', $settings_per_page), true)[$_SERVER['REQUEST_URI']];
              $inputs = '';
              foreach($page_settings as $key => $value) {
                $input = '';
                $info_type = "data-info-type='$key'";
                if(isset($value['input_options'])) {
                  $options_list = $value['input_options'];
                }
                switch ($value['input_type']) {
                  case 'textarea':
                  $input .= "<textarea class='qof-input' $info_type></textarea>";
                    break;
                  case 'number':
                  $input .= "<input class='qof-input' type='number' $info_type min='1'>";
                    break;
                  case 'radio':
                  $options = "";
                  for($i = 0; $i < count($options_list); $i++) {
                    if($i === 1) {
                      $options .=
                      "<label class='qof-label' checked='checked'>
                        <input class='qof-input' type='radio' name='qof-radio_$key' $info_type value='".$options_list[$i]."'>".
                        $options_list[$i].
                      "</label>";
                    } else {
                      $options .=
                      "<label class='qof-label'>
                        <input class='qof-input' type='radio' name='qof-radio_$key' $info_type value='".$options_list[$i]."'>".
                        $options_list[$i].
                      "</label>";
                    }
                  }
                  $input .=
                  "<div class='qof-options_wrap'>
                    $options
                  </div>";
                    break;
                  case 'checkbox':
                  $options = "";
                  for($i = 0; $i < count($options_list); $i++) {
                      $options .=
                      "<label class='qof-label'>
                        <input class='qof-input' type='checkbox' $info_type value='".$options_list[$i]."'>".
                        $options_list[$i].
                      "</label>";
                  }
                  $input .=
                  "<div class='qof-options_wrap'>
                    $options
                  </div>";
                    break;
                  case 'select':
                  $options= '<option value="">Выберите вариант</option>';
                  foreach($options_list as $option) {
                    $options .= "<option value='".$option."'>".$option."</option>";
                  }
                  $input .=
                  "<select class='qof-input' $info_type>
                    $options
                  </select>";
                    break;
                  default:
                    break;
                }
                $inputs .=
                "<div class='qof-input_wrap'>
                  <p class='qof-input_title'>$key</p>
                  $input
                </div>";
              }
              echo $inputs;
            }
          ?>
          <textarea name="qof-product_info"></textarea>
        </div>
        <div class="qof-input_wrap">
          <p class="qof-input_title">Количество (штук)</p>
          <input class="qof-input" name="qof-quant" type="number" min="1" value="1000">
        </div>
        <div class="qof-input_wrap">
          <p class="qof-input_title">Примечания к заказу</p>
          <textarea class="qof-input" name="qof-comment" rows="5"></textarea>
        </div>
        <div class="qof-input_wrap">
          <p class="qof-input_title">Ваше имя *</p>
          <input class="qof-input" name="qof-name" type="text" placeholder="Ваше имя (обязательно)" required>
        </div>
        <div class="qof-input_wrap">
          <p class="qof-input_title">Номер телефона *</p>
          <input class="qof-input" name="qof-tel" type="tel" placeholder="Ваш номер телефона (обязательно)" required>
        </div>
        <div class="qof-input_wrap">
          <p class="qof-input_title">Email</p>
          <input class="qof-input" name="qof-email" placeholder="Ваш email" type="email">
        </div>
        <input class="qof-submit qof-input" type="submit" value="Заказать">
        <label class='qof-label'>
          <input class="qof-input" checked name="qof-agr" type="checkbox">
          <span>Я согласен на <a href="/politika-konfidentsialnosti">обработку
          персональных данных</a><span>.
        </label>
    </form>
  </div>
</div>
<script>
  function qofPostData(e, url) {
    var msg = $($(e.target)[0].form).serialize();
    var h1val = $('h1').text();
    if(h1val) {
      msg += '&qof-product_name='+h1val;
    }
    $.ajax({
        type: 'POST',
        url: url,
        data: msg,
        success: function() {
            console.log("Заказ успешно оформлен.");
        },
        error: function(xhr, str) {
            console.log(xhr.responseCode);
            console.log(xhr.status);
            console.log(str);
        }
    }).always(function() {
        try {
            qofModalOpen();
            setTimeout(qofModalClose, 3000);
        } catch(e) {
            console.log("Ошибка в ответе сервера.");
        }
    });
  }
  function qofModalOpen() {
    $(".qof_modal").css("display","flex").hide().fadeIn();
    $('body').css('overflow', 'hidden');
  }
  function qofModalClose() {
      $(".qof_modal").fadeOut();
      $('body').css('overflow', 'auto');
  }
  $(function() {
    $('body').on("click", '.modal_close', function() {
        qofModalClose();
    });
    var productInfo = {};
    $('[name="qof-product_info"]').val(JSON.stringify(productInfo));

    $('body').on('change', '.qof-product .qof-input', function(e) {
      var infoType = $(e.currentTarget).data('infoType');
      var val = $(e.currentTarget).val();
      if(val) {
        productInfo[infoType] = val;
      } else {
        delete productInfo[infoType];
      }
      $('[name="qof-product_info"]').val(JSON.stringify(productInfo));
    });

    $('body').on('click', '.qof-submit', function(e) {e.preventDefault(); qofPostData(e, '/formScriptQOF.php')});
  });
</script>