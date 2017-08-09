<?php global $post; ?>
<?php get_template_part('html-head'); ?>

<div class="header-large">
    <div class="header__image-large"></div>
    <div class="header__banner-large">
        <img class="header__logo-large" src="<?php echo wpod_get_option( 'gloggi_einstellungen', 'abteilungslogo' ); ?>" alt="">
        <h1 class="header__title"><?php echo wpod_get_option( 'gloggi_einstellungen', 'abteilung'); ?></h1>
    </div>
</div>

<?php get_template_part('navigation'); ?>

<div class="window">
    <div class="content">