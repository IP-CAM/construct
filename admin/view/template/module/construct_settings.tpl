<?php echo $header; ?>
<div id="content">
<div class="breadcrumb">
  <?php foreach ($breadcrumbs as $breadcrumb) { ?>
  <?php echo $breadcrumb['separator']; ?><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a>
  <?php } ?>
</div>
<div class="box">
  <div class="heading">
    <h1><?php echo $heading_title; ?></h1>
    <a href="<?php echo $link_list; ?>" class="link-list"><?php echo $order_list; ?></a>
  </div>
  <div class="content">
    <h2><?php echo $text_main_module; ?></h2>
    <div class="module-settings">
      <form action="index.php?route=module/construct/saveModuleSettings&token=<?php echo $token; ?>" method="post" class="module-settings__box">
        <a class="btn save"><?php echo $button_save_settings_module; ?></a>
        <div class="box__group">
          <label for="big-imahe-size"><?php echo $text_big_image_size; ?></label>
          <input type="text" name="big_image_size" placeholder="360X480" id="big-imahe-size" value="<?php echo $big_image_size; ?>">
        </div>
        <div class="box__group">
          <label for="mini-imahe-size"><?php echo $text_mini_image_size; ?></label>
          <input type="text" name="mini_image_size" placeholder="50X50" id="mini-imahe-size" value="<?php echo $mini_image_size; ?>">
        </div>
        <div class="box__group">
          <label for="link"><?php echo $text_link; ?></label>
          <input type="text" name="link" placeholder="konstruktor-besedok" id="link" value="<?php echo $link; ?>">
        </div>
      </form>
    </div>
    <h2><?php echo $text_main; ?></h2>
    <div class="main-settings">
      <div class="main-settings__box">
        <div class="box__group" data-group-name="tree">
          <label><?php echo $text_tree; ?></label>
          <div class="box__group__items">
            <?php foreach($trees as $key => $tree){?>
              <div class="box__group__item" data-item-id="<?php echo $tree['id']; ?>">
                <input type="radio" name="selected_tree" <?php if($tree['selected']){ ?>checked="checked"<?php } ?> title="<?php echo $info_selected; ?>">
                <input type="number" name="sequence" value="<?php echo $tree['sequence']; ?>" title="<?php echo $info_sequence; ?>" class="sequence">
                <input type="text" name="name" value="<?php echo $tree['name']; ?>">
                <button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="<?php echo $tree['id']; ?>"><?php echo $button_remove; ?></button>
              </div>
            <?php } ?>
          </div>
          <div class="box__group__item form_group">
            <input type="text" name="name">
            <button class="add-item btn" title="<?php echo $info_add; ?>"><?php echo $button_add; ?></button>
          </div>
        </div>

        <div class="box__group" data-group-name="type_section">
          <label><?php echo $text_type_section; ?></label>
          <div class="box__group__items">
            <?php foreach($types_section as $key => $type){?>
              <div class="box__group__item" data-item-id="<?php echo $type['id']; ?>">
                <input type="radio" name="selected_type_section" <?php if($type['selected']){ ?>checked="checked"<?php } ?> title="<?php echo $info_selected; ?>">
                <input type="number" name="sequence" value="<?php echo $type['sequence']; ?>" title="<?php echo $info_sequence; ?>" class="sequence">
                <input type="text" name="name" value="<?php echo $type['name']; ?>">
                <button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="<?php echo $type['id']; ?>"><?php echo $button_remove; ?></button>
              </div>
            <?php } ?>
          </div>
          <div class="box__group__item form_group">
            <input type="text" name="name">
            <button class="add-item btn" title="<?php echo $info_add; ?>"><?php echo $button_add; ?></button>
          </div>
        </div>

        <div class="box__group" data-group-name="type_alcove">
          <label><?php echo $text_type_alcove; ?></label>
          <div class="box__group__items">
            <?php foreach($types_alcove as $key => $type){?>
              <div class="box__group__item" data-item-id="<?php echo $type['id']; ?>">
                <input type="radio" name="selected_type_alcove" <?php if($type['selected']){ ?>checked="checked"<?php } ?> title="<?php echo $info_selected; ?>">
                <input type="number" name="sequence" value="<?php echo $type['sequence']; ?>" title="<?php echo $info_sequence; ?>" class="sequence">
                <div class="image" title="<?php echo $info_big_image; ?>">
                  <a onclick="image_upload('imageBig<?php echo $type['id']; ?>', 'thumbBig<?php echo $type['id']; ?>');"><img src="<?php echo empty($type['big_image'])?$no_image:$type['big_image']; ?>" alt="" id="thumbBig<?php echo $type['id']; ?>" /></a>
                  <input type="hidden" name="big_image" value="<?php echo empty($type['big_image_path'])?'':$type['big_image']; ?>" id="imageBig<?php echo $type['id']; ?>">
                </div>
                <div class="image" title="<?php echo $info_mini_image; ?>">
                  <a onclick="image_upload('image<?php echo $type['id']; ?>', 'thumb<?php echo $type['id']; ?>');"><img src="<?php echo empty($type['image'])?$no_image:$type['image']; ?>" alt="" id="thumb<?php echo $type['id']; ?>" /></a>
                  <input type="hidden" name="image" value="<?php echo empty($type['image_path'])?'':$type['image']; ?>" id="image<?php echo $type['id']; ?>"  />
                </div>

                <input type="text" name="name" value="<?php echo $type['name']; ?>">
                <input type="text" name="count_section" value="<?php echo $type['count_section']; ?>" class="count-row">
                <button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="<?php echo $type['id']; ?>"><?php echo $button_remove; ?></button>
              </div>
            <?php } ?>
          </div>
          <div class="box__group__item form_group">
            <div class="image" title="<?php echo $info_big_image; ?>">
              <a onclick="image_upload('imageBigNew', 'thumbBigNew');"><img src="<?php echo $no_image; ?>" alt="" id="thumbBigNew" /></a>
              <input type="hidden" value="" id="imageBigNew" name="big_image">
            </div>
            <div class="image" title="<?php echo $info_mini_image; ?>">
              <a onclick="image_upload('imageNew', 'thumbNew');"><img src="<?php echo $no_image; ?>" alt="" id="thumbNew" /></a>
              <input type="hidden" value="" id="imageNew" name="image">
            </div>

            <input type="text" name="name" value="">
            <input type="text" name="count_section" title="<?php echo $info_count_section; ?>" value="" class="count-row">
            <button class="add-item btn" title="<?php echo $info_add; ?>"><?php echo $button_add; ?></button>
          </div>
        </div>

        <div class="box__group" data-group-name="box">
          <label><?php echo $text_box; ?></label>
          <div class="box__group__items">
            <?php foreach($boxes as $key => $box){?>
              <div class="box__group__item" data-item-id="<?php echo $box['id']; ?>">
                <input type="radio" name="selected_box_<?php echo $box['type']; ?>" <?php if($box['selected']){ ?>checked="checked"<?php } ?> title="<?php echo $info_selected; ?>">
                <input type="number" name="sequence" value="<?php echo $box['sequence']; ?>" title="<?php echo $info_sequence; ?>" class="sequence">
                <div class="image" title="<?php echo $info_mini_image; ?>" data-size="100x100">
                  <a onclick="image_upload('box_image<?php echo $box['id']; ?>', 'box_thumb<?php echo $box['id']; ?>');"><img src="<?php echo empty($box['image'])?$no_image:$box['image']; ?>" alt="" id="box_thumb<?php echo $box['id']; ?>" /></a>
                  <input type="hidden" name="image" value="<?php echo empty($box['image_path'])?'':$box['image_path']; ?>" id="box_image<?php echo $box['id']; ?>"  />
                </div>

                <input type="text" name="name" value="<?php echo $box['name']; ?>">
                <p class="item-text text-box-type"><?php echo ${'text_'.$box['type'].'_box'}?></p>
                <button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="<?php echo $box['id']; ?>"><?php echo $button_remove; ?></button>
              </div>
            <?php } ?>
          </div>
          <div class="box__group__item form_group">
            <div class="image" title="<?php echo $info_mini_image; ?>">
              <a onclick="image_upload('imageNew1', 'thumbNew1');"><img src="<?php echo $no_image; ?>" alt="" id="thumbNew1" /></a>
              <input type="hidden" value="" id="imageNew1" name="image">
            </div>

            <input type="text" name="name" value="">
            <select name="type">
              <option value="top" selected="selected"><?php echo $text_top_box; ?></option>
              <option value="bottom"><?php echo $text_bottom_box; ?></option>
            </select>
            <button class="add-item btn" title="<?php echo $info_add; ?>"><?php echo $button_add; ?></button>
          </div>
        </div>

        <div class="box__group" data-group-name="option">
          <label><?php echo $text_option; ?></label>
          <div class="box__group__items">
            <?php foreach($options as $key => $option){?>
              <div class="box__group__item" data-item-id="<?php echo $option['id']; ?>">
                <input type="number" name="sequence" value="<?php echo $option['sequence']; ?>" title="<?php echo $info_sequence; ?>" class="sequence">
                <input type="text" name="name" value="<?php echo $option['name']; ?>">
                <p class="item-text text-type" title="<?php echo $info_option_type; ?>"><?php echo ${"text_option_".$option['type']}; ?></p>
                <p class="item-text text-depends" title="<?php echo $info_option_depends; ?>"><?php echo ${"text_option_".$option['depends']}; ?></p>
                <button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="<?php echo $option['id']; ?>"><?php echo $button_remove; ?></button>
              </div>
            <?php } ?>
          </div>
          <div class="box__group__item form_group option-form">
            <input type="text" name="name">
            <select name="type" title="<?php echo $info_option_type; ?>">
              <option value="radio" selected="selected"><?php echo $text_option_radio; ?></option>
              <option value="checkbox"><?php echo $text_option_checkbox; ?></option>
            </select>
            <select name="depends" title="<?php echo $info_option_depends; ?>">
              <option value="tree" selected="selected"><?php echo $text_option_tree; ?></option>
              <option value="type_alcove"><?php echo $text_option_type_alcove; ?></option>
              <option value="type_section"><?php echo $text_option_type_section; ?></option>
            </select>
            <button class="add-item btn" title="<?php echo $info_add; ?>"><?php echo $button_add; ?></button>
          </div>
        </div>

      </div>
    </div>
    <div class="second-settings">
      <div class="second-settings_refresh">
        <button class="refresh refresh-button btn"><?php echo $button_refresh; ?></button>
      </div>
      <div class="second-settings__wrap"></div>
    </div>
  </div>
</div>
</div>
<div class="big-image-preview">
  <img src="" class="big-image-preview_image">
</div>
<script><!--

var secondScript = function(){
  $('.htabs a').tabs();
  $('.vtabs_price a').tabs();
  $('.vtabs_images a').tabs();
}

$('.second-settings__wrap').load('index.php?route=module/construct/getSecondSettings&token=<?php echo $token; ?>', function(response, status){
  if(status == "success"){
    secondScript();
  }
});
// ---- Загрузка изображений ----
function image_upload(field, thumb) {
	$('#dialog').remove();

	$('#content').prepend('<div id="dialog" style="padding: 3px 0px 0px 0px;"><iframe src="index.php?route=common/filemanager&token=<?php echo $token; ?>&field=' + encodeURIComponent(field) + '" style="padding:0; margin: 0; display: block; width: 100%; height: 100%;" frameborder="no" scrolling="auto"></iframe></div>');

	$('#dialog').dialog({
		title: '<?php echo $text_image_manager; ?>',
		close: function (event, ui) {
			if ($('#' + field).attr('value')) {
				$.ajax({
					url: 'index.php?route=common/filemanager/imagesizer&token=<?php echo $token; ?>&image=' + encodeURIComponent($('#' + field).attr('value')),
					dataType: 'text',
					success: function(data) {
            if(data){
              if(!$('#' + thumb).parent().parent().parent().hasClass('form_group') && !$('#' + thumb).parent().parent().parent().parent().parent().parent().hasClass('images')){
                updateRow('#' + thumb, $('#' + field).attr('value'));
                $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
              }else{
                $('#' + thumb).replaceWith('<img src="' + data + '" alt="" id="' + thumb + '" />');
              }
            }else {
              $('#' + thumb).replaceWith('<img src="' + $('#' + field).attr('value') + '" alt="" id="' + thumb + '" />');
            }
					}
				});
			}
		},
		bgiframe: false,
		width: 700,
		height: 400,
		resizable: false,
		modal: false
	});
};

// ---- Генерация второго шага ----
$(document).on('click', '.refresh', function(){
  $('.second-settings__wrap').load('index.php?route=module/construct/getSecondSettings&token=<?php echo $token; ?>', function(response, status, xhr){
    if(status == "success"){
      secondScript();
      $('.second-settings').removeClass('refresh-settings-wrap');
    }else{
      alert("Error load second settings!");
    }
  });
});

// ---- Изменение главных настроек ----
// ---- ---- Добавление поля
$(document).on('click', '.main-settings__box .add-item', function(){
  $('.second-settings_refresh').parent().addClass('refresh-settings-wrap');
  var dataGroup = $(this).parent().parent(),
      group = dataGroup.attr('data-group-name'),
      trigger = true, data = '';

  $(this).parent().find('input, select').each(function(i, input){
    data += $(input).attr('name') + '=' + input.value + '&';
    if(!input.value.length && $(input).attr('type') != 'hidden'){
      input.focus();
      trigger = false;
    }
  });

  if(!trigger){
    return;
  }

  $.ajax({
    url: 'index.php?route=module/construct/saveMainRow&token=<?php echo $token; ?>',
    type: 'post',
    dataType: 'json',
    data: data + 'group=' + group,
    success: function(json){
      if(json['success']){
        html = '';
        switch (group) {
          case 'tree':
            html += '<div class="box__group__item" data-item-id="' + json['success']['id'] + '">';
            html += '<input type="radio" name="selected_tree" title="<?php echo $info_selected; ?>">';
            html += '<input type="number" name="sequence" value="' + json['success']['sequence'] + '" title="<?php echo $info_sequence; ?>" class="sequence">';
            html += '<input type="text" name="name" value="' + json['success']['name'] + '">';
            html += ' <button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="' + json['success']['id'] + '"><?php echo $button_remove; ?></button>';
            html += '</div>';
            break;
          case 'type_section':
            html += '<div class="box__group__item" data-item-id="' + json['success']['id'] + '">';
            html += '<input type="radio" name="selected_type_section" title="<?php echo $info_selected; ?>">';
            html += '<input type="number" name="sequence" value="' + json['success']['sequence'] + '" title="<?php echo $info_sequence; ?>" class="sequence">';
            html += '<input type="text" name="name" value="' + json['success']['name'] + '">';
            html += ' <button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="' + json['success']['id'] + '"><?php echo $button_remove; ?></button>';
            html += '</div>';
            break;
          case 'type_alcove':
            html += '<div class="box__group__item" data-item-id="' + json['success']['id'] + '">';
            html += '<input type="radio" name="selected_type_alcove" title="<?php echo $info_selected; ?>">';
            html += '<input type="number" name="sequence" value="' + json['success']['sequence'] + '" title="<?php echo $info_sequence; ?>" class="sequence">';

            html += '<div class="image" title="<?php echo $info_big_image; ?>" data-size="200x300">';
            html += '<a onclick="image_upload(\'imageBig' + json['success']['id'] + '\', \'thumbBig' + json['success']['id'] + '\');"><img src="' + (json['success']['big_image']?json['success']['big_image']:'<?php echo $no_image; ?>') + '" alt="" id="thumbBig' + json['success']['id'] + '" /></a>';
            html += '<input type="hidden" name="big_image" value="' + (json['success']['big_image']?json['success']['big_image']:'') + '" id="imageBig' + json['success']['id'] + '"  />';
            html += '</div>';

            html += '<div class="image" title="<?php echo $info_mini_image; ?>" data-size="100x100">';
            html += '<a onclick="image_upload(\'image' + json['success']['id'] + '\', \'thumb' + json['success']['id'] + '\');"><img src="' + (json['success']['image']?json['success']['image']:'<?php echo $no_image; ?>') + '" alt="" id="thumb' + json['success']['id'] + '" /></a>';
            html += '<input type="hidden" name="image" value="' + (json['success']['image']?json['success']['image']:'') + '" id="image' + json['success']['id'] + '"  />';
            html += '</div>';

            html += '<input type="text" name="name" value="' + json['success']['name'] + '">';
            html += ' <input type="text" name="count_section" value="' + json['success']['count_section'] + '" class="count-row">';
            html += ' <button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="' + json['success']['id'] + '"><?php echo $button_remove; ?></button>';
            html += '</div>';
            break;
          case 'box':
            html += '<div class="box__group__item" data-item-id="' + json['success']['id'] + '">';
            html += '<input type="radio" name="selected_box_' + json['success']['type'] + '" title="<?php echo $info_selected; ?>">';
            html += '<input type="number" name="sequence" value="' + json['success']['sequence'] + '" title="<?php echo $info_sequence; ?>" class="sequence">';
            html += '<div class="image" title="<?php echo $info_mini_image; ?>" data-size="100x100">';
            html += '<a onclick="image_upload(\'box_image' + json['success']['id'] + '\', \'box_thumb' + json['success']['id'] + '\');"><img src="' + (json['success']['image']?json['success']['image']:'<?php echo $no_image; ?>') + '" alt="" id="box_thumb' + json['success']['id'] + '" /></a>';
            html += '<input type="hidden" name="image" value="' + (json['success']['image']?json['success']['image']:'') + '" id="box_image' + json['success']['id'] + '"  />';
            html += '</div>'

            html += '<input type="text" name="name" value="' + json['success']['name'] + '">';
            if(json['success']['type'] == "top"){
              html += '<p class="item-text text-box-type"><?php echo $text_top_box; ?></p>';
            }
            if(json['success']['type'] == "bottom"){
              html += '<p class="item-text text-box-type"><?php echo $text_bottom_box; ?></p>';
            }
            html += '<button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="' + json['success']['id'] + '"><?php echo $button_remove; ?></button>';
            html += '</div>';
            break;
          case 'option':
            html += '<div class="box__group__item" data-item-id="' + json['success']['id'] + '">';
            html += '<input type="number" name="sequence" value="' + json['success']['sequence'] + '" title="<?php echo $info_sequence; ?>" class="sequence">';
            html += '<input type="text" name="name" value="' + json['success']['name'] + '">';
            html += '<p class="item-text text-type" title="<?php echo $info_option_type; ?>">' + json['success']['type'] + '</p>';
            html += '<p class="item-text text-depends"title="<?php echo $info_option_depends; ?>">' + json['success']['depends'] + '</p>';
            html += '<button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="' + json['success']['id'] + '"><?php echo $button_remove; ?></button>';
            html += '</div>';
            break;
          default:
            alert('Error add new row!');
            return;
        }
        dataGroup.find('.box__group__items').append(html);
        $('.form_group').find('input').val('');
        $('.form_group').find('img').attr('src', '<?php echo $no_image; ?>');
      }else{
        alert('server error add new row');
      }
    }
  });
});

// ---- ---- Удаление поля
$(document).on('click', '.main-settings .remove-item', function(){
  $('.second-settings_refresh').parent().addClass('refresh-settings-wrap');
  var group = $(this).parent().parent().parent().attr('data-group-name'),
      self = $(this).parent();
  $.ajax({
    url: 'index.php?route=module/construct/removeMainRow&token=<?php echo $token; ?>',
    type: 'post',
    dataType: 'json',
    data: 'group=' + group + '&id=' + $(this).attr('data-id'),
    success: function(json){
      if(json['success']){
        self.remove();
      }
    }
  });
});

// ---- ---- Апдейт поля
$(document).on('change', '.main-settings .box__group__items input, .main-settings .box__group__items select', function(){
  updateRow(this);
});

var updateRow = function(self, image = 0){
  $('.second-settings_refresh').parent().addClass('refresh-settings-wrap');
  var dataGroup, group, id, updatedValue, updatedName;
  if(image != 0){
    dataGroup = $(self).parent().parent().parent().parent().parent(),
    group = dataGroup.attr('data-group-name'),
    id = $(self).parent().parent().parent().attr('data-item-id');
    updatedValue = image,
    updatedName = $(self).parent().parent().find('input').attr('name');
  }else{
    dataGroup = $(self).parent().parent().parent(),
    group = dataGroup.attr('data-group-name'),
    id = $(self).parent().attr('data-item-id');
    updatedValue = $(self).val(),
    updatedName = $(self).attr('name');
    if(!updatedValue.length){
      $(self).focus();
      return;
    }
  }

  $.ajax({
    url: 'index.php?route=module/construct/updateRow&token=<?php echo $token; ?>',
    type: 'post',
    dataType: 'json',
    data: 'value=' + updatedValue + '&col=' + updatedName + '&group=' + group + '&id=' + id,
    success: function(json){
      if(json['success']){
        console.log('updated');
      }
    }
  });
}

// ---- Сохранение второстепенных настроек
$(document).on('click', '.save', function(){
  if($(this).parent().hasClass('module-settings__box')){
    $(this).parent().find('input').each(function(i, input){
      if(!$(input).length){
        $(input).focus();
        return;
      }
    });
  }
  $.ajax({
    url: $(this).parent().attr('action'),
    type: $(this).parent().attr('method'),
    dataType: 'json',
    data: $(this).parent().serialize(),
    success: function(){
      alert('updated');
    }
  });
  return 0;
});

// ---- Сохранение настроек опций на лету
// ---- ---- Добавление
$(document).on('click', '.tab .add-item', function(){
  $('.htabs').addClass('refresh_options');
  var text = $(this).parent().find('input').val(),
      parentId = $(this).attr('data-id'),
      wrap = $(this).parent().parent().find('.box__group__items');

  if(text == ''){
    $(this).parent().find('input').focus();
    return;
  }
  $.ajax({
    url: 'index.php?route=module/construct/saveOptionChild&token=<?php echo $token; ?>',
    type: 'post',
    dataType: 'json',
    data: 'parent_id=' + parentId + '&text=' + text,
    success: function(json){
      var html = '';
      if(json['success']){
        html += '<div class="box__group__item" data-id="' + json['success']['id'] + '">';
        html += '<input type="text" name="option_children" value="' + json['success']['text'] + '">';
        html += '<button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="' + json['success']['id'] + '"><?php echo $button_remove; ?></button>';
        html += '</div>';
        wrap.append(html);
        $('.form_group').find('input').val('');
      }
    }
  });
});

// ---- ---- Удаление
$(document).on('click', '.tab .remove-item', function(){
  $('.htabs').addClass('refresh_options');
  var id = $(this).attr('data-id'), box = $(this).parent();

  $.ajax({
    url: 'index.php?route=module/construct/removeOptionChild&token=<?php echo $token; ?>',
    type: 'post',
    dataType: 'json',
    data: 'id=' + id,
    success: function(json){
      if(json['success']){
        box.remove();
      }
    }
  });
});

// ---- ---- Апдейт
$(document).on('change', '.tab .box__group__items input', function(){
  $('.htabs').addClass('refresh_options');
  var value = $(this).val(), id = $(this).parent().attr('data-id'),
      col = $(this).attr('name');

  $.ajax({
    url: 'index.php?route=module/construct/updateRow&token=<?php echo $token; ?>',
    type: 'post',
    dataType: 'json',
    data: 'value=' + value + '&col=' + col + '&group=option_children&id=' + id,
    success: function(json){
      if(json['success']){
        console.log('option updated');
      }
    }
  });
});

$(document).mouseover(function(e){
  if($(e.target).prop('nodeName') == 'IMG' && ($(e.target).parent().parent().hasClass('image') || $(e.target).parent().is('th') || $(e.target).parent().is('td')) && !$(e.target).parent().parent().parent().hasClass('form_group')){
    var offset = $(e.target).offset();
    $(document).find('.big-image-preview').css({
      'top': offset.top-250,
      'left': offset.left-250
    });
    $(document).find('.big-image-preview').show().find('img').attr('src', $(e.target).attr('src'));
  }
}).mouseout(function(e){
  if($(e.target).prop('nodeName') == 'IMG'){
    $(document).find('.big-image-preview').hide();
  }
});

//--></script>
<?php echo $footer; ?>
