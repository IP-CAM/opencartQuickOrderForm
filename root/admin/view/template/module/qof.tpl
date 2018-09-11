<?php echo $header; ?>
<div id="content">
  <div class="breadcrumb">
    <?php foreach ($breadcrumbs as $breadcrumb) { ?>
    <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
    <?php } ?>
  </div>
  <?php if ($error_warning) { ?>
  <div class="warning"><?php echo $error_warning; ?></div>
  <?php } ?>
  <div class="box">
    <div class="heading">
      <h1><img src="view/image/module.png" alt="" /> <?php echo $heading_title; ?></h1>
      <div class="buttons"><a onclick="$('#form').submit();" class="button"><?php echo $button_save; ?></a><a onclick="location = '<?php echo $cancel; ?>';" class="button"><?php echo $button_cancel; ?></a></div>
    </div>
    <div class="content">
      <form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form">
        <table id="module" class="list">
          <thead>
            <tr>
              <td class="left"><?php echo $entry_layout; ?></td>
              <td class="left"><?php echo $entry_settings_per_page; ?></td>
              <td class="left"><?php echo $entry_position; ?></td>
              <td class="left"><?php echo $entry_status; ?></td>
              <td class="right"><?php echo $entry_sort_order; ?></td>
              <td></td>
            </tr>
          </thead>
          <?php $module_row = 0; ?>
          <?php foreach ($modules as $module) { ?>
          <tbody id="module-row<?php echo $module_row; ?>">
            <tr>
              <td class="left"><select name="qof_module[<?php echo $module_row; ?>][layout_id]">
                  <?php foreach ($layouts as $layout) { ?>
                  <?php if ($layout['layout_id'] == $module['layout_id']) { ?>
                  <option value="<?php echo $layout['layout_id']; ?>" selected="selected"><?php echo $layout['name']; ?></option>
                  <?php } else { ?>
                  <option value="<?php echo $layout['layout_id']; ?>"><?php echo $layout['name']; ?></option>
                  <?php } ?>
                  <?php } ?>
                </select></td>
                <td class="left" data-row="<?php echo $module_row; ?>">
                    <div class="settings_panel"></div>
                    <textarea class="json_field" name="qof_module[<?php echo $module_row; ?>][settings_per_page]"><?php if($module['settings_per_page']) { echo str_replace('&quot;', '"', $module['settings_per_page']); } ?></textarea>
                    <div class="add_item-wrap" data-item-type="settings_block">
                        <textarea data-input-type="settings_block" placeholder="Введите ссылку на страницу"></textarea>
                        <a class="button add_item settings_block">Добавить настройки</a>
                    </div>
                </td>
              <td class="left"><select name="qof_module[<?php echo $module_row; ?>][position]">
                  <?php if ($module['position'] == 'content_top') { ?>
                  <option value="content_top" selected="selected"><?php echo $text_content_top; ?></option>
                  <?php } else { ?>
                  <option value="content_top"><?php echo $text_content_top; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'content_bottom') { ?>
                  <option value="content_bottom" selected="selected"><?php echo $text_content_bottom; ?></option>
                  <?php } else { ?>
                  <option value="content_bottom"><?php echo $text_content_bottom; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_left') { ?>
                  <option value="column_left" selected="selected"><?php echo $text_column_left; ?></option>
                  <?php } else { ?>
                  <option value="column_left"><?php echo $text_column_left; ?></option>
                  <?php } ?>
                  <?php if ($module['position'] == 'column_right') { ?>
                  <option value="column_right" selected="selected"><?php echo $text_column_right; ?></option>
                  <?php } else { ?>
                  <option value="column_right"><?php echo $text_column_right; ?></option>
                  <?php } ?>
                </select></td>
              <td class="left"><select name="qof_module[<?php echo $module_row; ?>][status]">
                  <?php if ($module['status']) { ?>
                  <option value="1" selected="selected"><?php echo $text_enabled; ?></option>
                  <option value="0"><?php echo $text_disabled; ?></option>
                  <?php } else { ?>
                  <option value="1"><?php echo $text_enabled; ?></option>
                  <option value="0" selected="selected"><?php echo $text_disabled; ?></option>
                  <?php } ?>
                </select></td>
              <td class="right"><input type="text" name="qof_module[<?php echo $module_row; ?>][sort_order]" value="<?php echo $module['sort_order']; ?>" size="3" /></td>
              <td class="left"><a onclick="$('#module-row<?php echo $module_row; ?>').remove();" class="button"><?php echo $button_remove; ?></a></td>
            </tr>
          </tbody>
          <?php $module_row++; ?>
          <?php } ?>
          <tfoot>
            <tr>
              <td colspan="4"></td>
              <td class="left"><a onclick="addModule();" class="button"><?php echo $button_add_module; ?></a></td>
            </tr>
          </tfoot>
        </table>
      </form>
    </div>
  </div>
</div>
<script type="text/javascript">
var module_row = <?php echo $module_row; ?>;

function addModule() {	
    html  = '<tbody id="module-row' + module_row + '">';
    html += '  <tr>';
    html += '    <td class="left"><select name="qof_module[' + module_row + '][layout_id]">';
    <?php foreach ($layouts as $layout) { ?>
    html += '      <option value="<?php echo $layout['layout_id']; ?>"><?php echo addslashes($layout['name']); ?></option>';
    <?php } ?>
    html += '    </select></td>';
    html += '    <td class="left" data-row="' + module_row + '">';
    html += '      <div class="settings_panel"></div>';
    html += '      <textarea class="json_field" name="qof_module[' + module_row + '][settings_per_page]"></textarea>';
    html += '      <div class="add_item-wrap" data-item-type="settings_block">';
    html += '        <textarea data-input-type="settings_block" placeholder="Введите ссылку на страницу"></textarea>';
    html += '        <a class="button add_item">Добавить настройки</a>';
    html += '      </div>';
    html += '    </td>';
    html += '    <td class="left"><select name="qof_module[' + module_row + '][position]">';
    html += '      <option value="content_top"><?php echo $text_content_top; ?></option>';
    html += '      <option value="content_bottom"><?php echo $text_content_bottom; ?></option>';
    html += '      <option value="column_left"><?php echo $text_column_left; ?></option>';
    html += '      <option value="column_right"><?php echo $text_column_right; ?></option>';
    html += '    </select></td>';
    html += '    <td class="left"><select name="qof_module[' + module_row + '][status]">';
    html += '      <option value="1" selected="selected"><?php echo $text_enabled; ?></option>';
    html += '      <option value="0"><?php echo $text_disabled; ?></option>';
    html += '    </select></td>';
    html += '    <td class="right"><input type="text" name="qof_module[' + module_row + '][sort_order]" value="" size="3" /></td>';
    html += '    <td class="left"><a onclick="$(\'#module-row' + module_row + '\').remove();" class="button"><?php echo $button_remove; ?></a></td>';
    html += '  </tr>';
    html += '</tbody>';

    $('#module tfoot').before(html);

    module_row++;
}

$(function() {
    var qofInputTypesArray = [
        "textarea", "number", "radio", "select", "checkbox"
    ];

    var qofSettingBlocks = [];

    $('.json_field').each(function(i) {
        var val = $(this).val();
        try {
            val = JSON.parse(val);
        } catch (error) {
            val = {};
            console.log(`Парсинг json не удался. Элементу с индексом ${i} присвоен пустой объект.`);
            console.log(error);
        }
        qofSettingBlocks.push(val);
    });

    function createFieldSettingsBlock(fieldName, fieldSettings) {
        var inputTypes = '';
        if(fieldSettings.input_type) {
            for(var inputType in qofInputTypesArray) {
                if (fieldSettings.input_type === qofInputTypesArray[inputType]) {
                    inputTypes += `<option value=${qofInputTypesArray[inputType]} selected="selected">${qofInputTypesArray[inputType]}</option>`;
                } else {
                    inputTypes += `<option value=${qofInputTypesArray[inputType]}>${qofInputTypesArray[inputType]}</option>`;
                }
            }
        }
        var inputOptions = "";
        if(fieldSettings.input_options && fieldSettings.input_options.length) {
            for(var fieldOption of fieldSettings.input_options) {
                inputOptions += fieldOption+"\n";
            }
        }
        return `
        <div class="item_block field_set_block">
            <div class="remove_item">&times;</div>
            <p class="input_name">${fieldName}</p>
            <select class="input_setting input_type">
                ${inputTypes}
            </select>
            ${fieldSettings.input_options ? `<textarea class="input_setting input_options" rows="5">${inputOptions}</textarea>` : ""}
        </div>`;
    }

    function createPageSettingsBlock(pageLink, blockData) {
        var fieldSettingsBlocks = '';
        if(blockData && Object.keys(blockData).length) {
            for(var key in blockData) {
                fieldSettingsBlocks += createFieldSettingsBlock(key, blockData[key]);
            }
        }
        return `
        <div class="item_block settings_block">
            <div class="remove_item">&times;</div>
            <p class="settings_page_link">${pageLink}</p>
            <div class="field_set">
                ${fieldSettingsBlocks}
            </div>
            <div class="add_item-wrap" data-item-type="field_block">
                <textarea data-input-type="field_block" placeholder="Введите название поля"></textarea>
                <a class="button add_item">Добавить поле</a>
            </div>
        </div>`;
    }

    function renderSettingsPanel(el) {
        var cell = $($(el).parents('td')[0]);
        var rowSettings = qofSettingBlocks[cell.data('row')];
        var jsonField = cell.find('.json_field');
        var settingsPanel = cell.find('.settings_panel');
        var settingsBlocks = '';
        if(rowSettings && Object.keys(rowSettings).length) {
            for(var key in rowSettings) {
                settingsBlocks += createPageSettingsBlock(key, rowSettings[key]);
            };
        }
        settingsPanel.html('').prepend(settingsBlocks);
        jsonField.val(JSON.stringify(rowSettings));
    }

    $(".add_item.settings_block").each(function() {
        renderSettingsPanel(this);
    });

    $('body').on('click', '.add_item', function(e) {
        var row = $($(e.currentTarget).parents('td')[0]).data('row');
        if(!qofSettingBlocks[row]) {
            qofSettingBlocks[row] = {};
        }
        var rowSettings = qofSettingBlocks[row];
        var current_wrap = $(e.currentTarget).parents(".add_item-wrap")[0];
        var new_item_name = $(current_wrap).children('textarea').val();
        if(new_item_name) {
            var item_type = $(current_wrap).data('itemType');
            if(item_type === "settings_block") {
                if(rowSettings.hasOwnProperty(new_item_name)) {
                    alert('Для этой страницы уже заданы настройки.');
                } else {
                    rowSettings[new_item_name] = {
                    };
                };
            } else if (item_type === "field_block") {
                var new_item_parent_settings_block_name = $(current_wrap).parents(".settings_block").find(".settings_page_link").text();
                if(rowSettings[new_item_parent_settings_block_name].hasOwnProperty(new_item_name)) {
                    alert('Для этой страницы уже создано поле с таким названием.');
                } else {
                    rowSettings[new_item_parent_settings_block_name][new_item_name] = {
                        'input_type': 'text'
                    };
                };
            }
            renderSettingsPanel(e.currentTarget);
        } else {
            alert('Введите название создаваемого объекта настроек!');
        }
    });
    $('body').on('keydown', '.add_item-wrap > textarea', function(e) {
        if(e.keyCode === 13) {
            e.preventDefault();
            $($(e.currentTarget).parents(".add_item-wrap")[0]).find('a.add_item').trigger('click');
        }
    })
    $('body').on('click', '.remove_item', function(e) {
        var row = $($(e.currentTarget).parents('td')[0]).data('row');
        var rowSettings = qofSettingBlocks[row];
        var target_item = $(e.currentTarget).parents(".item_block")[0];
        var settingsBlock = $(e.currentTarget).parents(".settings_block").find(".settings_page_link").text();
        if($(target_item).hasClass('settings_block')) {
            delete rowSettings[settingsBlock];
        } else if ($(target_item).hasClass('field_set_block')) {
            var fieldName = $(target_item).find(".input_name").text();
            delete rowSettings[settingsBlock][fieldName];
        }
        renderSettingsPanel(e.currentTarget);
    });
    $('body').on('change', '.field_set_block .input_setting', function(e) {
        var row = $($(e.currentTarget).parents('td')[0]).data('row');
        var rowSettings = qofSettingBlocks[row];
        var fieldSetBlock = $(e.currentTarget).parents(".field_set_block");
        var fieldName = fieldSetBlock.find(".input_name").text();
        var settingsBlock = $(e.currentTarget).parents(".settings_block").find(".settings_page_link").text();
        var val = $(e.currentTarget).val();
        if($(e.currentTarget).hasClass('input_type')) {
            if(val === 'checkbox' || val === 'select' || val === 'radio') {
                if(fieldSetBlock.find('textarea.input_options')[0] == undefined) {
                    fieldSetBlock.append('<textarea class="input_setting input_options" rows="5"></textarea>');
                }
                rowSettings[settingsBlock][fieldName] = {
                    'input_type': val,
                    'input_options': {}
                }
            } else {
                if(fieldSetBlock.find('textarea.input_options')[0] !== undefined) {
                    $(fieldSetBlock.find('textarea.input_options')[0]).remove();
                }
                rowSettings[settingsBlock][fieldName] = {
                    'input_type': val
                }
            }
        } else {
            val = val.replace(/("|\\)/g, "\\$1");
            val = '["'+val.replace(/\n/g, "\",\"")+'"]';
            rowSettings[settingsBlock][fieldName].input_options = JSON.parse(val);
        }
        renderSettingsPanel(e.currentTarget);
    });

});
</script> 
<?php echo $footer; ?>