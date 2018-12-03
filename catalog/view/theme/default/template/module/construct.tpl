<?php echo $header; ?>
<div class="confirm-construct">
  <h4 class="confirm-head"><?php echo $text_total; ?><h4>
  <div class="price"><?php echo $price; ?></div>
  <form action="index.php?route=module/construct/confirm" method="post" onsubmit="return false;">
      <input type="text" name="name" placeholder="<?php echo $text_name; ?>">
      <input type="text" name="email" placeholder="<?php echo $text_email; ?>">
      <input type="text" name="number" placeholder="<?php echo $text_number; ?>">
      <input type="hidden" name="price" value="<?php echo $price; ?>">
      <textarea type="text" name="comment" placeholder="<?php echo $text_comment; ?>"></textarea>
      <button type="submit" class="confirm"><?php echo $button_confirm; ?></button>
  </form>
</div>
<div class="main-construct">
  <div class="step-box">
    <h3 class="step-box__head"><?php echo $step_type_alcove; ?></h3>
    <div class="step-box__wrap">
      <div class="left">
        <div class="alcove-name"><?php echo $alcove_name; ?></div>
        <img src="<?php echo $first_step_image; ?>" class="alcove-image">
      </div>
      <div class="right">
        <?php foreach($types_section as $type_section){ ?>
          <div class="type-section-box box">
            <h4 class="type-section-box__head"><?php echo $type_section['name']; ?></h4>
            <div class="box__content" data-section-id="<?php echo $type_section['id']; ?>">
              <?php foreach($types_alcove as $type_alcove){ ?>
                <?php if(isset($names_alcove['name_alcove-'.$type_alcove['id'].'-'.$type_section['id']])){ ?>
                  <?php if($names_alcove['name_alcove-'.$type_alcove['id'].'-'.$type_section['id']]){ ?>
                    <label for="type-alcove-<?php echo $type_alcove['id'].'-'.$type_section['id']; ?>" title="<?php echo $type_alcove['name']; ?>"><img src="<?php echo $type_alcove['image']; ?>" alt="<?php echo $type_alcove['name']; ?>"></label>
                    <input type="radio" name="type_alcove" value="<?php echo $type_alcove['id']; ?>" id="type-alcove-<?php echo $type_alcove['id'].'-'.$type_section['id'];; ?>" <?php if($type_alcove['selected'] && $type_section['selected']){ ?>checked="checked"<?php } ?>>
                  <?php } ?>
                <?php } ?>
              <?php } ?>
            </div>
          </div>
        <?php } ?>
      </div>
    </div>
  </div>
  <div class="step-box">
    <h3 class="step-box__header"><?php echo $step_type_section; ?></h3>
    <div class="step-box__wrap">
      <div class="left">
        <img src="<?php echo $second_step_image; ?>" class="section-image">
      </div>
      <div class="right">
        <div class="box-box box">
          <h4 class="box-box__head"><?php echo $text_top_box; ?></h4>
          <div class="box__content">
            <?php foreach($boxes as $box){ ?>
              <?php if($box['type'] == "top"){ ?>
                <label for="top-box-<?php echo $box['id']; ?>" title="<?php echo $box['name']; ?>"><img src="<?php echo $box['image']; ?>" alt="<?php echo $box['name']; ?>"></label>
                <input type="radio" name="top_box" value="<?php echo $box['id']; ?>" id="top-box-<?php echo $box['id']; ?>" <?php if($box['selected']){ ?>checked="checked"<?php } ?>>
              <?php } ?>
            <?php } ?>
          </div>
        </div>
        <div class="box-box box">
          <h4 class="box-box__head"><?php echo $text_bottom_box; ?></h4>
          <div class="box__content">
            <?php foreach($boxes as $box){ ?>
              <?php if($box['type'] == "bottom"){ ?>
                <label for="bottom-box-<?php echo $box['id']; ?>" title="<?php echo $box['name']; ?>"><img src="<?php echo $box['image']; ?>" alt="<?php echo $box['name']; ?>"></label>
                <input type="radio" name="bottom_box" value="<?php echo $box['id']; ?>" id="bottom-box-<?php echo $box['id']; ?>" <?php if($box['selected']){ ?>checked="checked"<?php } ?>>
              <?php } ?>
            <?php } ?>
          </div>
        </div>
      </div>
    </div>
  </div>
  <div class="step-box">
    <h3 class="step-box__head"><?php echo $step_option; ?></h3>
    <div class="step-box__wrap">
      <div class="box__option">
        <label for="flooring"><?php echo $text_flooring; ?></label>
        <input type="checkbox" name="flooring" id="flooring">
      </div>
      <div class="box__option generated">
        <?php foreach($options as $option){ ?>
          <?php if($option['type'] == "checkbox"){ ?>
            <label for="option-<?php echo $option['id']; ?>"><?php echo $option['name']; ?></label>
            <input type="checkbox" name="option_<?php echo $option['id']; ?>" id="option-<?php echo $option['id']; ?>">
          <?php }else if($option['type'] == "radio"){ ?>
            <h4 class="option-name"><?php echo $option['name']; ?></h4>
            <?php foreach($option['children'] as $child){ ?>
              <label for="option-<?php echo $option['id'].'-'.$child['id']; ?>"><?php echo $child['text']; ?></label>
              <input type="radio" name="option_<?php echo $option['id']; ?>" value="<?php echo $child['id']; ?>" id="option-<?php echo $option['id'].'-'.$child['id']; ?>" <?php if($child['selected']){ ?>checked="checked"<?php } ?>>
            <?php } ?>
          <?php } ?>
        <?php } ?>
      </div>
      <div class="box__option">
        <h4 class="option-name"><?php echo $text_tree; ?></h4>
        <?php foreach($trees as $tree){ ?>
          <label for="tree-<?php echo $tree['id']; ?>"><?php echo $tree['name']; ?></label>
          <input type="radio" name="tree" value="<?php echo $tree['id']; ?>" id="tree-<?php echo $tree['id']; ?>" <?php if($tree['selected']){ ?>checked="checked"<?php } ?>>
        <?php } ?>
      </div>
    </div>
  </div>
</div>
<script><!--
!function(a){"function"==typeof define&&define.amd?define(["jquery"],a):a("object"==typeof exports?require("jquery"):jQuery)}(function(a){var b,c=navigator.userAgent,d=/iphone/i.test(c),e=/chrome/i.test(c),f=/android/i.test(c);a.mask={definitions:{9:"[0-9]",a:"[A-Za-z]","*":"[A-Za-z0-9]"},autoclear:!0,dataName:"rawMaskFn",placeholder:"_"},a.fn.extend({caret:function(a,b){var c;if(0!==this.length&&!this.is(":hidden"))return"number"==typeof a?(b="number"==typeof b?b:a,this.each(function(){this.setSelectionRange?this.setSelectionRange(a,b):this.createTextRange&&(c=this.createTextRange(),c.collapse(!0),c.moveEnd("character",b),c.moveStart("character",a),c.select())})):(this[0].setSelectionRange?(a=this[0].selectionStart,b=this[0].selectionEnd):document.selection&&document.selection.createRange&&(c=document.selection.createRange(),a=0-c.duplicate().moveStart("character",-1e5),b=a+c.text.length),{begin:a,end:b})},unmask:function(){return this.trigger("unmask")},mask:function(c,g){var h,i,j,k,l,m,n,o;if(!c&&this.length>0){h=a(this[0]);var p=h.data(a.mask.dataName);return p?p():void 0}return g=a.extend({autoclear:a.mask.autoclear,placeholder:a.mask.placeholder,completed:null},g),i=a.mask.definitions,j=[],k=n=c.length,l=null,a.each(c.split(""),function(a,b){"?"==b?(n--,k=a):i[b]?(j.push(new RegExp(i[b])),null===l&&(l=j.length-1),k>a&&(m=j.length-1)):j.push(null)}),this.trigger("unmask").each(function(){function h(){if(g.completed){for(var a=l;m>=a;a++)if(j[a]&&C[a]===p(a))return;g.completed.call(B)}}function p(a){return g.placeholder.charAt(a<g.placeholder.length?a:0)}function q(a){for(;++a<n&&!j[a];);return a}function r(a){for(;--a>=0&&!j[a];);return a}function s(a,b){var c,d;if(!(0>a)){for(c=a,d=q(b);n>c;c++)if(j[c]){if(!(n>d&&j[c].test(C[d])))break;C[c]=C[d],C[d]=p(d),d=q(d)}z(),B.caret(Math.max(l,a))}}function t(a){var b,c,d,e;for(b=a,c=p(a);n>b;b++)if(j[b]){if(d=q(b),e=C[b],C[b]=c,!(n>d&&j[d].test(e)))break;c=e}}function u(){var a=B.val(),b=B.caret();if(o&&o.length&&o.length>a.length){for(A(!0);b.begin>0&&!j[b.begin-1];)b.begin--;if(0===b.begin)for(;b.begin<l&&!j[b.begin];)b.begin++;B.caret(b.begin,b.begin)}else{for(A(!0);b.begin<n&&!j[b.begin];)b.begin++;B.caret(b.begin,b.begin)}h()}function v(){A(),B.val()!=E&&B.change()}function w(a){if(!B.prop("readonly")){var b,c,e,f=a.which||a.keyCode;o=B.val(),8===f||46===f||d&&127===f?(b=B.caret(),c=b.begin,e=b.end,e-c===0&&(c=46!==f?r(c):e=q(c-1),e=46===f?q(e):e),y(c,e),s(c,e-1),a.preventDefault()):13===f?v.call(this,a):27===f&&(B.val(E),B.caret(0,A()),a.preventDefault())}}function x(b){if(!B.prop("readonly")){var c,d,e,g=b.which||b.keyCode,i=B.caret();if(!(b.ctrlKey||b.altKey||b.metaKey||32>g)&&g&&13!==g){if(i.end-i.begin!==0&&(y(i.begin,i.end),s(i.begin,i.end-1)),c=q(i.begin-1),n>c&&(d=String.fromCharCode(g),j[c].test(d))){if(t(c),C[c]=d,z(),e=q(c),f){var k=function(){a.proxy(a.fn.caret,B,e)()};setTimeout(k,0)}else B.caret(e);i.begin<=m&&h()}b.preventDefault()}}}function y(a,b){var c;for(c=a;b>c&&n>c;c++)j[c]&&(C[c]=p(c))}function z(){B.val(C.join(""))}function A(a){var b,c,d,e=B.val(),f=-1;for(b=0,d=0;n>b;b++)if(j[b]){for(C[b]=p(b);d++<e.length;)if(c=e.charAt(d-1),j[b].test(c)){C[b]=c,f=b;break}if(d>e.length){y(b+1,n);break}}else C[b]===e.charAt(d)&&d++,k>b&&(f=b);return a?z():k>f+1?g.autoclear||C.join("")===D?(B.val()&&B.val(""),y(0,n)):z():(z(),B.val(B.val().substring(0,f+1))),k?b:l}var B=a(this),C=a.map(c.split(""),function(a,b){return"?"!=a?i[a]?p(b):a:void 0}),D=C.join(""),E=B.val();B.data(a.mask.dataName,function(){return a.map(C,function(a,b){return j[b]&&a!=p(b)?a:null}).join("")}),B.one("unmask",function(){B.off(".mask").removeData(a.mask.dataName)}).on("focus.mask",function(){if(!B.prop("readonly")){clearTimeout(b);var a;E=B.val(),a=A(),b=setTimeout(function(){B.get(0)===document.activeElement&&(z(),a==c.replace("?","").length?B.caret(0,a):B.caret(a))},10)}}).on("blur.mask",v).on("keydown.mask",w).on("keypress.mask",x).on("input.mask paste.mask",function(){B.prop("readonly")||setTimeout(function(){var a=A(!0);B.caret(a),h()},0)}),e&&f&&B.off("input.mask").on("input.mask",u),A()})}})});

$(document).on('change', '.main-construct input', function(){
  var sectionId = $('.main-construct').find('input[name=\'type_alcove\']:radio:checked').parent().attr('data-section-id'),
      treeId = $('.main-construct').find('input[name=\'tree\']:radio:checked').val(),
      typeAcolveId = $('.main-construct').find('input[name=\'type_alcove\']:radio:checked').val(),
      topBox = $('.main-construct').find('input[name=\'top_box\']:radio:checked').val(),
      bottomBox = $('.main-construct').find('input[name=\'bottom_box\']:radio:checked').val(),
      flooring = +$('.main-construct').find('input[name=\'flooring\']').prop("checked"),
      options = '', priceBox = $(document).find('.price'), firstStepImage = $(document).find('.alcove-image'), secondStepImage = $(document).find('.section-image'), formInpPrice = $(document).find('form input[name=\'price\']'), alcoveName = $(document).find('.alcove-name');


  $('.main-construct .generated input:radio:checked, .main-construct .generated input:checkbox:checked').each(function(i, input){
    options += '&'+$(input).attr('name')+'='+$(input).val();
  });
  $.ajax({
    url: 'index.php?route=module/construct/getData',
    type: 'post',
    dataType: 'json',
    data: 'type_section_id=' + sectionId + '&tree_id=' + treeId + '&type_alcove_id=' + typeAcolveId + '&top_box_id=' + topBox + '&bottom_box_id=' + bottomBox + '&flooring=' + flooring + options,
    success: function(json){
      if(json['success']){
        priceBox.html(json['success']['price']);
        formInpPrice.val(json['success']['price']);
        firstStepImage.attr("src", json['success']['images']['first_step_image']);
        secondStepImage.attr("src", json['success']['images']['second_step_image']);
        alcoveName.html(json['success']['alcove_name']);
      }
    }
  });
});

$(document).on('click', '.confirm', function(){
  var userInfo = $(this).parent().serialize(),
      sectionId = $('.main-construct').find('input[name=\'type_alcove\']:radio:checked').parent().attr('data-section-id'),
      treeId = $('.main-construct').find('input[name=\'tree\']:radio:checked').val(),
      typeAcolveId = $('.main-construct').find('input[name=\'type_alcove\']:radio:checked').val(),
      topBox = $('.main-construct').find('input[name=\'top_box\']:radio:checked').val(),
      bottomBox = $('.main-construct').find('input[name=\'bottom_box\']:radio:checked').val(),
      flooring = +$('.main-construct').find('input[name=\'flooring\']').prop("checked"),
      options = '', form = $(this).parent(), pattern = /^([a-z0-9_\.-])+@[a-z0-9-]+\.([a-z]{2,4}\.)?[a-z]{2,4}$/i, trigger = false;

  form.find('input').each(function(i, input){
    if($(input).val() == '' || ($(input).attr('name')=="email" && !pattern.test($(input).val()))){
      $(input).focus();
      trigger = true;
    }
  });

  if(trigger){
    return;
  }

  $('.main-construct .generated input:radio:checked, .main-construct .generated input:checkbox:checked').each(function(i, input){
    options += '&'+$(input).attr('name')+'='+$(input).val();
  });

  $.ajax({
    url: $(this).parent().attr('action'),
    type: $(this).parent().attr('method'),
    dataType: 'json',
    data: userInfo + '&type_section_id=' + sectionId + '&tree_id=' + treeId + '&type_alcove_id=' + typeAcolveId + '&top_box_id=' + topBox + '&bottom_box_id=' + bottomBox + '&flooring=' + flooring + options,
    success: function(json){
      if(json['success']){
        html = '<div class="success">' + json['success'] + '</div>';
        form.html(html);
      }
    }
  });
});

$(document).ready(function(){
  $("input[name=\'number\']").mask("+7(999)-999-99-99");
});
//--></script>
<?php echo $footer; ?>
