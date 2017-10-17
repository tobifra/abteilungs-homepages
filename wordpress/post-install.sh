#!/bin/bash

if [ "$#" -ne 1 ]; then
    echo "Usage: $0 <path/to/wp-cli.phar>"
    exit
fi

wp=$1

# Here specific Wordpress setup can be done using WP-CLI.
# Note, the commands in this file are run every time docker-compose up runs (regardless of whether the containers are newly created or re-started).

if [[ $($wp option get blogdescription) == *WordPress* ]]
then

	# We are setting up for the first time
	echo 'Starting this script for the first time on this WordPress instance, do initial setup'

	# Remove unnecessary plugins and themes
	$wp plugin list --status=inactive --field=name | egrep -v "gloggi" | xargs $wp plugin uninstall
	$wp theme list --status=inactive --enabled=no --field=name | egrep -v "gloggi" | xargs $wp theme delete

	# Remove unneccessary example content
	$wp site empty --yes

	# Create new pages
	mitmachen=$($wp post create --post_type=page --post_title="Mitmachen" --post_status=publish --menu_order=0 --porcelain)
	$wp post meta update $mitmachen _wp_page_template index.php
	waswirtun=$($wp post create --post_type=page --post_title="Was wir tun" --post_status=publish --menu_order=1 --porcelain)
	$wp post meta update $waswirtun _wp_page_template waswirtun.php
	werwirsind=$($wp post create --post_type=page --post_title="Wer wir sind" --post_status=publish --menu_order=2 --porcelain)
	$wp post meta update $werwirsind _wp_page_template werwirsind.php
	agenda=$($wp post create --post_type=page --post_title="Agenda" --post_status=publish --menu_order=3 --porcelain)
	$wp post meta update $agenda _wp_page_template agenda.php

	# Create initial content
	biberstufe=$($wp post create --post_type=stufe --post_title="Biberstufe" --post_status=publish --menu_order=0 --porcelain)
	$wp post meta update $biberstufe alter-von 4
	$wp post meta update $biberstufe alter-bis 7
	wolfsstufe=$($wp post create --post_type=stufe --post_title="Wolfsstufe" --post_status=publish --menu_order=1 --porcelain)
	$wp post meta update $wolfsstufe alter-von 7
	$wp post meta update $wolfsstufe alter-bis 11
	pfadistufe=$($wp post create --post_type=stufe --post_title="Pfadistufe" --post_status=publish --menu_order=2 --porcelain)
	$wp post meta update $pfadistufe alter-von 11
	$wp post meta update $pfadistufe alter-bis 14
	piostufe=$($wp post create --post_type=stufe --post_title="Piostufe" --post_status=publish --menu_order=3 --porcelain)
	$wp post meta update $piostufe alter-von 14
	$wp post meta update $piostufe alter-bis 16

	# Set the static front page
	$wp option update show_on_front page
	$wp option update page_on_front $mitmachen

	# Set some options in options-general.php
	$wp option update users_can_register 0
	$wp option update timezone_string Europe/Zurich
	$wp option update date_format d.m.Y
	$wp option update time_format H:i

	# Set some options in options-discussion.php
	$wp option update default_pingback_flag 0
	$wp option update default_ping_status 0
	$wp option update default_comment_status 0
	$wp option update comment_registration 1
	$wp option update close_comments_for_old_posts 1
	$wp option update close_comments_days_old 0
	$wp option update thread_comments 0
	$wp option update comments_notify 0
	$wp option update moderation_notify 0
	$wp option update comment_moderation 1
	$wp option update comment_whitelist 0

	# Set some options in options-media.php
	$wp option update uploads_use_yearmonth_folders 0

	# Mark the initial setup as completed (this field is used as a reference for the if statement at the top of this file)
	$wp option update blogdescription "Pfadiwebseite"

else

	echo 'This WordPress instance is not at default settings, not doing initial setup'

fi
