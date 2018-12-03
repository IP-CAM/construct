<?php
class ModelModuleConstruct extends Model{
    public function install(){
      $this->db->query("
      CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "construct_box` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `type` enum('top','bottom') NOT NULL,
        `image` text NOT NULL,
        `name` varchar(255) NOT NULL,
        `selected` int(1) NOT NULL DEFAULT '0',
        `sequence` int(2) NOT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=20 DEFAULT CHARSET=utf8;");
      $this->db->query("
      CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "construct_image` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `type_alcove_id` int(11) NOT NULL,
        `box_top_id` int(11) NOT NULL,
        `box_bottom_id` int(11) NOT NULL,
        `image` text NOT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=49 DEFAULT CHARSET=utf8;");
      $this->db->query("
      CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "construct_option` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `name` varchar(255) NOT NULL,
        `type` enum('checkbox','radio') NOT NULL,
        `depends` enum('tree','type_alcove','type_section') NOT NULL,
        `sequence` int(2) NOT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=13 DEFAULT CHARSET=utf8;");
      $this->db->query("
      CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "construct_option_children` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `option_id` int(11) NOT NULL,
        `text` varchar(255) NOT NULL,
        `sequence` int(2) NOT NULL,
        `selected` int(1) NOT NULL DEFAULT '0',
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=16 DEFAULT CHARSET=utf8;");
      $this->db->query("
      CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "construct_order` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `name` varchar(255) NOT NULL,
        `email` varchar(255) NOT NULL,
        `number` varchar(100) NOT NULL,
        `comment` varchar(255) NOT NULL,
        `tree_id` int(11) NOT NULL,
        `type_alcove_id` int(11) NOT NULL,
        `type_section_id` int(11) NOT NULL,
        `box_top_id` int(11) NOT NULL,
        `flooring` int(11) NOT NULL,
        `box_bottom_id` int(11) NOT NULL,
        `options` text NOT NULL,
        `total` varchar(100) NOT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=utf8;");
      $this->db->query("
      CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "construct_price` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `tree_id` varchar(11) NOT NULL,
        `type_alcove_id` varchar(11) NOT NULL,
        `type_section_id` varchar(11) NOT NULL,
        `box_id` varchar(11) NOT NULL,
        `tag` varchar(200) NOT NULL,
        `price` int(11) NOT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=115 DEFAULT CHARSET=utf8;");
      $this->db->query("
      CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "construct_tree` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `name` varchar(200) NOT NULL,
        `sequence` int(2) NOT NULL,
        `selected` int(1) NOT NULL DEFAULT '0',
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;");
      $this->db->query("
      CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "construct_type_alcove` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `name` varchar(255) NOT NULL,
        `image` text NOT NULL,
        `big_image` text NOT NULL,
        `count_section` int(2) NOT NULL,
        `sequence` int(2) NOT NULL,
        `selected` int(1) NOT NULL DEFAULT '0',
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=33 DEFAULT CHARSET=utf8;");
      $this->db->query("
      CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "construct_type_section` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `name` varchar(200) NOT NULL,
        `sequence` int(2) NOT NULL,
        `selected` int(1) NOT NULL DEFAULT '0',
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;");
      $this->db->query("
      CREATE TABLE IF NOT EXISTS `" . DB_PREFIX . "construct_alcove_name` (
        `id` int(11) NOT NULL AUTO_INCREMENT,
        `type_alcove_id` int(11) NOT NULL,
        `type_section_id` int(11) NOT NULL,
        `name` varchar(255) NOT NULL,
        PRIMARY KEY (`id`)
      ) ENGINE=MyISAM AUTO_INCREMENT=9 DEFAULT CHARSET=utf8;");
      $this->setLink("construct");
    }
    public function remove(){
      $this->db->query("DROP TABLE `" . DB_PREFIX . "construct_box`");
      $this->db->query("DROP TABLE `" . DB_PREFIX . "construct_image`");
      $this->db->query("DROP TABLE `" . DB_PREFIX . "construct_option`");
      $this->db->query("DROP TABLE `" . DB_PREFIX . "construct_option_children`");
      $this->db->query("DROP TABLE `" . DB_PREFIX . "construct_order`");
      $this->db->query("DROP TABLE `" . DB_PREFIX . "construct_price`");
      $this->db->query("DROP TABLE `" . DB_PREFIX . "construct_tree`");
      $this->db->query("DROP TABLE `" . DB_PREFIX . "construct_type_alcove`");
      $this->db->query("DROP TABLE `" . DB_PREFIX . "construct_type_section`");
      $this->db->query("DROP TABLE `" . DB_PREFIX . "construct_alcove_name`");
      $this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE `query` = 'module/construct'");
    }

    public function setLink($link){
      $this->db->query("DELETE FROM `" . DB_PREFIX . "url_alias` WHERE `query` = 'module/construct'");

      $this->db->query("INSERT INTO `" . DB_PREFIX . "url_alias` (`query`, `keyword`) VALUES ('module/construct', '" . $this->db->escape($link) . "')");
    }

    public function getLink(){
      $link = $this->db->query("SELECT `keyword` FROM `" . DB_PREFIX . "url_alias` WHERE `query` = 'module/construct'");
      return isset($link->row['keyword'])?$link->row['keyword']:'';
    }

    public function getTrees($id = NULL){
      $sql = "";
      if(!is_null($id)){
        $sql = "WHERE `id` = '" . (int)$id . "'";
      }
      $data = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_tree`" . $sql);
      if(!is_null($id)){
        return $data->row;
      }else{
        return $data->rows;
      }
    }

    public function getTypesSection($id = NULL){
      $sql = "";
      if(!is_null($id)){
        $sql = "WHERE `id` = '" . (int)$id . "'";
      }
      $data = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_type_section`" . $sql);
      if(!is_null($id)){
        return $data->row;
      }else{
        return $data->rows;
      }
    }

    public function getTypesAlcove($id = NULL){
      $sql = "";
      if(!is_null($id)){
        $sql = "WHERE `id` = '" . (int)$id . "'";
      }
      $data = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_type_alcove`" . $sql);
      $this->load->model('tool/image');
      if(!is_null($id)){
        return array(
          'id' => $data->row['id'],
          'name' => $data->row['name'],
          'image' => $this->model_tool_image->resize($data->row['image'], 250, 250),
          'image_path' => $data->row['image'],
          'big_image' => $this->model_tool_image->resize($data->row['big_image'], 250, 250),
          'big_image_path' => $data->row['big_image'],
          'count_section' => $data->row['count_section'],
          'sequence' => $data->row['sequence'],
          'selected' => $data->row['selected']
        );
      }else{
        $results = array();
        foreach($data->rows as $row){
          $results[] = array(
            'id' => $row['id'],
            'name' => $row['name'],
            'image' => $this->model_tool_image->resize($row['image'], 250, 250),
            'image_path' => $row['image'],
            'big_image' => $this->model_tool_image->resize($row['big_image'], 250, 250),
            'big_image_path' => $row['big_image'],
            'count_section' => $row['count_section'],
            'sequence' => $row['sequence'],
            'selected' => $row['selected']
          );
        }
        return $results;
      }
    }

    public function getBox($id = NULL, $type = NULL){
      $sql = "";
      if(!is_null($id) || !is_null($type)){
        $sql .= "WHERE ";
      }
      if(!is_null($id)){
        $sql .= "`id` = '" . (int)$id . "' ";
      }
      if(!is_null($id) && !is_null($type)){
        $sql .= "AND ";
      }
      if(!is_null($type)){
        $sql .= "`type` = '" . $this->db->escape($type) . "'";
      }
      $data = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_box`" . $sql);
      $this->load->model('tool/image');
      if(!is_null($id)){
        return array(
          'id' => $data->row['id'],
          'name' => $data->row['name'],
          'image' => $this->model_tool_image->resize($data->row['image'], 250, 250),
          'image_path' => $data->row['image'],
          'type' => $data->row['type'],
          'sequence' => $data->row['sequence'],
          'selected' => $data->row['selected']
        );
      }else{
        $results = array();
        foreach($data->rows as $row){
          $results[] = array(
            'id' => $row['id'],
            'name' => $row['name'],
            'image' => $this->model_tool_image->resize($row['image'], 250, 250),
            'image_path' => $row['image'],
            'type' => $row['type'],
            'sequence' => $row['sequence'],
            'selected' => $row['selected']
          );
        }
        return $results;
      }
    }

    public function getOption($id = NULL, $type = NULL){
      $sql = "";
      if(!is_null($id)){
        $sql = "WHERE `id` = '" . (int)$id . "'";
      }
      $data = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_option`" . $sql);
      if(!is_null($id)){
        $this->load->language('module/construct');
        return array(
          'id' => $data->row['id'],
          'name' => $data->row['name'],
          'type' => $this->language->get('text_option_'.$data->row['type']),
          'depends' => $this->language->get('text_option_'.$data->row['depends']),
          'sequence' => $data->row['sequence']
        );
      }else{
        return $data->rows;
      }
    }

    public function getOptionChildren($id){
      return $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_option_children` WHERE `option_id` = '" . (int)$id . "'")->rows;
    }

    public function saveTree($data){
      $this->db->query("INSERT INTO `" . DB_PREFIX . "construct_tree` (`name`) VALUES ('" . $this->db->escape($data['name']) . "')");
      return $this->getTrees($this->db->getLastId());
    }

    public function saveTypeSection($data){
      $this->db->query("INSERT INTO `" . DB_PREFIX . "construct_type_section` (`name`) VALUES ('" . $this->db->escape($data['name']) . "')");
      return $this->getTypesSection($this->db->getLastId());
    }

    public function saveTypeAlcove($data){
      $this->db->query("INSERT INTO `" . DB_PREFIX . "construct_type_alcove` (`name`, `image`, `big_image`, `count_section`) VALUES ('" . $this->db->escape($data['name']) . "', '" . $this->db->escape($data['image']) . "', '" . $this->db->escape($data['big_image']) . "', '" . (int)$data['count_section'] . "')");
      return $this->getTypesAlcove($this->db->getLastId());
    }

    public function saveBox($data){
      $this->db->query("INSERT INTO `" . DB_PREFIX . "construct_box` (`name`, `type`, `image`) VALUES ('" . $this->db->escape($data['name']) . "', '" . $this->db->escape($data['type']) . "', '" . $this->db->escape($data['image']) . "')");
      return $this->getBox($this->db->getLastId());
    }

    public function saveOption($data){
      $this->db->query("INSERT INTO `" . DB_PREFIX . "construct_option` (`name`, `type`, `depends`) VALUES ('" . $this->db->escape($data['name']) . "', '" . $this->db->escape($data['type']) . "', '" . $this->db->escape($data['depends']) . "')");
      return $this->getOption($this->db->getLastId());
    }

    public function removeMainRow($data){
      $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_" . $this->db->escape($data['group']) . "` WHERE `id` = '" . (int)$data['id'] . "'");
      if($data['group'] == "box"){
        $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_image` WHERE `" . $this->db->escape($data['group']) . "_top_id` = '" . (int)$data['id'] . "'");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_image` WHERE `" . $this->db->escape($data['group']) . "_bottom_id` = '" . (int)$data['id'] . "'");
      }
      if($data['group'] == "type_alcove"){
        $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_alcove_name` WHERE `" . $this->db->escape($data['group']) . "_id` = '" . (int)$data['id'] . "'");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_image` WHERE `" . $this->db->escape($data['group']) . "_id` = '" . (int)$data['id'] . "'");
      }
      if($data['group'] == "type_section"){
        $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_alcove_name` WHERE `" . $this->db->escape($data['group']) . "_id` = '" . (int)$data['id'] . "'");
      }
      if($data['group'] == "option"){
        $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_option_children` WHERE `" . $this->db->escape($data['group']) . "_id` = '" . (int)$data['id'] . "'");
        $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_price` WHERE `tag` LIKE 'option_" . (int)$data['id'] . "%'");
      }else{
        $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_price` WHERE `" . $this->db->escape($data['group']) . "_id` = '" . (int)$data['id'] . "'");
      }
    }

    public function updateRow($data){
      if(strpos($data['col'], "selected") !== false){
        $sql = '';
        if(strpos($data['col'], "top") !== false){
          $sql .= " AND `type` = 'top'";
        }else if(strpos($data['col'], "bottom") !== false){
          $sql .= " AND `type` = 'bottom'";
        }else if(strpos($data['col'], "child") !== false){
          $option_id = $this->db->query("SELECT `option_id` FROM `" . DB_PREFIX . "construct_option_children` WHERE `id` = '" . (int)$data['id'] . "'")->row['option_id'];
          $sql .= " AND `option_id` = '" . $option_id . "'";
        }
        $data['col'] = "selected";
        $data['value'] = 1;
        $this->db->query("UPDATE `" . DB_PREFIX . "construct_" . $this->db->escape($data['group']) . "` SET `selected` = '0' WHERE `selected` = '1'" . $sql);
      }
      $this->db->query("UPDATE `" . DB_PREFIX . "construct_" . $this->db->escape($data['group']) . "` SET `" . $this->db->escape($data['col']) . "` = '" . $this->db->escape($data['value']) . "' WHERE `id` = '" . (int)$data['id'] . "'");
    }

    public function savePrice($data){
      $sql = "INSERT INTO `" . DB_PREFIX . "construct_price` (";
      $sql_search = "";
      if(!is_null($data['tree_id'])){
        $sql .= "`tree_id`,";
        $sql_search .= " `tree_id` = '" . $data['tree_id'] . "' AND";
      }
      if(!is_null($data['type_alcove_id'])){
        $sql .= " `type_alcove_id`,";
        $sql_search .= " `type_alcove_id` = '" . $data['type_alcove_id'] . "' AND";
      }
      if(!is_null($data['type_section_id'])){
        $sql .= " `type_section_id`,";
        $sql_search .= " `type_section_id` = '" . $data['type_section_id'] . "' AND";
      }
      if(!is_null($data['box_id'])){
        $sql .= " `box_id`,";
        $sql_search .= " `box_id` = '" . $data['box_id'] . "'";
      }
      $sql .= " `tag`, `price`) VALUES (";
      if(substr($sql_search, -3) != "AND"){
        $sql_search .= " AND ";
      }
      $sql_search .= "`tag` = '" . $this->db->escape($data['tag']) . "'";
      if($this->db->query("SELECT COUNT(*) as `count` FROM `" . DB_PREFIX . "construct_price` WHERE" . $sql_search)->row['count'] == 0){
        if(!is_null($data['tree_id'])){
          $sql .= "'" . $data['tree_id'] . "',";
        }
        if(!is_null($data['type_alcove_id'])){
          $sql .= "'" . $data['type_alcove_id'] . "',";
        }
        if(!is_null($data['type_section_id'])){
          $sql .= "'" . $data['type_section_id'] . "',";
        }
        if(!is_null($data['box_id'])){
          $sql .= "'" . $data['box_id'] . "',";
        }

        $sql .= "'" . $data['tag'] . "', '" . $data['price'] . "')";
        $this->db->query($sql);
      }else{
        $this->db->query("UPDATE `" . DB_PREFIX . "construct_price` SET `price` = '" . $data['price'] . "' WHERE" . $sql_search);
      }
    }

    public function getPrices(){
      $results = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_price`")->rows;
      $val_price = array();
      foreach($results as $result){
        $val_price[$result['tag'].'-'.$result['tree_id'].'-'.$result['type_alcove_id'].'-'.$result['type_section_id'].'-'.$result['box_id']] = $result['price'];
      }
      return $val_price;
    }

    public function saveImage($data){
      if($this->db->query("SELECT COUNT(*) as `count` FROM `" . DB_PREFIX . "construct_image` WHERE `type_alcove_id` = '" . $data['type_alcove_id'] . "' AND `box_top_id` = '" . $data['box_top_id'] . "' AND `box_bottom_id` = '" . $data['box_bottom_id'] . "'")->row['count'] == 0){
        $this->db->query("INSERT INTO `" . DB_PREFIX . "construct_image` (`type_alcove_id`, `box_top_id`, `box_bottom_id`, `image`) VALUES ('" . $data['type_alcove_id'] . "','" . $data['box_top_id'] . "','" . $data['box_bottom_id'] . "','" . $data['image'] . "')");
      }else{
        $this->db->query("UPDATE `" . DB_PREFIX . "construct_image` SET `image` = '" . $data['image'] . "' WHERE `type_alcove_id` = '" . $data['type_alcove_id'] . "' AND `box_top_id` = '" . $data['box_top_id'] . "' AND `box_bottom_id` = '" . $data['box_bottom_id'] . "'");
      }
    }

    public function saveName($data){
      if($this->db->query("SELECT COUNT(*) as `count` FROM `" . DB_PREFIX . "construct_alcove_name` WHERE `type_alcove_id` = '" . $data['type_alcove_id'] . "' AND `type_section_id` = '" . $data['type_section_id'] . "'")->row['count'] == 0){
        if(!empty($data['name'])){
          $this->db->query("INSERT INTO `" . DB_PREFIX . "construct_alcove_name` (`type_alcove_id`, `type_section_id`, `name`) VALUES ('" . $data['type_alcove_id'] . "', '" . $data['type_section_id'] . "', '" . $this->db->escape($data['name']) . "')");
        }
      }else{
        if(!empty($data['name'])){
          $this->db->query("UPDATE `" . DB_PREFIX . "construct_alcove_name` SET `name` = '" . $this->db->escape($data['name']) . "' WHERE `type_alcove_id` = '" . $data['type_alcove_id'] . "' AND `type_section_id` = '" . $data['type_section_id'] . "'");
        }else{
          $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_alcove_name` WHERE `type_alcove_id` = '" . $data['type_alcove_id'] . "' AND `type_section_id` = '" . $data['type_section_id'] . "'");
        }
      }
    }

    public function getNames(){
      $results = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_alcove_name`")->rows;
      $names_alcove = array();
      $this->load->model('tool/image');
      foreach($results as $result){
        $names_alcove['name_alcove-'.$result['type_alcove_id'].'-'.$result['type_section_id']] = $result['name'];
      }
      return $names_alcove;
    }

    public function getImages(){
      $results = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_image`")->rows;
      $images = array();
      $this->load->model('tool/image');
      foreach($results as $result){
        $images['image-'.$result['type_alcove_id'].'-'.$result['box_top_id'].'-'.$result['box_bottom_id']] = array(
          'preview' => $this->model_tool_image->resize($result['image'], 250, 250),
          'path' => $result['image']
        );
      }
      return $images;
    }

    public function getOptionChild($id){
      return $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_option_children` WHERE `id` = '" . (int)$id . "'")->row;
    }

    public function saveOptionChild($data){
      $this->db->query("INSERT INTO `" . DB_PREFIX . "construct_option_children` (`option_id`, `text`) VALUES ('" . (int)$data['parent_id'] . "', '" . $this->db->escape($data['text']) . "')");
      return $this->getOptionChild($this->db->getLastId());
    }

    public function removeOptionChild($id){
      $result = $this->getOptionChild($id);
      $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_option_children` WHERE `id` = '" . (int)$id . "'");
      $this->db->query("DELETE FROM `" . DB_PREFIX . "construct_price` WHERE `tag` LIKE 'option_" . (int)$result['option_id'] . "_" . (int)$result['id'] . "%'");
    }

    public function getOrders($start, $limit){
      $sql = "SELECT o.id, o.name, o.email, o.number, o.comment, o.total, o.flooring, o.options, o.box_top_id, o.box_bottom_id, ct.name as tree_name, ta.name as type_alcove_name, ts.name as type_section_name FROM " . DB_PREFIX . "construct_order o LEFT JOIN ";
      $sql .= DB_PREFIX . "construct_tree ct ON (o.tree_id = ct.id) LEFT JOIN ";
      $sql .= DB_PREFIX . "construct_type_alcove ta ON (o.type_alcove_id = ta.id) LEFT JOIN ";
      $sql .= DB_PREFIX . "construct_type_section ts ON (o.type_section_id = ts.id) WHERE 1";
      $sql .= " LIMIT " . (int)$start . "," . (int)$limit;
      $data = array();
      foreach($this->db->query($sql)->rows as $key => $row){
        $data[$key] = array(
          'id' => $row['id'],
          'name' => $row['name'],
          'email' => $row['email'],
          'number' => $row['number'],
          'comment' => $row['comment'],
          'total' => $row['total'],
          'flooring' => $row['flooring'],
          'tree_name' => $row['tree_name'],
          'type_alcove_name' => $row['type_alcove_name'],
          'type_section_name' => $row['type_section_name']
        );
        $data[$key]['box_top'] = $this->getBox($row['box_top_id'])['name'];
        $data[$key]['box_bottom'] = $this->getBox($row['box_bottom_id'])['name'];

        $options = json_decode($row['options']);
        $data[$key]['options'] = array();
        foreach($options as $option){
          $option_full = $this->getOption($option->option_id);
          $data[$key]['options'][] = array(
            'option_name' => $option_full['name'],
            'value' => empty($option->child_id)?'1':$this->db->query("SELECT `text` FROM `" . DB_PREFIX . "construct_option_children` WHERE `id` = '" . (int)$option->child_id . "'")->row['text']
          );
        }
      }
      return $data;
    }

    public function getTotal(){
      return $this->db->query("SELECT COUNT(*) as `count` FROM `" . DB_PREFIX . "construct_order`")->row['count'];
    }
}
?>
