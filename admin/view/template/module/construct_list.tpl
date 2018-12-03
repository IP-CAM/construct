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
  </div>
  <div class="content">
    <table class="list">
      <thead>
        <tr>
          <td><?php echo $order_id; ?></td>
          <td><?php echo $order_name; ?></td>
          <td><?php echo $order_email; ?></td>
          <td><?php echo $order_number; ?></td>
          <td><?php echo $order_comment; ?></td>
          <td><?php echo $order_tree; ?></td>
          <td><?php echo $order_alcove; ?></td>
          <td><?php echo $order_section_type; ?></td>
          <td><?php echo $order_box_top; ?></td>
          <td><?php echo $order_box_bottom; ?></td>
          <td><?php echo $order_flooring; ?></td>
          <td><?php echo $order_options; ?></td>
          <td><?php echo $order_total; ?></td>
        </tr>
      </thead>
      <tbody>
        <?php foreach($orders as $order){ ?>
          <tr>
            <td><?php echo $order['id']; ?></td>
            <td><?php echo $order['name']; ?></td>
            <td><?php echo $order['email']; ?></td>
            <td><?php echo $order['number']; ?></td>
            <td><?php echo $order['comment']; ?></td>
            <td><?php echo $order['tree_name']; ?></td>
            <td><?php echo $order['type_alcove_name']; ?></td>
            <td><?php echo $order['type_section_name']; ?></td>
            <td><?php echo $order['box_top']; ?></td>
            <td><?php echo $order['box_bottom']; ?></td>
            <td><?php echo $order['flooring']; ?></td>
            <td>
              <?php foreach($order['options'] as $option){ ?>
                <span><?php echo $option['option_name']; ?>:<?php echo $option['value']; ?>;</span><br>
              <?php } ?>
            </td>
            <td><?php echo $order['total']; ?></td>
          </tr>
        <?php } ?>
      </tbody>
    </table>
    <div class="pagination"><?php echo $pagination; ?></div>
  </div>
</div>
</div>
<?php echo $footer; ?>
