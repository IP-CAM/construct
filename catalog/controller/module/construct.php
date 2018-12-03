<?php
class ControllerModuleConstruct extends Controller {
  public function index(){
    $this->language->load('module/construct');
    $this->load->model('tool/image');
    $this->load->model('module/construct');

    $this->document->setTitle($this->language->get('heading_title'));

    $this->data['step_type_alcove'] = $this->language->get('step_type_alcove');
    $this->data['step_type_section'] = $this->language->get('step_type_section');
    $this->data['step_option'] = $this->language->get('step_option');
    $this->data['text_top_box'] = $this->language->get('text_top_box');
    $this->data['text_bottom_box'] = $this->language->get('text_bottom_box');
    $this->data['text_flooring'] = $this->language->get('text_flooring');
    $this->data['text_tree'] = $this->language->get('text_tree');
    $this->data['text_name'] = $this->language->get('text_name');
    $this->data['text_email'] = $this->language->get('text_email');
    $this->data['text_number'] = $this->language->get('text_number');
    $this->data['text_comment'] = $this->language->get('text_comment');
    $this->data['text_total'] = $this->language->get('text_total');

    $this->data['button_confirm'] = $this->language->get('button_confirm');

    $this->data['breadcrumbs'] = array();

    $this->data['breadcrumbs'][] = array(
      'text'      => $this->language->get('text_home'),
      'href'      => $this->url->link('common/home'),
      'separator' => false
    );

    $this->data['breadcrumbs'][] = array(
      'text'      => $this->language->get('heading_title'),
      'href'      => $this->url->link('module/construct'),
      'separator' => $this->language->get('text_separator')
    );

    $big_image_size = explode('x', $this->config->get('big_image_size'));
    $mini_image_size = explode('x', $this->config->get('mini_image_size'));

    $this->data['trees'] = $this->model_module_construct->getTrees();
		$this->data['types_section'] = $this->model_module_construct->getTypesSection();
		$this->data['types_alcove'] = $this->model_module_construct->getTypesAlcove();
    foreach($this->data['types_alcove'] as $key => $type){
      $this->data['types_alcove'][$key]['image'] = $this->model_tool_image->resize($type['image'], $mini_image_size[0], $mini_image_size[1], true);
    }
		$this->data['boxes'] = $this->model_module_construct->getBox();
    foreach($this->data['boxes'] as $key => $box){
      $this->data['boxes'][$key]['image'] = $this->model_tool_image->resize($box['image'], $mini_image_size[0], $mini_image_size[1], true);
    }
    $this->data['options'] = $this->model_module_construct->getOptions();

    $arr = array();
    $tree_id = $this->model_module_construct->getTrees(true);
    $type_alcove_id = $this->model_module_construct->getTypesAlcove(true);
    $type_section_id = $this->model_module_construct->getTypesSection(true);
    $box_top_id = $this->model_module_construct->getBox(true, 'top');
    $box_bottom_id = $this->model_module_construct->getBox(true, 'bottom');
    $arr[0] = array(
      'tag' => 'by_tree_frame',
      'tree_id' => $tree_id,
      'type_alcove_id' => $type_alcove_id,
      'type_section_id' => $type_section_id,
      'box_id' => ''
    );
    $arr[1] = array(
      'tag' => 'by_tree_box_top',
      'tree_id' => $tree_id,
      'type_alcove_id' => $type_alcove_id,
      'type_section_id' => $type_section_id,
      'box_id' => $box_top_id
    );
    $arr[2] = array(
      'tag' => 'by_tree_box_bottom',
      'tree_id' => $tree_id,
      'type_alcove_id' => $type_alcove_id,
      'type_section_id' => $type_section_id,
      'box_id' => $box_bottom_id
    );
    foreach($this->data['options'] as $option){
      if($option['type'] == "radio"){
        $child_id = $this->model_module_construct->getOptionChildren($option['id'], true);
        $arr[] = array(
          'tag' => 'option_'.$option['id'].'_'.$child_id,
          'tree_id' => $option['depends']=="tree"?$tree_id:'',
          'type_alcove_id' => $option['depends']=="type_alcove"?$type_alcove_id:'',
          'type_section_id' => $option['depends']=="type_section"?$type_section_id:'',
          'box_id' => ''
        );
      }
    }

    $image_data = array(
      'type_alcove_id' => (int)$type_alcove_id,
      'type_section_id' => (int)$type_section_id,
      'box_top_id' => (int)$box_top_id,
      'box_bottom_id' => (int)$box_bottom_id
    );

    $this->data['price'] = $this->pluralForm((int)$this->model_module_construct->formPrice($arr), array('рубль','рубля','рублей'));
    $images = $this->model_module_construct->getBigImages($image_data);
    $this->data['alcove_name'] = $this->model_module_construct->getName($image_data);
    $this->data['names_alcove'] = $this->model_module_construct->getNames();
    $this->data['first_step_image'] = $this->model_tool_image->resize($images['first_step_image'], $big_image_size[0], $big_image_size[1], true);
    $this->data['second_step_image'] = $this->model_tool_image->resize($images['second_step_image'], $big_image_size[0], $big_image_size[1], true);

    if (file_exists(DIR_TEMPLATE . $this->config->get('config_template') . '/template/module/construct.tpl')) {
			$this->template = $this->config->get('config_template') . '/template/module/construct.tpl';
		} else {
			$this->template = 'default/template/module/construct.tpl';
		}

    $this->children = array(
			'common/footer',
			'common/header'
		);

		$this->response->setOutput($this->render());
  }

  public function getData(){
    $json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
      $arr = array();

      $data = array(
        'tree_id' => (int)$this->request->post['tree_id'],
        'type_alcove_id' => (int)$this->request->post['type_alcove_id'],
        'type_section_id' => (int)$this->request->post['type_section_id'],
        'box_top_id' => (int)$this->request->post['top_box_id'],
        'flooring' => (int)$this->request->post['flooring'],
        'box_bottom_id' => (int)$this->request->post['bottom_box_id']
      );

      unset($this->request->post['tree_id']);
      unset($this->request->post['type_alcove_id']);
      unset($this->request->post['type_section_id']);
      unset($this->request->post['top_box_id']);
      unset($this->request->post['bottom_box_id']);
      unset($this->request->post['flooring']);

      $arr[0] = array(
        'tag' => 'by_tree_frame',
        'tree_id' => $data['tree_id'],
        'type_alcove_id' => $data['type_alcove_id'],
        'type_section_id' => $data['type_section_id'],
        'box_id' => ''
      );
      $arr[1] = array(
        'tag' => 'by_tree_box_top',
        'tree_id' => $data['tree_id'],
        'type_alcove_id' => $data['type_alcove_id'],
        'type_section_id' => $data['type_section_id'],
        'box_id' => $data['box_top_id']
      );
      $arr[2] = array(
        'tag' => 'by_tree_box_bottom',
        'tree_id' => $data['tree_id'],
        'type_alcove_id' => $data['type_alcove_id'],
        'type_section_id' => $data['type_section_id'],
        'box_id' => $data['box_bottom_id']
      );

      if((int)$data['flooring'] == 1){
        $arr[3] = array(
          'tag' => 'by_type_alcove_flooring',
          'tree_id' => $data['tree_id'],
          'type_alcove_id' => $data['type_alcove_id'],
          'type_section_id' => $data['type_section_id'],
          'box_id' => ''
        );
      }

      $this->load->model('module/construct');
      $this->load->model('tool/image');

      foreach($this->request->post as $key => $option){
        $option_attr = explode('_', $key);
        $option_depends = $this->model_module_construct->getOptions($option_attr[1]);
        $arr[] = array(
          'tag' => $option=="on"?$key:$key.'_'.$option,
          'tree_id' => $option_depends=="tree"?$data['tree_id']:'',
          'type_alcove_id' => $option_depends=="type_alcove"?$data['type_alcove_id']:'',
          'type_section_id' => $option_depends=="type_section"?$data['type_section_id']:'',
          'box_id' => ''
        );
      }

      $big_image_size = explode('x', $this->config->get('big_image_size'));

			$json['success']['price'] = $this->pluralForm((int)$this->model_module_construct->formPrice($arr), array('рубль','рубля','рублей'));
      $json['success']['images'] = $this->model_module_construct->getBigImages($data);
      $json['success']['images']['first_step_image'] = $this->model_tool_image->resize($json['success']['images']['first_step_image'], $big_image_size[0], $big_image_size[1], true);
      $json['success']['images']['second_step_image'] = $this->model_tool_image->resize($json['success']['images']['second_step_image'], $big_image_size[0], $big_image_size[1], true);
      $json['success']['alcove_name'] = $this->model_module_construct->getName($data);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
  }

  private function pluralForm($number, $after) {
    $cases = array (2, 0, 1, 1, 1, 2);
    return $number.' '.$after[ ($number%100>4 && $number%100<20)? 2: $cases[min($number%10, 5)] ];
  }

  public function confirm(){
    $json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
      $data = array(
        'name' => $this->request->post['name'],
        'email' => $this->request->post['email'],
        'number' => $this->request->post['number'],
        'comment' => $this->request->post['comment'],
        'tree_id' => (int)$this->request->post['tree_id'],
        'type_alcove_id' => (int)$this->request->post['type_alcove_id'],
        'type_section_id' => (int)$this->request->post['type_section_id'],
        'box_top_id' => (int)$this->request->post['top_box_id'],
        'flooring' => (int)$this->request->post['flooring'],
        'box_bottom_id' => (int)$this->request->post['bottom_box_id'],
        'total' => $this->request->post['price']
      );

      $data['options'] = array();

      foreach($this->request->post as $key => $option){
        if(strpos($key, 'option') !== false){
          $option_attr = explode('_', $key);
          $data['options'][] = array(
            'option_id' => $option_attr[1],
            'child_id' => $option=="on"?'':$option
          );
        }
      }

      $this->load->model('module/construct');
      $this->load->language('module/construct');
      $this->model_module_construct->addOrder($data);
      $json['success'] = $this->language->get('text_success');
    }
    $this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
  }

}
?>
