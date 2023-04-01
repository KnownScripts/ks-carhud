<<<<<<< HEAD
=======
<<<<<<< HEAD
fx_version 'cerulean'
game 'gta5'

description 'qb-hud'
version '2.2.0'

shared_scripts {
    '@Framework/shared/locale.lua',
    '@Framework/imports.lua',
    'locales/et.lua',
    'config.lua'
}

client_scripts {
    'client.lua',
    'cruise.lua'
} 
server_script 'server.lua'

ui_page 'html/index.html'

files {
    'html/*',
    'html/index.html',
    'html/styles.css',
    'html/responsive.css',
    'html/app.js',
}

depedencies {
    'ks-fuel'
}

lua54 'yes'
=======
print("~g~ KNOWNSCRIPTS CAR HUD LOADED ~g~")

>>>>>>> bb4d6d5b11fee7bf544ac3489c5971eff54c376b
fx_version 'cerulean'
game 'gta5'

description 'qb-hud'
version '2.2.0'

shared_scripts {
    '@Framework/shared/locale.lua',
    '@Framework/imports.lua',
    'locales/et.lua',
    'config.lua'
}

client_scripts {
    'client.lua',
    'cruise.lua'
} 
server_script 'server.lua'

ui_page 'html/index.html'

files {
<<<<<<< HEAD
    'html/*',
    'html/index.html',
    'html/styles.css',
    'html/responsive.css',
    'html/app.js',
}

depedencies {
    'ks-fuel'
}

lua54 'yes'
=======
	'html/*.png',
	'html/*.svg',
	'html/*.html',
	'html/ui.html',
	"html/img/*.svg",
	'html/css/main.css',
	'html/css/pricedown_bl-webfont.ttf',
	'html/css/pricedown_bl-webfont.woff',
	'html/css/pricedown_bl-webfont.woff2',
	'html/css/gta-ui.ttf',
	'html/js/app.js',
	'html/js/*.js',
	'html/css/pdown.ttf',
	'html/css/*.css',
	'html/css/*.ttf',
	'html/css/*.woff',
	'html/css/*.woff2',
}
>>>>>>> e181e0b7e5d36b8eb89a0fef9a46e933d79e574b
>>>>>>> bb4d6d5b11fee7bf544ac3489c5971eff54c376b
