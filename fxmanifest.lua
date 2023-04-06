
fx_version 'cerulean'
game 'gta5'

description 'ks-carhud'
version '2.2.0'

shared_scripts {
    '@Framework/shared/locale.lua',
    '@Framework/imports.lua',
    '@ox_lib/init.lua',
    'locales/et.lua',
    'config.lua'
}

client_scripts {
    'client.lua',
    'cruise.lua',
    'seatbelt.lua',
    
} 
server_scripts {
    'server.lua',
}


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


