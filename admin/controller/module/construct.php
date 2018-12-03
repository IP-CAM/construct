<?php
class ControllerModuleConstruct extends Controller {
	public function install(){
		$this->load->model('module/construct');
		$this->model_module_construct->install();
		$this->cache->delete('seo_pro');
	}

	public function uninstall(){
		$this->load->model('module/construct');
		$this->model_module_construct->remove();
		$this->cache->delete('seo_pro');
	}

	public function index(){
		$this->load->model('module/construct');
		$this->load->model('setting/setting');
		$this->load->language('module/construct');

		$this->settings();
	}

	public function settings(){
		$this->document->setTitle($this->language->get('heading_title'));
		$this->document->addScript('view/javascript/jquery/tabs.js');

		$this->data['heading_title'] = $this->language->get('heading_title');
		$this->data['text_big_image_size'] = $this->language->get('text_big_image_size');
		$this->data['text_mini_image_size'] = $this->language->get('text_mini_image_size');
		$this->data['text_link'] = $this->language->get('text_link');
		$this->data['text_tree'] = $this->language->get('text_tree');
		$this->data['text_type_section'] = $this->language->get('text_type_section');
		$this->data['text_type_alcove'] = $this->language->get('text_type_alcove');
		$this->data['text_main'] = $this->language->get('text_main');
		$this->data['text_main_module'] = $this->language->get('text_main_module');
		$this->data['text_price_section'] = $this->language->get('text_price_section');
		$this->data['text_box'] = $this->language->get('text_box');
		$this->data['text_option'] = $this->language->get('text_option');
		$this->data['text_browse'] = $this->language->get('text_browse');
		$this->data['text_clear'] = $this->language->get('text_clear');
		$this->data['text_top_box'] = $this->language->get('text_top_box');
		$this->data['text_bottom_box'] = $this->language->get('text_bottom_box');
		$this->data['text_select_none'] = $this->language->get('text_select_none');
		$this->data['text_image_manager'] = $this->language->get('text_image_manager');
		$this->data['text_option_tree'] = $this->language->get('text_option_tree');
		$this->data['text_option_type_alcove'] = $this->language->get('text_option_type_alcove');
		$this->data['text_option_type_section'] = $this->language->get('text_option_type_section');
		$this->data['text_option_radio'] = $this->language->get('text_option_radio');
		$this->data['text_option_checkbox'] = $this->language->get('text_option_checkbox');
		$this->data['order_list'] = $this->language->get('order_list');
		$this->data['no_image'] = $this->language->get('no_image');

		$this->data['button_add'] = $this->language->get('button_add');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_refresh'] = $this->language->get('button_refresh');
		$this->data['button_save_settings_module'] = $this->language->get('button_save_settings_module');

		$this->data['info_remove'] = $this->language->get('info_remove');
		$this->data['info_reload'] = $this->language->get('info_reload');
		$this->data['info_save'] = $this->language->get('info_save');
		$this->data['info_edit_image'] = $this->language->get('info_edit_image');
		$this->data['info_mini_image'] = $this->language->get('info_mini_image');
		$this->data['info_big_image'] = $this->language->get('info_big_image');
		$this->data['info_add'] = $this->language->get('info_add');
		$this->data['info_count_section'] = $this->language->get('info_count_section');
		$this->data['info_option_depends'] = $this->language->get('info_option_depends');
		$this->data['info_option_type'] = $this->language->get('info_option_type');
		$this->data['info_sequence'] = $this->language->get('info_sequence');
		$this->data['info_selected'] = $this->language->get('info_selected');

		$this->data['link_list'] = $this->url->link('module/construct/orderList', 'token=' . $this->session->data['token'], 'SSL');

		$this->document->addStyle('view/stylesheet/construct.css');

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('module/construct', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
		);

		$this->data['big_image_size'] = '';
		$this->data['mini_image_size'] = '';

		foreach($this->model_setting_setting->getSetting('construct') as $key => $setting){
			$this->data[$key] = $setting;
		}
		$this->data['link'] = $this->model_module_construct->getLink();

		$this->data['trees'] = $this->model_module_construct->getTrees();
		$this->data['types_section'] = $this->model_module_construct->getTypesSection();
		$this->data['types_alcove'] = $this->model_module_construct->getTypesAlcove();
		$this->data['boxes'] = $this->model_module_construct->getBox();
		$this->data['options'] = $this->model_module_construct->getOption();

		$this->data['token'] = $this->session->data['token'];

		$this->template = 'module/construct_settings.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$this->response->setOutput($this->render());
	}

	public function saveModuleSettings(){
		$json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
			$this->load->model('setting/setting');
			if(!empty($this->request->post['link'])){
				$this->load->model('module/construct');
				$this->model_module_construct->setLink($this->request->post['link']);
				unset($this->request->post['link']);
			}

			$this->model_setting_setting->editSetting('construct', $this->request->post);
			$this->cache->delete('seo_pro');
			$this->cache->delete('store');
			$json['success'] = true;
		}else{
			$json['error'] = true;
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function saveMainRow(){
		$json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
			$this->load->model('module/construct');

			$function_elements = explode('_', $this->request->post['group']);
			$model_function = "save";
			foreach($function_elements as $e){
				$model_function .= ucfirst($e);
			}

			$json['success'] = $this->model_module_construct->$model_function($this->request->post);
			$this->response->addHeader('Content-Type: application/json');
		}else{
			$json['error'] = true;
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function removeMainRow(){
		$json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
			$this->load->model('module/construct');

			$this->model_module_construct->removeMainRow($this->request->post);
			$json['success'] = true;
		}else{
			$json['error'] = true;
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function updateRow(){
		$json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
			$this->load->model('module/construct');

			$this->model_module_construct->updateRow($this->request->post);
			$json['success'] = true;
		}else{
			$json['error'] = true;
		}
		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function getSecondSettings(){
		$this->load->model('module/construct');
		$this->load->language('module/construct');

		$this->data['trees'] = $this->model_module_construct->getTrees();
		$this->data['types_section'] = $this->model_module_construct->getTypesSection();
		$this->data['types_alcove'] = $this->model_module_construct->getTypesAlcove();
		$this->data['boxes_top'] = $this->model_module_construct->getBox(NULL, 'top');
		$this->data['boxes_bottom'] = $this->model_module_construct->getBox(NULL, 'bottom');

		$this->data['val_price'] = $this->model_module_construct->getPrices();
		$this->data['images'] = $this->model_module_construct->getImages();
		$this->data['names_alcove'] = $this->model_module_construct->getNames();

		$this->data['options'] = $this->model_module_construct->getOption();

		$this->data['count_options_tree'] = 0;
		$this->data['count_options_type_alcove'] = 0;
		$this->data['count_options_type_section'] = 0;

		foreach($this->data['options'] as $key => $option){
			$this->data['options'][$key]['children'] = $this->model_module_construct->getOptionChildren($option['id']);

			if($option['depends'] == "tree"){
				$this->data['count_options_tree']++;
			}else if($option['depends'] == "type_alcove"){
				$this->data['count_options_type_alcove']++;
			}else{
				$this->data['count_options_type_section']++;
			}
		}

		$this->data['tab_tree'] = $this->language->get('tab_tree');
		$this->data['tab_price'] = $this->language->get('tab_price');
		$this->data['tab_option'] = $this->language->get('tab_option');
		$this->data['tab_image'] = $this->language->get('tab_image');
		$this->data['tab_name'] = $this->language->get('tab_name');

		$this->data['text_type_alcove_tab'] = $this->language->get('text_type_alcove_tab');
		$this->data['text_type_section_tab'] = $this->language->get('text_type_section_tab');
		$this->data['text_tree_tab'] = $this->language->get('text_tree_tab');
		$this->data['no_image'] = $this->language->get('no_image');

		$this->data['button_add'] = $this->language->get('button_add');
		$this->data['button_remove'] = $this->language->get('button_remove');
		$this->data['button_save_prices'] = $this->language->get('button_save_prices');
		$this->data['button_save_images'] = $this->language->get('button_save_images');
		$this->data['button_save_names'] = $this->language->get('button_save_names');
		$this->data['button_refresh'] = $this->language->get('button_refresh');

		$this->data['h3_price_frame'] = $this->language->get('h3_price_frame');
		$this->data['h3_price_section_top'] = $this->language->get('h3_price_section_top');
		$this->data['h3_price_section_bottom'] = $this->language->get('h3_price_section_bottom');
		$this->data['h3_price_flooring'] = $this->language->get('h3_price_flooring');
		$this->data['h3_price_option'] = $this->language->get('h3_price_option');

		$this->data['info_remove'] = $this->language->get('info_remove');
		$this->data['info_add'] = $this->language->get('info_add');
		$this->data['info_sequence'] = $this->language->get('info_sequence');
		$this->data['info_selected'] = $this->language->get('info_selected');
		$this->data['info_set'] = $this->language->get('info_set');

		$this->data['token'] = $this->session->data['token'];

		$this->data['info_big_image'] = $this->language->get('info_big_image');

		$this->template = 'module/construct_second_settings.tpl';

		$this->response->setOutput($this->render());
	}

	public function savePrices(){
		$json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
			$this->load->model('module/construct');
			foreach($this->request->post as $key => $row){
				if(empty($row)){
					$row = 0;
				}
				$val = explode('-', $key);
				$data = array(
					'tag' => $val[0],
					'tree_id' => $val[1]==''?NULL:(int)$val[1],
					'type_alcove_id' => $val[2]==''?NULL:(int)$val[2],
					'type_section_id' => $val[3]==''?NULL:(int)$val[3],
					'box_id' => $val[4]==''?NULL:(int)$val[4],
					'price' => (int)$row
				);
				$this->model_module_construct->savePrice($data);
			}
			$json['success'] = true;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function saveImages(){
		$json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
			$this->load->model('module/construct');
			foreach($this->request->post as $key => $row){
				if(empty($row)){
					$row = 'no_image.jpg';
				}
				$val = explode('-', $key);
				$data = array(
					'type_alcove_id' => (int)$val[1],
					'box_top_id' => (int)$val[2],
					'box_bottom_id' => (int)$val[3],
					'image' => $row
				);
				$this->model_module_construct->saveImage($data);
			}
			$json['success'] = true;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function saveNames(){
		$json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
			$this->load->model('module/construct');
			foreach($this->request->post as $key => $row){
				$val = explode('-', $key);
				$data = array(
					'type_alcove_id' => (int)$val[1],
					'type_section_id' => (int)$val[2],
					'name' => $row
				);
				$this->model_module_construct->saveName($data);
			}
			$json['success'] = true;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function saveOptionChild(){
		$json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
			$this->load->model('module/construct');
			$json['success'] = $this->model_module_construct->saveOptionChild($this->request->post);
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function removeOptionChild(){
		$json = array();
		if($this->request->server['REQUEST_METHOD'] == 'POST'){
			$this->load->model('module/construct');
			$this->model_module_construct->removeOptionChild($this->request->post['id']);
			$json['success'] = true;
		}

		$this->response->addHeader('Content-Type: application/json');
		$this->response->setOutput(json_encode($json));
	}

	public function orderList(){
		$this->load->language('module/construct');
		$this->document->setTitle($this->language->get('order_list'));
		$this->document->addStyle('view/stylesheet/construct.css');

		$this->data['breadcrumbs'] = array();

		$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_home'),
				'href'      => $this->url->link('common/home', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => false
		);

		$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('text_module'),
				'href'      => $this->url->link('extension/module', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
		);

		$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('heading_title'),
				'href'      => $this->url->link('module/construct', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
		);
		$this->data['breadcrumbs'][] = array(
				'text'      => $this->language->get('order_list'),
				'href'      => $this->url->link('module/construct/orderList', 'token=' . $this->session->data['token'], 'SSL'),
				'separator' => ' :: '
		);

		$this->data['heading_title'] = $this->language->get('order_list');
		$this->data['order_id'] = $this->language->get('order_id');
		$this->data['order_name'] = $this->language->get('order_name');
		$this->data['order_email'] = $this->language->get('order_email');
		$this->data['order_number'] = $this->language->get('order_number');
		$this->data['order_total'] = $this->language->get('order_total');
		$this->data['order_comment'] = $this->language->get('order_comment');
		$this->data['order_tree'] = $this->language->get('order_tree');
		$this->data['order_alcove'] = $this->language->get('order_alcove');
		$this->data['order_section_type'] = $this->language->get('order_section_type');
		$this->data['order_box_top'] = $this->language->get('order_box_top');
		$this->data['order_box_bottom'] = $this->language->get('order_box_bottom');
		$this->data['order_flooring'] = $this->language->get('order_flooring');
		$this->data['order_options'] = $this->language->get('order_options');

		$this->load->model('module/construct');
		$page = isset($this->request->get['page'])?$this->request->get['page']:1;
		$limit = $this->config->get('config_admin_limit');

		$this->data['orders'] = $this->model_module_construct->getOrders(($page - 1) * $limit, $limit);
		$this->template = 'module/construct_list.tpl';
		$this->children = array(
			'common/header',
			'common/footer'
		);

		$pagination = new Pagination();
		$pagination->total = $this->model_module_construct->getTotal();
		$pagination->page = $page;
		$pagination->limit = $limit;
		$pagination->text = $this->language->get('text_pagination');
		$pagination->url = $this->url->link('module/construct/orderList', 'token=' . $this->session->data['token'] . '&page={page}', 'SSL');

		$this->data['pagination'] = $pagination->render();


		$this->response->setOutput($this->render());
	}
}
?>
