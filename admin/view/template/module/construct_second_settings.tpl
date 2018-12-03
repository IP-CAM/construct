<div class="load-content">
  <div class="htabs">
    <a href="#tab-1" class="selected"><span><?php echo $tab_price; ?></span></a>
    <a href="#tab-2"><span><?php echo $tab_image; ?></span></a>
    <a href="#tab-3"><span><?php echo $tab_option; ?></span></a>
    <a href="#tab-4"><span><?php echo $tab_name; ?></span></a>
    <span class="refresh-option"><button class="refresh refresh-button-mini btn"><?php echo $button_refresh; ?></button></span>
  </div>
  <div class="box-tabs">
    <div class="tab" id="tab-1">
      <div class="vtabs_price vtabs">
        <?php if(!empty($trees)){ ?>
          <p class="tab-text"><?php echo $text_tree_tab; ?></p>
          <?php $i = 0; foreach($trees as $key => $tree){ ?>
          <a href="#tree_tab-<?php echo $key; ?>" <?php if($i < 1){ ?>class="selected"<?php } $i++; ?>><?php echo $tree['name']; ?></a>
          <?php } ?>
        <?php } ?>

        <?php if(!empty($types_alcove)){ ?>
          <p class="tab-text"><?php echo $text_type_alcove_tab; ?></p>
          <?php foreach($types_alcove as $key => $type){ ?>
          <a href="#alcove_tab-<?php echo $key; ?>"><?php echo $type['name']; ?></a>
          <?php } ?>
        <?php } ?>

        <?php if(!empty($types_section)){ ?>
          <p class="tab-text"><?php echo $text_type_section_tab; ?></p>
          <?php foreach($types_section as $key => $type){ ?>
          <a href="#section_tab-<?php echo $key; ?>"><?php echo $type['name']; ?></a>
          <?php } ?>
        <?php } ?>
      </div>

      <form action="index.php?route=module/construct/savePrices&token=<?php echo $token; ?>" method="post">
        <a class="btn save"><?php echo $button_save_prices; ?></a>
        <?php if(!empty($trees)){ ?>
          <?php $i = 0; foreach($trees as $key => $tree){ ?>
          <div id="tree_tab-<?php echo $key; ?>" class="sub-tab">
            <h3><?php echo $h3_price_frame; ?></h3>
            <table>
              <thead>
                <tr>
                  <th></th>
                  <?php foreach($types_section as $type){ ?>
                    <th><?php echo $type['name'];?></th>
                  <?php } ?>
                </tr>
              </thead>
              <tbody>
                <?php foreach($types_alcove as $type){ ?>
                  <tr>
                    <td><img src="<?php echo $type['image']; ?>" class="size-stabile" alt="<?php echo $type['name']; ?>" title="<?php echo $type['name']; ?>"></td>
                    <?php foreach($types_section as $type_s){ ?>
                    <td><input type="text" name="by_tree_frame-<?php echo $tree['id'].'-'.$type['id'].'-'.$type_s['id'].'-'; ?>" value="<?php echo isset($val_price['by_tree_frame-'.$tree['id'].'-'.$type['id'].'-'.$type_s['id'].'-'])?$val_price['by_tree_frame-'.$tree['id'].'-'.$type['id'].'-'.$type_s['id'].'-']:''; ?>"></td>
                    <?php } ?>
                  </tr>
                <?php } ?>
              </tbody>
            </table>

            <h3><?php echo $h3_price_section_top; ?></h3>
            <table>
              <thead>
                <tr>
                  <th></th>
                  <?php foreach($types_section as $type){ ?>
                    <th><?php echo $type['name'];?></th>
                  <?php } ?>
                </tr>
              </thead>
              <tbody>
                <?php foreach($boxes_top as $box){ ?>
                  <tr>
                    <td><img src="<?php echo $box['image']; ?>" class="size-stabile" alt="<?php echo $box['name']; ?>" title="<?php echo $box['name']; ?>"></td>
                    <?php foreach($types_section as $type_s){ ?>
                    <td><input type="text" name="by_tree_box_top-<?php echo $tree['id'].'--'.$type_s['id'].'-'.$box['id']; ?>" value="<?php echo isset($val_price['by_tree_box_top-'.$tree['id'].'--'.$type_s['id'].'-'.$box['id']])?$val_price['by_tree_box_top-'.$tree['id'].'--'.$type_s['id'].'-'.$box['id']]:''; ?>"></td>
                    <?php } ?>
                  </tr>
                <?php } ?>
              </tbody>
            </table>

            <h3><?php echo $h3_price_section_bottom; ?></h3>
            <table>
              <thead>
                <tr>
                  <th></th>
                  <?php foreach($types_section as $type){ ?>
                    <th><?php echo $type['name'];?></th>
                  <?php } ?>
                </tr>
              </thead>
              <tbody>
                <?php foreach($boxes_bottom as $box){ ?>
                  <tr>
                    <td><img src="<?php echo $box['image']; ?>" class="size-stabile" alt="<?php echo $box['name']; ?>" title="<?php echo $box['name']; ?>"></td>
                    <?php foreach($types_section as $type_s){ ?>
                    <td><input type="text" name="by_tree_box_bottom-<?php echo $tree['id'].'--'.$type_s['id'].'-'.$box['id']; ?>" value="<?php echo isset($val_price['by_tree_box_bottom-'.$tree['id'].'--'.$type_s['id'].'-'.$box['id']])?$val_price['by_tree_box_bottom-'.$tree['id'].'--'.$type_s['id'].'-'.$box['id']]:''; ?>"></td>
                    <?php } ?>
                  </tr>
                <?php } ?>
              </tbody>
            </table>

            <?php if(!empty($options) && $count_options_tree != 0){ ?>
              <h3><?php echo $h3_price_option; ?></h3>
              <?php foreach($options as $option){ ?>
                <?php if($option['depends'] == "tree"){ ?>
                  <?php if($option['type'] == "checkbox"){ ?>
                    <h4><?php echo $option['name']; ?></h4>
                    <input type="text" name="option_<?php echo $option['id'].'-'.$tree['id'].'---'; ?>" value="<?php echo isset($val_price['option_'.$option['id'].'-'.$tree['id'].'---'])?$val_price['option_'.$option['id'].'-'.$tree['id'].'---']:''; ?>">
                  <?php }else if($option['type'] == "radio"){ ?>
                    <h4><?php echo $option['name']; ?></h4>
                    <table>
                      <?php foreach($option['children'] as $child){ ?>
                      <tr>
                        <td><?php echo $child['text']; ?></td>
                        <td><input type="text" name="option_<?php echo $option['id'].'_'.$child['id'].'-'.$tree['id'].'---'; ?>" value="<?php echo isset($val_price['option_'.$option['id'].'_'.$child['id'].'-'.$tree['id'].'---'])?$val_price['option_'.$option['id'].'_'.$child['id'].'-'.$tree['id'].'---']:''; ?>"></td>
                      </tr>
                      <?php } ?>
                    </table>
                  <?php } ?>
                <?php } ?>
              <?php } ?>
            <?php } ?>
          </div>
          <?php } ?>
        <?php } ?>

        <?php if(!empty($types_alcove)){ ?>
          <?php foreach($types_alcove as $key => $type){ ?>
          <div id="alcove_tab-<?php echo $key; ?>" class="sub-tab">
            <h3><?php echo $h3_price_flooring; ?></h3>
            <table>
              <thead>
                <tr>
                  <th></th>
                  <?php foreach($types_section as $type_s){ ?>
                    <th><?php echo $type_s['name'];?></th>
                  <?php } ?>
                </tr>
              </thead>
              <tbody>
                <?php foreach($trees as $tree){ ?>
                  <tr>
                    <td><?php echo $tree['name']; ?></td>
                    <?php foreach($types_section as $type_s){ ?>
                    <td><input type="text" name="by_type_alcove_flooring-<?php echo $tree['id'].'-'.$type['id'].'-'.$type_s['id'].'-'; ?>" value="<?php echo isset($val_price['by_type_alcove_flooring-'.$tree['id'].'-'.$type['id'].'-'.$type_s['id'].'-'])?$val_price['by_type_alcove_flooring-'.$tree['id'].'-'.$type['id'].'-'.$type_s['id'].'-']:''; ?>"></td>
                    <?php } ?>
                  </tr>
                <?php } ?>
              </tbody>
            </table>

            <?php if(!empty($options) && $count_options_type_alcove != 0){ ?>
              <h3><?php echo $h3_price_option; ?></h3>
              <?php foreach($options as $option){ ?>
                <?php if($option['depends'] == "type_alcove"){ ?>
                  <?php if($option['type'] == "checkbox"){ ?>
                    <h4><?php echo $option['name']; ?></h4>
                    <input type="text" name="option_<?php echo $option['id'].'--'.$type['id'].'--'; ?>" value="<?php echo isset($val_price['option_'.$option['id'].'--'.$type['id'].'--'])?$val_price['option_'.$option['id'].'--'.$type['id'].'--']:''; ?>">
                  <?php }else if($option['type'] == "radio"){ ?>
                    <h4><?php echo $option['name']; ?></h4>
                    <table>
                      <?php foreach($option['children'] as $child){ ?>
                      <tr>
                        <td><?php echo $child['text']; ?></td>
                        <td><input type="text" name="option_<?php echo $option['id'].'_'.$child['id'].'--'.$type['id'].'--'; ?>" value="<?php echo isset($val_price['option_'.$option['id'].'_'.$child['id'].'--'.$type['id'].'--'])?$val_price['option_'.$option['id'].'_'.$child['id'].'--'.$type['id'].'--']:''; ?>"></td>
                      </tr>
                      <?php } ?>
                    </table>
                  <?php } ?>
                <?php } ?>
              <?php } ?>
            <?php } ?>
          </div>
          <?php } ?>
        <?php } ?>

        <?php if(!empty($types_section)){ ?>
          <?php foreach($types_section as $key => $type){ ?>
          <div id="section_tab-<?php echo $key; ?>" class="sub-tab">
            <?php if(!empty($options) && $count_options_type_section != 0){ ?>
              <h3><?php echo $h3_price_option; ?></h3>
              <?php foreach($options as $option){ ?>
                <?php if($option['depends'] == "type_section"){ ?>
                  <?php if($option['type'] == "checkbox"){ ?>
                    <h4><?php echo $option['name']; ?></h4>
                    <input type="text" name="option_<?php echo $option['id'].'---'.$type['id'].'-'; ?>" value="<?php echo isset($val_price['option_'.$option['id'].'---'.$type['id'].'-'])?$val_price['option_'.$option['id'].'---'.$type['id'].'-']:''; ?>">
                  <?php }else if($option['type'] == "radio"){ ?>
                    <h4><?php echo $option['name']; ?></h4>
                    <table>
                      <?php foreach($option['children'] as $child){ ?>
                      <tr>
                        <td><?php echo $child['text']; ?></td>
                        <td><input type="text" name="option_<?php echo $option['id'].'_'.$child['id'].'---'.$type['id'].'-'; ?>" value="<?php echo isset($val_price['option_'.$option['id'].'_'.$child['id'].'---'.$type['id'].'-'])?$val_price['option_'.$option['id'].'_'.$child['id'].'---'.$type['id'].'-']:''; ?>"></td>
                      </tr>
                      <?php } ?>
                    </table>
                  <?php } ?>
                <?php } ?>
              <?php } ?>
            <?php } ?>
          </div>
          <?php } ?>
        <?php } ?>
      </form>
    </div>
    <div class="tab" id="tab-2">
      <?php if(!empty($types_alcove) || !empty($boxes_top) || !empty($boxes_bottom)){ ?>
        <div class="vtabs_images vtabs">
          <?php if(!empty($types_alcove)){ ?>
            <?php $i = 0; foreach($types_alcove as $key => $type){ ?>
            <a href="#image_tab-<?php echo $key; ?>" <?php if($i < 1){ ?>class="selected"<?php } $i++; ?>><?php echo $type['name']; ?></a>
            <?php } ?>
          <?php } ?>
        </div>

        <form action="index.php?route=module/construct/saveImages&token=<?php echo $token; ?>" method="post">
          <a class="btn save"><?php echo $button_save_images; ?></a>
          <?php if(!empty($types_alcove)){ ?>
            <?php foreach($types_alcove as $key => $type){ ?>
              <div id="image_tab-<?php echo $key; ?>" class="sub-tab">
                <table class="images">
                  <thead>
                    <tr>
                      <th></th>
                      <?php foreach($boxes_top as $box_top){ ?>
                        <th><img src="<?php echo $box_top['image']; ?>" class="size-stabile" alt="<?php echo $box_top['name']; ?>" title="<?php echo $box_top['name']; ?>"></th>
                      <?php } ?>
                    </tr>
                  </thead>
                  <tbody>
                    <?php foreach($boxes_bottom as $box_bottom){ ?>
                      <tr>
                        <td><img src="<?php echo $box_bottom['image']; ?>" class="size-stabile" alt="<?php echo $box_bottom['name']; ?>" title="<?php echo $box_bottom['name']; ?>"></td>
                        <?php foreach($boxes_top as $box_top){ ?>
                        <td>
                          <div class="image" title="<?php echo $info_big_image; ?>">
                            <a onclick="image_upload('image-<?php echo $type['id'].'-'.$box_top['id'].'-'.$box_bottom['id']; ?>', 'thumb-<?php echo $type['id'].'-'.$box_top['id'].'-'.$box_bottom['id']; ?>');"><img src="<?php echo isset($images['image-'.$type['id'].'-'.$box_top['id'].'-'.$box_bottom['id']])?$images['image-'.$type['id'].'-'.$box_top['id'].'-'.$box_bottom['id']]['preview']:$no_image; ?>" alt="" id="thumb-<?php echo $type['id'].'-'.$box_top['id'].'-'.$box_bottom['id']; ?>" /></a>
                            <input type="hidden" name="image-<?php echo $type['id'].'-'.$box_top['id'].'-'.$box_bottom['id']; ?>" value="<?php echo isset($images['image-'.$type['id'].'-'.$box_top['id'].'-'.$box_bottom['id']])?$images['image-'.$type['id'].'-'.$box_top['id'].'-'.$box_bottom['id']]['path']:''; ?>" id="image-<?php echo $type['id'].'-'.$box_top['id'].'-'.$box_bottom['id']; ?>">
                          </div>
                        </td>
                        <?php } ?>
                      </tr>
                    <?php } ?>
                  </tbody>
                </table>
              </div>
            <?php } ?>
          <?php } ?>
        </form>
      <?php }else{ ?>
        <span class="info"><?php echo sprintf($info_set, 'типы секций, типы беседок.'); ?></span>
      <?php }?>
    </div>
    <div class="tab option_tab" id="tab-3">
      <?php if(!empty($options)){ ?>
        <?php foreach($options as $option){ ?>
          <?php if($option['type'] == 'radio'){ ?>
            <div class="box__group">
              <h3><?php echo $option['name']; ?></h3>
              <div class="box__group__items">
              <?php foreach($option['children'] as $child){ ?>
                <div class="box__group__item" data-id="<?php echo $child['id']; ?>">
                  <input type="radio" name="selected_option_child_<?php echo $option['id']; ?>" <?php if($child['selected']){ ?>checked="checked"<?php } ?> title="<?php echo $info_selected; ?>">
                  <input type="number" name="sequence" value="<?php echo $child['sequence']; ?>" title="<?php echo $info_sequence; ?>" class="sequence">
                  <input type="text" name="text" value="<?php echo $child['text']; ?>">
                  <button class="remove-item btn" title="<?php echo $info_remove; ?>" data-id="<?php echo $child['id']; ?>"><?php echo $button_remove; ?></button>
                </div>
              <?php }?>
              </div>
              <div class="box__group__item form_group">
                <input type="text" name="option_children">
                <button class="add-item btn" title="<?php echo $info_add; ?>" data-id="<?php echo $option['id']; ?>"><?php echo $button_add; ?></button>
              </div>
            </div>
          <?php }?>
        <?php }?>
      <?php }else{ ?>
        <span class="info"><?php echo sprintf($info_set, 'отдельные опции.'); ?></span>
      <?php }?>
    </div>
    <div class="tab option_tab" id="tab-4">
      <?php if(!empty($types_alcove) && !empty($types_section)){ ?>
        <form action="index.php?route=module/construct/saveNames&token=<?php echo $token; ?>" method="post">
          <a class="btn save"><?php echo $button_save_names; ?></a>
          <table>
            <thead>
              <tr>
                <th></th>
                <?php foreach($types_alcove as $type){ ?>
                  <th><img src="<?php echo $type['image']; ?>" class="size-stabile" alt="<?php echo $type['name']; ?>" title="<?php echo $type['name']; ?>"></th>
                <?php } ?>
              </tr>
            </thead>
            <tbody>
              <?php foreach($types_section as $type_s){ ?>
                <tr>
                  <td><?php echo $type_s['name']; ?></td>
                  <?php foreach($types_alcove as $type){ ?>
                  <td>
                    <input type="text" name="name_alcove-<?php echo $type['id'].'-'.$type_s['id']; ?>" value="<?php echo isset($names_alcove['name_alcove-'.$type['id'].'-'.$type_s['id']])?$names_alcove['name_alcove-'.$type['id'].'-'.$type_s['id']]:''; ?>">
                  </td>
                  <?php } ?>
                </tr>
              <?php } ?>
            </tbody>
          </table>
        </form>
      <?php }else{ ?>
        <span class="info"><?php echo sprintf($info_set, 'nипы беседок, типы секций по габаритам.'); ?></span>
      <?php } ?>
    </div>
  </div>
</div>
