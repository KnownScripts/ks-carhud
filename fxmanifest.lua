print("~g~ KNOWNSCRIPTS CAR HUD LOADED ~g~")

fx_version 'cerulean'
games { 'rdr3', 'gta5' }

description 'KnownScripts CarHUD 2023'


server_scripts {
	"config.lua",
}
client_scripts {
	"config.lua",
	"client/main.lua",
	"client/ui.lua",
}
ui_page {
	'html/ui.html',	
}
exports {
	'SetSeatbelt',
}
files {
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