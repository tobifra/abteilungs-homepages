<?php
/*
Template Name: Was wir tun
*/
global $post;
$waswirtun_content = wpptd_get_post_meta_value( $post->ID, 'waswirtun-content' ); ?>
<?php get_template_part('header'); ?>

<?php if( $waswirtun_content ) : ?>
<div class="content__block">
  <p><?php echo $waswirtun_content; ?></p>
</div>
<?php endif; ?>

<?php 
$stufen = new WP_Query( array( 'post_type' => 'stufe', 'orderby' => 'menu_order', 'order' => 'ASC' ) );
while ( $stufen->have_posts() ) : $stufen->the_post();
  $stufenlogo = wpptd_get_post_meta_value( $post->ID, 'stufenlogo' );
  $stufenfarbe = wpptd_get_post_meta_value( $post->ID, 'stufenfarbe' );
  if( has_post_thumbnail() ) : ?>
<div class="content__big_image_container">
  <img class="content__big_image" src="<?php echo get_the_post_thumbnail_url(); ?>">
</div>
<?php endif; ?>
<div class="content__block">
  <h2 class="heading-2"><?php echo get_the_title(); ?></h2>
  <?php if( $stufenlogo && $stufenfarbe ) : ?>
  <div class="circle wwd__level-icon" style="background-color: <?php echo $stufenfarbe; ?>">
    <img class="circle-content" src="<?php echo wp_get_attachment_url( $stufenlogo ); ?>" alt="">
  </div>
  <?php endif; ?>
  <div class="content__text">
    <p><?php echo wpptd_get_post_meta_value( $post->ID, 'stufentext' ); ?></p>
  </div>
  <div style="clear: both;"></div>
</div>
<?php endwhile; wp_reset_postdata(); ?>

<?php get_template_part( 'footer' ); ?>