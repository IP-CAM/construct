<?php
class ModelModuleConstruct extends Model{
  public function getTrees($default = false){
    $sql = '';
    if($default){
      $sql .= "WHERE `selected` = '1' ";
    }
    $results = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_tree` " . $sql . " ORDER BY `sequence` ASC");
    if($default){
      return $results->row['id'];
    }else{
      return $results->rows;
    }
  }

  public function getTypesSection($default = false){
    $sql = '';
    if($default){
      $sql .= "WHERE `selected` = '1' ";
    }
    $results = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_type_section` " . $sql . " ORDER BY `sequence` ASC");
    if($default){
      return $results->row['id'];
    }else{
      return $results->rows;
    }
  }

  public function getTypesAlcove($default = false){
    $sql = '';
    if($default){
      $sql .= "WHERE `selected` = '1' ";
    }
    $results = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_type_alcove` " . $sql . " ORDER BY `sequence` ASC");
    if($default){
      return $results->row['id'];
    }else{
      return $results->rows;
    }
  }

  public function getBox($default = false, $type = false){
    $sql = '';
    if($default && $type){
      $sql .= "WHERE `selected` = '1' AND `type` = '" . $this->db->escape($type) . "'";
    }
    $results = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_box` " . $sql . " ORDER BY `sequence` ASC");
    if($default && $type){
      return $results->row['id'];
    }else{
      return $results->rows;
    }
  }

  public function getOptions($id = false){
    $sql = '';
    if($id){
      $sql .= " WHERE `id` = '" . (int)$id . "'";
    }
    $data = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_option` " . $sql . " ORDER BY `sequence` ASC");
    if($id == false){
      foreach($data->rows as $key => $row){
        $data->rows[$key]['children'] = $this->getOptionChildren($row['id']);
      }
      return $data->rows;
    }else{
      return $data->row['depends'];
    }
  }

  public function getOptionChildren($id, $default = false){
    $sql = '';
    if($default){
      $sql .= "AND `selected` = '1' ";
    }
    $results = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_option_children` WHERE `option_id` = '" . (int)$id . "' " . $sql . " ORDER BY `sequence` ASC");
    if($default){
      return $results->row['id'];
    }else{
      return $results->rows;
    }
  }

  public function getBigImages($data){
    $images = array();
    $images['first_step_image'] = $this->db->query("SELECT `big_image` FROM `" . DB_PREFIX . "construct_type_alcove` WHERE `id` = '" . $data['type_alcove_id'] . "'")->row['big_image'];
    $images['second_step_image'] = $this->db->query("SELECT `image` FROM `" . DB_PREFIX . "construct_image` WHERE `type_alcove_id` = '" . $data['type_alcove_id'] . "' AND `box_top_id` = '" . $data['box_top_id'] . "' AND `box_bottom_id` = '" . $data['box_bottom_id'] . "'")->row['image'];
    return $images;
  }

  public function getName($data){
    $name = $this->db->query("SELECT `name` FROM `" . DB_PREFIX . "construct_alcove_name` WHERE `type_alcove_id` = '" . $data['type_alcove_id'] . "' AND `type_section_id` = '" . $data['type_section_id'] . "'");
    return isset($name->row['name'])?$name->row['name']:'';
  }

  public function getNames(){
    $results = $this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_alcove_name`")->rows;
    $names_alcove = array();
    $this->load->model('tool/image');
    foreach($results as $result){
      $names_alcove['name_alcove-'.$result['type_alcove_id'].'-'.$result['type_section_id']] = empty($result['name'])?false:$result['name'];
    }
    return $names_alcove;
  }

  public function formPrice($steps){
    $price = 0;

    $val_price = array();
    foreach($this->db->query("SELECT * FROM `" . DB_PREFIX . "construct_price`")->rows as $result){
      $val_price[$result['tag'].'-'.$result['tree_id'].'-'.$result['type_alcove_id'].'-'.$result['type_section_id'].'-'.$result['box_id']] = $result['price'];
    }

    foreach($steps as $step){
      if(strpos($step['tag'], "box") !== false){
        $count_section = $this->db->query("SELECT `count_section` FROM `" . DB_PREFIX . "construct_type_alcove` WHERE `id` = '" . $step['type_alcove_id'] . "'")->row['count_section'];
        $step['type_alcove_id'] = '';
      }else{
        $count_section = false;
      }
      $tmp_price = isset($val_price[$step['tag'].'-'.$step['tree_id'].'-'.$step['type_alcove_id'].'-'.$step['type_section_id'].'-'.$step['box_id']])?(int)$val_price[$step['tag'].'-'.$step['tree_id'].'-'.$step['type_alcove_id'].'-'.$step['type_section_id'].'-'.$step['box_id']]:0;
      if($count_section){
        $tmp_price *= (int)$count_section;
      }
      $price += $tmp_price;
    }
    return $price;
  }

  public function addOrder($data){
    $this->db->query("INSERT INTO `construct_order` (`name`, `email`, `number`, `comment`, `tree_id`, `type_alcove_id`, `type_section_id`, `box_top_id`, `flooring`, `box_bottom_id`, `options`, `total`) VALUES ('" . $this->db->escape($data['name']) . "', '" . $this->db->escape($data['email']) . "', '" . $this->db->escape($data['number']) . "', '" . $this->db->escape($data['comment']) . "', '" . $data['tree_id'] . "', '" . $data['type_alcove_id'] . "', '" . $data['type_section_id'] . "', '" . $data['box_top_id'] . "', '" . $data['flooring'] . "', '" . $data['box_bottom_id'] . "', '" .  json_encode($data['options']) . "', '" . $this->db->escape($data['total']) . "')");
  }
}
?>
