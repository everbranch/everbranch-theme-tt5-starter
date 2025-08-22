<?php
add_action('wp_enqueue_scripts', function () {
    wp_enqueue_style('everbranch-child', get_stylesheet_uri(), [], wp_get_theme()->get('Version'));
    wp_enqueue_style('everbranch-fonts', 'https://fonts.googleapis.com/css2?family=Inter:wght@400;500&family=Poppins:wght@600;700&display=swap', [], null);
});

add_action('after_setup_theme', function () {
    add_theme_support('editor-styles');
});
